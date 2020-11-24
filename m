Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA82C24AD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbgKXLiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732792AbgKXLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606217879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4EKV2Um7/yJIu8VsarQJwEZ8n5C8kG7HOAuj6t2iAfw=;
        b=fw33vJke2XbbyR8Yw//YUTOKNp8t7YG2dCqE5BqcVHhl0/eyxVN2Hxsvw3/3Vxo2lv1+/B
        PcyiS0i0yxWOLCDce7LY2ERpfWBlHQJGG8jL7e2sSWXfy06gkFebJG9yxdIwfC/MhSZD9B
        QT28I/INiSDybLKEJDooYhU2j7zi5lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-fkJl_pP-Mdu07RMLrlJGVw-1; Tue, 24 Nov 2020 06:37:56 -0500
X-MC-Unique: fkJl_pP-Mdu07RMLrlJGVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E9518C0211;
        Tue, 24 Nov 2020 11:37:37 +0000 (UTC)
Received: from T590 (ovpn-13-202.pek2.redhat.com [10.72.13.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 567556F450;
        Tue, 24 Nov 2020 11:37:33 +0000 (UTC)
Date:   Tue, 24 Nov 2020 19:37:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.11] block: optimise for_each_bvec() advance
Message-ID: <20201124113729.GA88892@T590>
References: <60aaa6caab3d061cf7194716c27a10920b5bd7ad.1606212786.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60aaa6caab3d061cf7194716c27a10920b5bd7ad.1606212786.git.asml.silence@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:21:23AM +0000, Pavel Begunkov wrote:
> Because of how for_each_bvec() works it never advances across multiple
> entries at a time, so bvec_iter_advance() is an overkill. Add
> specialised bvec_iter_advance_single() that is faster. It also handles
> zero-len bvecs, so can kill bvec_iter_skip_zero_bvec().
> 
>    text    data     bss     dec     hex filename
> before:
>   23977     805       0   24782    60ce lib/iov_iter.o
> before, bvec_iter_advance() w/o WARN_ONCE()
>   22886     600       0   23486    5bbe ./lib/iov_iter.o
> after:
>   21862     600       0   22462    57be lib/iov_iter.o
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/linux/bvec.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 2efec10bf792..4a304dfafa18 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -121,18 +121,24 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
>  	return true;
>  }
>  
> -static inline void bvec_iter_skip_zero_bvec(struct bvec_iter *iter)
> +static inline void bvec_iter_advance_single(const struct bio_vec *bv,
> +				struct bvec_iter *iter, unsigned int bytes)
>  {
> -	iter->bi_bvec_done = 0;
> -	iter->bi_idx++;
> +	unsigned int done = iter->bi_bvec_done + bytes;
> +
> +	if (done == bv[iter->bi_idx].bv_len) {
> +		done = 0;
> +		iter->bi_idx++;
> +	}
> +	iter->bi_bvec_done = done;
> +	iter->bi_size -= bytes;
>  }
>  
>  #define for_each_bvec(bvl, bio_vec, iter, start)			\
>  	for (iter = (start);						\
>  	     (iter).bi_size &&						\
>  		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
> -	     (bvl).bv_len ? (void)bvec_iter_advance((bio_vec), &(iter),	\
> -		     (bvl).bv_len) : bvec_iter_skip_zero_bvec(&(iter)))
> +	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
>  
>  /* for iterating one bio from start to end */
>  #define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
> -- 
> 2.24.0
> 

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


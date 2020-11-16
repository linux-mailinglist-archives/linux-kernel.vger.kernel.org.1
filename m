Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9742B3C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKPEcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbgKPEcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605501136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWwwHi+vPJ8ujzj6hxsvoqxeQ6ueO5UlgElf6+sCWok=;
        b=eMNvgmBPjOTE/KG/ahvFKdvYCigf5BJBVzzSRDr+2BxUMfhmIirVeTew50FoR/S/xlH30f
        uXZ6Y9I7iz76rzGyGCeIQfqXLGVbbK2BMjFsz7MJNX+2Qvq99FHUljWHtLPLWPbXlJR1Ck
        1Srlb2lxQi/Q9qefHsZHwBYXhQvIGu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-EPvhdJzgOy60UuEuZ9rE2A-1; Sun, 15 Nov 2020 23:32:15 -0500
X-MC-Unique: EPvhdJzgOy60UuEuZ9rE2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 186831007474;
        Mon, 16 Nov 2020 04:32:14 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 535C15B4C5;
        Mon, 16 Nov 2020 04:32:04 +0000 (UTC)
Subject: Re: [PATCH RFC 11/12] vringh: allow vringh_iov_xfer() to skip bytes
 when ptr is NULL
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-12-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a5cfe66f-5ae2-1a73-6010-74123721135b@redhat.com>
Date:   Mon, 16 Nov 2020 12:32:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-12-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> In some cases, it may be useful to provide a way to skip a number
> of bytes in a vringh_iov.
>
> In order to keep vringh_iov consistent, let's reuse vringh_iov_xfer()
> logic and skip bytes when the ptr is NULL.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>
> I'm not sure if this is the best option, maybe we can add a new
> function vringh_iov_skip().
>
> Suggestions?


I might be worth to check whether we can convert vringh_iov to use iov 
iterator then we can use iov_iterator_advance() here.

Thanks


> ---
>   drivers/vhost/vringh.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 8bd8b403f087..ed3290946ad7 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -75,7 +75,9 @@ static inline int __vringh_get_head(const struct vringh *vrh,
>   	return head;
>   }
>   
> -/* Copy some bytes to/from the iovec.  Returns num copied. */
> +/* Copy some bytes to/from the iovec.  Returns num copied.
> + * If ptr is NULL, skips at most len bytes.
> + */
>   static inline ssize_t vringh_iov_xfer(struct vringh *vrh,
>   				      struct vringh_kiov *iov,
>   				      void *ptr, size_t len,
> @@ -89,12 +91,16 @@ static inline ssize_t vringh_iov_xfer(struct vringh *vrh,
>   		size_t partlen;
>   
>   		partlen = min(iov->iov[iov->i].iov_len, len);
> -		err = xfer(vrh, iov->iov[iov->i].iov_base, ptr, partlen);
> -		if (err)
> -			return err;
> +
> +		if (ptr) {
> +			err = xfer(vrh, iov->iov[iov->i].iov_base, ptr, partlen);
> +			if (err)
> +				return err;
> +			ptr += partlen;
> +		}
> +
>   		done += partlen;
>   		len -= partlen;
> -		ptr += partlen;
>   		iov->consumed += partlen;
>   		iov->iov[iov->i].iov_len -= partlen;
>   		iov->iov[iov->i].iov_base += partlen;


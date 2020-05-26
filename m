Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C551BE060
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgD2OMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 10:12:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726811AbgD2OMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588169571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/c2OUq86MJcfNlBcO0fpqAK43s5QsWMF0jpIrxBr1s=;
        b=RpVFm4cggJLNZSkalq4Ma/PMjVePRn6zewCOou43nyMf5O47b9fVXRPzD5uoSMexnEkilg
        ipgKR0Dzd7LJeEhzH7xHCZfIyKwUWfPYVJxaeCI/tV/TUvyKaFv07eNl1KATQCPV+xGuDU
        pXssaDM3rZM13bR2c+3wCsdVDSTGMp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-6dKzlqqnNaCDSQnyz49PXg-1; Wed, 29 Apr 2020 10:12:46 -0400
X-MC-Unique: 6dKzlqqnNaCDSQnyz49PXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E880106BF98;
        Wed, 29 Apr 2020 14:12:44 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33DDF5D9C9;
        Wed, 29 Apr 2020 14:12:33 +0000 (UTC)
Date:   Wed, 29 Apr 2020 22:12:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, narayan@google.com,
        zezeozue@google.com, kernel-team@android.com, maco@google.com,
        bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] loop: Factor out loop size validation
Message-ID: <20200429141229.GE700644@T590>
References: <20200429140341.13294-1-maco@android.com>
 <20200429140341.13294-2-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140341.13294-2-maco@android.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:03:32PM +0200, Martijn Coenen wrote:
> Ensuring we don't truncate loff_t when casting to sector_t is done in
> multiple places; factor it out.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  drivers/block/loop.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index f1754262fc94..396b8bd4d75c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -228,15 +228,30 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>  		blk_mq_unfreeze_queue(lo->lo_queue);
>  }
>  
> +/**
> + * loop_validate_size() - validates that the passed in size fits in a sector_t
> + * @size: size to validate
> + */
> +static int
> +loop_validate_size(loff_t size)
> +{
> +	if ((loff_t)(sector_t)size != size)
> +		return -EFBIG;
> +
> +	return 0;
> +}
> +

Now sector_t has been switched to u64 unconditionally, do we still need such
validation?


Thanks, 
Ming


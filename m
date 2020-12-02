Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A0E2CC08F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgLBPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:17:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbgLBPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606922143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCRxxD0qgiGuwAeD/tYASFn0YHQ6vMXNC4OmSA+Rj38=;
        b=SkuEZLfrU315c8xYNJ1ifzZCEDHeWXFiCHVZ+eqVkwOYS8Syp9ImSDocsA50egb/IqaVos
        4eEUZbgcgTYjRTXI3YKnUv9O6VZG20e++eCmTNfznv1KQKPIwwVAgVkgd16UlyxZgS4QBb
        oOzK+zRKsYGPYvJcTIL0X44RmaizRlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-j4InH0duPqWsmxc-3es42A-1; Wed, 02 Dec 2020 10:15:39 -0500
X-MC-Unique: j4InH0duPqWsmxc-3es42A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0202C1092BCA;
        Wed,  2 Dec 2020 15:15:37 +0000 (UTC)
Received: from [10.36.112.89] (ovpn-112-89.ams2.redhat.com [10.36.112.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF0D15C1B4;
        Wed,  2 Dec 2020 15:15:33 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] vfio: platform: simplify device removal
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201124133139.3072124-1-uwe@kleine-koenig.org>
 <20201124133139.3072124-4-uwe@kleine-koenig.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <63756c77-2374-8493-6340-98c278a70353@redhat.com>
Date:   Wed, 2 Dec 2020 16:15:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201124133139.3072124-4-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 11/24/20 2:31 PM, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> vfio_platform_remove_common() cannot return non-NULL in
> vfio_amba_remove() as the latter is only called if vfio_amba_probe()
> returned success.
> 
> Diagnosed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/vfio/platform/vfio_amba.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index 9636a2afaecd..7b3ebf1558e1 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -73,16 +73,12 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  static int vfio_amba_remove(struct amba_device *adev)
>  {
> -	struct vfio_platform_device *vdev;
> -
> -	vdev = vfio_platform_remove_common(&adev->dev);
> -	if (vdev) {
> -		kfree(vdev->name);
> -		kfree(vdev);
> -		return 0;
> -	}
> +	struct vfio_platform_device *vdev =
> +		vfio_platform_remove_common(&adev->dev);
>  
> -	return -EINVAL;
> +	kfree(vdev->name);
> +	kfree(vdev);
> +	return 0;
>  }
>  
>  static const struct amba_id pl330_ids[] = {
> 


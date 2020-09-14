Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A1268D23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgINOPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgINOOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:14:09 -0400
Received: from coco.lan (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E16D20EDD;
        Mon, 14 Sep 2020 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600092817;
        bh=I5Q0Sc0ArcFSWCiqBhVtOYBqBwGBdQJZ2+JxwnWdPu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M2yl01g87iv19UGAdn4Upjcxf8rR5Nr9IcAatVzWgXbE3Ey/89Lpw7rAIwUvHyR45
         l89MvnmNReNQHbVKj0fRb3Y9XDC4sAh836l4AKKyfHMPeqeg10BiXpQYIIWz28T9R4
         5C1M/k3xtS9udIFl335N2gYZEa82JsfGJJpLMwGk=
Date:   Mon, 14 Sep 2020 16:13:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] misc: hisi_hikey_usb: fix return of uninitialized
 ret status variable
Message-ID: <20200914161332.2796e7b1@coco.lan>
In-Reply-To: <20200914135646.99334-1-colin.king@canonical.com>
References: <20200914135646.99334-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 14 Sep 2020 14:56:46 +0100
Colin King <colin.king@canonical.com> escreveu:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the return value from ret is uninitialized so the function
> hisi_hikey_usb_parse_kirin970 is returning a garbage value when
> succeeding. Since ret is not used anywhere else in the function, remove
> it and just return 0 success at the end of the function.
> 
> Addresses-Coverity: ("Uninitialixed scalar variable")
> Fixes: d210a0023590 ("misc: hisi_hikey_usb: add support for Hikey 970")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/misc/hisi_hikey_usb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
> index 2ddd4072788d..5759e7209023 100644
> --- a/drivers/misc/hisi_hikey_usb.c
> +++ b/drivers/misc/hisi_hikey_usb.c
> @@ -151,7 +151,6 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
>  					 struct hisi_hikey_usb *hisi_hikey_usb)
>  {
>  	struct regulator *regulator;
> -	int ret;
>  
>  	regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
>  	if (IS_ERR(regulator)) {
> @@ -172,7 +171,7 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
>  	if (IS_ERR(hisi_hikey_usb->reset))
>  		return PTR_ERR(hisi_hikey_usb->reset);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int hisi_hikey_usb_probe(struct platform_device *pdev)



Thanks,
Mauro

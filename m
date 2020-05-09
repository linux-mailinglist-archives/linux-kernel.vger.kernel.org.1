Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE61CBE7B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgEIHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 03:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgEIHnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 03:43:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DFC24953;
        Sat,  9 May 2020 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589010181;
        bh=ptvuRf7F2tJWhTTSAUYDoRicbbLI9qbZu6bxKj0Ytfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6A2qaFw13v7+IrUNrtLZqbOyi3DfgMxp+SwN5G45vf8tIYmYkeRHEKE6cY3XuwNL
         FJhNwSluLOHM0Ln4VkuDdV1lDs8JsUyoYyhaz8MMePDWnH2EmJMD8wJzcwHGQJnHs5
         cm+nBEPh80VKgFj8hzD9eM/5ptRE3WmJyBu7bbRU=
Date:   Sat, 9 May 2020 09:42:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiuhao Li <Qiuhao.Li@outlook.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: use usleep_range() for ATIM window
 size
Message-ID: <20200509074258.GB1831917@kroah.com>
References: <HK0PR01MB28684D4FFF457F5979ECFC27FCA30@HK0PR01MB2868.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB28684D4FFF457F5979ECFC27FCA30@HK0PR01MB2868.apcprd01.prod.exchangelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 03:19:31PM +0800, Qiuhao Li wrote:
> According to Documentation/timers/timers-howto.rst, sleeping for small
> milliseconds should use usleep_range() instead of msleep().
> 
> Signed-off-by: Qiuhao Li <Qiuhao.Li@outlook.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> index 8d035f67ef61..61fdd942c30a 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> @@ -5406,7 +5406,8 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
>  			return H2C_SUCCESS;
>  
>  		if ((pstapriv->tim_bitmap & BIT(0)) && (psta_bmc->sleepq_len > 0)) {
> -			msleep(10);/*  10ms, ATIM(HIQ) Windows */
> +			/* 10ms, ATIM(HIQ) Windows */
> +			usleep_range(10000, 10001);

How do you know this will work properly?  Can you test this?

thanks,

greg k-h

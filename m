Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1222ADE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbgKJSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJSdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:33:45 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB4DC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:33:44 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r9so5276862lfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MVvD+a8T0Lc81M2SgYvZ+Yt+89POCdnsUJ507OhxC5s=;
        b=kOH5xt2Mltc6vGl49BTAuQAfoJubwB2S+N/Jh7NzC5GRY7we9YV9QWrMvwOcAnfTqb
         OQjP0XCFkzFqbQqsniChW+kM56nIrGOtD9eA0MRdO3aesrFDcp+qUOeLehh9fzaycD46
         qddyF+XUzCCTf3xqwSXPiwjk9OAjMxU6gnRLlY1AltRdtX/8EcG061Q93uhxP76Z8jbo
         pmrDwmgYvr9TgTFTawzJFuR/0yOUgboDKYb8kwCqZ73znfIxjFaQebAfV/yJn3tyc6o/
         yQdAUVjpGeKBUpEcORKHyFZOEG3W2GlDH5i99fpcNkQO8xiTmFRtjxYyeePrPL1R0cEm
         REXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MVvD+a8T0Lc81M2SgYvZ+Yt+89POCdnsUJ507OhxC5s=;
        b=qCB4wKITj0jVo+apEV+Vqz08D5ao+yUaRxj6RrH9uhuLt6cI1jO8X8i3Glp+WCtf7M
         tp/45H9Q/qmxjNdVVH4+4Yfasgl0NlS52SLG8R5P0Xthhkn/Y2ExL9ty/KGMC+6Jf8d/
         jQ340K//CtTBfnTW9sZybsGvfe6hxA82jYyDVBMv6+yifDZraI4mn0c7kWlIKrPOELgO
         bZV19ks+IA6QLjt5jRbCBfek5HaTPoUJMmJMAI0nvpAGHkzvDZ1q+VSrZHJCKIsedVNH
         Zf2Tg21ifZpHHUYAJrzxknOfUAwCd5QvtimYeXAPuH2R15w1O+TSWaetQYQynWl7QrqP
         qlKg==
X-Gm-Message-State: AOAM532sM3RdPZ7gickoYuMII8HQ2Wo7NW6+vWB9uVUWMGBhM9lSpz2a
        wL4l7ZqHojXB0Xj6DM7XP5QBfKz5sgYVvuSD
X-Google-Smtp-Source: ABdhPJwcf56QLxLhbLGE/FcV9D4tJZdBfGrN8jRXtcg2lVeImXvKRXBuuLc1a4DdPxa/DsHTuWtkbg==
X-Received: by 2002:a19:418e:: with SMTP id o136mr47635lfa.80.1605033223385;
        Tue, 10 Nov 2020 10:33:43 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id 133sm2699139ljf.90.2020.11.10.10.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:33:42 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:33:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb: idt: fix error check in ntb_hw_idt.c
Message-ID: <20201110183340.77xcobfsnz43vsa2@mobilestation>
References: <1604655811-31933-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604655811-31933-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wang

On Fri, Nov 06, 2020 at 05:43:31PM +0800, Wang Qing wrote:
> idt_create_dev never return NULL and fix smatch warning.

Thanks for submitting this. For the both changes
Acked-by: Serge Semin <fancer.lancer@gmail.com>

They are mostly unrelated though. If they weren't trivial I'd have
suggested to split them up into the dedicated patches. Since they
aren't I suppose leaving the patch 'as is' is ok, unless the subsystem
maintainer thinks differently.

-Sergey

> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index d54261f..e7a4c2a
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2511,7 +2511,7 @@ static int idt_init_dbgfs(struct idt_ntb_dev *ndev)
>  	/* If the top directory is not created then do nothing */
>  	if (IS_ERR_OR_NULL(dbgfs_topdir)) {
>  		dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
> -		return PTR_ERR(dbgfs_topdir);
> +		return PTR_ERR_OR_ZERO(dbgfs_topdir);
>  	}
>  
>  	/* Create the info file node */
> @@ -2756,7 +2756,7 @@ static int idt_pci_probe(struct pci_dev *pdev,
>  
>  	/* Allocate the memory for IDT NTB device data */
>  	ndev = idt_create_dev(pdev, id);
> -	if (IS_ERR_OR_NULL(ndev))
> +	if (IS_ERR(ndev))
>  		return PTR_ERR(ndev);
>  
>  	/* Initialize the basic PCI subsystem of the device */
> -- 
> 2.7.4
> 

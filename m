Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8644E2F0FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbhAKKGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAKKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:06:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A676EC061786;
        Mon, 11 Jan 2021 02:05:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id be12so9251473plb.4;
        Mon, 11 Jan 2021 02:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Bzo0eMkrMWg6SoJuDn3iLa2JxZEbk8PffkOOa23MQI=;
        b=S0Lo50LxpwK0u1kIVZe/o1m8cQm6ELvXdNqdp1WVYAsG1zlVZEDhak2EfOD7QQrhlU
         J+SMFQZHt8oxspnbuwtUX7sjVNyiw8hPYdEBuCa85PAenEi0+g+drmW6GvRAtBOROrDU
         MgVo4UVU/xTl3gDsj8ScvjZBS9Xv59SfiWhGM0byydIv223fefkPVyHqW3hzzDRVw1OO
         TJ7mGRRqISnimsptniclVOfkAC7E5h3VYz/GJiXzARnJHXeUNdQ/sn+Id62WtzzTab3s
         FMxZe0Z1oXWxEHYDekMxLLbkAGqKsREU/2x5G5Ou9NjBg4S7QamLLnekxdziAkz2Ikjd
         2Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Bzo0eMkrMWg6SoJuDn3iLa2JxZEbk8PffkOOa23MQI=;
        b=Ue5+xTaNqKTJrTyQgZbYllvCVbvxnkG3s/yKNWmmFdPLs6+4bp0e8oWWmlUIg5+6JP
         rM6NZVfrvYhnN0qAoA1FbdpAuNwWzVd+ExmAOglF9zUEFR9RYPNEGlAejYOxU2T7bM3w
         obEvko+9HsrXIkliefrOS93kK5L+fLDQ28HI/V4A+0lCbFHZAibSNRsLGaOJ2WB70942
         4d5XPz7VRnuHzs7HQWhbfEqn5GXA6dXJQiT6cteE/IQmUQwV9EShr2u1XYDX7Gpsn/4d
         2NsDun4g/W92SYRY8eU7Xkcv0eaRcFGobq5oR6/xTF59AMj/8XSL3aXJMnfIdPLBx6bI
         9Ajg==
X-Gm-Message-State: AOAM531y30Umk4liv/PN85K2210i9vFrNgaMGzCfn0Pp+dveyIUE+Tib
        qpi6IEpa7PDaKNld1Gm9pVMr3zU+pKW4oA==
X-Google-Smtp-Source: ABdhPJy4fu3w6X6H8SITG9hF3dwqCdd+Us5WQfYaC/zBiZqxS0P0c/rRyZBOQ8Wk0APdIEd0qNQcaQ==
X-Received: by 2002:a17:902:8307:b029:dc:8ac6:c4f8 with SMTP id bd7-20020a1709028307b02900dc8ac6c4f8mr15653556plb.79.1610359539236;
        Mon, 11 Jan 2021 02:05:39 -0800 (PST)
Received: from b29397-desktop ([194.5.48.251])
        by smtp.gmail.com with ESMTPSA id s29sm20149096pgn.65.2021.01.11.02.05.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jan 2021 02:05:38 -0800 (PST)
Date:   Mon, 11 Jan 2021 18:05:30 +0800
From:   Peter Chen <hzpeterchen@gmail.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: Re: [PATCH] usb: cdns3: Adds missing __iomem markers
Message-ID: <20210111100529.GA8182@b29397-desktop>
References: <20201214125043.29710-1-pawell@cadence.com>
 <BYAPR07MB53815F102C9C56CBC7AAD89FDDAB0@BYAPR07MB5381.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB53815F102C9C56CBC7AAD89FDDAB0@BYAPR07MB5381.namprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-11 09:20:31, Pawel Laszczak wrote:
> Hi Peter,
> 
> What about this patch, can you apply it into for-usb-next ?

Done.

Peter
> 
> Thanks
> Pawel
> 
> >
> >Patch adds missing __iomem markers in core.h file
> >and makes some changes in drd.c file related with
> >these markers.
> >
> >The lack of __iomem has reported by sparse checker
> >on parsic architecture.
> >
> >Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >Reported-by: kernel test robot <lkp@intel.com>
> >---
> > drivers/usb/cdns3/core.h | 12 ++++++------
> > drivers/usb/cdns3/drd.c  | 12 ++++++------
> > 2 files changed, 12 insertions(+), 12 deletions(-)
> >
> >diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> >index f8e350cef699..bfa39795208e 100644
> >--- a/drivers/usb/cdns3/core.h
> >+++ b/drivers/usb/cdns3/core.h
> >@@ -86,12 +86,12 @@ struct cdns {
> > 	struct resource			xhci_res[CDNS_XHCI_RESOURCES_NUM];
> > 	struct cdns3_usb_regs __iomem	*dev_regs;
> >
> >-	struct resource			otg_res;
> >-	struct cdns3_otg_legacy_regs	*otg_v0_regs;
> >-	struct cdns3_otg_regs		*otg_v1_regs;
> >-	struct cdnsp_otg_regs		*otg_cdnsp_regs;
> >-	struct cdns_otg_common_regs	*otg_regs;
> >-	struct cdns_otg_irq_regs	*otg_irq_regs;
> >+	struct resource				otg_res;
> >+	struct cdns3_otg_legacy_regs __iomem	*otg_v0_regs;
> >+	struct cdns3_otg_regs __iomem		*otg_v1_regs;
> >+	struct cdnsp_otg_regs __iomem		*otg_cdnsp_regs;
> >+	struct cdns_otg_common_regs __iomem	*otg_regs;
> >+	struct cdns_otg_irq_reg __iomem		*otg_irq_regs;
> > #define CDNS3_CONTROLLER_V0	0
> > #define CDNS3_CONTROLLER_V1	1
> > #define CDNSP_CONTROLLER_V2	2
> >diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> >index 605a413db727..0701853b501c 100644
> >--- a/drivers/usb/cdns3/drd.c
> >+++ b/drivers/usb/cdns3/drd.c
> >@@ -27,7 +27,7 @@
> >  */
> > static int cdns_set_mode(struct cdns *cdns, enum usb_dr_mode mode)
> > {
> >-	u32 __iomem *override_reg;
> >+	void __iomem  *override_reg;
> > 	u32 reg;
> >
> > 	switch (mode) {
> >@@ -406,7 +406,7 @@ int cdns_drd_init(struct cdns *cdns)
> > 		cdns->otg_v1_regs = NULL;
> > 		cdns->otg_cdnsp_regs = NULL;
> > 		cdns->otg_regs = regs;
> >-		cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
> >+		cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem  *)
> > 				     &cdns->otg_v0_regs->ien;
> > 		writel(1, &cdns->otg_v0_regs->simulate);
> > 		dev_dbg(cdns->dev, "DRD version v0 (%08x)\n",
> >@@ -416,14 +416,14 @@ int cdns_drd_init(struct cdns *cdns)
> > 		cdns->otg_v1_regs = regs;
> > 		cdns->otg_cdnsp_regs = regs;
> >
> >-		cdns->otg_regs = (void *)&cdns->otg_v1_regs->cmd;
> >+		cdns->otg_regs = (void __iomem *)&cdns->otg_v1_regs->cmd;
> >
> >-		if (cdns->otg_cdnsp_regs->did == OTG_CDNSP_DID) {
> >-			cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
> >+		if (readl(cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
> >+			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
> > 					      &cdns->otg_cdnsp_regs->ien;
> > 			cdns->version  = CDNSP_CONTROLLER_V2;
> > 		} else {
> >-			cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
> >+			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
> > 					      &cdns->otg_v1_regs->ien;
> > 			writel(1, &cdns->otg_v1_regs->simulate);
> > 			cdns->version  = CDNS3_CONTROLLER_V1;
> >--
> >2.17.1
> 

-- 

Thanks,
Peter Chen


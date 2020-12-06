Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326972D0806
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 00:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgLFX01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 18:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLFX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 18:26:27 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1739AC0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 15:25:47 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id c7so2785391qke.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 15:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrm+4ZKWOsKZ/Gabbvdu+1GZWGD6E7h/REZlQOG1h2Y=;
        b=ySNThDEmDnkrKwY36pBezSeFTzHP8FIBNIRFI1/MlumxnSy7xHQ18vofPm3zcAdiZ4
         GQTwly7KYHGPP5LZJk+cWxVJXgYelWEheAnCBCrKTYjPR8zZrrW+pxdeVcq9WYyvDjII
         iVmrqWTQpfpB4ssUZ1AgAjRp6cSEyRYs5s6RluDDBInJ2nCQiwXR/bVLGGUcsLGIoAOc
         zmxzc94T6AgrlUsNkdWeRKJEfv/tim+I1GzGS0e3LrQX1hmNmSzeK6jxSq4+x1hBfNsr
         hsLKql/Th4dUp79EZpUdL+KlQ/3FMQoRb/Jelc6YVuKijZ5B8r35Y4Zf58lsHOk2WX6y
         QP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrm+4ZKWOsKZ/Gabbvdu+1GZWGD6E7h/REZlQOG1h2Y=;
        b=diGgyQZ8ZHK0J0rVjU3V23PaavIOHkMYfC/qfmfXnaueqYU9lwGZcuCLUoih/EomS9
         0eOHVyfp1Uqgev44dZ1dFQRPPLG+nbOx20UVEliJbjmRaWfonnhgPfFMO0qSkPyyp18u
         qVPVCkWfjN6zaHIjAyLen1WZnIpbR5bAOWE7DDUan+SPBKJceVhw5blxLb/sp0z8Jz1l
         cjS5gEq0P8BxIrkusxCoUJnsSoGS8rgK1PXX9HQ/7MzceDfbBtW7svuKtksEPMywDNrn
         FZTcSH2AYJ3ZkCGbCs4JWKeaL9MmhiPkoNgbIaY0VkWLg/joPyG0KsqyVne/IwmmH8tY
         uxgg==
X-Gm-Message-State: AOAM531nJsjaC6QBeP8OFNvpwHKdicbbG98+zfVX7o22Wyk34wD5qY47
        MYDnhVKMFa4yGh/n1QsvI/uwdQ==
X-Google-Smtp-Source: ABdhPJyaiXthPQ1OA3IBlW+gUs+IRlD0rMYvjVOwcmY95XkayGvMgVue+hxCLKrhxf7fezOzllSg9A==
X-Received: by 2002:a37:af06:: with SMTP id y6mr21639192qke.305.1607297146382;
        Sun, 06 Dec 2020 15:25:46 -0800 (PST)
Received: from kudzu.us ([2605:a601:a606:1b00:2919:5287:92b6:26db])
        by smtp.gmail.com with ESMTPSA id 9sm10006501qty.30.2020.12.06.15.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 15:25:46 -0800 (PST)
Date:   Sun, 6 Dec 2020 18:25:44 -0500
From:   Jon Mason <jdmason@kudzu.us>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Wang Qing <wangqing@vivo.com>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb: idt: fix error check in ntb_hw_idt.c
Message-ID: <20201206232544.GB11795@kudzu.us>
References: <1604655811-31933-1-git-send-email-wangqing@vivo.com>
 <20201110183340.77xcobfsnz43vsa2@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110183340.77xcobfsnz43vsa2@mobilestation>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:33:40PM +0300, Serge Semin wrote:
> Hello Wang
> 
> On Fri, Nov 06, 2020 at 05:43:31PM +0800, Wang Qing wrote:
> > idt_create_dev never return NULL and fix smatch warning.
> 
> Thanks for submitting this. For the both changes
> Acked-by: Serge Semin <fancer.lancer@gmail.com>

Applied to the ntb branch.

Thanks,
Jon

> 
> They are mostly unrelated though. If they weren't trivial I'd have
> suggested to split them up into the dedicated patches. Since they
> aren't I suppose leaving the patch 'as is' is ok, unless the subsystem
> maintainer thinks differently.
> 
> -Sergey
> 
> > 
> > Signed-off-by: Wang Qing <wangqing@vivo.com>
> > ---
> >  drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > index d54261f..e7a4c2a
> > --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> > +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > @@ -2511,7 +2511,7 @@ static int idt_init_dbgfs(struct idt_ntb_dev *ndev)
> >  	/* If the top directory is not created then do nothing */
> >  	if (IS_ERR_OR_NULL(dbgfs_topdir)) {
> >  		dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
> > -		return PTR_ERR(dbgfs_topdir);
> > +		return PTR_ERR_OR_ZERO(dbgfs_topdir);
> >  	}
> >  
> >  	/* Create the info file node */
> > @@ -2756,7 +2756,7 @@ static int idt_pci_probe(struct pci_dev *pdev,
> >  
> >  	/* Allocate the memory for IDT NTB device data */
> >  	ndev = idt_create_dev(pdev, id);
> > -	if (IS_ERR_OR_NULL(ndev))
> > +	if (IS_ERR(ndev))
> >  		return PTR_ERR(ndev);
> >  
> >  	/* Initialize the basic PCI subsystem of the device */
> > -- 
> > 2.7.4
> > 

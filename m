Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E762A97B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKFOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:33:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F6C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 06:33:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so739723wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 06:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DyXfDDWSKwU8s+VIA5hQfPeuUhLrKjIyJ35kol6OQUw=;
        b=lehKZzcTDVaoI0brWupnB6wN/qt2ttOEp1rS+RgjR1ypgpVb6yQSS0va6bulWe9XS7
         49dYfYmOtXqSXUoC6m1qZQXzzOH2LXgk7vvKkpDtIq8GWgAlJTxsGPe5+7Q4H4zJhgT2
         6U9lKG92h/MhuszreEY+6XBYNoAivhPmsyv+5MCbKi4oVH7Uvfm8gjYiWYaGptUy6RIg
         UrEg4dFKmYf7AfsEe/q81H2ef+eELFpkInuUwY1IfSj1p4CwkjRLSKYYrle4xyyYvOOQ
         zvROXxZTgAuWXRyqLo+hvKDIj/OBe0oXWwx63uQRTCKBxKi6jkx7Wc0wFVezM0ZYGVuu
         a3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DyXfDDWSKwU8s+VIA5hQfPeuUhLrKjIyJ35kol6OQUw=;
        b=XFPEslPjmiF+YAW/diZBdHD5adLY8OUZeDxvXEjHtSCDzzAjiCzaWXhmA5q5F2pVT6
         9RmE/+ZO3twgwkPRhwrrnJAN0OU0oHv2QCFH9gx7351Lm/6OtggqymKXMIJGLxctAEjs
         Yinnxq8h1toZomslnfcpeTUEz1mSezD2wIgXHXam7Ud25XiBQ54C74uzBqjpyPVgaFL+
         ROcTwmaTxw9w5lvxD/fyCqNz5nRY2r+R/N22Jq+2AepDD92nuV28Ru6UmUwbuu2GjESt
         Gqnc6cRI4WIvkehUBaCGsepgF3zAk65TVybayHF0im0/+9Jqldcb7CisdM2Wb/J+Q+AW
         MTVQ==
X-Gm-Message-State: AOAM532mgD07cD9TBb9vzFncey51FonFPTXZ6MYI8h8kVIJdaUuqUeHN
        YaAidBSI+s8/7CYz6ZK/kLjrVw==
X-Google-Smtp-Source: ABdhPJwAEZ/j1smm7cvrpAIEJEB1BLq1MOwT4y7JoEF3M4exGNSO232kghjhVfLgpyA8EzWic1p5gQ==
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr3253347wrs.198.1604673189626;
        Fri, 06 Nov 2020 06:33:09 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id y10sm2348316wru.94.2020.11.06.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 06:33:08 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:33:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     vigneshr@ti.com, richard@nod.at, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 00/23] Rid W=1 warnings in MTD
Message-ID: <20201106143307.GK2063125@dell>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
 <20201106133247.GI2063125@dell>
 <20201106144420.13c18b97@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106144420.13c18b97@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Miquel Raynal wrote:

> Hi Lee,
> 
> Lee Jones <lee.jones@linaro.org> wrote on Fri, 6 Nov 2020 13:32:47
> +0000:
> 
> > > This set is part of a larger effort attempting to clean-up W=1
> > > kernel builds, which are currently overwhelmingly riddled with
> > > niggly little warnings.
> > > 
> > > Lee Jones (23):
> > >   mtd: mtdpart: Fix misdocumented function parameter 'mtd'
> > >   mtd: devices: phram: File headers are not good candidates for
> > >     kernel-doc
> > >   mtd: nand: onenand: onenand_base: Fix expected kernel-doc formatting
> > >   mtd: devices: docg3: Fix kernel-doc 'bad line' and 'excessive doc'
> > >     issues
> > >   mtd: mtdcore: Fix misspelled function parameter 'section'
> > >   mtd: nand: onenand: onenand_bbt: Fix expected kernel-doc formatting
> > >   mtd: spi-nor: controllers: hisi-sfc: Demote non-conformant kernel-doc
> > >   mtd: ubi: build: Document 'ubi_num' in struct mtd_dev_param
> > >   mtd: nand: spi: toshiba: Demote non-conformant kernel-doc header
> > >   mtd: ubi: kapi: Correct documentation for 'ubi_leb_read_sg's 'sgl'
> > >     parameter
> > >   mtd: ubi: eba: Fix a couple of misdocumentation issues
> > >   mtd: ubi: wl: Fix a couple of kernel-doc issues
> > >   mtd: nand: raw: brcmnand: brcmnand: Demote non-conformant kernel-doc
> > >     headers
> > >   mtd: ubi: gluebi: Fix misnamed function parameter documentation
> > >   mtd: nand: raw: diskonchip: Marking unused variables as
> > >     __always_unused
> > >   mtd: nand: raw: cafe_nand: Remove superfluous param doc and add
> > >     another
> > >   mtd: nand: raw: s3c2410: Add documentation for 2 missing struct
> > >     members
> > >   mtd: nand: raw: omap_elm: Finish half populated function header,
> > >     demote empty ones
> > >   mtd: nand: raw: omap2: Fix a bunch of kernel-doc misdemeanours
> > >   mtd: nand: raw: sunxi_nand: Document 'sunxi_nfc's 'caps' member
> > >   mtd: nand: raw: arasan-nand-controller: Document 'anfc_op's 'buf'
> > >     member
> > >   mtd: nand: onenand: onenand_base: Fix some kernel-doc misdemeanours
> > >   mtd: devices: powernv_flash: Add function names to headers and fix
> > >     'dev'  
> > 
> > May I ask; what is the plan for these patches please?
> > 
> > Do you plan on taking the ones that do not require re-work, rather
> > than fixing up and re-submitting the whole set.  It would certainly
> > save a lot of mailing list churn if that were the case.
> > 
> > Either way, let me know and I will abide by your decision.
> > 
> 
> I would prefer receiving a v2 with all the patches if you don't mind.

No problem.  Just so long as I know.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

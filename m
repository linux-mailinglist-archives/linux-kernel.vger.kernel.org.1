Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8E72A9707
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgKFNcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKFNcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:32:53 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBBAC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 05:32:51 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id w14so1332606wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 05:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w8s8ntm2MEeIEI9ayWbc8zocfTuCuxT7Pca+ADb+7Qc=;
        b=QPMTT57iu7yE57KwXd2MSuIoF8zeMW6dlOjE29Zt9x9bL7xLRdpukPDMRe9JJTEgoE
         z2iIiLfgwgx1ow66QG/inALdJe+CDzdxlyltDJQzuC00MaqXrcNrVL+gbkLL4N5N6GxV
         gv6e4iwpqr0IRo3025RiRJZMPjSGubVGS7XstCtVJSYGLb8IAB37o2fxtH8WIl/eNSd3
         PufoIT4Q7KmRiSYxVJ8XU2JoHIF9ILcfSnhS2YrA8hI/cc6X0URCLdBlTL+ds9RpWtDy
         BHU0GYhyyaiBAdMQHumOniY0biwr+MMISfgdeimNoXVSdq9feD4bdPvu7No50vDrQX7y
         bH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w8s8ntm2MEeIEI9ayWbc8zocfTuCuxT7Pca+ADb+7Qc=;
        b=kSnlSn7sZ1px6xw2WQ0Il6kF1QKcEeISewYwi2SZzMBkuXvq3vbWyghG1E0xajKTGE
         H1nzEUKOX2RSsRRCXWSwA6lXPQ5fr2e30CBN0q76u0szU9cK/Qzb/ka9lMXecZkM3rSS
         kaCTfiL1Hhcn5Vfxhx2ahoJDSIK9yO55sARP2UeNqaQHuOdm6TKTes43Lk8wrOHEmJk4
         JlzKWzkwa5VCmFFbxUwrNAEWaYHgJi7pHslKSbw0N50E4HNSlxc5AAugvoZgKqnKWzGF
         PjUznHBOoBkn+JZuXUheqidB09s2hw638UdVmHeM2K9zP4AtiARQMWeQblqaiNYh/7fG
         7YIA==
X-Gm-Message-State: AOAM531c3c9tdRFPcJpI6yU3H5csFQ19LUCPA60tEdSWz8wQNMpCur8m
        8mhqUalNP3WRn7UK420UDrMEmd61F0/Kwwl/
X-Google-Smtp-Source: ABdhPJxeXGa3R+8smOLhstaSz3/5YQ4z71LspuSmfI64m1Y6cCR8hwn0U8R3qzR3KdqsDWMxHPyZuQ==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr2749293wrv.30.1604669569911;
        Fri, 06 Nov 2020 05:32:49 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id u81sm2624297wmb.27.2020.11.06.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 05:32:49 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:32:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com, miquel.raynal@bootlin.com, richard@nod.at
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 00/23] Rid W=1 warnings in MTD
Message-ID: <20201106133247.GI2063125@dell>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (23):
>   mtd: mtdpart: Fix misdocumented function parameter 'mtd'
>   mtd: devices: phram: File headers are not good candidates for
>     kernel-doc
>   mtd: nand: onenand: onenand_base: Fix expected kernel-doc formatting
>   mtd: devices: docg3: Fix kernel-doc 'bad line' and 'excessive doc'
>     issues
>   mtd: mtdcore: Fix misspelled function parameter 'section'
>   mtd: nand: onenand: onenand_bbt: Fix expected kernel-doc formatting
>   mtd: spi-nor: controllers: hisi-sfc: Demote non-conformant kernel-doc
>   mtd: ubi: build: Document 'ubi_num' in struct mtd_dev_param
>   mtd: nand: spi: toshiba: Demote non-conformant kernel-doc header
>   mtd: ubi: kapi: Correct documentation for 'ubi_leb_read_sg's 'sgl'
>     parameter
>   mtd: ubi: eba: Fix a couple of misdocumentation issues
>   mtd: ubi: wl: Fix a couple of kernel-doc issues
>   mtd: nand: raw: brcmnand: brcmnand: Demote non-conformant kernel-doc
>     headers
>   mtd: ubi: gluebi: Fix misnamed function parameter documentation
>   mtd: nand: raw: diskonchip: Marking unused variables as
>     __always_unused
>   mtd: nand: raw: cafe_nand: Remove superfluous param doc and add
>     another
>   mtd: nand: raw: s3c2410: Add documentation for 2 missing struct
>     members
>   mtd: nand: raw: omap_elm: Finish half populated function header,
>     demote empty ones
>   mtd: nand: raw: omap2: Fix a bunch of kernel-doc misdemeanours
>   mtd: nand: raw: sunxi_nand: Document 'sunxi_nfc's 'caps' member
>   mtd: nand: raw: arasan-nand-controller: Document 'anfc_op's 'buf'
>     member
>   mtd: nand: onenand: onenand_base: Fix some kernel-doc misdemeanours
>   mtd: devices: powernv_flash: Add function names to headers and fix
>     'dev'

May I ask; what is the plan for these patches please?

Do you plan on taking the ones that do not require re-work, rather
than fixing up and re-submitting the whole set.  It would certainly
save a lot of mailing list churn if that were the case.

Either way, let me know and I will abide by your decision.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

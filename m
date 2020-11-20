Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD702BA3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKTHuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKTHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:50:05 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A466BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 23:50:04 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id s13so8931043wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 23:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ebx5P9t5H+MiQQTlLfM0hkZw/MTzmtdqFls14AM1z/M=;
        b=e1mwo+ECalTd3S98s5Ektjznx93/PmbMRwHlKHMiD8na32C42TLPqJljO3cb1++GrV
         XbnjjRsDxXrnJuu//pgdIiiKhC0vACcmUHFq7Fg2IkM453kGb9jhMeVMJV1hOQWPb7XG
         X2z+sg0YTSqBEmNQ5Q+SMQ2VqUq66zaSsoKEo7Yx6iSIIHR8ou3N2cOeU0luTK4Pq0A4
         TekOE63Co03VRv5c6F18ey/D3z7/3oWE5A5odAixoxpsHpkwQ3hnFwWoH4cTKZKibOqS
         g1wyVQpH2YqyNL0PovbKe9CQeiFXsekdAFfP9bdfOMeA88XQ0weuxDMsnPoctKGeX2QA
         gG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ebx5P9t5H+MiQQTlLfM0hkZw/MTzmtdqFls14AM1z/M=;
        b=XEeMYxwYstuE+sgDrFLZPjDgYzw2OYtdL2Glr3LLC6W08G7wOVqADwiK5LTJ5vybNu
         hTMBpjhnl+10qusDeEhr1TQ7XD/7E0PcfCCpJWYsP2J9yk7ZK9/cuq0gf/9ZB6dR4qCG
         adYkVOTc2rEjiLZ2cTbWQAhvvvEwPZ9qIhgSv9lKt8imZgNtzq5ssGlfLr7l2hzHcXP4
         yrtGJOwlC9eFNel9u4WUIAjpSkIwZ4XQJnFhelc7noraZuWcpxjYsy6utWqJ1vxdW3a4
         apUjijJcq4aa0vaUi5kbwiryuu12b9K84Sr2xgHBiU4dpgTwikSwGssjQRIJ0ERW2nBn
         MR7g==
X-Gm-Message-State: AOAM530qri7kSGFm953wImnZq/xlGCD0pU6yXeIElz3ErDe8Bwnxby9j
        r8PdGneks4uAExinUa1DhftfopcnmU4AVmO/
X-Google-Smtp-Source: ABdhPJx4fGTY2rHUzVNZxl2TJRKDria44u2mMJodTpI8NFP2+B0rLTwEJhgPV9+TxdAoNSy5h1Qd8A==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr8420302wmb.139.1605858603401;
        Thu, 19 Nov 2020 23:50:03 -0800 (PST)
Received: from dell ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id u23sm3555393wmc.32.2020.11.19.23.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 23:50:02 -0800 (PST)
Date:   Fri, 20 Nov 2020 07:50:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 23/23] mtd: devices: powernv_flash: Add function names
 to headers and fix 'dev'
Message-ID: <20201120075000.GA1869941@dell>
References: <20201109182206.3037326-24-lee.jones@linaro.org>
 <20201119210716.25046-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201119210716.25046-1-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020, Miquel Raynal wrote:

> On Mon, 2020-11-09 at 18:22:06 UTC, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/mtd/devices/powernv_flash.c:129: warning: Cannot understand  * @mtd: the device
> >  drivers/mtd/devices/powernv_flash.c:145: warning: Cannot understand  * @mtd: the device
> >  drivers/mtd/devices/powernv_flash.c:161: warning: Cannot understand  * @mtd: the device
> >  drivers/mtd/devices/powernv_flash.c:184: warning: Function parameter or member 'dev' not described in 'powernv_flash_set_driver_info'
> > 
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linux-mtd@lists.infradead.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Superstar.  Thanks for your help Miquel.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

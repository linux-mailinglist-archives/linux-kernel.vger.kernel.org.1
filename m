Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE2D2B8E80
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgKSJOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgKSJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:14:08 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4875C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 01:14:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 10so6427790wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 01:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q1kCKO2Wajos9XCYv+42QajKl+b5nwdS+s4fQXMXkC0=;
        b=aHOJude4XUYBYjMHIXIqvPOfAJzFbbFBGbY5wBxiUcWK3+/nHouZjtA7/WMBcAkiHz
         gQ66gQ7MTko4w0yV/MsSX8nZ3MP4plP2aiBbnPMAr5ojbCMY46+sYgtkBjND7pnVCjRb
         zah9CpF0jKDxPeNgDaIUtGFyOE9Cc7nsfubxmbozzEaGLgSpaGNir0A6W6RT7UgVT/hD
         EBMLBiBueBBra7fy1k5YpGhKiUFbLGn+3spcyNr3MhqRp/M9VDqyjgSuGM8st9+2qzba
         YujN/QBFgpxCTLjZjZxq1gOMMNy4Ecw6Jn57htDgPDXmo0xWVEzQgeyVpZNbOZbxwRm/
         CsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q1kCKO2Wajos9XCYv+42QajKl+b5nwdS+s4fQXMXkC0=;
        b=IoM+sMvaN1CzeVNUF4ATMl5u/YB1SqEJsyOH1Om6w0umAIMkNCVGGfNzuZPkUtwGPh
         rSt3S3yavJJIyXr72trAli2Elj1PYbVfoIunUz0RSpPJrwwb8S2ZG3FtXRLzyYAOCsk0
         BW72fvIdBgB5KRNZdNl4CG1QnRIcGwbj9UcH5x/7t4I5lXHSezHSlfj1UU+OA+D1D3sS
         amS3FeKTT4NUZyj2obucU7L/PjLhXXRgqHwJh5OnJU/KIGxWNEuuhDqgBPFMgWnlzQRU
         dYwX2zrId0QYrbcEo1ocwm8I+VZ1PGqGplOuzyRtyT4w79ozynm96MhLsxnv8TRK+ocs
         NbUQ==
X-Gm-Message-State: AOAM530oGKj8tPLYyE9zJWthNzSrcZkGb+dzlT2/DZ5gq5BTx1m2fDFB
        Z3WgSsrSvlVcvKJASlmRec6vx7aGQ8wq8o7z
X-Google-Smtp-Source: ABdhPJwE7lzWIduefdcr1ejwZbR/vePOO0xyNX6/Qw/49e6vJ75qt37PcLbLMcgnz+VSxsYH51hUiA==
X-Received: by 2002:a1c:6306:: with SMTP id x6mr2659954wmb.154.1605777244745;
        Thu, 19 Nov 2020 01:14:04 -0800 (PST)
Received: from dell ([91.110.221.241])
        by smtp.gmail.com with ESMTPSA id g186sm24648747wma.1.2020.11.19.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:14:03 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:14:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thomas Gleixner <gleixner@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 01/23] mtd: mtdpart: Fix misdocumented function
 parameter 'mtd'
Message-ID: <20201119091402.GY1869941@dell>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
 <20201106213655.1838861-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106213655.1838861-2-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/mtdpart.c:300: warning: Function parameter or member 'mtd' not described in '__mtd_del_partition'
>  drivers/mtd/mtdpart.c:300: warning: Excess function parameter 'priv' description in '__mtd_del_partition'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Thomas Gleixner <gleixner@linutronix.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Is there anything else you need from me Miquel, or does the set now
look suitable for inclusion?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

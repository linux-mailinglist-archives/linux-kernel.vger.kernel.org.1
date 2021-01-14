Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53942F5EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbhANKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhANKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:23:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFBAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:22:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d26so5152431wrb.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QIyL9Uw+vfuGT5cNV4SCiN59pKgDZZ0r/aGN6Gj7Cbc=;
        b=W6U/rx99DHjceiADT1UQoT/TYprMOmBw5kgwTq9TVJEE4SOMKJsN/+127+O3+E3FQ2
         nI+puxdYpYyUHiK817ifu11spReZQAK1MoekYSJOiVYn2sKc8YAf7aoQbMgOKHQVJKJT
         lqvuucIyQQD5R7ovABl1dRGacOY5Iwb1MrOnmwmacqHpbFakdV+vcbc3Al0KHnoQVPnH
         SOmwMNH+Y9Vq+u8wnX+q8kIXwaeCmAdlnP4SMA1HdDUPjSBxbUDPus2TFzc3r7E/MNEP
         /iY4kiuOORNBIYCxT0oP0uWxYWqNBCf5yjsKXmpFJ7NdjItUksDKXVkvoKyPNlWAzRVd
         NhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QIyL9Uw+vfuGT5cNV4SCiN59pKgDZZ0r/aGN6Gj7Cbc=;
        b=Ad5ZdFoXhErc4v7BpOPTi32AEsQBvJ5ti6UvKoN7H5p5pjgAZ6QTf86/DX7g3JdV56
         4XmeNjcVQhDvdq0QsHe3Pf2B1DwoOVjkknNWBhbNsIsPuphH1VTwBQ6BSyETBdkZrVt9
         ZEwmMnqazx8GVSEtVNjN58WQ+vcXfLKJ0lcJPWSkW8A9ER7HSN67HZ1eFTE5C06BEM4/
         am7pVfzIXDfsjI2o0/7zVyI+hS8+GFYmbah0RA0edz+4VR5ZJyYKuv1rcDeDAc+BSCvC
         iqTk1RSKxEm0M5OOp9Xbp9L4NPSbyGPA642LlJYl4l45p4do3y3dluQKoR2JkFZPdF0v
         G4+A==
X-Gm-Message-State: AOAM531npR4NWciOROmmhGmNpTwtUPX/ZVG+FpvPp5yGn05buOYLHohK
        M54pDrPFSzgWFNWCGTaeSUStySyOSvIofr5U
X-Google-Smtp-Source: ABdhPJzXp6RVWiSV2k3P66UHDVAXtYbJxyLKjpObtngmdn134g5aUph55JB7GTPQAi3/+R/YLQa29w==
X-Received: by 2002:a5d:5049:: with SMTP id h9mr7359351wrt.404.1610619743123;
        Thu, 14 Jan 2021 02:22:23 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id u83sm7616248wmu.12.2021.01.14.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:22:22 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:22:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Alder Lake PCH-P PCI IDs
Message-ID: <20210114102220.GS3975472@dell>
References: <20210105153925.62283-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105153925.62283-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jan 2021, Andy Shevchenko wrote:

> Add Intel Alder Lake LPSS PCI IDs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

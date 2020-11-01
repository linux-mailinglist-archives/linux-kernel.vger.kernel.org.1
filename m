Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7750E2A1E38
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgKANL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKANL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:11:26 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F355C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 05:11:26 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w23so6853530wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 05:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GRrHOthps9zf4Auc9/JlDQwutpigo7Lq8Mr1OxomJKk=;
        b=rci98WPZ7wj7OrYX1nyAW9H2FIxoFIssMu6mCULkKMPE7BxQIGpDBITLwhJxC1IQED
         USeMNuKECDt3fctkRdl6/CtbuzjAikGTdw30nmMTqpRxTfkdgAKR9iH8GDLCKi9AI5XN
         NE9KJnBTUH7Y9zQ1bes3DIz8x3HVJ/91heVfQ/R2rweEPpUv74Oin75uzPFRXC0CiM4e
         jHYlbBFI1xg0UImj07/TJiNd4YsRg4wVRhpPFC8LRlun8OfaVCIGS/S0Y9Gt6giG38GW
         agsO6HFgXft1HGd+sN4Pgv6lXYsWf6sVctTr0ci8n8Simaij4e62as1hIMgUNHzGq6nD
         UxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GRrHOthps9zf4Auc9/JlDQwutpigo7Lq8Mr1OxomJKk=;
        b=E5OqcDhdPmBwsLIFxBailXjXH4xdIsC1FYxrS9/xGmejtl8v9VrX87By8JQIa1c5OZ
         GWzU9GA0yRDINzw/mGwMC+ny7J14YBeiCwu5smwNGJuiQ7Ee1HA4TNsG3GOkJhFxJcvb
         1hyg3fj0CsYQVIziB79XC2aT2rZOJ3RLaK0CHaS0SFeR5x9wJv4gWdzV1wD9VJBhYPTS
         BUHvb3XoLJdtIrSHQOfvv+nBD7kV12sf29tNRESppnZMaHVlj1aCD1L/3wHQ/Qvdyb7t
         NnauKJ6TEl0UVYgBUeyrIoZ2mYgSuDoD569rFIkWXsf9ioNRde3a7Giz9tvcQ8iDrvv3
         2JgA==
X-Gm-Message-State: AOAM530i5gfkAGtdwNnmjjC7wfgSZmVPHz79Dey3iGh/YCuCAeAYDdK5
        KUafYYxmfxg8uxBjcGrPmXhwyA==
X-Google-Smtp-Source: ABdhPJzXr5t0XeK+ClsK0P96R44KjtAAm+3QXxnJ8L1pcRNTN3ZH9K2+Bgu6kiPaCwXyAZ0Gs+iGMQ==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr12610500wmf.111.1604236284579;
        Sun, 01 Nov 2020 05:11:24 -0800 (PST)
Received: from dell ([91.110.221.176])
        by smtp.gmail.com with ESMTPSA id f1sm8439821wmj.3.2020.11.01.05.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 05:11:23 -0800 (PST)
Date:   Sun, 1 Nov 2020 13:11:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        yepeilin.cs@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] Fonts: font_acorn_8x8: Replace discarded const
 qualifier
Message-ID: <20201101131122.GD4127@dell>
References: <20201030181822.570402-1-lee.jones@linaro.org>
 <20201031102709.GH1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201031102709.GH1551@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020, Russell King - ARM Linux admin wrote:

> On Fri, Oct 30, 2020 at 06:18:22PM +0000, Lee Jones wrote:
> > Commit 09e5b3fd5672 ("Fonts: Support FONT_EXTRA_WORDS macros for
> 
> Your commit ID does not exist in mainline kernels, which makes this
> confusing. The commit ID you should be using is 6735b4632def.

Ah yes, quite right.  That is the ID from android-3.18 where this
issue was first seen and fixed against.  I will fix it up for
Mainline.

Does the fix look okay to you though Russell?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

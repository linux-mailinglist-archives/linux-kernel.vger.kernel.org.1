Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5404929EFD8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgJ2P2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgJ2P1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:27:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E691CC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:27:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w1so3238479wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5yihwEJHhD6yUSoqMFixvNRTmupkb6uwUjgpXDMjAVw=;
        b=Rs4EfmngejS1DTek+LshRa4uIDewFCrHKsPScfG76cIQDAyiwPaX5pYemQZWCQUK+O
         NknWT+05C4HRuUnUCeVkWG+Av5N+kUv4auD9gr3VCW6p4oN+7PmJJFNkPUj9VXY7lqCh
         l5Uk2PxCT8bfzZeGuSVvGb3iVBDYKalI5m26mlG/dINVnGAODiTbADWSWDx3DJofY2gx
         yA/aV9STC0Kv6+Qux6rEbdH4jedi8SUWlbgS/is5Zeu4re9vn5MdNkj2HReL5mnsn9Pr
         GhaOGDh3zZ0r4Yo1QxrxbMYuPYJzRumuUr298fcNCIwk+yEjEdGYfKN+325aRxi1SE3Q
         ho6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5yihwEJHhD6yUSoqMFixvNRTmupkb6uwUjgpXDMjAVw=;
        b=nicgnL80fu1VqRpFNBnnXB2YuVtEjiP6X75CXAnqFsK/MwbG4m4vQZbKhOJDFj6+iy
         XecWTWP162Ztevv3eCLl4a7ZXd5iRAvkPZYA1Vl+S8K+310hcyOxaE7qhb3LNA4GEqgv
         LSjGOIheuChB0qnUXS16oCyk16Q+ePHRfGk5nTjP2HgVj1+oaaE2Ub4KOH+1LI9C8U0Y
         8gRyZjoHWWW7BsLdhyEw/p7Lrihk/wnxChSBtXymm4caKLL8svgHGbLMFivzHjwdP00r
         6ua2e5ZDdkBtE1sWZtSRRrWgDxjUog2OXh1UQQBe5M7EllVug1Of143/QTiiBeoNWren
         roXg==
X-Gm-Message-State: AOAM530/fYJtSYmB+KHE/rZf27ZmsJsbtGh5agQ1IQEDSo6+EE5JlRqd
        aBJIt9nJ/tgcTdx/OJD/awNpEv0eUzY4Jg==
X-Google-Smtp-Source: ABdhPJy69xBGlnPIJReYtBG/scUyF0lN3h3AVYD6KrdKpt1z54NvpNY9X5XOcovRSBBK0v9G5iEk7g==
X-Received: by 2002:adf:906b:: with SMTP id h98mr6263042wrh.310.1603985241690;
        Thu, 29 Oct 2020 08:27:21 -0700 (PDT)
Received: from dell ([91.110.221.160])
        by smtp.gmail.com with ESMTPSA id o129sm310549wmb.25.2020.10.29.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:27:21 -0700 (PDT)
Date:   Thu, 29 Oct 2020 15:27:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary
 CONFIG_PM_SLEEP
Message-ID: <20201029152719.GC4127@dell>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
 <20201029100647.233361-3-coiby.xu@gmail.com>
 <20201029110029.GF4077@smile.fi.intel.com>
 <20201029142911.p54mbwbfaeymrqy5@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029142911.p54mbwbfaeymrqy5@Rk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020, Coiby Xu wrote:

> On Thu, Oct 29, 2020 at 01:00:29PM +0200, Andy Shevchenko wrote:
> > On Thu, Oct 29, 2020 at 06:06:41PM +0800, Coiby Xu wrote:
> > > SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
> > 
> > Have you compiled this with
> > 	% make W=1 ...
> > ?
> > 
> 
> Sorry my bad. I thought I had run "make modules" with CONFIG_PM_SLEEP
> disabled. I'll run "make W=1 M=..." for each driver after adding
> __maybe_unused in v2.

No, thank you.  Just keep it as it is.

The current code is space saving.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

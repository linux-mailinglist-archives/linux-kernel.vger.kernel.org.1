Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923BE2F0834
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 16:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbhAJPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 10:49:42 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E0CC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 07:49:01 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 30so10972324pgr.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+4PfVpWzIwPp8aKWtKGCptiTFkBNjW8LRR/4faGpkhk=;
        b=uetcUeWGL+KLQeDlN6q0dqdxyDb8W98E1HoxCyviCDAokQX0QprFgLLHwPSaSERuCI
         b+sW1fiNX1jGsa5AXWGoa9eRiz6MzMe14FJiz/H3my+AJpNhkv7+14v4r7G00he6aY3j
         KuJlVLxHLdwULhGm6DKMt2h/rtSHhOTcMxYUSLDV3MkLsvTUU5SGYoInjUj+kAx/0fbR
         u9QyzKaW3OyMQVkdzRlFQTBj93G9p42lFCnOPb85CgYRtOOOw0w/XfsV2yP2SCvwrlfA
         yMKjHdqu/mTDaOSF8omgy/IjJAGyfGHMWYy0XtR6arlQ55Hotn3zpp0NdiAO4XAXrpwe
         gEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+4PfVpWzIwPp8aKWtKGCptiTFkBNjW8LRR/4faGpkhk=;
        b=gaHOwBKkFh2+KDIjlwR8uvInzKLmqzug6fxvtIlMKKBf2VAbKlyud4ofwwaCY8vb0u
         B1BGPFgPp6HohnVoq+HxpTJG87hOSzT4/QQ5cfi8EIuIfkmeOSEmIzZ9w3f7gk1v3Sav
         AQDOhLu2c9ESeO1Z/puuiZqaBTgMUwoJhR1QDp2wwUt54e7Rt46LH68PaCJikNEXab4G
         3AHZlrxgRuVySu69qm7WDJVPQb+Nj6BZ7q6YlC32p2iuNJISP2hvnJldmo0PgMzg8i5Q
         ZhvZ3jmzoXZU6N9lFE43qO7RGh5uFIJzQRe3ee8BSeKA3jZdKWij60GYcAUtuurQaLna
         OdJQ==
X-Gm-Message-State: AOAM531YU9OYUty6NLBWkeex26vP0BFOYGdL52czbY8gVId4kzeEN/VG
        cbym3CWSkga1h7qMo/Yp9sXU
X-Google-Smtp-Source: ABdhPJyYfhLMVP2TMnuARZ+px/60XGDJc7t5XLSGFCjLDWxXyCz/sXm3e2Q9C8ix2ohXgPGNtIulsg==
X-Received: by 2002:a63:1315:: with SMTP id i21mr16045078pgl.370.1610293741244;
        Sun, 10 Jan 2021 07:49:01 -0800 (PST)
Received: from thinkpad ([2409:4072:6d1d:b3a0:54f0:7e43:912d:37b2])
        by smtp.gmail.com with ESMTPSA id 123sm17076145pgf.38.2021.01.10.07.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 07:49:00 -0800 (PST)
Date:   Sun, 10 Jan 2021 21:18:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, baicar@os.amperecomputing.com,
        saiprakash.ranjan@codeaurora.org, bjorn.andersson@linaro.org
Subject: Re: EDAC driver for ARMv8 RAS extension is being worked on
Message-ID: <20210110154853.GB15624@thinkpad>
References: <20210110151149.GA15624@thinkpad>
 <20210110152943.GD22211@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110152943.GD22211@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 04:29:43PM +0100, Borislav Petkov wrote:
> On Sun, Jan 10, 2021 at 08:41:49PM +0530, Manivannan Sadhasivam wrote:
> > I've collected the feedback on those submissions and came up with the idea of
> > a single "armv8_ras_edac" driver which will work for both Devicetree and ACPI
> 
> "ras" and "edac" both is too much. Just call it armv8_edac or arm64_edac or so.
> 

Okay, sure.

Thanks,
Mani

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

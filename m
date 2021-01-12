Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA61B2F2A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbhALIhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbhALIhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:37:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D99C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:37:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j13so1213207pjz.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sNacm9ehhXHDD+E+vM/v4BSvqULuhqFVBF88cmNDIFo=;
        b=DDMq/obY0QRg81EH+vwR4Kgm7tPTFPl/QX9l02SSYrbXsJ99XvqoZTeFYfzkiZpX+U
         lZsNY3XGyTFluu9B6DC0Ysf0LMEg3zK3rWzqePz34pghQ8c/qAEI0yYfNPX1VkfnPiWB
         96vjwX9nlQ0wF95bAc0MLMNYyfiP1htNj59GdGbkfoALVg9ZFCojWWNkg83OlEU+NycE
         8tVX76MB6J1ONXV51AcASm4IWBtL6zuECHYdo1Prwq+UaSYLC6RLq4Th2hSrtGSmLbVt
         ifCq5JIBU/PaUXj++wHGKfmhC5XNtwjxIqsIje5q6ZfDOpzSNo5fGxScY3VLW+q54nyK
         do7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sNacm9ehhXHDD+E+vM/v4BSvqULuhqFVBF88cmNDIFo=;
        b=cO2WxZarcXWAIEvVlffoYg/y/7eczTdjfY8Ru93ZmbKaa1PpbqGMFMvPTuR13iOfD4
         XRHs4Yuki9bu2hkiBKBB1+HdvDJdJuEDiECFpOOZoNlwhJbMEYbtFwJGzlMlbwMnKXcJ
         X9BVekrb3HDK0zVJ7wOI8bg6t66+uuim173dsccJIhk4viP9dRE9gF/Fv3XBbfpSB3LV
         xs0YJjFYvS2CfL6dGa8wVWYtI/JW0YnmXy/YsXG9f5VJRfAMkLeS0jFDv3CSgQGhORI+
         Hsnjf8anfVn869bx3R8mCiTeTRtBXN07Q+xjgvT67DJu6JiZ74z3ffnIiffZKJVyqpyN
         SXMw==
X-Gm-Message-State: AOAM533XPwS+cKqBtSE0jSw+wjdDimzdFF+FrYMKaBOTSSgq+3UgUbFZ
        rDzYgmhVKKEcqTZ1QEe/5736LhuVoXRZ0A==
X-Google-Smtp-Source: ABdhPJz3clZ59bT//pRKzHW2VM+sQQyK+EpOtnrH1NFu1PVlACLYTXzKe57v+JEyGW6un9EttLrJOw==
X-Received: by 2002:a17:902:8203:b029:dc:3371:6b04 with SMTP id x3-20020a1709028203b02900dc33716b04mr3692078pln.81.1610440626102;
        Tue, 12 Jan 2021 00:37:06 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id b1sm2112101pjh.54.2021.01.12.00.37.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 00:37:05 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:07:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bill Mills <bill.mills@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        anmar.oueja@linaro.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] of: unittest: Statically apply overlays using fdtoverlay
Message-ID: <20210112083703.yfpicoi4zrddeykd@vireshk-i7>
References: <be5cb12a68d9ac2c35ad9dd50d6b168f7cad6837.1609996381.git.viresh.kumar@linaro.org>
 <1e42183ccafa1afba33b3e79a4e3efd3329fd133.1610095159.git.viresh.kumar@linaro.org>
 <23e16d20-36eb-87d9-4473-142504ad8a95@gmail.com>
 <31611390-eded-d290-36a7-0b1e8465f71e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31611390-eded-d290-36a7-0b1e8465f71e@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-21, 20:22, Bill Mills wrote:
> On 1/11/21 5:06 PM, Frank Rowand wrote:
> > NACK to this specific patch, in its current form.
> > 
> > There are restrictions on applying an overlay at runtime that do not apply
> > to applying an overlay to an FDT that will be loaded by the kernel during
> > early boot.  Thus the unittest overlays _must_ be applied using the kernel
> > overlay loading methods to test the kernel runtime overlay loading feature.
> > 
> > I agree that testing fdtoverlay is a good idea.  I have not looked at the
> > parent project to see how much testing of fdtoverlay occurs there, but I
> > would prefer that fdtoverlay tests reside in the parent project if practical
> > and reasonable.  If there is some reason that some fdtoverlay tests are
> > more practical in the Linux kernel repository then I am open to adding
> > them to the Linux kernel tree.

I wasn't looking to add any testing for fdtoverlay in the kernel, but
then I stumbled upon unit-tests here and thought it would be a good
idea to get this built using static tools as well, as we aren't
required to add any new source files for this and the existing tests
already cover a lot of nodes.

And so I am fine if we don't want to do this stuff in kernel.

> I thought we were aligned that any new overlays into the kernel today would
> only be for boot loader applied case.  Applying overlays at kernel runtime
> was out of scope at your request.
> 
> Rob had requested that the overlays be test applied at build time.  I don't
> think there is any way to test the kernel runtime method at build time
> correct?
> 
> Please clarify your concern and your suggested way forward.

The kernel does some overlay testing currently (at kernel boot only,
not later), to see if the overlays get applied correctly or not, these
are the unit tests.

What Frank is probably saying is that the unit-tests dtbs shouldn't
get used for testing fdtoverlay stuff. He isn't asking to support
runtime application of overlays, but to not do fdtoverlay testing in
the kernel.

-- 
viresh

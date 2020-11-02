Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79D2A2889
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgKBKvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:51:30 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D945C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:51:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id y12so14015403wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 02:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kJ2Qk+d6nVO4qztRVSC2C047EFiVw1O4Iypq+cqC+jw=;
        b=bs93L0ESL/tO8cxcZVkQ6uHNQG8Ywj4VcCjUrDc6rxI0a/A3mGRhEHCMa2fPG9msr+
         B3aCGOiVIPmOtLvi8w9KaygEEMM6ZMSnxAv6g2bX6vjp5beCST/kyxTGTZWmhmicQgy3
         bTvZaDdfLlCb4WGA2A6wGsm+YrJZdAJfHKTp9+UcjClgJEAHIPgH+hWhhXEOQlyBt5Td
         Uo5Jzci/QPy4S0fZvV4MNIIJZ6HENvPwwgKQ+ZkbChIX07fANRNHLReS7xhuUB5IfgFW
         5Shg9RjdNe5dTe2Tt20r8K1QUfTfxWwprJj6iev2ntRzGYAke2hn1ICD+YU/nsphY0Y8
         NIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kJ2Qk+d6nVO4qztRVSC2C047EFiVw1O4Iypq+cqC+jw=;
        b=KGiVhLnbDEW9k2GcNUem0tF3AjeuhTt/FQ1YuvsifdJeRY7E2Zzl8GxBSEGq5EnwqW
         z0F6p7AvTlwK/stGsGyVTuFFxEhElykZSswF2JVX80KBafEXOx2QXzikzSkFndsei3OQ
         EoeaCr421bBf9VehVac4vVQJfgjEIYQFxxf/nQwe319aNZ129OGC7lHez7VjO62Uc7hc
         2vWVqGtk5SiESFAsl2FRpITfTKaL9m0H6EeHPfLKFIBvuSd1Ua8OR/gJC8UV/VEvZj+x
         tSW59x/gr2IE6liDTY0WTr5FXO6IxM2JkKPabzDkPDMz+BQfF3d689d03G0sC4z7BujE
         8b+w==
X-Gm-Message-State: AOAM533iwmmoXHQ2WEqnonWM9R10x4HhJ2Jx/KX6S7zkTiOYMyYclSI6
        k1CMDZP35g1vYSe5GxJk3BmKoA==
X-Google-Smtp-Source: ABdhPJwbEzgvc4dP/pQuBXTNdbYSOc0T7hgZlJL3BnLmise+myMQhJ8Ullz9wYaimPbtZVGp8CTxQQ==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr20695407wrm.116.1604314287978;
        Mon, 02 Nov 2020 02:51:27 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o3sm20960571wru.15.2020.11.02.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:51:27 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:51:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Coiby Xu <coiby.xu@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary
 CONFIG_PM_SLEEP
Message-ID: <20201102105125.GJ4127@dell>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
 <20201029100647.233361-3-coiby.xu@gmail.com>
 <20201029110029.GF4077@smile.fi.intel.com>
 <20201029142911.p54mbwbfaeymrqy5@Rk>
 <20201029152719.GC4127@dell>
 <CAHp75Vd6dV18x9BLOSSEqL-nVSRhAEc9zQCyOJF7P7tur86BDA@mail.gmail.com>
 <20201102083955.GE4127@dell>
 <CAHp75VeWbhEbVg2HYaeU2trASJt1EKzJfUG1VRJpD0CL+onbrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeWbhEbVg2HYaeU2trASJt1EKzJfUG1VRJpD0CL+onbrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, Andy Shevchenko wrote:

> On Mon, Nov 2, 2020 at 10:39 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 29 Oct 2020, Andy Shevchenko wrote:
> > > On Thu, Oct 29, 2020 at 5:27 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > On Thu, 29 Oct 2020, Coiby Xu wrote:
> > > > > On Thu, Oct 29, 2020 at 01:00:29PM +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Oct 29, 2020 at 06:06:41PM +0800, Coiby Xu wrote:
> > > > > > > SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
> > > > > >
> > > > > > Have you compiled this with
> > > > > >     % make W=1 ...
> > > > > > ?
> > > > > >
> > > > >
> > > > > Sorry my bad. I thought I had run "make modules" with CONFIG_PM_SLEEP
> > > > > disabled. I'll run "make W=1 M=..." for each driver after adding
> > > > > __maybe_unused in v2.
> > > >
> > > > No, thank you.  Just keep it as it is.
> > > >
> > > > The current code is space saving.
> > >
> > > Perhaps you need to go thru __maybe_unused handling.
> > > There are pros and cons of each approach, but not above.
> >
> > Do you know that all compilers drop the section?
> 
> At least all that Linux kernel can be officially built with.

Fair enough.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

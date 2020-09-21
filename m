Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC19273327
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgIUTua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUTu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:50:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B77FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:50:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k14so9936189pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfum0xk/RZI5/Ob/LotdK/fUqBVcECeLZPhlAXF7GSA=;
        b=MzlFGtZxMRR3IzQFO78/27PAi9Tln8PEKmg4AWR1bn4Yo/X9UINdsoC9HczWeOPzK7
         QNTmfcvvkJG792tUX68D4WrnSFP9CgJoYPCVFNR3GKZ+FyLm9t8ZFvvG1E2VbgZ5QAOS
         +fB2gXbEHSaAuwNmKSv0Pd9zLHo+Oakazz/3+sTuhR7vJmpMwG3RSQFWLIHrAFmxsCGF
         rqx+I3MNILJxZtgM/ON8s9FbFBrflmYiKAX23PoTz6WxO8eG+V87SwM9NqDKQlik6d31
         oPGbYOdDpITjhl+sn2utDDkLbhUp7n/Am/HwVzM1DY93mI1ZfI1r1BvJTjtfivUMY2U6
         ZKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfum0xk/RZI5/Ob/LotdK/fUqBVcECeLZPhlAXF7GSA=;
        b=a3ssneYLS5n65/EkQfdvGFuKgeysbmOziZJnPcyOtDPqHC+RMFyEIkku+FP00oIWQp
         q0Y7PKEa2/i6/1QyxQHtwKYFph3+21/xu/LpAxNXyMF95OxiR/yh8zR+cmE55pqTLxd7
         Sh2Gni0mJDWGILhPdNHIMJ9zICtH6BWNfzOVNNn3FykSciahmgAl0egb9Hte/nH6/wkG
         TTL+CY1tr96cMlSPE5JwvQpQI8Chdxg86ZUlaNm9bY6WdFmk/2eG+v3D6sjV9K4v+UbC
         lE8NOQExFs2KKTHK3e/kuJlo7J1pxQLAbmuNLQP1BpeJ1sTvf6TBPA01AFHeAEdrxgHi
         xtIQ==
X-Gm-Message-State: AOAM532y7XlOw7YKCJ7QmulprBPML5ccRJyqijx/sDD0xz2B47jf7+mf
        9eXNzlvJndAltUIDGkOEvf5mALKSitdiQuwXAuLhJQ==
X-Google-Smtp-Source: ABdhPJz0K7J9Kcn11+9meMrf3vRxVrLQJR4W3Bic2SiC1mK4LkwttbXKUrEWzTmF/9m2Ua801TzhyzK2CS2WC7W1H4g=
X-Received: by 2002:a62:5586:0:b029:13e:d13d:a108 with SMTP id
 j128-20020a6255860000b029013ed13da108mr1208250pfb.36.1600717828686; Mon, 21
 Sep 2020 12:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkGd6mPw_OKHwmpVs_xxFW2oqAoXyr7M8hu3PCCwkqCEQ@mail.gmail.com>
 <CAPcyv4jZfbuS8zHZXBNqRTi_1HzHLUztkxDmsruMk5PGinGhPg@mail.gmail.com>
In-Reply-To: <CAPcyv4jZfbuS8zHZXBNqRTi_1HzHLUztkxDmsruMk5PGinGhPg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Sep 2020 12:50:17 -0700
Message-ID: <CAKwvOdnVeAFu_Zb2KNuCUcVRWcqsX9r855uyKAMR4+FM8LTdoQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYZGF4X3N1cHBvcnRlZOKAmQ==?=
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kernelci.org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:47 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Sep 21, 2020 at 11:35 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Hello DAX maintainers,
> > I noticed our PPC64LE builds failing last night:
> > https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047043
> > https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047056
> > https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047099
> > and looking on lore, I see a fresh report from KernelCI against arm:
> > https://lore.kernel.org/linux-next/?q=dax_supported
> >
> > Can you all please take a look?  More concerning is that I see this
> > failure on mainline.  It may be interesting to consider how this was
> > not spotted on -next.
>
> The failure is fixed with commit 88b67edd7247 ("dax: Fix compilation
> for CONFIG_DAX && !CONFIG_FS_DAX"). I rushed the fixes that led to
> this regression with insufficient exposure because it was crashing all
> users. I thought the 2 kbuild-robot reports I squashed covered all the
> config combinations, but there was a straggling report after I sent my
> -rc6 pull request.
>
> The baseline process escape for all of this was allowing a unit test
> triggerable insta-crash upstream in the first instance necessitating
> an urgent fix.

No worries; just checking that failures are root-caused.  I see it on
top of v5.9-rc6:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/.
I don't see it on -next today, but assume it will be there tomorrow.
Thanks for the info.
-- 
Thanks,
~Nick Desaulniers

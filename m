Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F312C206A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbgKXIvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgKXIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:51:42 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066BAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:51:42 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id o11so21093743ioo.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6G34B8UuYAuKelScbRyT107JffrqzzUEbW2EtqDPeNY=;
        b=OCLmvw72ObHFVDiScD08rJnqQbrVi8VXSGtvRWItHCcnkmYaemxWdRri2G9j4Bf0yw
         EJ8oZM3CuAZYL84IjKu8PklfLunlpeToKts4l3JaJ3tizyjI0neNgO9ymmksO8CFuMR1
         osLmtVR/TQ9e9JnZsO7dTD/t0vmtFYMBtsoQKBIV9OexYzSkshmtTeqTBFpjTvhMRsRe
         PX/X/cfhBEhL1Ri5HDSxWEZC/en2UzfnWor/b9wkOyjKo7A0QP1F4Z31jkw7yPCpt8vG
         m0+iV84fRYSQ+OSrxt/7FrtLavEqmTBc9PvJ3N4g5JFRITFlQyFWMNLQSB9xQiDeiOPc
         L5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6G34B8UuYAuKelScbRyT107JffrqzzUEbW2EtqDPeNY=;
        b=TguqRTTIrpCaEvl2b2xDfpU6NZOx9c/VbF+m2d0VG60zsuwrCcAZyT5nkugQ3fttTV
         abMeCfEq7wR+Y8I2ZJxV5GaRJwjQQgtuRMN/fNx0/fSGGdfVv86wX/DIpa8pRErTXE9I
         XK/cxT8jJY6bjKgv58qAaaq/BPJcFlw31HiDugqsFuOSo1JbxBFxuuuf9CB5IE9rmI2p
         TNS/zYL1lpxbKIlbVUSgOZ+GNCr7XR3/clekUo+zsKEjkSEk5+OZNtkEFiqDHnoPtGF6
         yZpTYaoLtlYoXHkf6LqR4Q5SesXO519UdrOAmtYEUlnlzS9LzCkQRJmeDVM6NyjVObhk
         bybw==
X-Gm-Message-State: AOAM530aXyNJxKVljcbMo2Kn630ZioAuxZ6XIRQ9D62rdOKbr6+TohxD
        h7BBUul9FLTFpniDiS+D5HmniRV979ux/CPwPg==
X-Google-Smtp-Source: ABdhPJwQVaVeoun07nUGXLW7b3J+SnUIqGDp6QW3kkFX/IbJQ9XwMJGyLEMzGMIi86b6DnlWQx17SZXeE1E+aPRWtNE=
X-Received: by 2002:a02:a413:: with SMTP id c19mr3636261jal.7.1606207901458;
 Tue, 24 Nov 2020 00:51:41 -0800 (PST)
MIME-Version: 1.0
References: <1606109846-13688-1-git-send-email-kernelfans@gmail.com> <20201123140552.GN3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201123140552.GN3021@hirez.programming.kicks-ass.net>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 24 Nov 2020 16:50:45 +0800
Message-ID: <CAFgQCTvJXtWY21CUzOT5=_RYNF-r1kWm-uE10TbPCNcaaxH2SA@mail.gmail.com>
Subject: Re: [PATCH 1/2] events/core: introduce perf_pmu_disable_all() to turn
 off all PMU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Omar Sandoval <osandov@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 23, 2020 at 01:37:25PM +0800, Pingfan Liu wrote:
>
> > +/* When crashed, other cpus hang in idle loop, so here do an emergency job under no lock */
>
> -ENOPARSE, -ETOOLONG
>
> > +void perf_pmu_disable_all(void)
> > +{
> > +     struct pmu *pmu;
> > +
> > +     list_for_each_entry(pmu, &pmus, entry)
> > +             if (pmu->pmu_disable)
> > +                     pmu->pmu_disable(pmu);
> > +}
>
> This violates both locking rules and coding style.
Oops. I will re-work on it to see how to run it safely on crashed context.

Thanks,
Pingfan

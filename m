Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A22B70D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgKQVWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgKQVWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:22:02 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9DBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:22:01 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id y9so18933ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=katWkOXeT9cKSkuNJDqg8k4n6KRzCgL5P/0+AH0wLfM=;
        b=OIte6M7wsOrmtWwknxeObOn8TCXuM0vl3WAjff4DmRbczKi4M8UaTl51zQ2FW7gJaC
         d/zEWf4Mu2SE5K2yCrMLK/NQsU9FtlhqIyA2sk6oqxiUWaoqh8q9Rvzos36JxoLSG9y3
         eKqArLFp4ESRwR/4stCGSzWFcb/BLNvqZzunIFQrfvHjoS1PXAzKl7u29oxfqFm6mojb
         3vJJFewJ3GYkdUG2FGhWIIPU10LpqipW1urXgZLfi+mIUeIAXWP7q8nDR79/hrviKIG1
         KEsdLsTSimbhSj+SW25moXW+UABKy0TbdFT7ktcsa+er7dPGw9wfK8ylaFS+dDAi/wxL
         0Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=katWkOXeT9cKSkuNJDqg8k4n6KRzCgL5P/0+AH0wLfM=;
        b=jfVchzk/4Y9g2jfRgu9GllamLyIn6rFiXPI+VFZzUfIeshCOovCBdNoy/Epni+Cfsa
         1q29E8SgEUoyt6i1E/RFty5s7SZqYd3lwNNXNH/LhPKR4VeteRbkx7KgiDTdOGUZVXWR
         82+iIlZB3GlqIZ8tdeyLqAs6FXqI0CgCxJcQDWYCftix0eHuX5kXXGIiYevEsDWpydt0
         OVzWtKEY/wTr+6QOPrycwPtViH6lp2H4bpL3p2zU0da8TxOIoDhxhVksHjr4pEWr7E+D
         9igtxja9VNfkjwRPNig+YqTdtFebjFbW2jMoiqoENM0NVajE4G9FrmTwg3r2TlGU1h1z
         VaQw==
X-Gm-Message-State: AOAM530zc2tVcOobRpSZ79GezoUCffVIdiCe9YvB45Gz1A+6qNomu2Fg
        32fdWgIMYuFo1wkCswMpbDeo8aUrZdAnTZedGsA7xQ==
X-Google-Smtp-Source: ABdhPJwTvUsHon0yqAwCAQ/HKINxkyrmpzvT0T7DloiMnk9xVSN6K66nTVynT8fA5GiB/fWU1ceb353MfwQodERr9Lo=
X-Received: by 2002:a92:1f19:: with SMTP id i25mr14165325ile.198.1605648119997;
 Tue, 17 Nov 2020 13:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20200615063837.GA14668@zn.tnic> <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic> <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com> <20201117210018.GA4247@weirdfishes>
In-Reply-To: <20201117210018.GA4247@weirdfishes>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 17 Nov 2020 13:21:48 -0800
Message-ID: <CACdnJusV0QBy16Njge3-KR+gxcdTVXF3aO4B-z-QN+e0uhDnkQ@mail.gmail.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
To:     Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, kernel-team@fb.com,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 1:00 PM Mathieu Chouquet-Stringer
<me@mathieu.digital> wrote:

> I'm late to the party but it seems allowing MSR_IA32_ENERGY_PERF_BIAS
> has the downside of flagging the kernel as tainted without telling you
> why if you use something like x86_energy_perf_policy (from
> tools/power/x86/x86_energy_perf_policy) which itself is used by tuned.

I initially pushed back against a kernel interface for
MSR_IA32_ENERGY_PERF_BIAS (cc: Len Brown, who tried mightily to
convince me I was wrong here) on the grounds that it was exporting an
implementation detail rather than providing a generic interface, and
that it was something that could be done via userland instead. I
thought we'd end up with more examples of similar functionality and
could tie it into something more reasonable - history has proven me
wrong on that. I think it's probably reasonable to dust off the driver
that Len submitted however many years ago and push that into the
kernel now.

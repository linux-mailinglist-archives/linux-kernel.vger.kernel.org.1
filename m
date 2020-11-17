Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B902B70DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgKQVXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgKQVXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:23:03 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C53C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:23:01 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u21so22712608iol.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WRD9K2m6dhhul0lisphy8QdJQFjcZsj68Hj+fomUoZM=;
        b=bh99XQeqcpnTkB8f+4cmAhV+F5bCR8QoaAb94TwgBqiQgmfhMjaufNypBq+aRmFQX0
         hnJU1YMNc2FPDTKIULpJxqMygyUMGhMURazsLExa1n66uCvIcFNBuGq0HJgB6eK8XUIu
         KpPuW64aSuzMBNF2psjb5tTp99vIfMekPCYxEescloDNMCb3Eq1MqxRCcWoOmAjgPJ+B
         ZME/fG7IN96WqJVD8k7S6jYcL0KzVz7e0sJqIry2kIiDBUc2N2QsYlrG/bSI9aHRdGo7
         hbUXoi1nDUrdDZnOjsLG2aT6tlNScXfYTsX/2C6yIr7tQvPxCYXZVjYJ8PHR+GDpB5P9
         S1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WRD9K2m6dhhul0lisphy8QdJQFjcZsj68Hj+fomUoZM=;
        b=CeG8oak2R2XX+tuoZxp9s9wJ2DAQCnj058oqynSYJUHjDa/Pvq81Mas3YQcH80gbt3
         wfrWBwvIBv3qStcQHPhkQRJKI3HMLxPDCku3iLH1mg54m1yCMnz4PpdtxBJUQXiChvyx
         Te///mX6+WzZNtnAPE98nBmqRy5YuiN5bI9PIQ4tT0VyCaX6IWokD6CFTHFfhFpAYMdR
         1iAOKZgUa3SPgcMEPyexFE/N80hcIBeqtk3nYImNTzVaT8o2UUm7Y0oYULN6f3Yo36aP
         bbfVeN6r8jf1IeLD5JC2/bKOpcyWZ57yW0kxiBY74qfBT8e9oEeCsosrjPWfuXvT6L4o
         SzSw==
X-Gm-Message-State: AOAM532XijSt/hKxyHGd+EjjS20PV1n4oLeSf2ABsTXNaHZghPqS3+om
        qlSuif5y6GygClMeyrq2ecz76gViY9sLte8BctYkZw==
X-Google-Smtp-Source: ABdhPJzDSd+aLBT5MVDJf715F9jbKf7AuqS2BoPqEjjzBDjqEzg7PnBFdTtmkje8lRu38hZT5Aqt+NOQb9MGA+EccrA=
X-Received: by 2002:a05:6638:1035:: with SMTP id n21mr5272928jan.107.1605648180707;
 Tue, 17 Nov 2020 13:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20200615063837.GA14668@zn.tnic> <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic> <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
 <20201117210018.GA4247@weirdfishes> <CACdnJusV0QBy16Njge3-KR+gxcdTVXF3aO4B-z-QN+e0uhDnkQ@mail.gmail.com>
In-Reply-To: <CACdnJusV0QBy16Njge3-KR+gxcdTVXF3aO4B-z-QN+e0uhDnkQ@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 17 Nov 2020 13:22:49 -0800
Message-ID: <CACdnJuvXhVnoeK223pA3VmaRAQ=utWZei6RpQrkJyBcdpMxkOg@mail.gmail.com>
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

On Tue, Nov 17, 2020 at 1:21 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, Nov 17, 2020 at 1:00 PM Mathieu Chouquet-Stringer
> <me@mathieu.digital> wrote:
>
> > I'm late to the party but it seems allowing MSR_IA32_ENERGY_PERF_BIAS
> > has the downside of flagging the kernel as tainted without telling you
> > why if you use something like x86_energy_perf_policy (from
> > tools/power/x86/x86_energy_perf_policy) which itself is used by tuned.
>
> I initially pushed back against a kernel interface for
> MSR_IA32_ENERGY_PERF_BIAS (cc: Len Brown, who tried mightily to
> convince me I was wrong here) on the grounds that it was exporting an
> implementation detail rather than providing a generic interface, and
> that it was something that could be done via userland instead. I
> thought we'd end up with more examples of similar functionality and
> could tie it into something more reasonable - history has proven me
> wrong on that. I think it's probably reasonable to dust off the driver
> that Len submitted however many years ago and push that into the
> kernel now.

But ha ok based on Borislav's response it looks like someone's already
done that.

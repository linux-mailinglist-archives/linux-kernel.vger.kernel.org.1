Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA8627FD38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgJAKXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAKXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:23:23 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B06C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 03:23:21 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g3so3822477qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W259fc64ya1EFQ9j8EJVUKriprN8ho0dBOONikOqrRM=;
        b=kYJsfwJVV85sgpQD1coWo9LLy7qyUDalbDV7oqIK+P2WIq0ATEoL86j1k4chqIyoH7
         nQRLbUPxNN3LWRlXFlh0WYrLLVMHVLu7PIiE9BNawhNDuWAuTd3YGjJALquD4pr8UsR+
         yuTZNiIbxTFbMIPpMY3s0mYvkrvBTxw9fvgWz0F3713JxJ/NgV6XtuOs9ogz9YmLqzL7
         fiRT5NZtJR/TLfghDYnNJRGuCQGV9LSNoK3ljkdzvsYIIMf318KKvQnNtXeprDhMs/Vw
         6qdaGDHH7YvDtolLSuFMJXxHecJIhWEAFDdvyxX0hCjajIlkPGr279PbpRMt+7T6YH65
         XrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W259fc64ya1EFQ9j8EJVUKriprN8ho0dBOONikOqrRM=;
        b=jjmfNMXW87lC+e2N6PUKqNkV2+cwM+511YaVSz5zrWYP22xpRbA2grSA1gyqqx4msD
         aABZGnwiPad0fRBkiQuq4XeVk64BDg3ntE6vSEnBIClHKr6xq53CwdQtR2lZej9gOVfr
         z5uRpBMN2oJmhVy5fJKTJF4KbMb86WWzAM1HLq7+skbwv1jseAOfb2X7+oO365j3nXxm
         FDUBHxbjX3b04KaHMeHF6EclrcMtQJRfhk/OwtHos2RIzHqKk2UfQ966Lmbnx9PaNHaD
         csKmrTwg4ODjhYsxDNgfiIGlRkqmC8wdNZoTT4siRBedzqPnCuO2wNrB79VwR2Rs2zdO
         8gJA==
X-Gm-Message-State: AOAM530+bpD1lufaN0KwZ1AuHVg0sDfS9kqMRTRtq+4WPk36cAonbP8c
        uvrEUxcpj3df8BS44kIqRVqQTe/qo5OfN5lw4n0wxw==
X-Google-Smtp-Source: ABdhPJzT+5d2SnMzfm8dsQQEakN3AJz21lx4XznpyBIx2gtnxKnYm7cuN2hkt4UD00GmNfpOr7/MxM/NrfDzB4rzIG0=
X-Received: by 2002:ac8:4658:: with SMTP id f24mr6711635qto.158.1601547800344;
 Thu, 01 Oct 2020 03:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
 <20200928083819.GD1685@zn.tnic> <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic> <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
 <20200928202353.GI1685@zn.tnic> <20200929083336.GA21110@zn.tnic>
 <CACT4Y+bfKwoZe3SC-BKJkOET1GxGp9tCpLzkae8q1sjWYnmgmw@mail.gmail.com>
 <20200930161711.GH6810@zn.tnic> <CACT4Y+Zc7kD431Aed49U4R6cqzWGAWqEXevnheRHKQRQoEnh7w@mail.gmail.com>
 <20200930163120.GJ6810@zn.tnic>
In-Reply-To: <20200930163120.GJ6810@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 1 Oct 2020 12:23:08 +0200
Message-ID: <CACT4Y+amigeTPFtwEgbeOGGTiRXFOVZauhOhQCz9CQ70HM17Ow@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 6:31 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 30, 2020 at 06:23:44PM +0200, Dmitry Vyukov wrote:
> > Here is the answer:
> > https://github.com/google/syzkaller/blob/master/tools/create-gce-image.sh#L189
> >
> > # rodata=n: mark_rodata_ro becomes very slow with KASAN (lots of PGDs)
> >
> > I have some vague memory that there was some debug double checking
> > that pages are indeed read-only and that debug check was slow, but it
> > was always executed without rodata=n.
>
> Sounds like debug_checkwx() which is disabled by turning off
> CONFIG_DEBUG_WX.
>
> You could either disable it in your .configs or, provided there's even
> such an option, disable KASAN checking around it until that one-time
> boot test completes and then reenable KASAN.

Thanks!

I've prepared a change that removes rodata=n:
https://github.com/google/syzkaller/pull/2155

I think we will be able to indirectly evaluate if it helps or not over
some period of time based on occurrence of any new similar crashes.

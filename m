Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662512967BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 01:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373529AbgJVXti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 19:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373518AbgJVXth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 19:49:37 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEC4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:49:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c15so4927091ejs.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZlkuWdQsWCC+a50v77gxrEMTeODSOjQWFOP4UJJDnk=;
        b=cUh4yK+PBHMfvd0jB2OsQ/bbtVKzuZXCL7HCSyczFYL0WDzRBvZVm9aGeWWIrYr1bV
         eQsOXOM/9NK6ZpiQfmHlPRe4enJaYE4/D8F89jSu64rneyt74YTf/zmuRNDcncLY9PbV
         vox7spklRgKMSQvRa+Z12H1g1wjSNh7DosrlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZlkuWdQsWCC+a50v77gxrEMTeODSOjQWFOP4UJJDnk=;
        b=FlZkSJo6/H4XHuqA7pF+xb+49qhpuU6zaqFMxB513nGhwgDZQAp9SmYtMXevkpQByn
         Cw4kmd20sSxCO4YonBFLgB8lzsQCNqO7EaB9i6b9trtQIVutXIGrJF9apCwt281zNT1r
         qn/K4jOvigu6gxHblNfMKywjjtPzBdp5gcgUf/sxB3CzDLAEOkU8Y8i0lnNaKFTqMt5l
         YASxLsQQLisyJUxVSqTMX6j0viiqYwHeWTzE68pdnEWDHsR5zfSxs2T8Oj2GJCaJriln
         6HO1twMvmo9DZ0oimkSY83HqkBPsqVpqCn3rTL/OCzxSo6jr4he2UdTyXZPTxgCWkEyZ
         A30A==
X-Gm-Message-State: AOAM531KtPz1sUd9AtMu2Nhy53ORfVLhCONt4wBwi8a/CE2aI5CVQer8
        MBq4UHy6T0VWx8TTE2NIrUVm9sWHWNCWuA==
X-Google-Smtp-Source: ABdhPJxMT80Y0WTA493Xo+np+W/lA3IQHSBMMJ3l82AWz9rwf+WNG4p4JBzeEBZCXuOcUQOOOCS77Q==
X-Received: by 2002:a17:906:1f08:: with SMTP id w8mr4638746ejj.181.1603410575432;
        Thu, 22 Oct 2020 16:49:35 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id i4sm56729edq.12.2020.10.22.16.49.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 16:49:35 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a3so4878369ejy.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:49:35 -0700 (PDT)
X-Received: by 2002:a2e:8815:: with SMTP id x21mr2045832ljh.312.1603410225256;
 Thu, 22 Oct 2020 16:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com> <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
In-Reply-To: <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Oct 2020 16:43:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
Message-ID: <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
Subject: Re: mmstress[1309]: segfault at 7f3d71a36ee8 ip 00007f3d77132bdf sp
 00007f3d71a36ee8 error 4 in libc-2.27.so[7f3d77058000+1aa000]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        X86 ML <x86@kernel.org>, LTP List <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        zenglg.jy@cn.fujitsu.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 1:55 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> The bad commit points to,
>
> commit d55564cfc222326e944893eff0c4118353e349ec
> x86: Make __put_user() generate an out-of-line call
>
> I have reverted this single patch and confirmed the reported
> problem is not seen anymore.

Thanks. Very funky, but thanks. I've been running that commit on my
machine for over half a year, and it still looks "trivially correct"
to me, but let me go look at it one more time. Can't argue with a
reliable bisect and revert..

            Linus

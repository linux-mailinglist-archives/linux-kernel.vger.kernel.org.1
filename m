Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F00427FE16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbgJALFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:05:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41896 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731839AbgJALFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:05:21 -0400
Received: from zn.tnic (p200300ec2f089d0086f50977b536c1c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:9d00:86f5:977:b536:c1c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5551A1EC04B9;
        Thu,  1 Oct 2020 13:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601550320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9c/l0kmClTAlJvD865tYjP10jYTfLqBs8vejfOpvoT4=;
        b=j/AbL0RwAq2++eRYzmx63l1TDHmKg/0tgsz+0kUUrORBXneDyoXc966/ag2axOHxyLtxVT
        SGLOrFdgBFy5qcm7oICYTxyahmmDZkwZ5hbu3ivexYbXBXXG8Fn537oJ991Zo6WzKZvj6j
        b5ebJvBT21yLjw2ICiHL7WxjGNBbkOQ=
Date:   Thu, 1 Oct 2020 13:05:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
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
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: general protection fault in perf_misc_flags
Message-ID: <20201001110512.GB17683@zn.tnic>
References: <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic>
 <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
 <20200928202353.GI1685@zn.tnic>
 <20200929083336.GA21110@zn.tnic>
 <CACT4Y+bfKwoZe3SC-BKJkOET1GxGp9tCpLzkae8q1sjWYnmgmw@mail.gmail.com>
 <20200930161711.GH6810@zn.tnic>
 <CACT4Y+Zc7kD431Aed49U4R6cqzWGAWqEXevnheRHKQRQoEnh7w@mail.gmail.com>
 <20200930163120.GJ6810@zn.tnic>
 <CACT4Y+amigeTPFtwEgbeOGGTiRXFOVZauhOhQCz9CQ70HM17Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+amigeTPFtwEgbeOGGTiRXFOVZauhOhQCz9CQ70HM17Ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 12:23:08PM +0200, Dmitry Vyukov wrote:
> I've prepared a change that removes rodata=n:
> https://github.com/google/syzkaller/pull/2155

Looks good.

> I think we will be able to indirectly evaluate if it helps or not over
> some period of time based on occurrence of any new similar crashes.

Yap, that would be interesting to see whether those corruptions
disappear. If they do, you probably should start getting #PFs of writes
to RO memory, instead, resulting from those stray writes. We'll see.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

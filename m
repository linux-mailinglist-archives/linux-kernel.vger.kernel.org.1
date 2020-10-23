Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911AC2972ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464146AbgJWPxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464128AbgJWPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:53:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B2C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:53:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d24so2066838ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=So975owvkkTFfYXQ470Q4DlssmIVIFu2QdqnJrTF8xg=;
        b=TzWUN3CTm+h3r1g9oyCsI8lQvw43xzR9vIG57jNVIMScon9dkhOPSHSU0YuPTCTEbW
         xSUTXNkTa/xHcxjOZm+H+owVFWXNWx30+II0u/JJDBaUgnHNJQKAZRQgLvSR8UT7JBoq
         5hUnMcwfEz4zN7MfPmgGe/s+oSgXWn8ttaA2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=So975owvkkTFfYXQ470Q4DlssmIVIFu2QdqnJrTF8xg=;
        b=pgvKNAJdMP2zzyqJZqitmLcN6cZSMaZ9xeT8k4dcyZv7ORWgbVavrlh4H1FRizxvV1
         XB0CSJa0UiTe00fvZ540mnCx5s2jBDRySSesfPUpIFPLG4/DPeBpuDBoer7UlIZVN9Bn
         aTlkMVUWuRsCv+4MRdoZ5T4FyJSgMThaw7wA9b2HUpELwjN8ebz3D/iajim6BxKBr6Qg
         n1GRCOJPiEoAN4PvUW5YVi4CMHR8JB90fs8YMmhfjCXr2JJpoFnZBhDaDxjxMaexS2ag
         jIG16wRx+n1dpZgVuSfRVu3xLmJSTIbzALjFetvKSQWaeGOblXLNytKfryp+d3CF/elK
         PVEQ==
X-Gm-Message-State: AOAM531bnMTyZNPgePtXiXWfDupgU2MCJ1jmhVQF/RCni7ZD+9Z3XfCS
        13iCQJ5khG3++6NA4pHTWVxpoATB54qCeA==
X-Google-Smtp-Source: ABdhPJw9tKPp0N6dBFNitanpJJqO5InL6EK+Z544LhyiaQssdlX+j8TP2OkoJpkkDl8rAXvu4+ziWg==
X-Received: by 2002:a2e:7a15:: with SMTP id v21mr1218904ljc.424.1603468388467;
        Fri, 23 Oct 2020 08:53:08 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id c26sm171582lfh.107.2020.10.23.08.53.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 08:53:07 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id i2so2080281ljg.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:53:06 -0700 (PDT)
X-Received: by 2002:a2e:898c:: with SMTP id c12mr1248002lji.285.1603468386475;
 Fri, 23 Oct 2020 08:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
 <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
 <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
 <CAEUSe78A4fhsyF6+jWKVjd4isaUeuFWLiWqnhic87BF6cecN3w@mail.gmail.com>
 <CAHk-=wgqAp5B46SWzgBt6UkheVGFPs2rrE6H4aqLExXE1TXRfQ@mail.gmail.com> <20201023050214.GG23681@linux.intel.com>
In-Reply-To: <20201023050214.GG23681@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 08:52:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBjUvjN_Mw2Oo5XMUJFSREi3d9AHTSFmgp-a42ZH_K_w@mail.gmail.com>
Message-ID: <CAHk-=wjBjUvjN_Mw2Oo5XMUJFSREi3d9AHTSFmgp-a42ZH_K_w@mail.gmail.com>
Subject: Re: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in libc-2.27.so[7f3d77058000+1aa000]
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        zenglg.jy@cn.fujitsu.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@redhat.com>, LTP List <ltp@lists.linux.it>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:02 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> I haven't reproduced the crash, but I did find a smoking gun that confirms the
> "register shenanigans are evil shenanigans" theory.  I ran into a similar thing
> recently where a seemingly innocuous line of code after loading a value into a
> register variable wreaked havoc because it clobbered the input register.

Yup, that certainly looks like the smoking gun.

Thanks for finding an example of this, clearly I'll have to either go
back to the "conditionally use 'A' or 'a' depending on size" model, or
perhaps try Rasmus' patch.

              Linus

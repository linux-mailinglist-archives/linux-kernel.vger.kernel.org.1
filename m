Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95662C8E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgK3TkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgK3TkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:40:20 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C992FC061A49
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:39:11 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y10so19814262ljc.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+kKX0kuteZmVrkELKmO38aHUCQfmtksSV+RNnpLrBU=;
        b=J/bqOdKxRj6v313iPonX/IikdbWpTlowHmo/2YfKookREQFK4kMLQ8QiA2iHZ6s6hl
         1iD9XEmJitK7+FqMZe21RtqW2tbK64eSNxhNMJQC5Nt/DZyxLElOjrWUqcfp7AU1xxl9
         xPPPszWhrBash8DYZBc4GgMPxNcNzsz9Yn0MdTTqGdJKpEOXkv4+g61plZbdJ7IfXQ3e
         AtuxK9Ap3PCYyiaf7JVuSka96p0kGVmafDZo4hhLAdFXTIQ7T6sSY6gQZg9dEe/QLoPB
         VVuXdQsI9RjgoRMIqT31lf35pKiKvRTnZpHOT7SqIOU7yBIuYLjepszfGWRpOfHvJgga
         hTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+kKX0kuteZmVrkELKmO38aHUCQfmtksSV+RNnpLrBU=;
        b=qghYl1nDOX6qI8/M+sg8RSBv5+qdJEU247Fi1B9lya6fo2NjzCS7ltLWQ+jtClqQEH
         oiGv9t/NdpM0ISmtQolq2dPkbjsbRknLhMUjdn2El9oE/DZvGpQf9eDi2J0pfSLUd26H
         RclvtHRH+JE/VYEOO4mluSUxJJvwm8vtct88UUpKSfpYq0ewwAOhF4EPouZ2v3m54trQ
         osWJmNlDjXD38SiykA0+oTvXKzVOS+RuU0MbqPMuWuT5aolWbtBx8kMwX26ItAs4m5aO
         Xh/KqTigZ2nonOm3A5w94/aOHvQFCJQSY9Fe/+0hqWuz9r6hq8VQld4fCvAp05JIXQmh
         XzPw==
X-Gm-Message-State: AOAM530siPXYS5wspSNQ9JxWjn85+r85N+bVepkye4MJF+r0pX2iJn9C
        w9fDDLj/hUXjcaqHn8CHUj38eDovRdIuz/Rb7lAwkQ==
X-Google-Smtp-Source: ABdhPJzl5GtwHh8u58PsVhPmQyulqAyzFwl6ovo793j64B4rhBzRkF7NsGtFUrbp/zwQ0qfPVs4EW+p+yUBEmTmH7QY=
X-Received: by 2002:a05:651c:1292:: with SMTP id 18mr10179147ljc.334.1606765149900;
 Mon, 30 Nov 2020 11:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20201110162211.9207-2-yu-cheng.yu@intel.com> <20201130182641.29812-1-ndesaulniers@google.com>
 <4fad528b-e467-f96d-b7fb-9484fd975886@intel.com>
In-Reply-To: <4fad528b-e467-f96d-b7fb-9484fd975886@intel.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 30 Nov 2020 11:38:58 -0800
Message-ID: <CAFP8O3LjdP69_T1Ve-zZjvg7+v8xV1mh9Wk8zm4LpAsE2PG58Q@mail.gmail.com>
Subject: Re: [PATCH v15 01/26] Documentation/x86: Add CET description
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        bsingharora@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        dave.hansen@linux.intel.com, esyr@redhat.com,
        Florian Weimer <fweimer@redhat.com>, gorcunov@gmail.com,
        "H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        jannh@google.com, Kees Cook <keescook@chromium.org>,
        linux-api@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        luto@kernel.org, mike.kravetz@oracle.com,
        Ingo Molnar <mingo@redhat.com>, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        vedvyas.shanbhogue@intel.com, weijiang.yang@intel.com,
        X86 ML <x86@kernel.org>, Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        erich.keane@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:34 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote=
:
>
> On 11/30/2020 10:26 AM, Nick Desaulniers wrote:
> > (In response to https://lore.kernel.org/lkml/20201110162211.9207-2-yu-c=
heng.yu@intel.com/)
> >
> >> These need to be enabled to build a CET-enabled kernel, and Binutils v=
2.31
> >> and GCC v8.1 or later are required to build a CET kernel.
> >
> > What about LLVM? Surely CrOS might be of interest to ship this on (we s=
hip the
> > equivalent for aarch64 on Android).
> >
>
> I have not built with LLVM, but think it probably will work as well.  I
> will test it.
>
> >> An application's CET capability is marked in its ELF header and can be
> >> verified from the following command output, in the NT_GNU_PROPERTY_TYP=
E_0
> >> field:
> >>
> >>      readelf -n <application> | grep SHSTK
> >>          properties: x86 feature: IBT, SHSTK
> >
> > Same for llvm-readelf.
> >
>
> I will add that to the document.
>
> Thanks,
> Yu-cheng

The baseline LLVM version is 10.0.1, which is good enough for  clang
-fcf-protection=3Dfull, llvm-readelf -n, LLD's .note.gnu.property
handling (the LLD option is `-z force-ibt`, though)


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

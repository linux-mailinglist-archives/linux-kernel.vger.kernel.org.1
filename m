Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D746624A4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 19:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHSROZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 13:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSROT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:14:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F032AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:14:18 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l23so18728295edv.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lxWQpzEJBRxFWn4dOvs/9NY97u5lA3hOWcxGQWOxLjs=;
        b=jVxm6/oUDida23iZYrjKJtAjmMhRD0e2p/PFTP5RagnlyLpe2G3kUYAPDI2Q4Bm22E
         qZQBpZDzkoRg0Roy3eU3FzNjDQkT/W0zkOKehErGd8mufcZ9Q5tH2IQaXoslMMZfnpgO
         vZykzKDr4SVqY9uDD1noPfutJV33VKlPTqXQC9P0Aw40i/uQB7fMKa5WFatVJODNjseU
         777vyJYRFfU3ZOICebBV2T+dbcAorrFMxD85BHeSzJK4z7nUklQr1cmX7DeiWPLvhC0J
         /wCteY/71o1AXJ610CoveefVw9Aec3bsVlJSi3YfqZRVBp96ljVlEqSrTERjIG9UwKjQ
         wJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lxWQpzEJBRxFWn4dOvs/9NY97u5lA3hOWcxGQWOxLjs=;
        b=Mbmdtv8hNjNBEEHcWQuCTW1xuqP5ydaJlUdANC7TDIgTF9lZ2iA+l1rO33/yn5arLp
         FtKxRQzqdX3ahn42P++VGXbGzCni3rUkPe6Hrp5VO8RyHPiyADQ1YIp1s4f29R872Xpm
         o++KG9BZ/G0WP2CeBdZWBE/+K8G4vMfwpQbGVdxec4QyIcfRsuEyxPJhaxDdPESz5JL0
         9HUO631j0+jTfo3S6jJpNbuB2qxcd+8cY3KyiwCC2lJqPZG+8nPXDXV6hbkgk1NeATH5
         bv2RpNrov/8BxGeLcp5h6gR4KRhbpKCHxpBA41Cy0UCSpqDiTbKRBc0qLzVFfzQxnU0s
         WQdw==
X-Gm-Message-State: AOAM533xYb28P3uhrCeuISPPdNHMjlsq+zal+O8vyy2ahO23A29uuv9o
        nfPHLX8KXAfho0O3TL4THo15Lshxd4G1GgTmZX0LNw==
X-Google-Smtp-Source: ABdhPJwBq/IJpNmKU01Vbvw68YKifhG/5x5RhndnYLaMJW1Fx62abFTCNjPNM6I4B+T450H7iUk2pV1GiSXi5avskBg=
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr26516518edv.271.1597857257546;
 Wed, 19 Aug 2020 10:14:17 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 19 Aug 2020 10:14:03 -0700
Message-ID: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com>
Subject: [REGRESSION] x86/entry: Tracer no longer has opportunity to change
 the syscall number at entry via orig_ax
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>
Cc:     "Robert O'Callahan" <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tl;dr: after 27d6b4d14f5c3ab21c4aef87dd04055a2d7adf14 ptracer
modifications to orig_ax in a syscall entry trace stop are not honored
and this breaks our code.

rr, a userspace record and replay debugger[0], redirects syscalls of
its ptracee through an in-process LD_PRELOAD-injected solib. To do
this, it ptraces the tracee to a syscall entry event, and then, if the
syscall instruction is not our redirected syscall instruction, it
examines the tracee's code and pattern matches against a set of
syscall invocations that it knows how to rewrite. If that succeeds, rr
hijacks[1] the current syscall entry by setting orig_ax to something
innocuous like SYS_gettid, runs the hijacked syscall, and then
restores program state to before the syscall entry trace event and
allows the tracee to execute forwards, through the newly patched code
and into our injected solib.

Before 27d6b4d14f5c3ab21c4aef87dd04055a2d7adf14 modifications to
orig_ax were honored by x86's syscall_enter_trace[2]. The generic arch
code however does not honor any modifications to the syscall number[3]
(presumably because on most architectures syscall results clobber the
first argument and not the syscall number, so there is no equivalent
to orig_rax).

Note that the above is just one example of when rr changes the syscall
number this way. This is done in many places in our code and rr is
largely broken on 5.9-rc1 at the moment because of this bug.

- Kyle

[0] https://rr-project.org/
[1] https://github.com/mozilla/rr/blob/cd61ba22ccc05b426691312784674c0eb8e654ef/src/Task.cc#L872
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/entry/common.c?h=v5.8&id=bcf876870b95592b52519ed4aafcf9d95999bc9c#n204
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/entry/common.c?h=v5.8&id=27d6b4d14f5c3ab21c4aef87dd04055a2d7adf14#n44

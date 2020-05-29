Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E273D1E831B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgE2QGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:06:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9BC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 09:06:07 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jehWE-0000dm-EV; Fri, 29 May 2020 18:06:02 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CF971100F1A; Fri, 29 May 2020 18:06:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: PANIC: double fault in fixup_bad_iret
In-Reply-To: <87o8q6n38p.fsf@nanos.tec.linutronix.de>
References: <000000000000d2474c05a6c938fe@google.com> <CACT4Y+ajjB8RmG3_H_9r-kaRAZ05ejW02-Py47o7wkkBjwup3Q@mail.gmail.com> <87o8q6n38p.fsf@nanos.tec.linutronix.de>
Date:   Fri, 29 May 2020 18:06:01 +0200
Message-ID: <87lflan2ty.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Dmitry Vyukov <dvyukov@google.com> writes:
>> On Fri, May 29, 2020 at 3:14 PM syzbot
>> <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com> wrote:
>>
>> From the reproducer it seems to be either x86 related or ptrace
>> related.
>>
>>> RIP: 0010:fixup_bad_iret+0x24/0x170 arch/x86/kernel/traps.c:665
>
> as a quick assumption that's related to KASAN in fixup_bad_iret() which
> is a frightenly bad idea. I'm about to verify.

Exactly as I assumed. With KASAN off, no problem, with KASAN on, insta
crash.

This function needs to be excluded from KASAN or any other of those
magic function. I need to walk the dogs first and will look into fixing
it later.

Thanks,

        tglx

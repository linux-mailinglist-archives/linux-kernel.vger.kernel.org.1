Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A8C1E78C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgE2Ivl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgE2Ivc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:51:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003B8C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:51:31 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeaje-0007ry-0a; Fri, 29 May 2020 10:51:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3990B100C2D; Fri, 29 May 2020 10:51:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: WARNING: suspicious RCU usage in idtentry_exit
In-Reply-To: <CACT4Y+bVPSZVkWJquu5gk11ymhirsFvVFYHkexjqgBkgga379w@mail.gmail.com>
References: <000000000000840d4d05a6850c73@google.com> <87wo4wnpzb.fsf@nanos.tec.linutronix.de> <20200528161143.GF2869@paulmck-ThinkPad-P72> <878shbols9.fsf@nanos.tec.linutronix.de> <20200528204839.GR2869@paulmck-ThinkPad-P72> <CACT4Y+bVPSZVkWJquu5gk11ymhirsFvVFYHkexjqgBkgga379w@mail.gmail.com>
Date:   Fri, 29 May 2020 10:51:25 +0200
Message-ID: <87tuzzm8du.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

Dmitry Vyukov <dvyukov@google.com> writes:
> On Thu, May 28, 2020 at 10:48 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> On Thu, May 28, 2020 at 10:19:02PM +0200, Thomas Gleixner wrote:
>> OK, from the .config, another suggestion is to build the kernel
>> with CONFIG_RCU_EQS_DEBUG=y.  This still requires that this issue be
>> reproduced, but it might catch the problem earlier.
>
> How much does it slow down execution? If we enable it on syzbot, it
> will affect all fuzzing done by syzbot always.
> It can tolerate significant slowdown and it's far from a production
> kernel (it enables KASAN, KCOV, LOCKDEP and more). But I am still
> asking because some debugging features are built without performance
> in mind at all (like let's just drop a global lock in every
> kmalloc/free, which may be too much even for a standard debug build).

It's not worse than lockdep.

Thanks,

        tglx

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF202C5055
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbgKZIWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:22:00 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41775 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgKZIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:21:59 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4ChW2D5ND9z1qs46;
        Thu, 26 Nov 2020 09:21:56 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4ChW2D4M5lz1tlRp;
        Thu, 26 Nov 2020 09:21:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id WjLrAFcmc6jg; Thu, 26 Nov 2020 09:21:55 +0100 (CET)
X-Auth-Info: BoGFObDpcb77I0k8y7AkhnJm+ThoGpJqUiMP6Wbk9EeoYxTsuvUb71RgxxktGuAW
Received: from igel.home (ppp-46-244-163-84.dynamic.mnet-online.de [46.244.163.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 26 Nov 2020 09:21:55 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 2EA672C3292; Thu, 26 Nov 2020 09:21:55 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Carlos O'Donell via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Zack Weinberg <zackw@panix.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan>
        <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
        <87sg9vn40t.fsf@nanos.tec.linutronix.de>
        <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com>
        <87h7qbmqc3.fsf@nanos.tec.linutronix.de>
        <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com>
        <87k0v7kwdc.fsf@nanos.tec.linutronix.de>
        <7a4d7b14-1f0b-4c40-2bd1-2582d8b71868@redhat.com>
        <87y2jej8mp.fsf@nanos.tec.linutronix.de>
        <d88ede3f-5f50-24a2-5009-6418f3cfaf4c@redhat.com>
        <87wnygopen.fsf@nanos.tec.linutronix.de>
        <5c382ef4-c505-5629-a85c-abae67c05c7c@redhat.com>
        <87pn41j7jx.fsf@nanos.tec.linutronix.de>
        <1d3d00ac-c7a0-7168-0450-8a0e1499ea2b@redhat.com>
X-Yow:  Did YOU find a DIGITAL WATCH in YOUR box of VELVEETA?
Date:   Thu, 26 Nov 2020 09:21:55 +0100
In-Reply-To: <1d3d00ac-c7a0-7168-0450-8a0e1499ea2b@redhat.com> (Carlos
        O'Donell via Libc-alpha's message of "Wed, 25 Nov 2020 22:05:30
        -0500")
Message-ID: <87mtz41qak.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 25 2020, Carlos O'Donell via Libc-alpha wrote:

> We might write a syscall interception framework using seccomp
> and SECCOMP_RET_TRACE, but that involves ptrace'ing the process
> under test, and is equivalent to a micro-sandbox. I'm not against
> that idea for testing; we would test what we ship.

seccomp and ptrace does not work with qemu linux-user.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0071CEF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgELIxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 04:53:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:40914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgELIxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:53:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 05E73ABC7;
        Tue, 12 May 2020 08:53:52 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.7-rc5
References: <mhng-81c83c19-6f5d-4ed1-a0bb-26accf4b7d3a@palmerdabbelt-glaptop1>
        <CAHk-=win0EVU_GuO=GuJu3Ck0WG1B3+ub-CjncM3B1G9x5d9cw@mail.gmail.com>
        <mvmr1vqkhxb.fsf@suse.de>
        <CAHk-=wj8Cks7L2H9ToNWEMmqECYEfX0uyCXpW1OsZ+NAooi2Cw@mail.gmail.com>
X-Yow:  Two LITTLE black dots and one BIG black dot...nice 'n' FLUFFY!!
Date:   Tue, 12 May 2020 10:53:49 +0200
In-Reply-To: <CAHk-=wj8Cks7L2H9ToNWEMmqECYEfX0uyCXpW1OsZ+NAooi2Cw@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 11 May 2020 12:04:09 -0700")
Message-ID: <mvmftc5jzz6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 11 2020, Linus Torvalds wrote:

> Why is glibc doing it in the first place? Is it some historical thing
> that is simply irrelevant on RISC-V simply because RISC-V doesn't have
> that kind of history, perhaps?

It is completely generic.  Even new architectures become old over time
and accumulate cruft.  The idea is that if you configure glibc with
--enable-kernel=VERSION, it assumes that all syscalls from kernel
VERSION are guaranteed to exist, and drops the fallbacks for those
syscalls, or uses them in the first place (if no useful fallback
existed).  From time to time the absolute minimum supported kernel
version is increased (this happend the last time in 2017, when x86 and
x86_64 moved the mininum from 2.6.32 to 3.2, after all other
architectures did that step in 2016), which allows removing the fallback
code that becomes obsolete.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1861B2D63D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392854AbgLJRlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:41:00 -0500
Received: from pi3.com.pl ([185.238.74.129]:42632 "EHLO pi3.com.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392682AbgLJRPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:15:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 104AB4C13C2;
        Thu, 10 Dec 2020 18:14:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1607620473; bh=tzI2N+yOZitZvgQn+tMtexStcLZFVKAH5eFs6YZ6Pq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwO/4UpB8X5G42wv0oVg0GVuOZAb/rWje807ZvR1Z+NklTGvEXU+Bvn07kLbbhceU
         45iFZgttjWXWRHwCEfqXZG011nkZ8dfYIylQxmcQslMRWLyLKniXaQ7ZFP2yETw8d+
         BmxRpoUwKj3MFPXb4LgB0RSymTek/+34Yx4nQPyzkM0DcfFFaA8HPbLaO9NGpjJy3r
         MMQAL7bq/EUoq1cjRjU95bj10A1LsJ3E449cp7uioWOzc08+kuO73zCr9HoMo67vRR
         KnzZwmdc3qePiAhDe0NiSgaWkJ1VWKDhPB2U+kr1Yz7I5XNnEnL47I7i/13VfjmRZZ
         ioVHdoLdF0LaA==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FatlzZp9kIw7; Thu, 10 Dec 2020 18:14:30 +0100 (CET)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 31CDC4C1555; Thu, 10 Dec 2020 18:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1607620470; bh=tzI2N+yOZitZvgQn+tMtexStcLZFVKAH5eFs6YZ6Pq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WlglAWSSebrl518UaJuXq6PTpLklW2Rx7pCb+UrxW0rQy1p0kLaoq9uh92L1l5xij
         tfLo7COfO+y9ZT2rsmiDdQph+3Js4VoaFsn/t7Ck0YqAHFJKbbwljlns81BrWQAmaA
         ilonXGxyoUchlp8jN6R0IUZNLVqhwUF7YT32Fll5b6BJ4zcV+Dfy+3JM/YwgFrUR8l
         YrV2V1usxdar0m33O4nXwA0Zh4FExNYvedqoa7VOCMQE5obfQfRZQVwdDlx7sj7xr5
         PseBNdAx+edy+m/5j9GdkiJUaeMBXkE110x50ldN6/fwUmypYSCbimhZLrIhHscD1a
         g2BqJuDYGgQWA==
Date:   Thu, 10 Dec 2020 18:14:30 +0100
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>
Subject: Re: KRETPROBES are broken since kernel 5.8
Message-ID: <20201210171430.GA20584@pi3.com.pl>
References: <20201209215001.GA8593@pi3.com.pl>
 <20201210102507.6bd47a08191852b9f8b5e3f0@kernel.org>
 <20201210071742.GA14484@pi3.com.pl>
 <20201210220937.5232571bf5b03237e7018012@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210220937.5232571bf5b03237e7018012@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > However, there might be another issue which I wanted to brought / discuss - 
> > problem with optimizer. Until kernel 5.9 KRETPROBE on e.g. 
> > 'ftrace_enable_sysctl' function was correctly optimized without any problems. 
> 
> Did you check it on other functions? Did you see it only on the "ftrace_enable_sysctl"?
> 

Yes, I see it in most of the functions with padding.

> > Since 5.9 it can't be optimized anynmore. I didn't see any changes in the 
> > sources regarding the optimizer, neither function itself.
> > When I looked at the generated vmlinux binary, I can see that GCC generated 
> > padding at the end of this function using INT3 opcode:
> > 
> > ...
> > ffffffff8130528b:       41 bd f0 ff ff ff       mov    $0xfffffff0,%r13d
> > ffffffff81305291:       e9 fe fe ff ff          jmpq   ffffffff81305194 <ftrace_enable_sysctl+0x114>
> > ffffffff81305296:       cc                      int3
> > ffffffff81305297:       cc                      int3
> > ffffffff81305298:       cc                      int3
> > ffffffff81305299:       cc                      int3
> > ffffffff8130529a:       cc                      int3
> > ffffffff8130529b:       cc                      int3
> > ffffffff8130529c:       cc                      int3
> > ffffffff8130529d:       cc                      int3
> > ffffffff8130529e:       cc                      int3
> > ffffffff8130529f:       cc                      int3
> 
> So these int3 is generated by GCC for padding, right?
> 

I've just browsed a few commits and I've found that one:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7705dc8557973d8ad8f10840f61d8ec805695e9e

It looks like INT3 is now a default padding used by linker.

> > However, that's not the case here. INT3_INSN_OPCODE is placed at the end of 
> > the function as padding (and protect from NOP-padding problems).
> > 
> > I wonder, if optimizer should take this special case into account? Is it worth 
> > to still optimize such functions when they are padded with INT3?
> 
> Indeed. I expected int3 is used from other subsystems (e.g. kgdb) and,
> in that case the optimization can confuse them.

Right. The same can happen when text section is being actively modified. 
However, this case could be covered by running the optimizer logic under 
text_mutex.

> But if the gcc uses int3 to pad the room between functions, it should be
> reconsidered. 
> 

Looks like it's a default behavior now.

> Thank you,
>
> > If it is OK, we should backport those to stable tree.
> 
> Agreed.

It is also important to make sure that distro kernels would pick-up such 
backported fix.

Thanks,
Adam

-- 
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl


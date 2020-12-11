Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8568D2D7FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393948AbgLKUFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:05:53 -0500
Received: from pi3.com.pl ([185.238.74.129]:45886 "EHLO pi3.com.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392341AbgLKUFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:05:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 7373F4C13BE;
        Fri, 11 Dec 2020 21:04:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1607717076; bh=5Ce/dDH+T2OHXDPjdTSKgi1NR++ZTjSPGIeQWJLQVrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sItC7k4OkrEzH9WMgMsWnBkAoQrGBNijei1+5gysuG4WItCIKqo9U1RulUbXHLDPv
         JzGrjrsy5Tw/92w8YdV1zyC0P85kf21E9zB5/V2ZBWku/dcOc+g0m/OY5P7D4ErGJQ
         hL+3FhogTi9issWQUDEupyZrPUoLPJ8b4Mk3c1JngdTCpgswxDRk9icmx8OvHWnUQs
         VbCbHwMnfJ9czE7RjiW8Cg6ydwHVaS5TdgjYzw55nLz9ikN5G2jYLXYUQSbgPTdHfK
         KxPnJazoJsX/1Hj/X93g8M+qkPiIxg+Dbn1VUJuSvVkF1nBgII9AYwqTW+q7RppvAr
         L2OT10FLXKWNw==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uZOmmTq_daaR; Fri, 11 Dec 2020 21:04:33 +0100 (CET)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 879BE4C14E9; Fri, 11 Dec 2020 21:04:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1607717073; bh=5Ce/dDH+T2OHXDPjdTSKgi1NR++ZTjSPGIeQWJLQVrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zn7p1P4gd8Ryu3XI2+XDNmEfNt1GbVUbFhrPj8Q6h1dVXy8HxKRLX+ongwIVUghq3
         V+a/77aUxWJfV3NpPOqVPVnqUkpkThAXS4ngTEOsjHhIhv6jo394cA0UeTGzfe7cwA
         8HS14BHbSgbUTVDfoTL6Ve27pxsUfURf1X+izDJpiLnKlH4Ckl8S8yrYiwcD0rdIcW
         wMn6WkXRDe/2y1Gci/TiJigc23AmMpOKvJdFumIWfYtNEP8Cpr61ZKZ56uZqNbQiw/
         l6mlwU0qBykTbCqeNgZ6JczknfonEf+uNVrH25umWLPdpIo4nELyfbsfbcKPeNCwMU
         CzkBHEkXSdYQg==
Date:   Fri, 11 Dec 2020 21:04:33 +0100
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] x86/kprobes: Fix optprobe to detect padding int3
 correctly
Message-ID: <20201211200433.GA4773@pi3.com.pl>
References: <160767025681.3880685.16021570341428835411.stgit@devnote2>
 <202012111139.948F2ECF1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202012111139.948F2ECF1@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've applied this patch on the top of kernel 5.9.7 and verified it works 
fine:

ffffffff813050e0 <ftrace_enable_sysctl>:
...
...
ffffffff813052f1:       e9 fe fe ff ff          jmpq   ffffffff813051f4 <ftrace_enable_sysctl+0x114>
ffffffff813052f6:       cc                      int3
ffffffff813052f7:       cc                      int3
ffffffff813052f8:       cc                      int3
ffffffff813052f9:       cc                      int3
ffffffff813052fa:       cc                      int3
ffffffff813052fb:       cc                      int3
ffffffff813052fc:       cc                      int3
ffffffff813052fd:       cc                      int3
ffffffff813052fe:       cc                      int3
ffffffff813052ff:       cc                      int3

When I install KRETPROBE on this function, it is correctly optimized:

root@pi3:~/off-debug/git/lkrg# cat /sys/kernel/debug/kprobes/list|grep ftrace_enable_sysctl
ffffffff813050e0  r  ftrace_enable_sysctl+0x0    [OPTIMIZED]
root@pi3:~/off-debug/git/lkrg# 

gef➤  x/2i ftrace_enable_sysctl
   0xffffffff813050e0 <ftrace_enable_sysctl>:   jmp    0xffffffffc062807a
   0xffffffff813050e5 <ftrace_enable_sysctl+5>: push   r14

Thanks,
Adam

On Fri, Dec 11, 2020 at 11:39:15AM -0800, Kees Cook wrote:
> On Fri, Dec 11, 2020 at 04:04:17PM +0900, Masami Hiramatsu wrote:
> > Fix optprobe to detect padding int3 correctly.
> > 
> > Since commit 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP
> > for linker fill bytes") changed the padding bytes between functions
> > from nop to int3, when optprobe decodes a target function it finds
> > int3 and gives up the jump optimization.
> > 
> > Instead of giving up any int3 detection, this checks whether the
> > rest of bytes to the end of the function are int3 or not. If all
> > of those are int3, those come from the linker. In that case,
> > optprobe continues jump optimization.
> > 
> > Fixes: 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP for linker fill bytes")
> > Cc: stable@vger.kernel.org
> > Reported-by: Adam Zabrocki <pi3@pi3.com.pl>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -- 
> Kees Cook

-- 
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl


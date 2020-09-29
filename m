Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB6C27CE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgI2M4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:56:07 -0400
Received: from disco-boy.misterjones.org ([51.254.78.96]:34262 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgI2Mzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:55:53 -0400
X-Greylist: delayed 941 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 08:55:52 EDT
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@misterjones.org>)
        id 1kNEvL-00FpwQ-Tb; Tue, 29 Sep 2020 13:40:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Sep 2020 13:40:03 +0100
From:   Marc Zyngier <maz@misterjones.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Rabin Vincent <rabin@rab.in>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Add RIP to scripts/decodecode
In-Reply-To: <20200929113238.GC21110@zn.tnic>
References: <20200929113238.GC21110@zn.tnic>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <b18c145f7b96cace7cd503de33c08311@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: bp@alien8.de, akpm@linux-foundation.org, will@kernel.org, rabin@rab.in, x86@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[dropping these ARM people I never heard of...]

On 2020-09-29 12:32, Borislav Petkov wrote:
> Hi,
> 
> how about we add RIP to decodecode output? See below.
> 
> I've added the couple of people to Cc who seem to use this thing. The
> patch is dirty and needs cleaning still but I think it would be cool to
> have the actual addresses in that output so that when you compare with
> objdump output in another window, you can find the code very quickly.
> 
> You'd need to supply the rIP from the splat, though, as an env var:
> 
> $ RIP=0xffffffff8329a927 ./scripts/decodecode < ~/tmp/syz/gfs2.splat
> [ 477.379104][T23917] Code: 48 83 ec 28 48 89 3c 24 48 89 54 24 08 e8
> c1 b4 4a fe 48 8d bb 00 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
> fa 48 c1 ea 03 <80> 3c 02 00 0f 85 97 05 00 00 48 8b 9b 00 01 00 00 48
> 85 db 0f 84
> Cleaned: [48 83 ec 28 48 89 3c 24 48 89 54 24 08 e8 c1 b4 4a fe 48 8d
> bb 00 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80>
> 3c 02 00 0f 85 97 05 00 00 48 8b 9b 00 01 00 00 48 85 db 0f 84]
> Marker: 127
> rIP_sub: 42
> adj_vma: 0xffffffff8329a8fd
> All code
> ========
> ffffffff8329a8fd:       48 83 ec 28             sub    $0x28,%rsp
> ffffffff8329a901:       48 89 3c 24             mov    %rdi,(%rsp)
> ffffffff8329a905:       48 89 54 24 08          mov    %rdx,0x8(%rsp)
> ffffffff8329a90a:       e8 c1 b4 4a fe          callq  
> 0xffffffff81745dd0
> ffffffff8329a90f:       48 8d bb 00 01 00 00    lea    0x100(%rbx),%rdi
> ffffffff8329a916:       48 b8 00 00 00 00 00    movabs 
> $0xdffffc0000000000,%rax
> ffffffff8329a91d:       fc ff df
> ffffffff8329a920:       48 89 fa                mov    %rdi,%rdx
> ffffffff8329a923:       48 c1 ea 03             shr    $0x3,%rdx
> ffffffff8329a927:*      80 3c 02 00             cmpb
> $0x0,(%rdx,%rax,1)               <-- trapping instruction
> ffffffff8329a92b:       0f 85 97 05 00 00       jne    
> 0xffffffff8329aec8
> ffffffff8329a931:       48 8b 9b 00 01 00 00    mov    0x100(%rbx),%rbx
> ffffffff8329a938:       48 85 db                test   %rbx,%rbx
> ffffffff8329a93b:       0f                      .byte 0xf
> ffffffff8329a93c:       84                      .byte 0x84
> 
> Code starting with the faulting instruction
> ===========================================
> ffffffff8329a8fd:       80 3c 02 00             cmpb   
> $0x0,(%rdx,%rax,1)
> ffffffff8329a901:       0f 85 97 05 00 00       jne    
> 0xffffffff8329ae9e
> ffffffff8329a907:       48 8b 9b 00 01 00 00    mov    0x100(%rbx),%rbx
> ffffffff8329a90e:       48 85 db                test   %rbx,%rbx
> ffffffff8329a911:       0f                      .byte 0xf
> ffffffff8329a912:       84                      .byte 0x84
> 

Looks neat. Only objection is that RIP is pretty tainted from an
architecture perspective. How about PC instead, which most people
understand immediately?

Bonus points if you can convince decodecode to grok something such
as "do_undefinstr+0x2e0/0x2f0" as the PC! ;-)

Thanks,

         M.
-- 
Who you jivin' with that Cosmik Debris?

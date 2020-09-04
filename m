Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C89E25D3A6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgIDI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 04:29:10 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42708 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbgIDI3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:29:09 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kE75j-0001TK-23; Fri, 04 Sep 2020 18:29:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Sep 2020 18:29:03 +1000
Date:   Fri, 4 Sep 2020 18:29:03 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: fix possible padata_works_lock deadlock
Message-ID: <20200904082902.GF1214@gondor.apana.org.au>
References: <20200902170756.332491-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902170756.332491-1-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 01:07:56PM -0400, Daniel Jordan wrote:
> syzbot reports,
> 
>   WARNING: inconsistent lock state
>   5.9.0-rc2-syzkaller #0 Not tainted
>   --------------------------------
>   inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>   syz-executor.0/26715 takes:
>   (padata_works_lock){+.?.}-{2:2}, at: padata_do_parallel kernel/padata.c:220
>   {IN-SOFTIRQ-W} state was registered at:
>     spin_lock include/linux/spinlock.h:354 [inline]
>     padata_do_parallel kernel/padata.c:220
>     ...
>     __do_softirq kernel/softirq.c:298
>     ...
>     sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1091
>     asm_sysvec_apic_timer_interrupt arch/x86/include/asm/idtentry.h:581
> 
>    Possible unsafe locking scenario:
> 
>          CPU0
>          ----
>     lock(padata_works_lock);
>     <Interrupt>
>       lock(padata_works_lock);
> 
> padata_do_parallel() takes padata_works_lock with softirqs enabled, so a
> deadlock is possible if, on the same CPU, the lock is acquired in
> process context and then softirq handling done in an interrupt leads to
> the same path.
> 
> Fix by leaving softirqs disabled while do_parallel holds
> padata_works_lock.
> 
> Reported-by: syzbot+f4b9f49e38e25eb4ef52@syzkaller.appspotmail.com
> Fixes: 4611ce2246889 ("padata: allocate work structures for parallel jobs from a pool")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/padata.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

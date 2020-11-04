Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F152A636F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgKDLim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgKDLig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:38:36 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D70C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:38:36 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CR4RG0Fdjz9sVN; Wed,  4 Nov 2020 22:38:32 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     "Paul E . McKenney" <paulmck@kernel.org>, Qian Cai <cai@redhat.com>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201028182334.13466-1-cai@redhat.com>
References: <20201028182334.13466-1-cai@redhat.com>
Subject: Re: [PATCH] powerpc/smp: Move rcu_cpu_starting() earlier
Message-Id: <160448988356.674824.15131006402948740998.b4-ty@ellerman.id.au>
Date:   Wed,  4 Nov 2020 22:38:32 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 14:23:34 -0400, Qian Cai wrote:
> The call to rcu_cpu_starting() in start_secondary() is not early enough
> in the CPU-hotplug onlining process, which results in lockdep splats as
> follows:
> 
>  WARNING: suspicious RCU usage
>  -----------------------------
>  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/smp: Call rcu_cpu_starting() earlier
      https://git.kernel.org/powerpc/c/99f070b62322a4b8c1252952735806d09eb44b68

cheers

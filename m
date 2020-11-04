Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951132A636E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgKDLig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgKDLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:38:35 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73259C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:38:35 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CR4RC23yVz9sVK; Wed,  4 Nov 2020 22:38:30 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@redhat.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201028152717.8967-1-cai@redhat.com>
References: <20201028152717.8967-1-cai@redhat.com>
Subject: Re: [PATCH] powerpc/eeh_cache: Fix a possible debugfs deadlock
Message-Id: <160448988321.674824.1925161464513848358.b4-ty@ellerman.id.au>
Date:   Wed,  4 Nov 2020 22:38:30 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 11:27:17 -0400, Qian Cai wrote:
> Lockdep complains that a possible deadlock below in
> eeh_addr_cache_show() because it is acquiring a lock with IRQ enabled,
> but eeh_addr_cache_insert_dev() needs to acquire the same lock with IRQ
> disabled. Let's just make eeh_addr_cache_show() acquire the lock with
> IRQ disabled as well.
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&pci_io_addr_cache_root.piar_lock);
>                                 local_irq_disable();
>                                 lock(&tp->lock);
>                                 lock(&pci_io_addr_cache_root.piar_lock);
>    <Interrupt>
>      lock(&tp->lock);
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/eeh_cache: Fix a possible debugfs deadlock
      https://git.kernel.org/powerpc/c/fd552e0542b4532483289cce48fdbd27b692984b

cheers

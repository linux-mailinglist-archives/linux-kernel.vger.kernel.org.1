Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457A52CFADC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 10:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgLEJfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 04:35:12 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:45834 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLEJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 04:31:52 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 53EFA2010F4;
        Sat,  5 Dec 2020 09:05:30 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 5188420EC4; Sat,  5 Dec 2020 09:55:07 +0100 (CET)
Date:   Sat, 5 Dec 2020 09:55:07 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pcmcia: Remove NEC VRC4173 CARDU
Message-ID: <X8tK64MJaY4mRE13@light.dominikbrodowski.net>
References: <202009161552.irOZaEej%lkp@intel.com>
 <20200916081629.cfi6svr3yjvzimqs@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916081629.cfi6svr3yjvzimqs@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Sep 16, 2020 at 10:16:29AM +0200 schrieb Sebastian Andrzej Siewior:
> This driver is the very definition of bitrotting:
> - Introduced in commit
>   79a140932c776 ("[PATCH] mips: vR41xx updates")
>   which is 2.6.11-rc3.
> 
> - Provides ->register_callback which was removed in commit
>   7f316b033b36a ("[PATCH] pcmcia: remove socket register_callback")
>   which is v2.6.14-rc3
> 
> - Uses INIT_WORK() with three arguments which was removed in commit
>   65f27f38446e1 ("WorkStruct: Pass the work_struct pointer instead of context data")
>   which is v2.6.20-rc1
> 
> - Provides ->inquire_socket and uses socket_cap_t which was removed in
>   commit
>   b7949fdacbe00 ("[PCMCIA] Remove inquire_socket")
>   which is 2.5.72
> 
> - Provides ->get_io_map which was removed in commit
>   d7de1b64a23b9 ("[PCMCIA] pcmcia-2: Remove get_io_map and get_mem_map socket methods.")
>   which is 2.5.66
> 
> Remove VRC4173 CARDU from the tree because it never had the luck to be
> successfully compiled. Let it finally find peace in byte heaven.
> 
> Cc: Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to pcmcia-next.

Thanks,
	Dominik

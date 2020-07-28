Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2113F230CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgG1PDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:03:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbgG1PDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:03:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1AA031B;
        Tue, 28 Jul 2020 08:03:17 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305F83F718;
        Tue, 28 Jul 2020 08:03:16 -0700 (PDT)
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com> <20200727053230.19753-10-srikar@linux.vnet.ibm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v4 09/10] Powerpc/smp: Create coregroup domain
In-reply-to: <20200727053230.19753-10-srikar@linux.vnet.ibm.com>
Date:   Tue, 28 Jul 2020 16:03:11 +0100
Message-ID: <jhjr1sviswg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 27/07/20 06:32, Srikar Dronamraju wrote:
> Add percpu coregroup maps and masks to create coregroup domain.
> If a coregroup doesn't exist, the coregroup domain will be degenerated
> in favour of SMT/CACHE domain.
>

So there's at least one arm64 platform out there with the same "pairs of
cores share L2" thing (Ampere eMAG), and that lives quite happily with the
default scheduler topology (SMT/MC/DIE). Each pair of core gets its MC
domain, and the whole system is covered by DIE.

Now arguably it's not a perfect representation; DIE doesn't have
SD_SHARE_PKG_RESOURCES so the highest level sd_llc can point to is MC. That
will impact all callsites using cpus_share_cache(): in the eMAG case, only
pairs of cores will be seen as sharing cache, even though *all* cores share
the same L3.

I'm trying to paint a picture of what the P9 topology looks like (the one
you showcase in your cover letter) to see if there are any similarities;
from what I gather in [1], wikichips and your cover letter, with P9 you can
have something like this in a single DIE (somewhat unsure about L3 setup;
it looks to be distributed?)

     +---------------------------------------------------------------------+
     |                                  L3                                 |
     +---------------+-+---------------+-+---------------+-+---------------+
     |       L2      | |       L2      | |       L2      | |       L2      |
     +------+-+------+ +------+-+------+ +------+-+------+ +------+-+------+
     |  L1  | |  L1  | |  L1  | |  L1  | |  L1  | |  L1  | |  L1  | |  L1  |
     +------+ +------+ +------+ +------+ +------+ +------+ +------+ +------+
     |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs| |4 CPUs|
     +------+ +------+ +------+ +------+ +------+ +------+ +------+ +------+

Which would lead to (ignoring the whole SMT CPU numbering shenanigans)

NUMA     [                                                   ...
DIE      [                                             ]
MC       [         ] [         ] [         ] [         ]
BIGCORE  [         ] [         ] [         ] [         ]
SMT      [   ] [   ] [   ] [   ] [   ] [   ] [   ] [   ]
         00-03 04-07 08-11 12-15 16-19 20-23 24-27 28-31  <other node here>

This however has MC == BIGCORE; what makes it you can have different spans
for these two domains? If it's not too much to ask, I'd love to have a P9
topology diagram.

[1]: 20200722081822.GG9290@linux.vnet.ibm.com

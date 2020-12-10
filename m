Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266D22D5946
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbgLJLbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389510AbgLJLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:52 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508FCC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:30:34 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBYF1ksbz9shj; Thu, 10 Dec 2020 22:30:24 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Phil Auld <pauld@redhat.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201202050456.164005-1-srikar@linux.vnet.ibm.com>
References: <20201202050456.164005-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/4] Powerpc: Better preemption for shared processor
Message-Id: <160756606176.1313423.10082301769067590963.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:30:24 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 10:34:52 +0530, Srikar Dronamraju wrote:
> Currently, vcpu_is_preempted will return the yield_count for
> shared_processor. On a PowerVM LPAR, Phyp schedules at SMT8 core boundary
> i.e all CPUs belonging to a core are either group scheduled in or group
> scheduled out. This can be used to better predict non-preempted CPUs on
> PowerVM shared LPARs.
> 
> perf stat -r 5 -a perf bench sched pipe -l 10000000 (lesser time is better)
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc: Refactor is_kvm_guest() declaration to new header
      https://git.kernel.org/powerpc/c/92cc6bf01c7f4c5cfefd1963985c0064687ebeda
[2/4] powerpc: Rename is_kvm_guest() to check_kvm_guest()
      https://git.kernel.org/powerpc/c/16520a858a995742c2d2248e86a6026bd0316562
[3/4] powerpc: Reintroduce is_kvm_guest() as a fast-path check
      https://git.kernel.org/powerpc/c/a21d1becaa3f17a97b933ffa677b526afc514ec5
[4/4] powerpc/paravirt: Use is_kvm_guest() in vcpu_is_preempted()
      https://git.kernel.org/powerpc/c/ca3f969dcb111d35674b66bdcb72beb2c426b9b5

cheers

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55217285702
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgJGDVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:21:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgJGDVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:21:24 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4C5fkW1J2sz9sTm; Wed,  7 Oct 2020 14:21:22 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Nathan Lynch <nathanl@linux.ibm.com>
In-Reply-To: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
References: <20200921095653.9701-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 00/11] Optimization to improve CPU online/offline on Powerpc
Message-Id: <160204083660.257875.8709249280751026471.b4-ty@ellerman.id.au>
Date:   Wed,  7 Oct 2020 14:21:22 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 15:26:42 +0530, Srikar Dronamraju wrote:
> Here are some optimizations and fixes to make CPU online/offline
> faster and hence result in faster bootup.
> 
> Its based on top of my v5 coregroup support patchset.
> https://lore.kernel.org/linuxppc-dev/20200810071834.92514-1-srikar@linux.vnet.ibm.com/t/#u
> 
> Anton reported that his 4096 cpu (1024 cores in a socket) was taking too
> long to boot. He also analyzed that most of the time was being spent on
> updating cpu_core_mask.
> 
> [...]

Applied to powerpc/next.

[01/11] powerpc/topology: Update topology_core_cpumask
        https://git.kernel.org/powerpc/c/4bce545903fa0290e011cf118997717f0c4f4d20
[02/11] powerpc/smp: Stop updating cpu_core_mask
        https://git.kernel.org/powerpc/c/4ca234a9cbd7c3a656b34dd98c8b156f70ed7849
[03/11] powerpc/smp: Remove get_physical_package_id
        https://git.kernel.org/powerpc/c/e29e9ed665eeb6f98cd88672994ecf4aaefdb943
[04/11] powerpc/smp: Optimize remove_cpu_from_masks
        https://git.kernel.org/powerpc/c/70edd4a7c753ba18e3e4bb9e97b6d85156cea738
[05/11] powerpc/smp: Limit CPUs traversed to within a node.
        https://git.kernel.org/powerpc/c/53516d4abacfab1faaa075c1f79957abc3da358c
[06/11] powerpc/smp: Stop passing mask to update_mask_by_l2
        https://git.kernel.org/powerpc/c/1f3a4181042107e32e44047e9dde990aced845b5
[07/11] powerpc/smp: Depend on cpu_l1_cache_map when adding CPUs
        https://git.kernel.org/powerpc/c/661e3d42f99193b7fdd71467a87e48f6e597c285
[08/11] powerpc/smp: Check for duplicate topologies and consolidate
        https://git.kernel.org/powerpc/c/375370a10d061d5c75c6bc5b09c5db4cc0b0fcfe
[09/11] powerpc/smp: Optimize update_mask_by_l2
        https://git.kernel.org/powerpc/c/3ab33d6dc3e98e83b55732049e1d1d488207bb6d
[10/11] powerpc/smp: Move coregroup mask updation to a new function
        https://git.kernel.org/powerpc/c/b8a97cb4599cda28bd3b3bc13042f5803b42ad65
[11/11] powerpc/smp: Optimize update_coregroup_mask
        https://git.kernel.org/powerpc/c/70a94089d7f7fa91bc1795622426b3ed017ec71a

cheers

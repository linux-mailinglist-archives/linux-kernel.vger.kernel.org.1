Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA05626DA48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgIQLdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgIQL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:53 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC8C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:50 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSl0HLFz9sVf; Thu, 17 Sep 2020 21:27:34 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Neuling <mikey@linux.ibm.com>,
        Michael Ellerman <michaele@au1.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Anton Blanchard <anton@au1.ibm.com>,
        Nick Piggin <npiggin@au1.ibm.com>
In-Reply-To: <20200810071834.92514-1-srikar@linux.vnet.ibm.com>
References: <20200810071834.92514-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 00/10] Coregroup support on Powerpc
Message-Id: <160034201134.3339803.10634582499637013510.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:34 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 12:48:24 +0530, Srikar Dronamraju wrote:
> Changelog v4->v5:
> v4: http://lore.kernel.org/lkml/20200727053230.19753-1-srikar@linux.vnet.ibm.com/t/#u
> 
> Changelog v4 ->v5:
> powerpc/smp: Optimize start_secondary
> 	Retain cache domain, no need for generalization
> 		 (Michael Ellerman, Peter Zijlstra,
> 		 Valentin Schneider, Gautham R. Shenoy)
> 
> [...]

Applied to powerpc/next.

[01/10] powerpc/smp: Fix a warning under !NEED_MULTIPLE_NODES
        https://git.kernel.org/powerpc/c/d0fd24bbd27619d7b8d4da26a19a2027931ae9fc
[02/10] powerpc/smp: Merge Power9 topology with Power topology
        https://git.kernel.org/powerpc/c/2ef0ca54d97f40f7621d595ac5479bd7fa076bfa
[03/10] powerpc/smp: Move powerpc_topology above
        https://git.kernel.org/powerpc/c/5e93f16ae48b728775496429c6db53d0bf8cdd9b
[04/10] powerpc/smp: Move topology fixups into a new function
        https://git.kernel.org/powerpc/c/3c6032a8fe99547d31b2b57715e303a67d1b0c66
[05/10] powerpc/smp: Dont assume l2-cache to be superset of sibling
        https://git.kernel.org/powerpc/c/f6606cfdfbcda00ce8a6e63c8fc13c93e73ac059
[06/10] powerpc/smp: Optimize start_secondary
        https://git.kernel.org/powerpc/c/caa8e29da59926bef099b46ab6280333d583e944
[07/10] powerpc/numa: Detect support for coregroup
        https://git.kernel.org/powerpc/c/f9f130ff2ec93c5949576bbfb168cc9530c23649
[08/10] powerpc/smp: Allocate cpumask only after searching thread group
        https://git.kernel.org/powerpc/c/6e086302816b2ced602bc99641eb0189c05f018a
[09/10] powerpc/smp: Create coregroup domain
        https://git.kernel.org/powerpc/c/72730bfc2a2b91a525f38dfc830f598bdb95f216
[10/10] powerpc/smp: Implement cpu_to_coregroup_id
        https://git.kernel.org/powerpc/c/fa35e868f9ddcbb7984fd5ab7f91aef924fa8543

cheers

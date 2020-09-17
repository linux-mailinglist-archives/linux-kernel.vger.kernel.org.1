Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD726DA55
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgIQLfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgIQL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:49 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66214C061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:31 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSd26GKz9sTp; Thu, 17 Sep 2020 21:27:29 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au
Cc:     mikey@neuling.org, pedromfc@linux.ibm.com, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
References: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v6 0/8] powerpc/watchpoint: Bug fixes plus new feature flag
Message-Id: <160034200951.3339803.694776749712911885.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:29 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 09:59:37 +0530, Ravi Bangoria wrote:
> Patch #1 fixes issue for quardword instruction on p10 predecessors.
> Patch #2 fixes issue for vector instructions.
> Patch #3 fixes a bug about watchpoint not firing when created with
>          ptrace PPC_PTRACE_SETHWDEBUG and CONFIG_HAVE_HW_BREAKPOINT=N.
>          The fix uses HW_BRK_TYPE_PRIV_ALL for ptrace user which, I
>          guess, should be fine because we don't leak any kernel
>          addresses and PRIV_ALL will also help to cover scenarios when
>          kernel accesses user memory.
> Patch #4,#5 fixes infinite exception bug, again the bug happens only
>          with CONFIG_HAVE_HW_BREAKPOINT=N.
> Patch #6 fixes two places where we are missing to set hw_len.
> Patch #7 introduce new feature bit PPC_DEBUG_FEATURE_DATA_BP_ARCH_31
>          which will be set when running on ISA 3.1 compliant machine.
> Patch #8 finally adds selftest to test scenarios fixed by patch#2,#3
>          and also moves MODE_EXACT tests outside of BP_RANGE condition.
> 
> [...]

Applied to powerpc/next.

[1/8] powerpc/watchpoint: Fix quadword instruction handling on p10 predecessors
      https://git.kernel.org/powerpc/c/4759c11ed20454b7b36db4ec15f7d5aa1519af4a
[2/8] powerpc/watchpoint: Fix handling of vector instructions
      https://git.kernel.org/powerpc/c/4441eb02333a9b46a0d919aa7a6d3b137b5f2562
[3/8] powerpc/watchpoint/ptrace: Fix SETHWDEBUG when CONFIG_HAVE_HW_BREAKPOINT=N
      https://git.kernel.org/powerpc/c/9b6b7c680cc20971444d9f836e49fc98848bcd0a
[4/8] powerpc/watchpoint: Move DAWR detection logic outside of hw_breakpoint.c
      https://git.kernel.org/powerpc/c/edc8dd99b29e4d705c45e2a3a6c01b096ee056db
[5/8] powerpc/watchpoint: Fix exception handling for CONFIG_HAVE_HW_BREAKPOINT=N
      https://git.kernel.org/powerpc/c/5b905d77987de065bdd3a2906816b5f143df087b
[6/8] powerpc/watchpoint: Add hw_len wherever missing
      https://git.kernel.org/powerpc/c/58da5984d2ea6d95f3f9d9e8dd9f7e1b0dddfb3c
[7/8] powerpc/watchpoint/ptrace: Introduce PPC_DEBUG_FEATURE_DATA_BP_ARCH_31
      https://git.kernel.org/powerpc/c/fa725cc53d353110f39a9e5b9f60d6acb2c7ff49
[8/8] selftests/powerpc: Tests for kernel accessing user memory
      https://git.kernel.org/powerpc/c/ac234524056da4e0c081f682da3ea25cdaab737a

cheers

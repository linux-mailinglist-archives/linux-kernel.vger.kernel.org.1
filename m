Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1B293B74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394318AbgJTMX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:23:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38107 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394210AbgJTMX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:23:58 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CFt8W3RDHz9sRR; Tue, 20 Oct 2020 23:23:54 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
In-Reply-To: <20201019042716.106234-1-srikar@linux.vnet.ibm.com>
References: <20201019042716.106234-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/2] Fixes for coregroup
Message-Id: <160319650960.2348169.11451661238920733591.b4-ty@ellerman.id.au>
Date:   Tue, 20 Oct 2020 23:23:54 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 09:57:14 +0530, Srikar Dronamraju wrote:
> These patches fixes problems introduced by the coregroup patches.
> The first patch we remove a redundant variable.
> Second patch allows to boot with CONFIG_CPUMASK_OFFSTACK enabled.
> 
> Changelog v1->v2:
> https://lore.kernel.org/linuxppc-dev/20201008034240.34059-1-srikar@linux.vnet.ibm.com/t/#u
> 1. 1st patch was not part of previous posting.
> 2. Updated 2nd patch based on comments from Michael Ellerman
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/smp: Remove unnecessary variable
      https://git.kernel.org/powerpc/c/966730a6e8524c1b5fe64358e5884605cab6ccb3
[2/2] powerpc/smp: Use GFP_ATOMIC while allocating tmp mask
      https://git.kernel.org/powerpc/c/84dbf66c63472069e5eb40b810731367618cd8b5

cheers

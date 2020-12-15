Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DCE2DAB70
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgLOKvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgLOKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:50:17 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C8DC061285
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:49:05 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFPB2Ysxz9sVk; Tue, 15 Dec 2020 21:49:01 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1607596739-32439-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1607596739-32439-1-git-send-email-ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/5] Extend Parsing "ibm, thread-groups" for Shared-L2 information
Message-Id: <160802921455.504444.5516120059698119802.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:49:01 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 16:08:54 +0530, Gautham R. Shenoy wrote:
> This is the v2 of the patchset to extend parsing of "ibm,thread-groups" property
> to discover the Shared-L2 cache information.
> 
> The previous versions can be found here :
> 
> v2 : https://lore.kernel.org/linuxppc-dev/1607533700-5546-1-git-send-email-ego@linux.vnet.ibm.com/T/#m043ea15d3832658527fca94765202b9cbefd330d
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc/smp: Parse ibm,thread-groups with multiple properties
      https://git.kernel.org/powerpc/c/790a1662d3a26fe9fa5f691386d8fde6bb8b0dc2
[2/5] powerpc/smp: Rename cpu_l1_cache_map as thread_group_l1_cache_map
      https://git.kernel.org/powerpc/c/1fdc1d6632ff3f6813a2f15b65586bde8fe0f0ba
[3/5] powerpc/smp: Rename init_thread_group_l1_cache_map() to make it generic
      https://git.kernel.org/powerpc/c/fbd2b672e91d276b9fa5a729e4a823ba29fa2692
[4/5] powerpc/smp: Add support detecting thread-groups sharing L2 cache
      https://git.kernel.org/powerpc/c/9538abee18cca70ffd03cef56027388b0c5084cc
[5/5] powerpc/cacheinfo: Print correct cache-sibling map/list for L2 cache
      https://git.kernel.org/powerpc/c/0be47634db0baa9e91c7e635e7e73355d6a5cf43

cheers

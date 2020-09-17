Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD8F26DAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIQL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgIQL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:30 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7514BC06178B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:22 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSR0Sg2z9sTQ; Thu, 17 Sep 2020 21:27:18 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <8ae4554357da4882612644a74387ae05525b2aaa.1599800716.git.christophe.leroy@csgroup.eu>
References: <8ae4554357da4882612644a74387ae05525b2aaa.1599800716.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/kasan: Fix CONFIG_KASAN_VMALLOC for 8xx
Message-Id: <160034201660.3339803.1270264630243029470.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:18 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 05:05:38 +0000 (UTC), Christophe Leroy wrote:
> Before the commit identified below, pages tables allocation was
> performed after the allocation of final shadow area for linear memory.
> But that commit switched the order, leading to page tables being
> already allocated at the time 8xx kasan_init_shadow_8M() is called.
> Due to this, kasan_init_shadow_8M() doesn't map the needed
> shadow entries because there are already page tables.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kasan: Fix CONFIG_KASAN_VMALLOC for 8xx
      https://git.kernel.org/powerpc/c/4c42dc5c69a8f24c467a6c997909d2f1d4efdc7f

cheers

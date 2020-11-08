Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981B52AAA8F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 11:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgKHK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 05:29:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52023 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgKHK3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 05:29:42 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CTVjv5lwvz9sTv; Sun,  8 Nov 2020 21:29:39 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <af834e8a0f1fa97bfae65664950f0984a70c4750.1602492856.git.christophe.leroy@csgroup.eu>
References: <af834e8a0f1fa97bfae65664950f0984a70c4750.1602492856.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/8xx: Always fault when _PAGE_ACCESSED is not set
Message-Id: <160483134413.1400561.8432797439436517862.b4-ty@ellerman.id.au>
Date:   Sun,  8 Nov 2020 21:29:39 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 08:54:31 +0000 (UTC), Christophe Leroy wrote:
> The kernel expects pte_young() to work regardless of CONFIG_SWAP.
> 
> Make sure a minor fault is taken to set _PAGE_ACCESSED when it
> is not already set, regardless of the selection of CONFIG_SWAP.
> 
> This adds at least 3 instructions to the TLB miss exception
> handlers fast path. Following patch will reduce this overhead.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/8xx: Always fault when _PAGE_ACCESSED is not set
      https://git.kernel.org/powerpc/c/29daf869cbab69088fe1755d9dd224e99ba78b56
[2/2] powerpc/8xx: Manage _PAGE_ACCESSED through APG bits in L1 entry
      https://git.kernel.org/powerpc/c/33fe43cfd9b1c20f6f9899b44bf04e91823ff1c9

cheers

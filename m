Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191E922E681
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 09:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgG0H1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 03:27:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34177 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgG0H06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:26:58 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BFWb36Z58z9sTg; Mon, 27 Jul 2020 17:26:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
Subject: Re: [PATCH 0/9] powerpc: delete duplicated words
Message-Id: <159583479016.602200.15928174680101710128.b4-ty@ellerman.id.au>
Date:   Mon, 27 Jul 2020 17:26:55 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 17:38:00 -0700, Randy Dunlap wrote:
> Drop duplicated words in arch/powerpc/ header files.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> 
> [...]

Applied to powerpc/next.

[1/9] powerpc/book3s/mmu-hash.h: delete duplicated word
      https://git.kernel.org/powerpc/c/10a4a016d6a882ba7601159b0f719330b102c41b
[2/9] powerpc/book3s/radix-4k.h: delete duplicated word
      https://git.kernel.org/powerpc/c/92be1fca08eabe8ab083b1dfccd3e932b4fb6f1a
[3/9] powerpc/cputime.h: delete duplicated word
      https://git.kernel.org/powerpc/c/dc9bf323d6b8996d22c111add0ac8b0c895dcf52
[4/9] powerpc/epapr_hcalls.h: delete duplicated words
      https://git.kernel.org/powerpc/c/8965aa4b684f022c4d0bc6429097ddb38a26eaef
[5/9] powerpc/hw_breakpoint.h: delete duplicated word
      https://git.kernel.org/powerpc/c/028cc22d29959b501add32fc62660e5484c8092d
[6/9] powerpc/ppc_asm.h: delete duplicated word
      https://git.kernel.org/powerpc/c/db10f5500004268b29e3c5bfd1e44ef53a1e25c9
[7/9] powerpc/reg.h: delete duplicated word
      https://git.kernel.org/powerpc/c/850659392abc303d41c3f9217d45ab4fa79d201c
[8/9] powerpc/smu.h: delete duplicated word
      https://git.kernel.org/powerpc/c/3b56ed4b461fd92b66f6ea44d81837e12878031f
[9/9] powerpc/powernv/pci.h: delete duplicated word
      https://git.kernel.org/powerpc/c/86052e407e8e1964c81965de25832258875a0e6d

cheers

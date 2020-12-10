Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0F2D5937
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389490AbgLJLam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:30:42 -0500
Received: from ozlabs.org ([203.11.71.1]:35319 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389446AbgLJLa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:27 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXT0LmQz9sWx; Thu, 10 Dec 2020 22:29:44 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <829ae1aed1d2fc6b5fc5818362e573dee5d6ecde.1602489852.git.christophe.leroy@csgroup.eu>
References: <829ae1aed1d2fc6b5fc5818362e573dee5d6ecde.1602489852.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Desintegrate MMU_FTR_PPCAS_ARCH_V2
Message-Id: <160756607081.1313423.15871737991465948250.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:44 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 08:04:24 +0000 (UTC), Christophe Leroy wrote:
> MMU_FTR_PPCAS_ARCH_V2 is defined in cpu_table.h
> as MMU_FTR_TLBIEL | MMU_FTR_16M_PAGE.
> 
> MMU_FTR_TLBIEL and MMU_FTR_16M_PAGE are defined in mmu.h
> 
> MMU_FTR_PPCAS_ARCH_V2 is used only in mmu.h and it is used only once.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm: Desintegrate MMU_FTR_PPCAS_ARCH_V2
      https://git.kernel.org/powerpc/c/0e8ff4f8d2faa2e3381e774c9e2fb975e8b4598f

cheers

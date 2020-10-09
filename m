Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5D2881ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgJIGEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:04:00 -0400
Received: from ozlabs.org ([203.11.71.1]:37459 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJIGEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:04:00 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4C6yF936fKz9sTR; Fri,  9 Oct 2020 17:03:57 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <319d379f696412681c66a987cc75e6abf8f958d2.1601975100.git.christophe.leroy@csgroup.eu>
References: <319d379f696412681c66a987cc75e6abf8f958d2.1601975100.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/32s: Rename head_32.S to head_book3s_32.S
Message-Id: <160222339355.867048.3903494504436906877.b4-ty@ellerman.id.au>
Date:   Fri,  9 Oct 2020 17:03:57 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 09:05:26 +0000 (UTC), Christophe Leroy wrote:
> Unlike PPC64 which had a single head_64.S, PPC32 are multiple ones.
> There is the head_32.S, selected by default based on the value of BITS
> and overridden based on some CONFIG_ values. This leads to thinking
> that it may be selected by different types of PPC32 platform but
> indeed it ends up being selected by book3s/32 only.
> 
> Make that explicit by:
> - Not doing any default selection based on BITS.
> - Renaming head_32.S to head_book3s_32.S.
> - Get head_book3s_32.S selected only by CONFIG_PPC_BOOK3S_32.

Applied to powerpc/next.

[1/2] powerpc/32s: Rename head_32.S to head_book3s_32.S
      https://git.kernel.org/powerpc/c/533090e5a980ad80bbe0961b4ed45a9bcf55cc0c
[2/2] powerpc/32s: Remove #ifdef CONFIG_PPC_BOOK3S_32 in head_book3s_32.S
      https://git.kernel.org/powerpc/c/865418795a1dea1c2b58a5fd7b6bdcb93e0c36b8

cheers

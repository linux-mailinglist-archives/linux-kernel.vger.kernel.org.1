Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E39F2D5940
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbgLJLal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:30:41 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389444AbgLJLa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:27 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXS1KWSz9sWt; Thu, 10 Dec 2020 22:29:43 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <18b357d68c4cde149f75c7a1031c850925cd8128.1605981539.git.christophe.leroy@csgroup.eu>
References: <18b357d68c4cde149f75c7a1031c850925cd8128.1605981539.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: inline iomap accessors
Message-Id: <160756604708.1313423.2512500774127488232.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:43 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Nov 2020 17:59:19 +0000 (UTC), Christophe Leroy wrote:
> ioreadXX()/ioreadXXbe() accessors are equivalent to ppc
> in_leXX()/in_be16() accessors but they are not inlined.
> 
> Since commit 0eb573682872 ("powerpc/kerenl: Enable EEH for IO
> accessors"), the 'le' versions are equivalent to the ones
> defined in asm-generic/io.h, allthough the ones there are inlined.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: inline iomap accessors
      https://git.kernel.org/powerpc/c/894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e

cheers

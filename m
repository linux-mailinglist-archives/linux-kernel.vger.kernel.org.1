Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD522E0A73
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgLVNMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:12:10 -0500
Received: from ozlabs.org ([203.11.71.1]:50509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbgLVNMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:12:06 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4D0cDD4hjWz9sTg; Wed, 23 Dec 2020 00:11:24 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <df05d53eed1210cf1aa76d1fb44aa0fab29c018e.1608488286.git.christophe.leroy@csgroup.eu>
References: <df05d53eed1210cf1aa76d1fb44aa0fab29c018e.1608488286.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/time: Force inlining of get_tb()
Message-Id: <160864266098.1929899.4436142434318857345.b4-ty@ellerman.id.au>
Date:   Wed, 23 Dec 2020 00:11:24 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Dec 2020 18:18:26 +0000 (UTC), Christophe Leroy wrote:
> Force inlining of get_tb() in order to avoid getting
> following function in vdso32, leading to suboptimal
> performance in clock_gettime()
> 
> 00000688 <.get_tb>:
>  688:	7c 6d 42 a6 	mftbu   r3
>  68c:	7c 8c 42 a6 	mftb    r4
>  690:	7d 2d 42 a6 	mftbu   r9
>  694:	7c 03 48 40 	cmplw   r3,r9
>  698:	40 e2 ff f0 	bne+    688 <.get_tb>
>  69c:	4e 80 00 20 	blr

Applied to powerpc/fixes.

[1/1] powerpc/time: Force inlining of get_tb()
      https://git.kernel.org/powerpc/c/0faa22f09caadc11af2aa7570870ebd2ac5b8170

cheers

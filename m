Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABB2DFB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgLULEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLULEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:04:12 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:03:31 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CzxR45BPPz9sVt; Mon, 21 Dec 2020 22:03:28 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <a1d31f84ddb0926813b17fcd5cc7f3fa7b4deac2.1602759123.git.christophe.leroy@csgroup.eu>
References: <a1d31f84ddb0926813b17fcd5cc7f3fa7b4deac2.1602759123.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: force inlining of csum_partial() to avoid multiple csum_partial() with GCC10
Message-Id: <160854857836.1696279.559566714940514857.b4-ty@ellerman.id.au>
Date:   Mon, 21 Dec 2020 22:03:28 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 10:52:20 +0000 (UTC), Christophe Leroy wrote:
> 	ppc-linux-objdump -d vmlinux | grep -e "<csum_partial>" -e "<__csum_partial>"
> 
> With gcc9 I get:
> 
> 	c0017ef8 <__csum_partial>:
> 	c00182fc:	4b ff fb fd 	bl      c0017ef8 <__csum_partial>
> 	c0018478:	4b ff fa 80 	b       c0017ef8 <__csum_partial>
> 	c03e8458:	4b c2 fa a0 	b       c0017ef8 <__csum_partial>
> 	c03e8518:	4b c2 f9 e1 	bl      c0017ef8 <__csum_partial>
> 	c03ef410:	4b c2 8a e9 	bl      c0017ef8 <__csum_partial>
> 	c03f0b24:	4b c2 73 d5 	bl      c0017ef8 <__csum_partial>
> 	c04279a4:	4b bf 05 55 	bl      c0017ef8 <__csum_partial>
> 	c0429820:	4b be e6 d9 	bl      c0017ef8 <__csum_partial>
> 	c0429944:	4b be e5 b5 	bl      c0017ef8 <__csum_partial>
> 	c042b478:	4b be ca 81 	bl      c0017ef8 <__csum_partial>
> 	c042b554:	4b be c9 a5 	bl      c0017ef8 <__csum_partial>
> 	c045f15c:	4b bb 8d 9d 	bl      c0017ef8 <__csum_partial>
> 	c0492190:	4b b8 5d 69 	bl      c0017ef8 <__csum_partial>
> 	c0492310:	4b b8 5b e9 	bl      c0017ef8 <__csum_partial>
> 	c0495594:	4b b8 29 65 	bl      c0017ef8 <__csum_partial>
> 	c049c420:	4b b7 ba d9 	bl      c0017ef8 <__csum_partial>
> 	c049c870:	4b b7 b6 89 	bl      c0017ef8 <__csum_partial>
> 	c049c930:	4b b7 b5 c9 	bl      c0017ef8 <__csum_partial>
> 	c04a9ca0:	4b b6 e2 59 	bl      c0017ef8 <__csum_partial>
> 	c04bdde4:	4b b5 a1 15 	bl      c0017ef8 <__csum_partial>
> 	c04be480:	4b b5 9a 79 	bl      c0017ef8 <__csum_partial>
> 	c04be710:	4b b5 97 e9 	bl      c0017ef8 <__csum_partial>
> 	c04c969c:	4b b4 e8 5d 	bl      c0017ef8 <__csum_partial>
> 	c04ca2fc:	4b b4 db fd 	bl      c0017ef8 <__csum_partial>
> 	c04cf5bc:	4b b4 89 3d 	bl      c0017ef8 <__csum_partial>
> 	c04d0440:	4b b4 7a b9 	bl      c0017ef8 <__csum_partial>
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: force inlining of csum_partial() to avoid multiple csum_partial() with GCC10
      https://git.kernel.org/powerpc/c/328e7e487a464aad024fbde6663b7859df082b7b

cheers

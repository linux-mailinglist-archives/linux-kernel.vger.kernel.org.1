Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DA62E0A72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgLVNMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:12:08 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbgLVNME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:12:04 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4D0cDB4BSMz9sWP; Wed, 23 Dec 2020 00:11:22 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <a3d819d5c348cee9783a311d5d3f3ba9b48fd219.1608531452.git.christophe.leroy@csgroup.eu>
References: <a3d819d5c348cee9783a311d5d3f3ba9b48fd219.1608531452.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Fix vmap stack - Properly set r1 before activating MMU on syscall too
Message-Id: <160864266247.1929899.17670433500031746494.b4-ty@ellerman.id.au>
Date:   Wed, 23 Dec 2020 00:11:22 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 06:18:03 +0000 (UTC), Christophe Leroy wrote:
> We need r1 to be properly set before activating MMU, otherwise any new
> exception taken while saving registers into the stack in syscall
> prologs will use the user stack, which is wrong and will even lockup
> or crash when KUAP is selected.
> 
> Do that by switching the meaning of r11 and r1 until we have saved r1
> to the stack: copy r1 into r11 and setup the new stack pointer in r1.
> To avoid complicating and impacting all generic and specific prolog
> code (and more), copy back r1 into r11 once r11 is save onto
> the stack.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/32: Fix vmap stack - Properly set r1 before activating MMU on syscall too
      https://git.kernel.org/powerpc/c/d5c243989fb0cb03c74d7340daca3b819f706ee7

cheers

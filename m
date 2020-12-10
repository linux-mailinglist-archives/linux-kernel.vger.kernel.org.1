Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C0F2D5943
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbgLJLbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389452AbgLJLae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:34 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ACDC0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:29:54 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXc1P19z9sX1; Thu, 10 Dec 2020 22:29:51 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 00/30] Modernise VDSO setup
Message-Id: <160756605935.1313423.1310599054627609745.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:51 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Sep 2020 09:16:16 +0000 (UTC), Christophe Leroy wrote:
> This series modernises the setup of VDSO:
> - Switch to using _install_special_mapping() which has replaced install_special_mapping()
> - Move datapage in front of text like most other architectures to simplify its localisation
> - Perform link time symbol resolution instead of runtime
> 
> This leads to a huge size reduction of vdso.c
> 
> [...]

Applied to powerpc/next.

[01/30] powerpc/vdso: Stripped VDSO is not needed, don't build it
        https://git.kernel.org/powerpc/c/7fe2de246e21f01212a8923fbabb4ac84c944d4a
[02/30] powerpc/vdso: Add missing includes and clean vdso_setup_syscall_map()
        https://git.kernel.org/powerpc/c/bc9d5bfc4d23fb3580e7da360f2c9bd878dda9b2
[03/30] powerpc/vdso: Rename syscall_map_32/64 to simplify vdso_setup_syscall_map()
        https://git.kernel.org/powerpc/c/1bb30b7a45976ae02d54fd43a8665e77314cc05e
[04/30] powerpc/vdso: Remove get_page() in vdso_pagelist initialization
        https://git.kernel.org/powerpc/c/abcdbd039e6823305c2841d07a352fbd2343564e
[05/30] powerpc/vdso: Remove NULL termination element in vdso_pagelist
        https://git.kernel.org/powerpc/c/35c1c7c0bc354d8c3d55bea3bf3e239797980013
[06/30] powerpc/vdso: Refactor 32 bits and 64 bits pages setup
        https://git.kernel.org/powerpc/c/3cf63825413c9eed2dae06070464efb27381bdac
[07/30] powerpc/vdso: Remove unnecessary ifdefs in vdso_pagelist initialization
        https://git.kernel.org/powerpc/c/4fe0e3c1724e397845df75f64059bcea4ff590e8
[08/30] powerpc/vdso: Use VDSO size in arch_setup_additional_pages()
        https://git.kernel.org/powerpc/c/7461a4f79ba16dc7733c07c00883a10c7e46b602
[09/30] powerpc/vdso: Simplify arch_setup_additional_pages() exit
        https://git.kernel.org/powerpc/c/b2df3f60b452ab496adcef1b2f9c2560f6d8e8e0
[10/30] powerpc/vdso: Move to _install_special_mapping() and remove arch_vma_name()
        https://git.kernel.org/powerpc/c/c1bab64360e6850ca54305d2f1902dac829c9752
[11/30] powerpc/vdso: Provide vdso_remap()
        https://git.kernel.org/powerpc/c/526a9c4a7234cccf6d900c6e82d79356f974cbfd
[12/30] powerpc/vdso: Replace vdso_base by vdso
        https://git.kernel.org/powerpc/c/c102f07667486dc4a6ae1e3fe7aa67135cb40e3e
[13/30] powerpc/vdso: Move vdso datapage up front
        https://git.kernel.org/powerpc/c/511157ab641eb6bedd00d62673388e78a4f871cf
[14/30] powerpc/vdso: Simplify __get_datapage()
        https://git.kernel.org/powerpc/c/591857b635c1f635cae556e1b1f9d81808242493
[15/30] powerpc/vdso: Remove unused \tmp param in __get_datapage()
        https://git.kernel.org/powerpc/c/550e6074c106e1a6fb57dfef62f0daede12d832c
[16/30] powerpc/vdso: Retrieve sigtramp offsets at buildtime
        https://git.kernel.org/powerpc/c/91bf695596f594e42d69d70deb2ae53cafecf77c
[17/30] powerpc/vdso: Use builtin symbols to locate fixup section
        https://git.kernel.org/powerpc/c/ed07f6353ddf19e51c4db6d2be72ca97f7ed8a08
[18/30] powerpc/vdso: Merge __kernel_sync_dicache_p5() into __kernel_sync_dicache()
        https://git.kernel.org/powerpc/c/0fc980db9a404a993c4ed542369a745d8a14b0b7
[19/30] powerpc/vdso: Remove vdso32_pages and vdso64_pages
        https://git.kernel.org/powerpc/c/b7fe9c15b57d767fda250e8eff79be435996ef33
[20/30] powerpc/vdso: Remove __kernel_datapage_offset
        https://git.kernel.org/powerpc/c/49bf59fd0371b1053a17021f27605f43071584ee
[21/30] powerpc/vdso: Remove runtime generated sigtramp offsets
        https://git.kernel.org/powerpc/c/899367ea50637f382fdc5c927fe47e6090d4aefe
[22/30] powerpc/vdso: Remove vdso_patches[] and associated functions
        https://git.kernel.org/powerpc/c/5cda7c75493fd17a010d7399e39fda6619f69043
[23/30] powerpc/vdso: Remove unused text member in struct lib32/64_elfinfo
        https://git.kernel.org/powerpc/c/e113f8ef1c7e5fd79b440e5565c8552b36122bfa
[24/30] powerpc/vdso: Remove symbol section information in struct lib32/64_elfinfo
        https://git.kernel.org/powerpc/c/6ed613ad572a84c175629fc8657a197c6415b7d6
[25/30] powerpc/vdso: Remove lib32_elfinfo and lib64_elfinfo
        https://git.kernel.org/powerpc/c/67a354051da28d482e53146def212b102664ce0e
[26/30] powerpc/vdso: Remove vdso_setup()
        https://git.kernel.org/powerpc/c/a4ccd64acb8c08ce8d36001cdd06477deec6ae89
[27/30] powerpc/vdso: Remove vdso_ready
        https://git.kernel.org/powerpc/c/23c4ceaf1a457808d031c666760fa325c7b7f23f
[28/30] powerpc/vdso: Remove DBG()
        https://git.kernel.org/powerpc/c/e90903203d94d0a0d0e8ebc979aa0617a7bbe9a3
[29/30] powerpc/vdso: Remove VDSO32_LBASE and VDSO64_LBASE
        https://git.kernel.org/powerpc/c/676155ab239dc2035d5306438b45695b6fa165e2
[30/30] powerpc/vdso: Cleanup vdso.h
        https://git.kernel.org/powerpc/c/65d2150c89121a49e4bd4abbb99c436c77003eed

cheers

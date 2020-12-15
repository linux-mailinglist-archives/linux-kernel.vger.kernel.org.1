Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A92DAB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgLOKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgLOKyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:54:14 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D4C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:53:34 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFVN2CBTz9sS8; Tue, 15 Dec 2020 21:53:32 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 01/20] powerpc/feature: Fix CPU_FTRS_ALWAYS by removing CPU_FTRS_GENERIC_32
Message-Id: <160802955561.509074.16674731922690701129.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:53:32 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 06:29:26 +0000 (UTC), Christophe Leroy wrote:
> On 8xx, we get the following features:
> 
> [    0.000000] cpu_features      = 0x0000000000000100
> [    0.000000]   possible        = 0x0000000000000120
> [    0.000000]   always          = 0x0000000000000000
> 
> This is not correct. As CONFIG_PPC_8xx is mutually exclusive with all
> other configurations, the three lines should be equal.
> 
> [...]

Patches 1-19 applied to powerpc/next.

[01/20] powerpc/feature: Fix CPU_FTRS_ALWAYS by removing CPU_FTRS_GENERIC_32
        https://git.kernel.org/powerpc/c/78665179e569c7e1fe102fb6c21d0f5b6951f084
[02/20] powerpc/mm: Add mask of always present MMU features
        https://git.kernel.org/powerpc/c/f9158d58a4e1d91f21741e4e8ebe67f770b84e12
[03/20] powerpc/mm: Remove flush_tlb_page_nohash() prototype.
        https://git.kernel.org/powerpc/c/a54d310856b9c1fe15ad67a2f8ee9edc02965a3a
[04/20] powerpc/32s: Make bat_addrs[] static
        https://git.kernel.org/powerpc/c/03d5b19c7243d6e605d360972dd7b701e2b1ba72
[05/20] powerpc/32s: Use mmu_has_feature(MMU_FTR_HPTE_TABLE) instead of checking Hash var
        https://git.kernel.org/powerpc/c/4cc445b4ff456f3a3997c321d7a353360feea04f
[06/20] powerpc/32s: Make Hash var static
        https://git.kernel.org/powerpc/c/4b74a35fc7e9b8efd9067b8a365bab0fefe889ff
[07/20] powerpc/32s: Declare Hash related vars as __initdata
        https://git.kernel.org/powerpc/c/6e980b5c56a266de479fcd022a03e094574e9a03
[08/20] powerpc/32s: Move _tlbie() and _tlbia() prototypes to tlbflush.h
        https://git.kernel.org/powerpc/c/cfe32ad0b3dc74df34ab6fea38ccb1e53f904a10
[09/20] powerpc/32s: Inline _tlbie() on non SMP
        https://git.kernel.org/powerpc/c/b91280f3f36d64cc6f8022893af00935c99de197
[10/20] powerpc/32s: Move _tlbie() and _tlbia() in a new file
        https://git.kernel.org/powerpc/c/f265512582a047e09390b1b41384f365d7dc806f
[11/20] powerpc/32s: Split and inline flush_tlb_mm() and flush_tlb_page()
        https://git.kernel.org/powerpc/c/fd1b4b7f51d0d75b73eeda41ef459ea7791aaab2
[12/20] powerpc/32s: Inline flush_tlb_range() and flush_tlb_kernel_range()
        https://git.kernel.org/powerpc/c/1e83396f29d75aae8a1d365f597996fec87ca4d0
[13/20] powerpc/32s: Split and inline flush_range()
        https://git.kernel.org/powerpc/c/91ec450f8d8c1e599a943c526ab1d2a4acf73c22
[14/20] powerpc/32s: Inline tlb_flush()
        https://git.kernel.org/powerpc/c/ef08d95546ccea540f6a592b89822bb085bf09c6
[15/20] powerpc/32s: Inline flush_hash_entry()
        https://git.kernel.org/powerpc/c/80007a17fc59bc2766f7d5cb2f79b4c65651504b
[16/20] powerpc/32s: Move early_mmu_init() into mmu.c
        https://git.kernel.org/powerpc/c/068fdba10ea54b6ebc12c2b2d85020b2137316d1
[17/20] powerpc/32s: Remove CONFIG_PPC_BOOK3S_6xx
        https://git.kernel.org/powerpc/c/a6a50d8495d098b6459166c3707ab251d3dc9e06
[18/20] powerpc/32s: Regroup 603 based CPUs in cputable
        https://git.kernel.org/powerpc/c/ad510e37e4b48f7da462650946aeaa078b977277
[19/20] powerpc/32s: Make support for 603 and 604+ selectable
        https://git.kernel.org/powerpc/c/44e9754d63c7b419874e4c18c0b5e7a770e058c6

cheers

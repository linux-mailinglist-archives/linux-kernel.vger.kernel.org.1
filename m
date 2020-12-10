Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914282D5941
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbgLJLam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:30:42 -0500
Received: from ozlabs.org ([203.11.71.1]:48917 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389453AbgLJLaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:35 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXd0xhjz9sXL; Thu, 10 Dec 2020 22:29:52 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
References: <da51f7ec632825a4ce43290a904aad61648408c0.1606285013.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/8] powerpc/32s: Always map kernel text and rodata with BATs
Message-Id: <160756606979.1313423.763672352823018023.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:52 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 07:10:46 +0000 (UTC), Christophe Leroy wrote:
> Since commit 2b279c0348af ("powerpc/32s: Allow mapping with BATs with
> DEBUG_PAGEALLOC"), there is no real situation where mapping without
> BATs is required.
> 
> In order to simplify memory handling, always map kernel text
> and rodata with BATs even when "nobats" kernel parameter is set.
> 
> [...]

Applied to powerpc/next.

[1/8] powerpc/32s: Always map kernel text and rodata with BATs
      https://git.kernel.org/powerpc/c/035b19a15a98907916a42a6b1d025877c42f10ad
[2/8] powerpc/32s: Don't hash_preload() kernel text
      https://git.kernel.org/powerpc/c/79d1befe054ad4adb277fbd2d2756b1394eaf24e
[3/8] powerpc/32s: Fix an FTR_SECTION_ELSE
      https://git.kernel.org/powerpc/c/7b107a71e732c298d684ee1bafd82f1a2be58d5e
[4/8] powerpc/32s: Don't use SPRN_SPRG_PGDIR in hash_page
      https://git.kernel.org/powerpc/c/03d701c2d9b0091cf8e96cb49ab7d2a6a9f19937
[5/8] powerpc/603: Use SPRN_SDR1 to store the pgdir phys address
      https://git.kernel.org/powerpc/c/c4a22611bf6ced73d86bdfc0604d7db8982a24a4
[6/8] powerpc/32: Simplify EXCEPTION_PROLOG_1 macro
      https://git.kernel.org/powerpc/c/6285f9cff570bfd07b542840912c1d01bd5428e0
[7/8] powerpc/32s: Use SPRN_SPRG_SCRATCH2 in DSI prolog
      https://git.kernel.org/powerpc/c/de1cd0790697e67b728de43e8657bb52f528bfb9
[8/8] powerpc/32: Use SPRN_SPRG_SCRATCH2 in exception prologs
      https://git.kernel.org/powerpc/c/d2e006036082e2dc394c5ec86c5bb88cc27c0749

cheers

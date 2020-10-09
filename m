Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10B2881F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbgJIGEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbgJIGEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:04:06 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454BCC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 23:04:06 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4C6yFF4Xm8z9sVM; Fri,  9 Oct 2020 17:04:01 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601362098.git.christophe.leroy@csgroup.eu>
References: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601362098.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/8] powerpc: Remove SYNC on non 6xx
Message-Id: <160222339231.867048.15565542201153601563.b4-ty@ellerman.id.au>
Date:   Fri,  9 Oct 2020 17:04:01 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 06:48:31 +0000 (UTC), Christophe Leroy wrote:
> SYNC is usefull for Powerpc 601 only. On everything else,
> SYNC is empty.
> 
> Remove it from code that is not made to run on 6xx.

Applied to powerpc/next.

[1/8] powerpc: Remove SYNC on non 6xx
      https://git.kernel.org/powerpc/c/ca1d3443b4dd1e8f152bd6c881ddb3eb2996179a
[2/8] powerpc: Remove CONFIG_PPC601_SYNC_FIX
      https://git.kernel.org/powerpc/c/e42a64002a507bf61e57106ed5323b1854371563
[3/8] powerpc: Drop SYNC_601() ISYNC_601() and SYNC()
      https://git.kernel.org/powerpc/c/d2a5cd83ee984c0e9fc172d2df9591c264261a52
[4/8] powerpc: Remove PowerPC 601
      https://git.kernel.org/powerpc/c/f0ed73f3fa2cdca65973659689ec9e46d99a5f60
[5/8] powerpc: Remove support for PowerPC 601
      https://git.kernel.org/powerpc/c/8b14e1dff067195dca7a42321771437cb33a99e9
[6/8] powerpc: Tidy up a bit after removal of PowerPC 601.
      https://git.kernel.org/powerpc/c/2e38ea486615bddbc7a42d002aee93a3a9e7a36f
[7/8] powerpc: Remove __USE_RTC()
      https://git.kernel.org/powerpc/c/a4c5a355422920bcbfe3fd1f01aead2d3a2a820c
[8/8] powerpc: Remove get_tb_or_rtc()
      https://git.kernel.org/powerpc/c/6601ec1c2ba929430f5585ce7f9d9960b0e0a01d

cheers

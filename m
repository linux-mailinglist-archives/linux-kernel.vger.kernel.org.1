Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB82881F1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbgJIGEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbgJIGEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:04:02 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C424C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 23:04:02 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4C6yFB6zx9z9sTc; Fri,  9 Oct 2020 17:03:58 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
References: <94dc68d3d9ef9eb549796d4b938b6ba0305a049b.1601556145.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/6] powerpc/time: Rename mftbl() to mftb()
Message-Id: <160222339491.867048.15263486614184650478.b4-ty@ellerman.id.au>
Date:   Fri,  9 Oct 2020 17:03:58 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 12:42:39 +0000 (UTC), Christophe Leroy wrote:
> On PPC64, we have mftb().
> On PPC32, we have mftbl() and an #define mftb() mftbl().
> 
> mftb() and mftbl() are equivalent, their purpose is to read the
> content of SPRN_TRBL, as returned by 'mftb' simplified instruction.
> 
> binutils seems to define 'mftbl' instruction as an equivalent
> of 'mftb'.
> 
> [...]

Applied to powerpc/next.

[1/6] powerpc/time: Rename mftbl() to mftb()
      https://git.kernel.org/powerpc/c/15c102153e722cc6e0729764a7068c209a7469cd
[2/6] powerpc/time: Make mftb() common to PPC32 and PPC64
      https://git.kernel.org/powerpc/c/ff125fbcd45d1706861579dbe66e31f5b3f1e779
[3/6] powerpc/time: Avoid using get_tbl() and get_tbu() internally
      https://git.kernel.org/powerpc/c/942e89115b588b4b5df86930b5302a5c07b820ba
[4/6] powerpc/time: Remove get_tbu()
      https://git.kernel.org/powerpc/c/e8d5bf30eafc37e31ce68bc7ccf1db970fe3cd04
[5/6] powerpc/time: Make get_tbl() common to PPC32 and PPC64
      https://git.kernel.org/powerpc/c/1156a6285cd38e5a6987ddee3758e7954c56cb3d
[6/6] powerpc/time: Make get_tb() common to PPC32 and PPC64
      https://git.kernel.org/powerpc/c/9686e431c683ee7b8aca0f3985c244aee3d9f30d

cheers

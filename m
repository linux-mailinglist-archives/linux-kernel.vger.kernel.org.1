Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13F26DA2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgIQL3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgIQL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:41 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2610AC061797
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:22 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSP0kmbz9sTq; Thu, 17 Sep 2020 21:27:16 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <f6ea2483c2c389567b007945948f704d18cfaeea.1598862623.git.christophe.leroy@csgroup.eu>
References: <f6ea2483c2c389567b007945948f704d18cfaeea.1598862623.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/8xx: Refactor calculation of number of entries per PTE in page tables
Message-Id: <160034201341.3339803.11663256745878554872.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:16 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 08:30:43 +0000 (UTC), Christophe Leroy wrote:
> On 8xx, the number of entries occupied by a PTE in the page tables
> depends on the size of the page. At the time being, this calculation
> is done in two places: in pte_update() and in set_huge_pte_at()
> 
> Refactor this calculation into a helper called
> number_of_cells_per_pte(). For the time being, the val param is
> unused. It will be used by following patch.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/8xx: Refactor calculation of number of entries per PTE in page tables
      https://git.kernel.org/powerpc/c/175a99991511fed16108dcb823f0af8e72325a1f
[2/2] powerpc/8xx: Support 16k hugepages with 4k pages
      https://git.kernel.org/powerpc/c/e47168f3d1b14af5281cf50c59561d59d28201f9

cheers

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E71F335C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 07:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgFIF2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 01:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgFIF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:37 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B19C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:28:37 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzDf6lyCz9sTH; Tue,  9 Jun 2020 15:28:34 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Qian Cai <cai@lca.pw>
Cc:     linuxppc-dev@lists.ozlabs.org, rashmicy@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200306044852.3236-1-cai@lca.pw>
References: <20200306044852.3236-1-cai@lca.pw>
Subject: Re: [PATCH v3] powerpc/64s/pgtable: fix an undefined behaviour
Message-Id: <159168031307.1381411.14671547649283777399.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 23:48:52 -0500, Qian Cai wrote:
> Booting a power9 server with hash MMU could trigger an undefined
> behaviour because pud_offset(p4d, 0) will do,
> 
> 0 >> (PAGE_SHIFT:16 + PTE_INDEX_SIZE:8 + H_PMD_INDEX_SIZE:10)
> 
> Fix it by converting pud_index() and friends to static inline
> functions.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64s/pgtable: fix an undefined behaviour
      https://git.kernel.org/powerpc/c/c2e929b18cea6cbf71364f22d742d9aad7f4677a

cheers

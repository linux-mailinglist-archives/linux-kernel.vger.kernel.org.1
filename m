Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B32DAB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgLOKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:50:58 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbgLOKtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:49:39 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFP56srbz9sTc; Tue, 15 Dec 2020 21:48:57 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <6470ab99e58c84a5445af43ce4d1d772b0dc3e93.1606247495.git.christophe.leroy@csgroup.eu>
References: <6470ab99e58c84a5445af43ce4d1d772b0dc3e93.1606247495.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/3] powerpc/32s: Remove unused counters incremented by create_hpte()
Message-Id: <160802921064.504444.15188323739151416876.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:48:57 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 19:51:55 +0000 (UTC), Christophe Leroy wrote:
> primary_pteg_full and htab_hash_searches are not used.
> 
> Remove them.

Applied to powerpc/next.

[1/3] powerpc/32s: Remove unused counters incremented by create_hpte()
      https://git.kernel.org/powerpc/c/c5ccb4e78968fbe64f938a5a012fc8ec25cafabf
[2/3] powerpc/32s: In add_hash_page(), calculate VSID later
      https://git.kernel.org/powerpc/c/fec6166b44ded68e68144144a02e498580118f1a
[3/3] powerpc/32s: Cleanup around PTE_FLAGS_OFFSET in hash_low.S
      https://git.kernel.org/powerpc/c/da481c4fe0e485cdab5cf4d2761be8b8fb38d3d1

cheers

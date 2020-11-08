Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC662AAA8C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 11:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgKHK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 05:29:40 -0500
Received: from ozlabs.org ([203.11.71.1]:56487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgKHK3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 05:29:39 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CTVjs42FZz9sTK; Sun,  8 Nov 2020 21:29:37 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b02ca2ed2d3676a096219b48c0f69ec982a75bcf.1602342801.git.christophe.leroy@csgroup.eu>
References: <b02ca2ed2d3676a096219b48c0f69ec982a75bcf.1602342801.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/40x: Always fault when _PAGE_ACCESSED is not set
Message-Id: <160483134342.1400561.2759999901303730148.b4-ty@ellerman.id.au>
Date:   Sun,  8 Nov 2020 21:29:37 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Oct 2020 15:14:29 +0000 (UTC), Christophe Leroy wrote:
> The kernel expects pte_young() to work regardless of CONFIG_SWAP.
> 
> Make sure a minor fault is taken to set _PAGE_ACCESSED when it
> is not already set, regardless of the selection of CONFIG_SWAP.

Applied to powerpc/fixes.

[1/1] powerpc/40x: Always fault when _PAGE_ACCESSED is not set
      https://git.kernel.org/powerpc/c/0540b0d2ce9073fd2a736d636218faa61c99e572

cheers

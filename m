Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A8222301
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgGPMz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:55:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48225 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbgGPMzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:55:53 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPf4xzsz9sTw; Thu, 16 Jul 2020 22:55:49 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     erhard_f@mailbox.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <3667deb0911affbf999b99f87c31c77d5e870cd2.1593690707.git.christophe.leroy@csgroup.eu>
References: <3667deb0911affbf999b99f87c31c77d5e870cd2.1593690707.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] Revert "powerpc/kasan: Fix shadow pages allocation failure"
Message-Id: <159490400742.3805857.5182439247334544863.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:49 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 11:52:02 +0000 (UTC), Christophe Leroy wrote:
> This reverts commit d2a91cef9bbdeb87b7449fdab1a6be6000930210.
> 
> This commit moved too much work in kasan_init(). The allocation
> of shadow pages has to be moved for the reason explained in that
> patch, but the allocation of page tables still need to be done
> before switching to the final hash table.
> 
> [...]

Applied to powerpc/next.

[1/2] Revert "powerpc/kasan: Fix shadow pages allocation failure"
      https://git.kernel.org/powerpc/c/b506923ee44ae87fc9f4de16b53feb313623e146
[2/2] powerpc/kasan: Fix shadow pages allocation failure
      https://git.kernel.org/powerpc/c/41ea93cf7ba4e0f0cc46ebfdda8b6ff27c67bc91

cheers

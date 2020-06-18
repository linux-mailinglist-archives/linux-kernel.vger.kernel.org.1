Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366371FF1FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgFRMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 08:37:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbgFRMhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:37:20 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49nhKB0y8Qz9sTL; Thu, 18 Jun 2020 22:37:16 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org
In-Reply-To: <20200615092229.23142-1-rppt@kernel.org>
References: <20200615092229.23142-1-rppt@kernel.org>
Subject: Re: [PATCH] powerpc/8xx: use pmd_off() to access a PMD entry in pte_update()
Message-Id: <159248379681.3471720.4172093587973243088.b4-ty@ellerman.id.au>
Date:   Thu, 18 Jun 2020 22:37:16 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 12:22:29 +0300, Mike Rapoport wrote:
> The pte_update() implementation for PPC_8xx unfolds page table from the PGD
> level to access a PMD entry. Since 8xx has only 2-level page table this can
> be simplified with pmd_off() shortcut.
> 
> Replace explicit unfolding with pmd_off() and drop defines of pgd_index()
> and pgd_offset() that are no longer needed.

Applied to powerpc/fixes.

[1/1] powerpc/8xx: use pmd_off() to access a PMD entry in pte_update()
      https://git.kernel.org/powerpc/c/687993ccf3b05070598b89fad97410b26d7bc9d2

cheers

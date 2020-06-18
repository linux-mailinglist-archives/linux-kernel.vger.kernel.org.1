Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DCA1FF1FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgFRMhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 08:37:16 -0400
Received: from ozlabs.org ([203.11.71.1]:59723 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbgFRMhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:37:15 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49nhK50SZcz9sTD; Thu, 18 Jun 2020 22:37:12 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <cover.1592225557.git.christophe.leroy@csgroup.eu>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 0/3] Fix build failure with v5.8-rc1
Message-Id: <159248379779.3471720.9152671306932635297.b4-ty@ellerman.id.au>
Date:   Thu, 18 Jun 2020 22:37:12 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 12:57:55 +0000 (UTC), Christophe Leroy wrote:
> Commit 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for
> {READ,WRITE}_ONCE() memory accesses") leads to following build
> failure on powerpc 8xx.
> 
> To fix it, this small series introduces a new helper named ptep_get()
> to replace the direct access with READ_ONCE(). This new helper
> can be overriden by architectures.
> 
> [...]

Applied to powerpc/fixes.

[1/3] mm/gup: Use huge_ptep_get() in gup_hugepte()
      https://git.kernel.org/powerpc/c/01a80ec6495f9e43f61b3231f3b283ca050a800e
[2/3] mm: Allow arches to provide ptep_get()
      https://git.kernel.org/powerpc/c/f7583fd6bdcc4d0b43f68fb81ebfae9669ee9338
[3/3] powerpc/8xx: Provide ptep_get() with 16k pages
      https://git.kernel.org/powerpc/c/b55129f97aeefd265314e12d98935330e011a14a

cheers

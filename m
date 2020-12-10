Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC082D593C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbgLJLak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:30:40 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:36945 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389430AbgLJLa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:27 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXQ0fbsz9sWp; Thu, 10 Dec 2020 22:29:41 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <34ebc3ba2c768d97f363bd5f2deea2356e9ae127.1605589460.git.christophe.leroy@csgroup.eu>
References: <34ebc3ba2c768d97f363bd5f2deea2356e9ae127.1605589460.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc: Retire e200 core (mpc555x processor)
Message-Id: <160756607466.1313423.7615581061447652822.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:41 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 05:07:58 +0000 (UTC), Christophe Leroy wrote:
> There is no defconfig selecting CONFIG_E200, and no platform.
> 
> e200 is an earlier version of booke, a predecessor of e500,
> with some particularities like an unified cache instead of both an
> instruction cache and a data cache.
> 
> Remove it.

Applied to powerpc/next.

[1/2] powerpc: Retire e200 core (mpc555x processor)
      https://git.kernel.org/powerpc/c/39c8bf2b3cc166a2a75111e4941cc5f7efbddc35
[2/2] powerpc: Remove ucache_bsize
      https://git.kernel.org/powerpc/c/8817aabb1bdd5811130f94ff6442bb19c9158a3a

cheers

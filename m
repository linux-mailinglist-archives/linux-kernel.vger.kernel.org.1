Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A72D2D594A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389560AbgLJLcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:32:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:55513 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbgLJLbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:31:04 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBYB2C9zz9sfR; Thu, 10 Dec 2020 22:30:21 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20201119160154.GA5183@redhat.com>
References: <20201119160154.GA5183@redhat.com>
Subject: Re: [PATCH v3 0/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in gpr_get() too
Message-Id: <160756604623.1313423.4426620918837892938.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:30:21 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 17:01:54 +0100, Oleg Nesterov wrote:
> Can we finally fix this problem? ;)
> 
> My previous attempt was ignored, see
> 
> 	https://lore.kernel.org/lkml/20190917121256.GA8659@redhat.com/
> 
> Now that gpr_get() was changed to use membuf API we can make a simpler fix.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/ptrace: Simplify gpr_get()/tm_cgpr_get()
      https://git.kernel.org/powerpc/c/640586f8af356096e084d69a9909d217852bde48
[2/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in gpr_get() too
      https://git.kernel.org/powerpc/c/324a69467f12652b21b17f9644faa967d3d8bbdf

cheers

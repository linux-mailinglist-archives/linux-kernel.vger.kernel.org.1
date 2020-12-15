Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788FC2DAB66
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgLOKth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLOKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:49:37 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E871BC06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:48:56 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFP306HYz9sSn; Tue, 15 Dec 2020 21:48:54 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <8a4ffe4798e9ea32aaaccdf85e411bb1beed3500.1605542955.git.christophe.leroy@csgroup.eu>
References: <8a4ffe4798e9ea32aaaccdf85e411bb1beed3500.1605542955.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Handle PROTFAULT in hash_page() also for CONFIG_PPC_KUAP
Message-Id: <160802920749.504444.12908339583780328287.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:48:54 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 16:09:31 +0000 (UTC), Christophe Leroy wrote:
> On hash 32 bits, handling minor protection faults like unsetting
> dirty flag is heavy if done from the normal page_fault processing,
> because it implies hash table software lookup for flushing the entry
> and then a DSI is taken anyway to add the entry back.
> 
> When KUAP was implemented, as explained in commit a68c31fc01ef
> ("powerpc/32s: Implement Kernel Userspace Access Protection"),
> protection faults has been diverted from hash_page() because
> hash_page() was not able to identify a KUAP fault.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Handle PROTFAULT in hash_page() also for CONFIG_PPC_KUAP
      https://git.kernel.org/powerpc/c/1b03e71ff6f2bd10b45a0128ce76e0e42014a44c

cheers

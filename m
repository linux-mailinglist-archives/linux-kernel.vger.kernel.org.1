Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C883C2631EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgIIQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbgIIQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:32 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A000C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:40 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVr4tTQz9sVT; Wed,  9 Sep 2020 23:27:32 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <2b69ac8e1cddff6f808fc7415907179eab4aae9e.1596693679.git.christophe.leroy@csgroup.eu>
References: <2b69ac8e1cddff6f808fc7415907179eab4aae9e.1596693679.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix assembler warning about r0
Message-Id: <159965716573.808686.4713414935633916441.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:32 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 06:01:42 +0000 (UTC), Christophe Leroy wrote:
> The assembler says:
>   arch/powerpc/kernel/head_32.S:1095: Warning: invalid register expression
> 
> It's objecting to the use of r0 as the RA argument. That's because
> when RA = 0 the literal value 0 is used, rather than the content of
> r0, making the use of r0 in the source potentially confusing.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Fix assembler warning about r0
      https://git.kernel.org/powerpc/c/b51ba4fe2e134b631f9c8f45423707aab71449b5

cheers

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D632D5956
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLJLgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbgLJLab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:31 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F85C061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:29:50 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXX4f4xz9sX3; Thu, 10 Dec 2020 22:29:48 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <e26ddc1d6f6aca739dd8d2b7c67351ead559b084.1602489664.git.christophe.leroy@csgroup.eu>
References: <e26ddc1d6f6aca739dd8d2b7c67351ead559b084.1602489664.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Remove useless #ifndef CPU_FTR_COHERENT_ICACHE in mem.c
Message-Id: <160756607046.1313423.10486808695253599894.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:48 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 08:02:30 +0000 (UTC), Christophe Leroy wrote:
> Since commit 10b35d9978ac ("[PATCH] powerpc: merged asm/cputable.h"),
> CPU_FTR_COHERENT_ICACHE has always been defined.
> 
> Remove the #ifndef CPU_FTR_COHERENT_ICACHE block.

Applied to powerpc/next.

[1/1] powerpc/mm: Remove useless #ifndef CPU_FTR_COHERENT_ICACHE in mem.c
      https://git.kernel.org/powerpc/c/1a1be322178ca8097abeee244262ce0da5b519a9

cheers

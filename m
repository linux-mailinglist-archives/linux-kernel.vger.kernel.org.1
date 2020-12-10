Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB8C2D5950
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbgLJLel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389465AbgLJLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:40 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458BFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:30:00 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXk02sKz9sXP; Thu, 10 Dec 2020 22:29:54 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <822833ce3dc10634339818f7d1ab616edf63b0c6.1603041883.git.christophe.leroy@csgroup.eu>
References: <822833ce3dc10634339818f7d1ab616edf63b0c6.1603041883.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/44x: Don't support 440 when CONFIG_PPC_47x is set
Message-Id: <160756607162.1313423.10915542444729443523.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:54 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Oct 2020 17:25:17 +0000 (UTC), Christophe Leroy wrote:
> As stated in platform/44x/Kconfig, CONFIG_PPC_47x is not
> compatible with 440 and 460 variants.
> 
> This is confirmed in asm/cache.h as L1_CACHE_SHIFT is different
> for 47x, meaning a kernel built for 47x will not run correctly
> on a 440.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/44x: Don't support 440 when CONFIG_PPC_47x is set
      https://git.kernel.org/powerpc/c/8b8319b181fd9d6821703fef1228b4dcde613a16
[2/2] powerpc/44x: Don't support 47x code and non 47x code at the same time
      https://git.kernel.org/powerpc/c/1f69aa0b89240653fdf708aada6a3d968447cce7

cheers

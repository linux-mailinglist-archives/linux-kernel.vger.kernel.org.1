Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0D26DA2B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgIQL32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgIQL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:41 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D56BC061351
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:24 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSS4NnCz9sV6; Thu, 17 Sep 2020 21:27:20 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <0eb61cf0dc66d781d47deb2228498cd61d03a754.1597643221.git.christophe.leroy@csgroup.eu>
References: <0eb61cf0dc66d781d47deb2228498cd61d03a754.1597643221.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/4] powerpc/process: Remove useless #ifdef CONFIG_VSX
Message-Id: <160034201621.3339803.17351420143711068195.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:20 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 05:47:55 +0000 (UTC), Christophe Leroy wrote:
> cpu_has_feature(CPU_FTR_VSX) returns false when CONFIG_VSX is
> not set.
> 
> There is no need to enclose the test in an #ifdef CONFIG_VSX.
> Remove it.

Applied to powerpc/next.

[1/4] powerpc/process: Remove useless #ifdef CONFIG_VSX
      https://git.kernel.org/powerpc/c/80739c2bd29133715d6828e333649a55095f4747
[2/4] powerpc/process: Remove useless #ifdef CONFIG_ALTIVEC
      https://git.kernel.org/powerpc/c/e3667ee427e224f9951eb3940a97477285548134
[3/4] powerpc/process: Remove useless #ifdef CONFIG_SPE
      https://git.kernel.org/powerpc/c/532ed1900d37a47c821718a0d8d28eb05b2c4d28
[4/4] powerpc/process: Remove useless #ifdef CONFIG_PPC_FPU
      https://git.kernel.org/powerpc/c/c83c192a6fbb1d4db4144c40296ed059f5eca384

cheers

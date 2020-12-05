Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1B2CF983
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 06:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgLEFTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 00:19:38 -0500
Received: from baldur.buserror.net ([165.227.176.147]:33700 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLEFTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 00:19:37 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <oss@buserror.net>)
        id 1klPwU-0005xK-RW; Fri, 04 Dec 2020 23:17:11 -0600
Message-ID: <d99b6d7dee253d7e2d85d863d96b8702bb1aa389.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Dec 2020 23:17:09 -0600
In-Reply-To: <34ebc3ba2c768d97f363bd5f2deea2356e9ae127.1605589460.git.christophe.leroy@csgroup.eu>
References: <34ebc3ba2c768d97f363bd5f2deea2356e9ae127.1605589460.git.christophe.leroy@csgroup.eu>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: christophe.leroy@csgroup.eu, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on baldur.localdomain
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
Subject: Re: [PATCH 1/2] powerpc: Retire e200 core (mpc555x processor)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-17 at 05:07 +0000, Christophe Leroy wrote:
> There is no defconfig selecting CONFIG_E200, and no platform.
> 
> e200 is an earlier version of booke, a predecessor of e500,
> with some particularities like an unified cache instead of both an
> instruction cache and a data cache.
> 
> Remove it.	
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/Makefile                     |  1 -
>  arch/powerpc/include/asm/cputable.h       | 11 -----
>  arch/powerpc/include/asm/mmu.h            |  2 +-
>  arch/powerpc/include/asm/reg.h            |  5 --
>  arch/powerpc/include/asm/reg_booke.h      | 12 -----
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S |  9 ----
>  arch/powerpc/kernel/cputable.c            | 46 ------------------
>  arch/powerpc/kernel/head_booke.h          |  3 +-
>  arch/powerpc/kernel/head_fsl_booke.S      | 57 +----------------------
>  arch/powerpc/kernel/setup_32.c            |  2 -
>  arch/powerpc/kernel/traps.c               | 25 ----------
>  arch/powerpc/mm/nohash/fsl_booke.c        | 12 ++---
>  arch/powerpc/platforms/Kconfig.cputype    | 13 ++----
>  13 files changed, 11 insertions(+), 187 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

-Scott



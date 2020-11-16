Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E62B530C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbgKPUoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:17 -0500
Received: from baldur.buserror.net ([165.227.176.147]:47060 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbgKPUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:44:14 -0500
X-Greylist: delayed 1010 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 15:44:13 EST
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <oss@buserror.net>)
        id 1kel5G-0005re-V4; Mon, 16 Nov 2020 14:26:44 -0600
Message-ID: <8b23cec8b7b490ec8ef578cbd2fe4316288d4e13.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     christophe.leroy@csgroup.eu, segher@kernel.crashing.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        natechancellor@gmail.com
Date:   Mon, 16 Nov 2020 14:26:40 -0600
In-Reply-To: <20201116120913.165317-1-mpe@ellerman.id.au>
References: <20201116120913.165317-1-mpe@ellerman.id.au>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org, christophe.leroy@csgroup.eu, segher@kernel.crashing.org, linux-kernel@vger.kernel.org, ndesaulniers@google.com, natechancellor@gmail.com
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on baldur.localdomain
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
Subject: Re: [PATCH] powerpc: Drop -me200 addition to build flags
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-16 at 23:09 +1100, Michael Ellerman wrote:
> Currently a build with CONFIG_E200=y will fail with:
> 
>   Error: invalid switch -me200
>   Error: unrecognized option -me200
> 
> Upstream binutils has never supported an -me200 option. Presumably it
> was supported at some point by either a fork or Freescale internal
> binutils.
> 
> We can't support code that we can't even build test, so drop the
> addition of -me200 to the build flags, so we can at least build with
> CONFIG_E200=y.
> 
> Reported-by: Németh Márton <nm127@freemail.hu>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> 
> More discussion: 
> https://lore.kernel.org/lkml/202011131146.g8dPLQDD-lkp@intel.com
> ---
>  arch/powerpc/Makefile | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Scott Wood <oss@buserror.net>

I'd go further and remove E200 code entirely, unless someone with the hardware
can claim that it actually works.  There doesn't appear to be any actual
platform support for an e200-based system.  It seems to be a long-abandoned
work in progress.

-Scott



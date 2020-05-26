Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E331AABE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414705AbgDOP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 11:26:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36328 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1414683AbgDOP0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:26:15 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jOjuy-0006EH-RF; Thu, 16 Apr 2020 01:25:37 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2020 01:25:36 +1000
Date:   Tue, 14 Apr 2020 23:57:31 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] lib/mpi: Fix building for powerpc with clang
Message-ID: <20200414135731.GA8766@gondor.apana.org.au>
References: <20200413195041.24064-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413195041.24064-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 12:50:42PM -0700, Nathan Chancellor wrote:
> 0day reports over and over on an powerpc randconfig with clang:
> 
> lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a
> inline asm context requiring an l-value: remove the cast or build with
> -fheinous-gnu-extensions
> 
> Remove the superfluous casts, which have been done previously for x86
> and arm32 in commit dea632cadd12 ("lib/mpi: fix build with clang") and
> commit 7b7c1df2883d ("lib/mpi/longlong.h: fix building with 32-bit
> x86").
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/991
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

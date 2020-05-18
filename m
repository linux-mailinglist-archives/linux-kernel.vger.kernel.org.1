Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A801D7540
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 12:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgERKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 06:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgERKc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:32:58 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6956207ED;
        Mon, 18 May 2020 10:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589797977;
        bh=FoTk8zGbyQhLWnQF+6rWBcKNCczuvfeAk/nbxrmO/Ag=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rScxuk1uhjeA7R0gJmBaGzaZdn7rhVquPJ/JiSKJMjHCd5r110YAA7L/YaRRR7ikB
         MXZfmn0V0xzCp1hRp7QzeFoobRXgnV3FsmZw1hTGWnlFw6NUBpU6DJ/Lp7zsG8otb0
         ld2XsF3bHH1bD0pLERZGzeN/FYLSzqqoSN6WWHKc=
Date:   Mon, 18 May 2020 12:32:53 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
cc:     WANG Wenhu <wenhu.wang@vivo.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wenhu.pku@gmail.com
Subject: Re: [PATCH] powerpc/sysdev: fix compile errors
In-Reply-To: <nycvar.YFH.7.76.2005181228480.25812@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2005181232140.25812@cbobk.fhfr.pm>
References: <20200302053801.26027-1-wenhu.wang@vivo.com> <62251ec1-dd42-6522-dcb2-613838cd5504@c-s.fr> <nycvar.YFH.7.76.2005181228480.25812@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020, Jiri Kosina wrote:

> > > Include linux/io.h into fsl_85xx_cache_sram.c to fix the
> > > implicit-declaration compile errors when building Cache-Sram.
> > > 
> > > arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function
> > > ‘instantiate_cache_sram’:
> > > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration
> > > of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’?
> > > [-Werror=implicit-function-declaration]
> > >    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
> > >                            ^~~~~~~~~~~~~~~~
> > >                            bitmap_complement
> > > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes
> > > pointer from integer without a cast [-Werror=int-conversion]
> > >    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
> > >                          ^
> > > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration
> > > of function ‘iounmap’; did you mean ‘roundup’?
> > > [-Werror=implicit-function-declaration]
> > >    iounmap(cache_sram->base_virt);
> > >    ^~~~~~~
> > >    roundup
> > > cc1: all warnings being treated as errors
> > > 
> > > Fixed: commit 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
> > > Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
> > 
> > Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> As this doesn't seem to have been picked up for linux-next yet, I am 
> picking it up now.

Only now I've noticed that this is actually a dead code o_O as this file 
can't be built by any combination of config options. So I am dropping the 
patch again, but why do we keep it in the tree in the first place?

-- 
Jiri Kosina
SUSE Labs


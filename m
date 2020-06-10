Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17511F524E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 12:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFJK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 06:29:53 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60254 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgFJK31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:29:27 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jixyV-0008Az-TN; Wed, 10 Jun 2020 20:28:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Jun 2020 20:28:51 +1000
Date:   Wed, 10 Jun 2020 20:28:51 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/microcode: Do not select FW_LOADER
Message-ID: <20200610102851.GA22584@gondor.apana.org.au>
References: <20200610042911.GA20058@gondor.apana.org.au>
 <20200610081609.GA14118@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610081609.GA14118@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:16:09AM +0200, Borislav Petkov wrote:
> On Wed, Jun 10, 2020 at 02:29:11PM +1000, Herbert Xu wrote:
> > The x86 microcode support works just fine without FW_LOADER.  In
> > fact these days most people load them early in boot so FW_LOADER
> > never gets into the picture anyway.
> 
> What's the use case here?

Because MICROCODE is the only thing on my system that pulls it
into the kernel.

> Also, I'm working on removing that homegrown get_builtin_firmware() and
> use the one in the fw loader:
> 
> https://lkml.kernel.org/r/20200408094526.GC24663@zn.tnic

That shouldn't be a problem.  That function can simply move under
another (hidden) Kconfig option that gets selected by both MICROCODE
and FW_LOADER.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

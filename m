Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD47258577
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 03:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIAB4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 21:56:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38262 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIAB4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:56:42 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kCvXC-0000rP-Eo; Tue, 01 Sep 2020 11:56:31 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Sep 2020 11:56:30 +1000
Date:   Tue, 1 Sep 2020 11:56:30 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: fsl: Remove bogus packed attributes from qman.h
Message-ID: <20200901015630.GA9065@gondor.apana.org.au>
References: <20200730125259.GA8948@gondor.apana.org.au>
 <VE1PR04MB6687FB075B9A6A0923F576978F2E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VE1PR04MB6687FB075B9A6A0923F576978F2E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 01:50:38AM +0000, Leo Li wrote:
>
> Sorry for the late response.  I missed this email previously.
> 
> These structures are descriptors used by hardware, we cannot have _ANY_ padding from the compiler.  The compiled result might be the same with or without the __packed attribute for now, but I think keep it there probably is safer for dealing with unexpected alignment requirements from the compiler in the future.
> 
> Having conflicting alignment requirements warning might means something is wrong with the structure in certain scenario.  I just tried a ARM64 build but didn't see the warnings.  Could you share the warning you got and the build setup?  Thanks.

Just do a COMPILE_TEST build on x86-64:

In file included from ../drivers/crypto/caam/qi.c:12:
../include/soc/fsl/qman.h:259:1: warning: alignment 1 of ‘struct qm_dqrr_entry’ is less than 8 [-Wpacked-not-aligned]
 } __packed;
 ^
../include/soc/fsl/qman.h:292:2: warning: alignment 1 of ‘struct <anonymous>’ is less than 8 [-Wpacked-not-aligned]
  } __packed ern;
  ^

In any case, those packed markers are completely unnecessary because
those structs contain no holes.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

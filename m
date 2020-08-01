Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D391E23526E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgHAMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 08:49:02 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:44010 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbgHAMtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 08:49:02 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1qwS-0000f2-OA; Sat, 01 Aug 2020 22:48:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 01 Aug 2020 22:48:48 +1000
Date:   Sat, 1 Aug 2020 22:48:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ce - Fix writel byte-order on big-endian
Message-ID: <20200801124848.GA955@gondor.apana.org.au>
References: <202007281310.eciiVHmF%lkp@intel.com>
 <20200728060040.GA15882@gondor.apana.org.au>
 <20200801064724.GA11589@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801064724.GA11589@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 08:47:24AM +0200, Corentin Labbe wrote:
>
> This is fixed in my v4 serie and the current driver is unaffected, only hashes/rng could hit a problem and v4 bring them along with the fix.

OK.  Please resubmit it once you've rebased it against cryptodev.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

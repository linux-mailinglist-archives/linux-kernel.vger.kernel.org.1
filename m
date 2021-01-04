Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC42E8FF8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 06:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbhADFWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 00:22:12 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:48838 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADFWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 00:22:12 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kwIIp-0001FT-UY; Mon, 04 Jan 2021 16:21:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 04 Jan 2021 16:21:11 +1100
Date:   Mon, 4 Jan 2021 16:21:11 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Eric Biggers <ebiggers@google.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: ERROR: ".crypto_skcipher_setkey" undefined!
Message-ID: <20210104052111.GA18507@gondor.apana.org.au>
References: <202101030238.zELW4VPr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101030238.zELW4VPr-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 03, 2021 at 02:37:42AM +0800, kernel test robot wrote:
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ERROR: ".kmem_cache_alloc" [net/nfc/nfc.ko] undefined!
>    ERROR: ".__ubsan_handle_type_mismatch_v1" [net/nfc/nfc.ko] undefined!
>    ERROR: ".find_next_zero_bit" [net/nfc/nfc.ko] undefined!

...

> >> ERROR: ".crypto_skcipher_setkey" [net/ceph/libceph.ko] undefined!

This looks like a bug in lkp.  Could you please have a look?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

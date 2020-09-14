Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4809526836D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 06:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgINEVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 00:21:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40864 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgINEVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 00:21:08 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kHfz5-0004rO-Tk; Mon, 14 Sep 2020 14:20:57 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 14 Sep 2020 14:20:56 +1000
Date:   Mon, 14 Sep 2020 14:20:56 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Pascal van Leeuwen <pascalvanl@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH 0/3] crypto: inside-secure - Silence stack frame size warning
 in safexcel_aead_setkey
Message-ID: <20200914042055.GA19691@gondor.apana.org.au>
References: <202009131804.zlwtwgkr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009131804.zlwtwgkr%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 06:42:09PM +0800, kernel test robot wrote:
> Hi Pascal,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ef2e9a563b0cd7965e2a1263125dcbb1c86aa6cc
> commit: bb7679b840cc7cf23868e05c5ef7a044e7fafd97 crypto: inside-secure - Added support for authenc HMAC-SHA1/DES-CBC
> date:   12 months ago
> config: arm-randconfig-r005-20200913 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout bb7679b840cc7cf23868e05c5ef7a044e7fafd97
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/crypto/inside-secure/safexcel_cipher.c: In function 'safexcel_aead_setkey':
> >> drivers/crypto/inside-secure/safexcel_cipher.c:457:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      457 | }
>          | ^

This is primarily caused by the istate/ostate variables on the
stack.  This patch series removes the warning by reusing the
ahash setkey code for aead.  Note that we've simply moved the
istate/ostate into the ahash code and the overall stack usage
is actually unchanged.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

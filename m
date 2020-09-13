Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31717267F40
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 12:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgIMKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 06:43:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:12214 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgIMKnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 06:43:07 -0400
IronPort-SDR: PuR7cm6dBK/49aquWbPIW7KmLGJCBkODl6PuDIDLKNFAg/vVKDyOiEGIharnw0uO+dZym1sfXs
 L4mY+ku7Y2ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9742"; a="146713433"
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="gz'50?scan'50,208,50";a="146713433"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 03:43:03 -0700
IronPort-SDR: YTiw2KDaudUKU1e1nJvPKB4IPNe7N0bDPG0atDmItZKyiprA7erTuMd30+7eTGXaOiKy967En3
 mg8LvpFcaSFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="gz'50?scan'50,208,50";a="305771927"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2020 03:43:01 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kHPTI-0000p1-RO; Sun, 13 Sep 2020 10:43:00 +0000
Date:   Sun, 13 Sep 2020 18:42:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: drivers/crypto/inside-secure/safexcel_cipher.c:457:1: warning: the
 frame size of 1064 bytes is larger than 1024 bytes
Message-ID: <202009131804.zlwtwgkr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pascal,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ef2e9a563b0cd7965e2a1263125dcbb1c86aa6cc
commit: bb7679b840cc7cf23868e05c5ef7a044e7fafd97 crypto: inside-secure - Added support for authenc HMAC-SHA1/DES-CBC
date:   12 months ago
config: arm-randconfig-r005-20200913 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bb7679b840cc7cf23868e05c5ef7a044e7fafd97
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/crypto/inside-secure/safexcel_cipher.c: In function 'safexcel_aead_setkey':
>> drivers/crypto/inside-secure/safexcel_cipher.c:457:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     457 | }
         | ^

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb7679b840cc7cf23868e05c5ef7a044e7fafd97
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout bb7679b840cc7cf23868e05c5ef7a044e7fafd97
vim +457 drivers/crypto/inside-secure/safexcel_cipher.c

1b44c5a60c137e Antoine Tenart     2017-05-24  341  
77cdd4efe57134 Pascal van Leeuwen 2019-07-05  342  static int safexcel_aead_setkey(struct crypto_aead *ctfm, const u8 *key,
f6beaea304872b Antoine Tenart     2018-05-14  343  				unsigned int len)
f6beaea304872b Antoine Tenart     2018-05-14  344  {
f6beaea304872b Antoine Tenart     2018-05-14  345  	struct crypto_tfm *tfm = crypto_aead_tfm(ctfm);
f6beaea304872b Antoine Tenart     2018-05-14  346  	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
f6beaea304872b Antoine Tenart     2018-05-14  347  	struct safexcel_ahash_export_state istate, ostate;
f6beaea304872b Antoine Tenart     2018-05-14  348  	struct safexcel_crypto_priv *priv = ctx->priv;
f6beaea304872b Antoine Tenart     2018-05-14  349  	struct crypto_authenc_keys keys;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  350  	struct crypto_aes_ctx aes;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  351  	int err = -EINVAL;
f6beaea304872b Antoine Tenart     2018-05-14  352  
1769f704e55b11 Pascal van Leeuwen 2019-09-13  353  	if (unlikely(crypto_authenc_extractkeys(&keys, key, len)))
f6beaea304872b Antoine Tenart     2018-05-14  354  		goto badkey;
f6beaea304872b Antoine Tenart     2018-05-14  355  
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  356  	if (ctx->mode == CONTEXT_CONTROL_CRYPTO_MODE_CTR_LOAD) {
1769f704e55b11 Pascal van Leeuwen 2019-09-13  357  		/* Must have at least space for the nonce here */
1769f704e55b11 Pascal van Leeuwen 2019-09-13  358  		if (unlikely(keys.enckeylen < CTR_RFC3686_NONCE_SIZE))
f6beaea304872b Antoine Tenart     2018-05-14  359  			goto badkey;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  360  		/* last 4 bytes of key are the nonce! */
f26882a3475eb7 Pascal van Leeuwen 2019-07-30  361  		ctx->nonce = *(u32 *)(keys.enckey + keys.enckeylen -
f26882a3475eb7 Pascal van Leeuwen 2019-07-30  362  				      CTR_RFC3686_NONCE_SIZE);
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  363  		/* exclude the nonce here */
1769f704e55b11 Pascal van Leeuwen 2019-09-13  364  		keys.enckeylen -= CTR_RFC3686_NONCE_SIZE;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  365  	}
f6beaea304872b Antoine Tenart     2018-05-14  366  
f6beaea304872b Antoine Tenart     2018-05-14  367  	/* Encryption key */
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  368  	switch (ctx->alg) {
bb7679b840cc7c Pascal van Leeuwen 2019-09-13  369  	case SAFEXCEL_DES:
bb7679b840cc7c Pascal van Leeuwen 2019-09-13  370  		err = verify_aead_des_key(ctfm, keys.enckey, keys.enckeylen);
bb7679b840cc7c Pascal van Leeuwen 2019-09-13  371  		if (unlikely(err))
bb7679b840cc7c Pascal van Leeuwen 2019-09-13  372  			goto badkey_expflags;
bb7679b840cc7c Pascal van Leeuwen 2019-09-13  373  		break;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  374  	case SAFEXCEL_3DES:
21f5a15e0f26c7 Ard Biesheuvel     2019-08-15  375  		err = verify_aead_des3_key(ctfm, keys.enckey, keys.enckeylen);
77cdd4efe57134 Pascal van Leeuwen 2019-07-05  376  		if (unlikely(err))
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  377  			goto badkey_expflags;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  378  		break;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  379  	case SAFEXCEL_AES:
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  380  		err = aes_expandkey(&aes, keys.enckey, keys.enckeylen);
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  381  		if (unlikely(err))
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  382  			goto badkey;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  383  		break;
1769f704e55b11 Pascal van Leeuwen 2019-09-13  384  	case SAFEXCEL_SM4:
1769f704e55b11 Pascal van Leeuwen 2019-09-13  385  		if (unlikely(keys.enckeylen != SM4_KEY_SIZE))
1769f704e55b11 Pascal van Leeuwen 2019-09-13  386  			goto badkey;
1769f704e55b11 Pascal van Leeuwen 2019-09-13  387  		break;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  388  	default:
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  389  		dev_err(priv->dev, "aead: unsupported cipher algorithm\n");
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  390  		goto badkey;
77cdd4efe57134 Pascal van Leeuwen 2019-07-05  391  	}
77cdd4efe57134 Pascal van Leeuwen 2019-07-05  392  
53c83e915ce8b2 Antoine Tenart     2018-06-28  393  	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma &&
f6beaea304872b Antoine Tenart     2018-05-14  394  	    memcmp(ctx->key, keys.enckey, keys.enckeylen))
f6beaea304872b Antoine Tenart     2018-05-14  395  		ctx->base.needs_inv = true;
f6beaea304872b Antoine Tenart     2018-05-14  396  
f6beaea304872b Antoine Tenart     2018-05-14  397  	/* Auth key */
a7dea8c0ff9f25 Ofer Heifetz       2018-06-28  398  	switch (ctx->hash_alg) {
01ba061d0fd769 Antoine Tenart     2018-05-14  399  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA1:
01ba061d0fd769 Antoine Tenart     2018-05-14  400  		if (safexcel_hmac_setkey("safexcel-sha1", keys.authkey,
01ba061d0fd769 Antoine Tenart     2018-05-14  401  					 keys.authkeylen, &istate, &ostate))
01ba061d0fd769 Antoine Tenart     2018-05-14  402  			goto badkey;
01ba061d0fd769 Antoine Tenart     2018-05-14  403  		break;
678b2878ac396f Antoine Tenart     2018-05-14  404  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA224:
678b2878ac396f Antoine Tenart     2018-05-14  405  		if (safexcel_hmac_setkey("safexcel-sha224", keys.authkey,
678b2878ac396f Antoine Tenart     2018-05-14  406  					 keys.authkeylen, &istate, &ostate))
678b2878ac396f Antoine Tenart     2018-05-14  407  			goto badkey;
678b2878ac396f Antoine Tenart     2018-05-14  408  		break;
678b2878ac396f Antoine Tenart     2018-05-14  409  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA256:
f6beaea304872b Antoine Tenart     2018-05-14  410  		if (safexcel_hmac_setkey("safexcel-sha256", keys.authkey,
f6beaea304872b Antoine Tenart     2018-05-14  411  					 keys.authkeylen, &istate, &ostate))
f6beaea304872b Antoine Tenart     2018-05-14  412  			goto badkey;
678b2878ac396f Antoine Tenart     2018-05-14  413  		break;
ea23cb533ce419 Antoine Tenart     2018-05-29  414  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA384:
ea23cb533ce419 Antoine Tenart     2018-05-29  415  		if (safexcel_hmac_setkey("safexcel-sha384", keys.authkey,
ea23cb533ce419 Antoine Tenart     2018-05-29  416  					 keys.authkeylen, &istate, &ostate))
ea23cb533ce419 Antoine Tenart     2018-05-29  417  			goto badkey;
ea23cb533ce419 Antoine Tenart     2018-05-29  418  		break;
87eee125e7490c Antoine Tenart     2018-05-29  419  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA512:
87eee125e7490c Antoine Tenart     2018-05-29  420  		if (safexcel_hmac_setkey("safexcel-sha512", keys.authkey,
87eee125e7490c Antoine Tenart     2018-05-29  421  					 keys.authkeylen, &istate, &ostate))
87eee125e7490c Antoine Tenart     2018-05-29  422  			goto badkey;
87eee125e7490c Antoine Tenart     2018-05-29  423  		break;
1769f704e55b11 Pascal van Leeuwen 2019-09-13  424  	case CONTEXT_CONTROL_CRYPTO_ALG_SM3:
1769f704e55b11 Pascal van Leeuwen 2019-09-13  425  		if (safexcel_hmac_setkey("safexcel-sm3", keys.authkey,
1769f704e55b11 Pascal van Leeuwen 2019-09-13  426  					 keys.authkeylen, &istate, &ostate))
1769f704e55b11 Pascal van Leeuwen 2019-09-13  427  			goto badkey;
1769f704e55b11 Pascal van Leeuwen 2019-09-13  428  		break;
678b2878ac396f Antoine Tenart     2018-05-14  429  	default:
a60619211dd188 Pascal van Leeuwen 2019-09-18  430  		dev_err(priv->dev, "aead: unsupported hash algorithmn");
678b2878ac396f Antoine Tenart     2018-05-14  431  		goto badkey;
678b2878ac396f Antoine Tenart     2018-05-14  432  	}
f6beaea304872b Antoine Tenart     2018-05-14  433  
f6beaea304872b Antoine Tenart     2018-05-14  434  	crypto_aead_set_flags(ctfm, crypto_aead_get_flags(ctfm) &
f6beaea304872b Antoine Tenart     2018-05-14  435  				    CRYPTO_TFM_RES_MASK);
f6beaea304872b Antoine Tenart     2018-05-14  436  
53c83e915ce8b2 Antoine Tenart     2018-06-28  437  	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma &&
f6beaea304872b Antoine Tenart     2018-05-14  438  	    (memcmp(ctx->ipad, istate.state, ctx->state_sz) ||
f6beaea304872b Antoine Tenart     2018-05-14  439  	     memcmp(ctx->opad, ostate.state, ctx->state_sz)))
f6beaea304872b Antoine Tenart     2018-05-14  440  		ctx->base.needs_inv = true;
f6beaea304872b Antoine Tenart     2018-05-14  441  
f6beaea304872b Antoine Tenart     2018-05-14  442  	/* Now copy the keys into the context */
f6beaea304872b Antoine Tenart     2018-05-14  443  	memcpy(ctx->key, keys.enckey, keys.enckeylen);
f6beaea304872b Antoine Tenart     2018-05-14  444  	ctx->key_len = keys.enckeylen;
f6beaea304872b Antoine Tenart     2018-05-14  445  
f6beaea304872b Antoine Tenart     2018-05-14  446  	memcpy(ctx->ipad, &istate.state, ctx->state_sz);
f6beaea304872b Antoine Tenart     2018-05-14  447  	memcpy(ctx->opad, &ostate.state, ctx->state_sz);
f6beaea304872b Antoine Tenart     2018-05-14  448  
f6beaea304872b Antoine Tenart     2018-05-14  449  	memzero_explicit(&keys, sizeof(keys));
f6beaea304872b Antoine Tenart     2018-05-14  450  	return 0;
f6beaea304872b Antoine Tenart     2018-05-14  451  
f6beaea304872b Antoine Tenart     2018-05-14  452  badkey:
f6beaea304872b Antoine Tenart     2018-05-14  453  	crypto_aead_set_flags(ctfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  454  badkey_expflags:
f6beaea304872b Antoine Tenart     2018-05-14  455  	memzero_explicit(&keys, sizeof(keys));
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  456  	return err;
f6beaea304872b Antoine Tenart     2018-05-14 @457  }
f6beaea304872b Antoine Tenart     2018-05-14  458  

:::::: The code at line 457 was first introduced by commit
:::::: f6beaea304872bb1c76bf6c551386bf896cac8b9 crypto: inside-secure - authenc(hmac(sha256), cbc(aes)) support

:::::: TO: Antoine Tenart <antoine.tenart@bootlin.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k1lZvvs/B4yU6o8G
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k1lZvvs/B4yU6o8G--

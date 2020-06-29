Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A7120D663
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgF2TTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:19:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59760 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbgF2TT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:19:28 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jpokF-0003vM-Nn; Mon, 29 Jun 2020 18:02:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 29 Jun 2020 18:02:27 +1000
Date:   Mon, 29 Jun 2020 18:02:27 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Tomer Maimon <tmaimon77@gmail.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: drivers/char/hw_random/npcm-rng.c:166:34: warning: unused
 variable 'rng_dt_id'
Message-ID: <20200629080227.GA11211@gondor.apana.org.au>
References: <202006232136.vz36SNV9%lkp@intel.com>
 <20200626064225.GA6023@gondor.apana.org.au>
 <20200626065247.GA2956367@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626065247.GA2956367@ubuntu-n2-xlarge-x86>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:52:47PM -0700, Nathan Chancellor wrote:
>
> No deficiency in clang, it's a W=1 build, which explicitly enables
> -Wunused-const-variable per scripts/Kbuild.extrawarn. The 0day team
> decided to enable W=1 for all build tests, hence the comment in the
> reproduce notes. A thread with discussion:
> 
> https://lore.kernel.org/lkml/202005200123.gFjGzJEH%25lkp@intel.com/

Fair enough.  I'll fix this by adding __maybe_unused.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

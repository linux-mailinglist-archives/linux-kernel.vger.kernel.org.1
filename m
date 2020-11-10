Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0AB2AD032
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKJHCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:02:11 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51602 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgKJHCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:02:11 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kcNf9-0008WD-K5; Tue, 10 Nov 2020 18:01:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 Nov 2020 18:01:55 +1100
Date:   Tue, 10 Nov 2020 18:01:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, SrujanaChalla <schalla@marvell.com>,
        lkp@intel.com, Dan Carpenter <error27@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [kbuild] drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c:1300
 create_engine_group() error: we previously assumed 'mirrored_eng_grp' could
 be null (see line 1256)
Message-ID: <20201110070155.GA28969@gondor.apana.org.au>
References: <20201109122919.GN18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109122919.GN18329@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 03:29:19PM +0300, Dan Carpenter wrote:
>
> Possibly the "eng_grp->mirror.is_ena" means this is a false positive.
> Too hard to tell without more context.

Yes I think this is a false positive for this reason as is_ena is
set to true by setup_eng_grp_mirroring.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

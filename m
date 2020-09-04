Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF11625D287
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 09:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgIDHkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 03:40:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42610 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgIDHkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:40:22 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kE6KK-0000Lo-9Q; Fri, 04 Sep 2020 17:40:05 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Sep 2020 17:40:04 +1000
Date:   Fri, 4 Sep 2020 17:40:04 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "shenyang (M)" <shenyang39@huawei.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>
Subject: Re: [PATCH RESEND 04/10] crypto: hisilicon/zip - replace 'sprintf'
 with 'scnprintf'
Message-ID: <20200904074004.GA24815@gondor.apana.org.au>
References: <1598238709-58699-1-git-send-email-shenyang39@huawei.com>
 <1598238709-58699-5-git-send-email-shenyang39@huawei.com>
 <d1102aca2bdc4df4acc31d8b082cacce@AcuMS.aculab.com>
 <abc0c78e-3232-9081-c330-3d5b8db9e683@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc0c78e-3232-9081-c330-3d5b8db9e683@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 04:56:40PM +0800, shenyang (M) wrote:
>
> > > @@ -514,13 +514,16 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
> > >  	struct debugfs_regset32 *regset;
> > >  	struct dentry *tmp_d;
> > >  	char buf[HZIP_BUF_SIZE];
> > > -	int i;
> > > +	int i, ret;
> > > 
> > >  	for (i = 0; i < HZIP_CORE_NUM; i++) {
> > >  		if (i < HZIP_COMP_CORE_NUM)
> > > -			sprintf(buf, "comp_core%d", i);
> > > +			ret = scnprintf(buf, HZIP_BUF_SIZE, "comp_core%d", i);
> > >  		else
> > > -			sprintf(buf, "decomp_core%d", i - HZIP_COMP_CORE_NUM);
> > > +			ret = scnprintf(buf, HZIP_BUF_SIZE, "decomp_core%d",
> > > +					i - HZIP_COMP_CORE_NUM);
> > > +		if (!ret)
> > > +			return -ENOMEM;
> > 
> > and that is just so wrong - did you even try to test
> > the 'buffer too small' code path?
> 
> Do you means the check is unnecessary?

No he's saying that your patch does the wrong thing when the string
is truncated.

Also ENOMEM is a strange error for that case.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

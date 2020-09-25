Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54FB278260
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgIYIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:14:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53250 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgIYIOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:14:53 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLisQ-0007Aj-04; Fri, 25 Sep 2020 18:14:47 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Sep 2020 18:14:45 +1000
Date:   Fri, 25 Sep 2020 18:14:45 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        qat-linux <qat-linux@intel.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] crypto: qat - convert to use DEFINE_SEQ_ATTRIBUTE
 macro
Message-ID: <20200925081445.GA6496@gondor.apana.org.au>
References: <7a1e8142cb4944ee95cea13e7efad23d@irsmsx602.ger.corp.intel.com>
 <20200924050042.GA32206@silpixa00400314>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924050042.GA32206@silpixa00400314>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 06:00:42AM +0100, Giovanni Cabiddu wrote:
> On Wed, Sep 16, 2020 at 03:50:17AM +0100, Liu Shixin wrote:
> > Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.
> > 
> > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> 
> Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Hi Giovanni:

Your acks are not making it to patchwork, seemingly because your
emails have a bogus References header with an Intel message ID
instead of the original message ID of the email you're replying
to.

I've added your acks manually for this patch but please fix your
emails as I can't guarantee that I'll spot the problem every time.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

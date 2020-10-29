Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C55A29E706
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgJ2JOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:14:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58734 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2JOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:14:52 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kY1un-0000dj-Rz; Thu, 29 Oct 2020 18:00:07 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 Oct 2020 18:00:05 +1100
Date:   Thu, 29 Oct 2020 18:00:05 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v2 1/6] crypto: Use memzero_explicit() for clearing state
Message-ID: <20201029070005.GA20177@gondor.apana.org.au>
References: <20201020203957.3512851-1-nivedita@alum.mit.edu>
 <20201020203957.3512851-2-nivedita@alum.mit.edu>
 <20201022043633.GD857@sol.localdomain>
 <20201023153927.GA217686@rani.riverdale.lan>
 <20201023155604.GA3908702@gmail.com>
 <20201023204536.GB27708@gondor.apana.org.au>
 <20201023215329.GA180517@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023215329.GA180517@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 02:53:29PM -0700, Eric Biggers wrote:
>
> It's doubtful that anyone will do a global conversion from memset() to
> memzero_explicit(), as it's too hard to find all the places that should be
> converted.  They are in lots of different subsystems; the crypto subsystem will
> have the most, but not all.  We just need to fix as many as we can.  If you'd
> like to do something more comprehensive than this patch, that would be great,
> but I hope we don't wait forever for a global conversion that never happens.

I had thought that there were more instances of memset in crypto/
that needed converting, but a quick grep seems to indicate that most
are not sensitive.  So I'm OK with this patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

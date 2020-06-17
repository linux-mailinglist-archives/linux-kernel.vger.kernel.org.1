Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6B81FCEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgFQNqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 09:46:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30568 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgFQNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592401604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6wEz7eoHV1YYQkmzrvw20KoNhWZxNuUKHu5DTnNaxE=;
        b=aJWK9biv9aHWYSckj4GtRtFGbk1vTNzgXCaUzo3mTUSHezmuL/5fwyuLfmiwYUmRAQ8KH9
        HDC2qkTg82+uWQPB1f/LqUTcOrTbby8i3pVjSGOzQz2kA45EXZsikJBZdU2WC+lFqiolSf
        bTaGztSAwB+AOz07r9dZ9mkZ411T35M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-k2MPCgopPq67u6U_I-qvWg-1; Wed, 17 Jun 2020 09:46:42 -0400
X-MC-Unique: k2MPCgopPq67u6U_I-qvWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B07711100F62;
        Wed, 17 Jun 2020 13:46:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 482CC5D9D3;
        Wed, 17 Jun 2020 13:46:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05HDkaMH022324;
        Wed, 17 Jun 2020 09:46:36 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05HDkY4V022320;
        Wed, 17 Jun 2020 09:46:34 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 17 Jun 2020 09:46:34 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Eric Biggers <ebiggers@kernel.org>,
        George Cherian <gcherian@marvell.com>,
        Wei Xu <xuwei5@hisilicon.com>, Zaibo Xu <xuzaibo@huawei.com>
cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Mike Snitzer <msnitzer@redhat.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Milan Broz <mbroz@redhat.com>
Subject: Re: [dm-devel] [PATCH 4/4] crypto: fix the drivers that don't respect
 CRYPTO_TFM_REQ_MAY_SLEEP
In-Reply-To: <20200616182327.GE207319@gmail.com>
Message-ID: <alpine.LRH.2.02.2006170940510.18714@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2006091259250.30590@file01.intranet.prod.int.rdu2.redhat.com> <20200610010450.GA6449@gondor.apana.org.au> <alpine.LRH.2.02.2006100756270.27811@file01.intranet.prod.int.rdu2.redhat.com> <20200610121106.GA23137@gondor.apana.org.au>
 <alpine.LRH.2.02.2006161052540.28052@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2006161102250.28052@file01.intranet.prod.int.rdu2.redhat.com> <20200616175022.GD207319@gmail.com> <alpine.LRH.2.02.2006161416510.12390@file01.intranet.prod.int.rdu2.redhat.com>
 <20200616182327.GE207319@gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Jun 2020, Eric Biggers wrote:

> On Tue, Jun 16, 2020 at 02:18:17PM -0400, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 16 Jun 2020, Eric Biggers wrote:
> > 
> > > On Tue, Jun 16, 2020 at 11:02:50AM -0400, Mikulas Patocka wrote:
> > > > Fix the crypto drivers that don't respect CRYPTO_TFM_REQ_MAY_SLEEP. If
> > > > CRYPTO_TFM_REQ_MAY_SLEEP is not set, the driver must not do allocation
> > > > that sleeps.
> > > > 
> > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > 
> > > I think you need to split this up per driver with a proper explanation and a
> > > "Fixes:" tag for each driver.
> > > 
> > > Also, these bugs should have been detected by the crypto self-tests already,
> > > since they test having preemption disabled and CRYPTO_TFM_REQ_MAY_SLEEP cleared.
> > > Can you double check whether these are all valid fixes?  One thing to watch out
> > > 
> > > for is that CRYPTO_TFM_REQ_MAY_SLEEP only applies to the function call like
> > > crypto_skcipher_encrypt() itself.  If the implementation is asynchronous and the
> > > request gets processed in the background (i.e. if crypto_skcipher_encrypt()
> > > returns -EINPROGRESS), the background work doesn't have to honor
> > > CRYPTO_TFM_REQ_MAY_SLEEP.
> > > 
> > > - Eric
> > 
> > I can only compile-test this patch. I don't have the hardware.
> > 
> 
> I'm just asking for you to check the code extra carefully.  The fact that the
> self-tests should have been detecting this type of bug implies that these might
> not actually be valid fixes.

I've checked it more thoroughly and found out that 3 out of 5 drivers do
the GFP_KERNEL allocation from crypto-engine callback. So, it is
supposedly OK.

> However, we do know that not all crypto drivers are being actively tested with
> the latest self-tests and with kernel debugging options enabled.  So it's
> expected that some are indeed broken.
> 
> - Eric

The broken ones are drivers/crypto/cavium/cpt/ and 
drivers/crypto/hisilicon/sec/

I'm sending patches for them.

Mikulas


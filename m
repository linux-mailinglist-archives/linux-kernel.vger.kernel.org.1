Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9323720CA46
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 22:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgF1UAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 16:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgF1UAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 16:00:24 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7C85206C3;
        Sun, 28 Jun 2020 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593374424;
        bh=VVxMX2lDV09g2mF+EVY4UZ5ddjynnYgTOdUT9eAi10I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUMvF0tURaxVQa9M353t/xbidOoVXPl6CjgsU6D5iLImfp0x89UQmOYQzZ0Zgstl0
         H9URve8x7WBzNjbVCz1wqWMWKAkNbX2HzaQgJ60pni/5OabVf+Wb12gNf3EGAeBRnT
         YAAO6JSCqEW9HqrHYt/f4zZTRZxE5x+7yuwrPuPk=
Date:   Sun, 28 Jun 2020 13:00:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <msnitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-kernel@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, dm-devel@redhat.com,
        George Cherian <gcherian@marvell.com>,
        linux-crypto@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Milan Broz <mbroz@redhat.com>
Subject: Re: [dm-devel] [PATCH 1/3 v2] crypto: introduce the flag
 CRYPTO_ALG_ALLOCATES_MEMORY
Message-ID: <20200628200022.GE11197@sol.localdomain>
References: <alpine.LRH.2.02.2006161101080.28052@file01.intranet.prod.int.rdu2.redhat.com>
 <20200616173620.GA207319@gmail.com>
 <alpine.LRH.2.02.2006171107220.18714@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2006171108440.18714@file01.intranet.prod.int.rdu2.redhat.com>
 <20200626044534.GA2870@gondor.apana.org.au>
 <alpine.LRH.2.02.2006261109520.11899@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2006261215480.13882@file01.intranet.prod.int.rdu2.redhat.com>
 <20200626164617.GA211634@gmail.com>
 <20200626170039.GB211634@gmail.com>
 <alpine.LRH.2.02.2006281505530.347@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2006281505530.347@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 03:07:49PM -0400, Mikulas Patocka wrote:
> > 
> > cryptd_create_skcipher(), cryptd_create_hash(), cryptd_create_aead(), and
> > crypto_rfc4309_create() are also missing setting the mask.
> > 
> > pcrypt_create_aead() is missing both setting the mask and inheriting the flags.
> 
> I added CRYPTO_ALG_ALLOCATES_MEMORY there.

I don't see where the cryptd request processing functions allocate memory.

It seems that cryptd should just inherit the flag, like most other templates.

Likewise for pcrypt.

And also likewise for rfc4309.

Where are you seeing the memory allocations that would require
CRYPTO_ALG_ALLOCATES_MEMORY to always be enabled for these?

- Eric

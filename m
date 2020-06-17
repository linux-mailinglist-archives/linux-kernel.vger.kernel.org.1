Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52331FD052
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgFQPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 11:08:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38110 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbgFQPIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592406531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FEK6XNclhxuYzDS0FsacZ9NhZwGmRowURBIeQOb6/qc=;
        b=haxkbwqYFxsFn4RCiiZn6yi8k1WF0iu9xNW4Ea9I6gdQKecc7EPPmsSgMShv1ZyZK0qBDn
        dZX7euSnRpLgG6CsMsr3HaRj3z7vljC/pY8J6ahbjm5O2WJxIDr2oi8gVIavYTaCbx2N99
        ARXeLseVFhqFP4ksNvKdB4WaeABpr98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-cZ6_ZyNyPqqsXk0mSd_y2Q-1; Wed, 17 Jun 2020 11:08:47 -0400
X-MC-Unique: cZ6_ZyNyPqqsXk0mSd_y2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B70F8735C9;
        Wed, 17 Jun 2020 15:08:45 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B4FF6E9F3;
        Wed, 17 Jun 2020 15:08:41 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05HF8eKu028836;
        Wed, 17 Jun 2020 11:08:40 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05HF8dow028832;
        Wed, 17 Jun 2020 11:08:39 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 17 Jun 2020 11:08:39 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Eric Biggers <ebiggers@kernel.org>
cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Mike Snitzer <msnitzer@redhat.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Milan Broz <mbroz@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        George Cherian <gcherian@marvell.com>,
        Wei Xu <xuwei5@hisilicon.com>, Zaibo Xu <xuzaibo@Huawei.com>
Subject: Re: [dm-devel] [PATCH 1/4] crypto: introduce
 CRYPTO_ALG_ALLOCATES_MEMORY
In-Reply-To: <20200616173620.GA207319@gmail.com>
Message-ID: <alpine.LRH.2.02.2006171107220.18714@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2006091259250.30590@file01.intranet.prod.int.rdu2.redhat.com> <20200610010450.GA6449@gondor.apana.org.au> <alpine.LRH.2.02.2006100756270.27811@file01.intranet.prod.int.rdu2.redhat.com> <20200610121106.GA23137@gondor.apana.org.au>
 <alpine.LRH.2.02.2006161052540.28052@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2006161101080.28052@file01.intranet.prod.int.rdu2.redhat.com> <20200616173620.GA207319@gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending the patches with your comments resolved...

Mikulas



On Tue, 16 Jun 2020, Eric Biggers wrote:

> On Tue, Jun 16, 2020 at 11:01:31AM -0400, Mikulas Patocka wrote:
> > Introduce a new flag CRYPTO_ALG_ALLOCATES_MEMORY and modify dm-crypt, so
> > that it uses only drivers without this flag.
> > 
> > If the flag is set, then the crypto driver allocates memory in its request
> > routine. Such drivers are not suitable for disk encryption because
> > GFP_ATOMIC allocation can fail anytime (causing random I/O errors) and
> > GFP_KERNEL allocation can recurse into the block layer, causing a
> > deadlock.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > Index: linux-2.6/include/linux/crypto.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/crypto.h
> > +++ linux-2.6/include/linux/crypto.h
> > @@ -97,9 +97,15 @@
> >  #define CRYPTO_ALG_OPTIONAL_KEY		0x00004000
> >  
> >  /*
> > + * The driver is allocating emmory in its encrypt or decrypt callback,
> > + * so it should not be used to encrypt block devices.
> > + */
> 
> "is allocating emmory" => "may allocate memory"
> 
> "so it should not be used to encrypt block devices" =>
> "so it shouldn't be used in cases where memory allocation failures aren't
>  acceptable, such as during block device encryption".
> 
> Also, which types of algorithms does this flag apply to?  E.g. if it applies to
> hash algorithms too, it's not sufficient to say "encrypt or decrypt callback".
> 
> How about:
> 
>  /*
>   * The driver may allocate memory during request processing, so it shouldn't be
>   * used in cases where memory allocation failures aren't acceptable, such as
>   * during block device encryption.
>   */
> 
> > +#define CRYPTO_ALG_ALLOCATES_MEMORY	0x00008000
> > +
> > +/*
> >   * Don't trigger module loading
> >   */
> > -#define CRYPTO_NOLOAD			0x00008000
> > +#define CRYPTO_NOLOAD			0x00010000
> >  
> >  /*
> >   * Transform masks and values (for crt_flags).
> > Index: linux-2.6/drivers/md/dm-crypt.c
> > ===================================================================
> 
> This would better belong as two separate patches: one to introduce
> CRYPTO_ALG_ALLOCATES_MEMORY, and one to make dm-crypt use it.
> 
> > --- linux-2.6.orig/drivers/md/dm-crypt.c
> > +++ linux-2.6/drivers/md/dm-crypt.c
> > @@ -419,7 +419,7 @@ static int crypt_iv_lmk_ctr(struct crypt
> >  		return -EINVAL;
> >  	}
> >  
> > -	lmk->hash_tfm = crypto_alloc_shash("md5", 0, 0);
> > +	lmk->hash_tfm = crypto_alloc_shash("md5", 0, CRYPTO_ALG_ALLOCATES_MEMORY);
> >  	if (IS_ERR(lmk->hash_tfm)) {
> >  		ti->error = "Error initializing LMK hash";
> >  		return PTR_ERR(lmk->hash_tfm);
> > @@ -581,7 +581,7 @@ static int crypt_iv_tcw_ctr(struct crypt
> >  		return -EINVAL;
> >  	}
> >  
> > -	tcw->crc32_tfm = crypto_alloc_shash("crc32", 0, 0);
> > +	tcw->crc32_tfm = crypto_alloc_shash("crc32", 0, CRYPTO_ALG_ALLOCATES_MEMORY);
> >  	if (IS_ERR(tcw->crc32_tfm)) {
> >  		ti->error = "Error initializing CRC32 in TCW";
> >  		return PTR_ERR(tcw->crc32_tfm);
> > @@ -768,7 +768,7 @@ static int crypt_iv_elephant_ctr(struct
> >  	struct iv_elephant_private *elephant = &cc->iv_gen_private.elephant;
> >  	int r;
> >  
> > -	elephant->tfm = crypto_alloc_skcipher("ecb(aes)", 0, 0);
> > +	elephant->tfm = crypto_alloc_skcipher("ecb(aes)", 0, CRYPTO_ALG_ALLOCATES_MEMORY);
> >  	if (IS_ERR(elephant->tfm)) {
> >  		r = PTR_ERR(elephant->tfm);
> >  		elephant->tfm = NULL;
> > @@ -2088,7 +2088,7 @@ static int crypt_alloc_tfms_skcipher(str
> >  		return -ENOMEM;
> >  
> >  	for (i = 0; i < cc->tfms_count; i++) {
> > -		cc->cipher_tfm.tfms[i] = crypto_alloc_skcipher(ciphermode, 0, 0);
> > +		cc->cipher_tfm.tfms[i] = crypto_alloc_skcipher(ciphermode, 0, CRYPTO_ALG_ALLOCATES_MEMORY);
> 
> Despite the recent relaxation in rules, the preferred length of a line is still
> 80 columns.
> 
> - Eric
> 


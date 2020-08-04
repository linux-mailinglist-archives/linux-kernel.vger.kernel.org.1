Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E1423B3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 06:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgHDEW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 00:22:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54692 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbgHDEW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:22:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k2oSt-0007l7-Hc; Tue, 04 Aug 2020 14:22:16 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Aug 2020 14:22:15 +1000
Date:   Tue, 4 Aug 2020 14:22:15 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Liwei Song <liwei.song@windriver.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>, David <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp - zero the cmd data after use it
Message-ID: <20200804042215.GA10939@gondor.apana.org.au>
References: <20200803075858.3561-1-liwei.song@windriver.com>
 <20200803125242.GA7689@gondor.apana.org.au>
 <87ae939b-4983-4e96-cc3d-1aa1d1b3d3ae@windriver.com>
 <20200804040420.GA10850@gondor.apana.org.au>
 <1b6be879-8449-b519-046f-0312e57aa9a4@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b6be879-8449-b519-046f-0312e57aa9a4@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 12:20:21PM +0800, Liwei Song wrote:
>
> Yes, the other process should do this zero work, but the case I met is
> this address will appear in the slab_alloc_node() as freelist pointer of slub,
> and before slub do zero wrok, even kzalloc() doesn't work with this address.

That would be memory corruption which has nothing to do with your
patch.  If it is occurring then you should fix the place that is
corrupting the memory and not work around it like this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

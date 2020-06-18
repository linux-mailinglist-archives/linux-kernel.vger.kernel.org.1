Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8791FED03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 09:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgFRH5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 03:57:09 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60448 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgFRH5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:57:09 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jlpPq-00023Z-G8; Thu, 18 Jun 2020 17:56:55 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 18 Jun 2020 17:56:54 +1000
Date:   Thu, 18 Jun 2020 17:56:54 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     b6da310b-e633-9f74-f7af-7791d803aaf5@huawei.com
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        Shukun Tan <tanshukun1@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] crypto: hisilicon - allow smaller reads in debugfs
Message-ID: <20200618075654.GD10091@gondor.apana.org.au>
References: <20200602135409.GA59808@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602135409.GA59808@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:54:09PM +0300, Dan Carpenter wrote:
> Originally this code rejected any read less than 256 bytes.  There
> is no need for this artificial limit.  We should just use the normal
> helper functions to read a string from the kernel.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Use simple_read_from_buffer().  The v1 was slightly half arsed
> because I left the original check for:
> 
> 	if (*pos)
> 		return 0;
> 
> So it could result in partial reads.  The new code means that if you
> want to read the buffer one byte at a time, that's fine or if you want
> to read it in one 256 byte chunk that's also fine.  Plus it deletes 21
> lines of code and is a lot cleaner.
> 
>  drivers/crypto/hisilicon/qm.c | 33 ++++++---------------------------
>  1 file changed, 6 insertions(+), 27 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

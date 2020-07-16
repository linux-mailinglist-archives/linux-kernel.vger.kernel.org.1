Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE48221D81
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 09:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGPHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 03:36:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39708 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPHgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:36:18 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jvyR8-0003l4-CL; Thu, 16 Jul 2020 17:36:11 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Jul 2020 17:36:10 +1000
Date:   Thu, 16 Jul 2020 17:36:10 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] crypto: caam - support tagged keys for skcipher
 algorithms
Message-ID: <20200716073610.GA28215@gondor.apana.org.au>
References: <1594591536-531-1-git-send-email-iuliana.prodan@nxp.com>
 <1594591536-531-3-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594591536-531-3-git-send-email-iuliana.prodan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 01:05:36AM +0300, Iuliana Prodan wrote:
> Tagged keys are keys that contain metadata indicating what
> they are and how to handle them using tag_object API.
> 
> Add support, for tagged keys, to skcipher algorithms by
> adding new transformations, with _tk_ prefix to distinguish
> between plaintext and tagged keys.
> 
> For job descriptors a new option (key_cmd_opt) was added for KEY command.
> Tagged keys can be loaded using only a KEY command with ENC=1
> and the proper setting of the EKT bit. The EKT bit in the
> KEY command indicates which encryption algorithm (AES-ECB or
> AES-CCM) should be used to decrypt the key. These options will be kept in
> key_cmd_opt.
> 
> The tk_ transformations can be used directly by their name:
> struct sockaddr_alg sa = {
>     .salg_family = AF_ALG,
>     .salg_type = "skcipher", /* this selects the symmetric cipher */
>     .salg_name = "tk(cbc(aes))" /* this is the cipher name */
> };
> or for dm-crypt, e.g. using dmsetup:
> dmsetup -v create encrypted --table "0 $(blockdev --getsz /dev/mmcblk2p10)
> crypt capi:tk(cbc(aes))-plain :32:logon:seckey 0 /dev/mmcblk2p10 0 1
> sector_size:512".
> 
> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Can this use the existing paes name instead of tk as done in
other drivers?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

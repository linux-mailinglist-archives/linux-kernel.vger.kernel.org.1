Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C8528A1D8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbgJJWcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730406AbgJJSwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:52:24 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC1B224DE;
        Sat, 10 Oct 2020 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602354747;
        bh=t2YgZVluuf4vryGXDuJmdnGG2MK0FpJGL36ekpajFyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJtOcZGh7MXDk3mHCLkO2CpBhVWoNQBXNq6tf8cfsTaZ6DpFprFeTrBnvbRhKd6KR
         ybWmbC57523Qg3vIUgF/Li8eFfwHMtvyz6IycfzpS+OMD7xzODZfvZAGtGdzMBnyDh
         8dyze2Gfxz8If89W7su1tb7C0SbjvOhXaiHWdMoQ=
Date:   Sat, 10 Oct 2020 11:32:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - Fix format argument warning
Message-ID: <20201010183226.GA1808@sol.localdomain>
References: <20201010021637.112091-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010021637.112091-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 10:16:37AM +0800, Ye Bin wrote:
> Fix follow warning:
> [crypto/testmgr.c:2317]: (warning) %d in format string (no. 5) requires
> 'int' but the argument type is 'unsigned int'.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  crypto/testmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index a64a639eddfa..aefa4b6b8d78 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -2315,7 +2315,7 @@ static void generate_random_aead_testvec(struct aead_request *req,
>  	if (vec->setkey_error == 0 && vec->setauthsize_error == 0)
>  		generate_aead_message(req, suite, vec, prefer_inauthentic);
>  	snprintf(name, max_namelen,
> -		 "\"random: alen=%u plen=%u authsize=%u klen=%u novrfy=%d\"",
> +		 "\"random: alen=%u plen=%u authsize=%u klen=%u novrfy=%u\"",
>  		 vec->alen, vec->plen, authsize, vec->klen, vec->novrfy);

Actually vec->novrfy is 'unsigned char', not 'unsigned int'.  Both %u and %d
will work, but %d is technically correct because 'unsigned char' gets promoted
to 'int'.  What tool are you using that claims this is wrong?

- Eric

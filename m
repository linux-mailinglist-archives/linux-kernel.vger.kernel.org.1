Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA72E9423
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbhADLed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:34:33 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:49772 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADLec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:34:32 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kwO7P-0005yY-AF; Mon, 04 Jan 2021 22:33:48 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 04 Jan 2021 22:33:47 +1100
Date:   Mon, 4 Jan 2021 22:33:47 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     liulongfang <liulongfang@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] crypto: hisilicon - enable new algorithms of SEC
Message-ID: <20210104113347.GA20681@gondor.apana.org.au>
References: <1607598607-8728-1-git-send-email-liulongfang@huawei.com>
 <20210102210044.GA1514@gondor.apana.org.au>
 <5432190d-0467-1a99-3629-bf8b618b35ef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5432190d-0467-1a99-3629-bf8b618b35ef@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 04:15:13PM +0800, liulongfang wrote:
>
> Currently, we have not conducted Fuzz testing.
> For SEC driver, we only adds support for these new algorithms
> with existing interfaces of Crypto. So, do we need to do Fuzz testing on the existing interfaces?

Please test with CRYPTO_MANAGER_EXTRA_TESTS.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

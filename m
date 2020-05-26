Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318EA1BEFBB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 07:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgD3Fcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 01:32:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60384 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3Fcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 01:32:36 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jU1nA-0005RX-Rn; Thu, 30 Apr 2020 15:31:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Apr 2020 15:32:18 +1000
Date:   Thu, 30 Apr 2020 15:32:18 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     hadar.gat@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        zou_wei@huawei.com
Subject: Re: [PATCH -next] hwrng: cctrng - Make some symbols static
Message-ID: <20200430053218.GA11940@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587644481-38192-1-git-send-email-zou_wei@huawei.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zou Wei <zou_wei@huawei.com> wrote:
> Fix the following sparse warnings:
> 
> drivers/char/hw_random/cctrng.c:316:6: warning: symbol
> 'cc_trng_compwork_handler' was not declared. Should it be static?
> drivers/char/hw_random/cctrng.c:451:6: warning: symbol
> 'cc_trng_startwork_handler' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
> drivers/char/hw_random/cctrng.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

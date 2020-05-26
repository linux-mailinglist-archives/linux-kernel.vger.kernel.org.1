Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A032D1BFD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgD3OKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:10:53 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60848 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbgD3OKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:10:49 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jU9s8-0000qz-47; Fri, 01 May 2020 00:09:05 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 May 2020 00:10:11 +1000
Date:   Fri, 1 May 2020 00:10:11 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hadar Gat <Hadar.Gat@arm.com>
Cc:     Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <Ofir.Drang@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v3 1/3] hwrng: cctrng - Add dependency on OF
Message-ID: <20200430141011.GA13992@gondor.apana.org.au>
References: <1587987364-4566-1-git-send-email-hadar.gat@arm.com>
 <1587987364-4566-2-git-send-email-hadar.gat@arm.com>
 <20200427150658.GA26305@gondor.apana.org.au>
 <DB7PR08MB3003E1459755B853B41490D6E9AC0@DB7PR08MB3003.eurprd08.prod.outlook.com>
 <20200428123007.GA3969@gondor.apana.org.au>
 <AM6PR08MB2999F52B99066C321837144DE9AA0@AM6PR08MB2999.eurprd08.prod.outlook.com>
 <20200430074941.GA12529@gondor.apana.org.au>
 <AM6PR08MB29990D46BD6C974ACE1914F0E9AA0@AM6PR08MB2999.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB29990D46BD6C974ACE1914F0E9AA0@AM6PR08MB2999.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 08:26:00AM +0000, Hadar Gat wrote:
>
> I don't understand if anything need to be fixed before this patch can be applied.
> The patch adds dependency on OF, which was missing and is required for the cctrng driver.
> (Indeed cctrng compilation passed also without CONFIG_OF because of the empty implementation of of_property_read*() functions that simply returns -ENOSYS.)

Nevermind, I already have the CONFIG_OF flag on in my build test
so it shouldn't be a problem.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A21BBDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgD1Mav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 08:30:51 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:47296 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgD1Mav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:30:51 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jTPKU-0001RT-DK; Tue, 28 Apr 2020 22:27:15 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Apr 2020 22:30:07 +1000
Date:   Tue, 28 Apr 2020 22:30:07 +1000
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
Message-ID: <20200428123007.GA3969@gondor.apana.org.au>
References: <1587987364-4566-1-git-send-email-hadar.gat@arm.com>
 <1587987364-4566-2-git-send-email-hadar.gat@arm.com>
 <20200427150658.GA26305@gondor.apana.org.au>
 <DB7PR08MB3003E1459755B853B41490D6E9AC0@DB7PR08MB3003.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR08MB3003E1459755B853B41490D6E9AC0@DB7PR08MB3003.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 12:26:31PM +0000, Hadar Gat wrote:
>
> I've set COMPILE_TEST but couldn't see any problem.
> Would you share what doesn't work?

I don't have OF in my config.  This driver builds just fine without
OF.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

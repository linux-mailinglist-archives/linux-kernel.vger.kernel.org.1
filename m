Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C1F256760
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgH2MEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 08:04:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36252 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgH2ME3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:04:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kBzab-0006OZ-Rb; Sat, 29 Aug 2020 22:04:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 29 Aug 2020 22:04:09 +1000
Date:   Sat, 29 Aug 2020 22:04:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     George Acosta <acostag.ubuntu@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Phani Kiran Hemadri <phemadri@marvell.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium/nitrox: add an error message to explain
 the failure of pci_request_mem_regions
Message-ID: <20200829120409.GA22368@gondor.apana.org.au>
References: <20200821031209.21279-1-acostag.ubuntu@gmail.com>
 <20200828071931.GB28064@gondor.apana.org.au>
 <CALhW5_QpsRCb73OCiOKC0xVSwuadz3BVSQg+r=T4AN+qCpSM0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALhW5_QpsRCb73OCiOKC0xVSwuadz3BVSQg+r=T4AN+qCpSM0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 08:53:36PM -0500, George Acosta wrote:
> Hi Herbert,
> I just noticed a small potential issue about the calling sequence of
> pci_disable_device and dev_err.
> Do you think it will be better to call dev_err before we call
> pci_disable_device(pdev) , or the order here does not matter?

I don't think it matters.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

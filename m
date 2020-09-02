Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199C025A2A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 03:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBBeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 21:34:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39256 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgIBBeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:34:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kDHf6-0002f5-Ig; Wed, 02 Sep 2020 11:34:09 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 02 Sep 2020 11:34:08 +1000
Date:   Wed, 2 Sep 2020 11:34:08 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: fsl: Remove bogus packed attributes from qman.h
Message-ID: <20200902013408.GA5012@gondor.apana.org.au>
References: <20200730125259.GA8948@gondor.apana.org.au>
 <VE1PR04MB6687FB075B9A6A0923F576978F2E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <20200901015630.GA9065@gondor.apana.org.au>
 <CADRPPNTt5dCX1pRUp5OenZBuMNJcN+k8jMVmUo5qw5g0VLZ4hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNTt5dCX1pRUp5OenZBuMNJcN+k8jMVmUo5qw5g0VLZ4hQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 04:40:16PM -0500, Li Yang wrote:
>
> Looks like the CAAM driver and dependent QBMAN driver doesn't support
> COMPILE_TEST yet.  Are you trying to add the support for it?

Yes.

> I think this is a valid concern that if the parent structure doesn't
> meet certain alignment requirements, the alignment for the
> sub-structure cannot be guaranteed.  If we just remove the __packed
> attribute from the parent structure, the compiler could try to add
> padding in the parent structure to fulfill the alignment requirements
> of the sub structure which is not good.  I think the following changes
> are a better fix for the warnings:

This works for me.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

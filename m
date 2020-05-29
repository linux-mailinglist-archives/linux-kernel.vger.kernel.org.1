Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8A1E7C54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 13:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2Lx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 07:53:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40702 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgE2Lxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:53:55 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jedYl-0004ub-1I; Fri, 29 May 2020 21:52:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 May 2020 21:52:22 +1000
Date:   Fri, 29 May 2020 21:52:22 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     davem@davemloft.net, ebiggers@kernel.org, ebiggers@google.com,
        pvanleeuwen@rambus.com, zohar@linux.ibm.com, gilad@benyossef.com,
        jarkko.sakkinen@linux.intel.com, dmitry.kasatkin@intel.com,
        nicstange@gmail.com, tadeusz.struk@intel.com, jmorris@namei.org,
        serge@hallyn.com, zhang.jia@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] crpyto: introduce OSCCA certificate and SM2
 asymmetric algorithm
Message-ID: <20200529115222.GB3573@gondor.apana.org.au>
References: <20200402123504.84628-1-tianjia.zhang@linux.alibaba.com>
 <20200416060136.GA19149@gondor.apana.org.au>
 <fba669ef-b784-bdd9-d34e-a7726df7342c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba669ef-b784-bdd9-d34e-a7726df7342c@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 07:04:48PM +0800, Tianjia Zhang wrote:
> 
> On 2020/4/16 14:01, Herbert Xu wrote:
> > On Thu, Apr 02, 2020 at 08:34:57PM +0800, Tianjia Zhang wrote:
> > > Hello all,
> > > 
> > > This new module implement the OSCCA certificate and SM2 public key
> > > algorithm. It was published by State Encryption Management Bureau, China.
> > > List of specifications for OSCCA certificate and SM2 elliptic curve
> > > public key cryptography:
> > > 
> > > * GM/T 0003.1-2012
> > > * GM/T 0003.2-2012
> > > * GM/T 0003.3-2012
> > > * GM/T 0003.4-2012
> > > * GM/T 0003.5-2012
> > > * GM/T 0015-2012
> > > * GM/T 0009-2012
> > > 
> > > IETF: https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
> > > oscca: http://www.oscca.gov.cn/sca/xxgk/2010-12/17/content_1002386.shtml
> > > scctc: http://www.gmbz.org.cn/main/bzlb.html
> > > 
> > > These patchs add the OID object identifier defined by OSCCA. The
> > > x509 certificate supports sm2-with-sm3 type certificate parsing
> > > and verification.
> > 
> > I don't have any objections to the crypto API bits, but obviously
> > this is contingent on the x509 bits getting accepted since that's
> > the only in-kernel user.  So can I see some acks on that please?
> 
> Any opinion on this series patches? Do I need to provide additional
> information ?

As I said I need acks for the patches outside of the crypto API.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

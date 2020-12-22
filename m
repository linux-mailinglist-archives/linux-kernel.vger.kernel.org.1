Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E32DC793
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgLPUOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:14:16 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:30739 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgLPUOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608149423;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
        Subject:Sender;
        bh=u9Ku5VexJVZju4MdPMP1Q8ygXDqOF8qJpf1GJvmL5TI=;
        b=W2wIi7/6kqJsu+IfuWrA2q/Fxl3++SghrcM2Xp9M0TULulz8ijIw0shj2dcI1DhlyG
        Xx9UJCwQ+p2xwFKmMmHtJwee7ZKWGFpHt81KExliHGdaallF1IOxuK/lG59exm2j9NXq
        pcU/IzSkVPiEAoV4Q+KLv0jr/bhWP2Zj31hRi9BfhMKFSx2mreZHboBxvZl55aWHkiF2
        hypQzkVRAd71DLRM4QmExlewjyzdrGL5oHLjrFAdu42TFg4VpNUhIwhjzUZlddOB9aDw
        aDHmYjydxXI6Mr1xDnSv3rhec2eltFrgSp0ZUgCxacf3o0VN1Bg0h9axXRtbRRvGBke3
        qK9w==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNzyCzy1Sfr67uExK884EC0GFGHavLSBZj8FSXg=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 47.9.1 DYNA|AUTH)
        with ESMTPSA id v0bfb2wBGKAF0J8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 16 Dec 2020 21:10:15 +0100 (CET)
Message-ID: <b38e3b40ef198166bff193940b8c82c41db6f13c.camel@chronox.de>
Subject: Re: [PATCH v4 4/5] crypto: hisilicon/hpre - add 'ECDH' algorithm
From:   Stephan Mueller <smueller@chronox.de>
To:     yumeng <yumeng18@huawei.com>
Cc:     linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
Date:   Wed, 16 Dec 2020 21:10:15 +0100
In-Reply-To: <711de58c-4f7c-4643-4b8b-6af98ed1a7bc@huawei.com>
References: <13db294664a6b2e26a892dd544c714d3e385b0cc.camel@chronox.de>
         <3903e2e8-165f-51b5-056c-24b8ce52e842@huawei.com>
         <711de58c-4f7c-4643-4b8b-6af98ed1a7bc@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 16.12.2020 um 10:39 +0800 schrieb yumeng:
> 
> 
> 
> > Am Freitag, den 11.12.2020, 14:30 +0800 schrieb Meng Yu:
> > > 
> > > +/* size in bytes of the n prime */
> > > +#define HPRE_ECC_NIST_P128_N_SIZE      16
> > 
> > Do we truly need P-128? Besides, I do not see that curve being defined in
> > contemporary cipher specs.
> > 
> > > +#define HPRE_ECC_NIST_P192_N_SIZE      24
> > > +#define HPRE_ECC_NIST_P224_N_SIZE      28
> > > +#define HPRE_ECC_NIST_P256_N_SIZE      32
> > > +#define HPRE_ECC_NIST_P320_N_SIZE      40
> > 
> > Do we truly need P-320? Besides, I do not see that curve being defined in
> > contemporary cipher specs.
> 
> Yes, in rfc 5903, only P-256, P-384 and P-521 is defined, but in
> 'rfc5639' and  "SEC 2: Recommended Elliptic Curve Domain Parameters",
> other curves like P-128, P-192, P-224, and P-320 curve parameters are
> found, and they are used in 'openssl';
> How about your idea?

Who is going to use that curve considering that common protocols that are
implemented in the kernel do not use it?

Thanks
Stephan


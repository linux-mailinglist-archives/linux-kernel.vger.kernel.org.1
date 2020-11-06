Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CBF2A8FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgKFHCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:02:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:35054 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFHCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:02:30 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kavlF-00082u-3F; Fri, 06 Nov 2020 18:02:14 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Nov 2020 18:02:13 +1100
Date:   Fri, 6 Nov 2020 18:02:13 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     trix@redhat.com
Cc:     giovanni.cabiddu@intel.com, davem@davemloft.net,
        ebiggers@google.com, dominik.przychodni@intel.com,
        wojciech.ziemba@intel.com, mpatocka@redhat.com,
        geert+renesas@glider.be, ardb@kernel.org, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qat: remove unneeded semicolon
Message-ID: <20201106070213.GF11620@gondor.apana.org.au>
References: <20201027190407.1587980-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027190407.1587980-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:04:07PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/crypto/qat/qat_common/qat_algs.c      | 2 +-
>  drivers/crypto/qat/qat_common/qat_asym_algs.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

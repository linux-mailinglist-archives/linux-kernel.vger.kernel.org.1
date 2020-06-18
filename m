Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993A21FED07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgFRH5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 03:57:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60454 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgFRH5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:57:11 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jlpPy-00023e-QP; Thu, 18 Jun 2020 17:57:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 18 Jun 2020 17:57:02 +1000
Date:   Thu, 18 Jun 2020 17:57:02 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrei Botila <andrei.botila@oss.nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: caam/qi2 - add support for dpseci_reset()
Message-ID: <20200618075702.GE10091@gondor.apana.org.au>
References: <20200603084704.5895-1-andrei.botila@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603084704.5895-1-andrei.botila@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 11:47:04AM +0300, Andrei Botila wrote:
> From: Andrei Botila <andrei.botila@nxp.com>
> 
> Add support for dpseci_reset() command for DPSECI objects.
> For DPSECI DPAA2 objects with version lower than v5.4 reset command
> was broken in MC f/w.
> 
> Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
> ---
> Changes since V1:
> - added, in dpaa2_dpseci_free function an error message in case dpseci_reset() fails.
> 
>  drivers/crypto/caam/caamalg_qi2.c | 15 +++++++++++++++
>  drivers/crypto/caam/dpseci.c      | 18 ++++++++++++++++++
>  drivers/crypto/caam/dpseci.h      |  2 ++
>  drivers/crypto/caam/dpseci_cmd.h  |  1 +
>  4 files changed, 36 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

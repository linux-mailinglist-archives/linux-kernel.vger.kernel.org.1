Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5562B24CF61
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHUHhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:37:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49866 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgHUHg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:36:57 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91ay-0003X6-Om; Fri, 21 Aug 2020 17:36:17 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 17:36:16 +1000
Date:   Fri, 21 Aug 2020 17:36:16 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     davem@davemloft.net, mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/17] crypto: sun8i-ce: move iv data to request
 context
Message-ID: <20200821073616.GA19456@gondor.apana.org.au>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
 <1595358391-34525-9-git-send-email-clabbe@baylibre.com>
 <20200731082427.GA28326@gondor.apana.org.au>
 <20200821073504.GA21887@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821073504.GA21887@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:35:04AM +0200, LABBE Corentin wrote:
>
> Since cryptodev now have 453431a54934 ("mm, treewide: rename kzfree() to kfree_sensitive()"), my serie should apply cleanly.

Please resubmit.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

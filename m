Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAC624A5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHSSJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 14:09:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:41567 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHSSJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:09:10 -0400
IronPort-SDR: GgVnQtVLAsj13IvToBMjD4RrCVnLMQiRghDauxVRjEczceYFV1p+Ky/FGGhhnrP9O6qhoi+Haj
 yGwa56CIfpCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="142991408"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="142991408"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 11:09:09 -0700
IronPort-SDR: BmpW4JVz/MmowLhjarGdOJDyLhM6/+aqrzGwN4H56xS28sZrYzGwoixReaA3vZnuUSbwUm7dO+
 6GRu61erQsjw==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="320571428"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 11:09:09 -0700
Date:   Wed, 19 Aug 2020 11:09:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Megha Dey <megha.dey@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 0/2] Cyrpto: Clean up kmap() use
Message-ID: <20200819180908.GD3142014@iweiny-DESK2.sc.intel.com>
References: <20200811004015.2800392-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811004015.2800392-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 05:40:13PM -0700, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> While going through kmap() users the following 2 issues were found via code
> inspection.

Any feedback on these patches?  Perhaps I've not included the correct people?
Adding some people to the CC list.

Specifically, Linus Walleij for the ux500 work.  Linus can you comment on the
first patch?

patch1: https://lore.kernel.org/lkml/20200811004015.2800392-2-ira.weiny@intel.com/
patch2: https://lore.kernel.org/lkml/20200811004015.2800392-3-ira.weiny@intel.com/

Thanks,
Ira

> 
> Ira Weiny (2):
>   crypto/ux500: Fix kmap() bug
>   crypto: Remove unused async iterators
> 
>  crypto/ahash.c                        | 41 +++------------------------
>  drivers/crypto/ux500/hash/hash_core.c | 30 ++++++++++++--------
>  include/crypto/internal/hash.h        | 13 ---------
>  3 files changed, 22 insertions(+), 62 deletions(-)
> 
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 

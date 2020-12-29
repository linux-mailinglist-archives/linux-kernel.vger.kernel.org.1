Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900322E7189
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2Ozc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:55:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:6084 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgL2Ozb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:55:31 -0500
IronPort-SDR: mmaY9qs+AgslRpB4Km3vmtd3wxytZ9A0iyLccfDEq7uajuCQXncy+GFu30QSevjBLcc7Ti8QL2
 xygXav0HBqnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="155702542"
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="155702542"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 06:53:46 -0800
IronPort-SDR: naMXQxSTKeZ8d9ibYInaBR39K4Kl+cvc/FcMS3Zhbo88T5DLOPx+6kXEki6cXBSP6KYI/JOoMF
 EstTeOFCOc3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="347412123"
Received: from shwdenpg096.ccr.corp.intel.com (HELO [10.67.104.88]) ([10.67.104.88])
  by fmsmga008.fm.intel.com with ESMTP; 29 Dec 2020 06:53:42 -0800
Subject: Re: [PATCH v4 3/5] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        linus.walleij@linaro.org, minyard@acm.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     BMC-SW@aspeedtech.com, cyrilbur@gmail.com, rlippert@google.com
References: <20201229063157.3587-1-chiawei_wang@aspeedtech.com>
 <20201229063157.3587-4-chiawei_wang@aspeedtech.com>
From:   Haiyue Wang <haiyue.wang@linux.intel.com>
Message-ID: <d436cf38-7ce2-3bea-4d0e-03003e36af42@linux.intel.com>
Date:   Tue, 29 Dec 2020 22:53:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201229063157.3587-4-chiawei_wang@aspeedtech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/2020 14:31, Chia-Wei, Wang wrote:
> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
>
> Signed-off-by: Chia-Wei, Wang<chiawei_wang@aspeedtech.com>
> ---
>   drivers/char/ipmi/kcs_bmc_aspeed.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)

Acked-by: Haiyue Wang <haiyue.wang@linux.intel.com>




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE84258F59
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgIANq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 09:46:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:21500 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgIANoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:44:16 -0400
IronPort-SDR: XwqyiRFBGqz6dT/XqYn29ktHJuXQAaBJaogHyl3SJndca544u2Jk8954Ca18Xq/WOW0yOyWkxb
 6/It8qdvrtLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="218716992"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="218716992"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 06:43:52 -0700
IronPort-SDR: F97Nl6M4+gKE+m+OZaZKFNWuKx8k1xlWUrXo/A72FuUkANm6Z1SDaftvAs//5IWn4w2eFJtOWU
 r8vITEePHSWQ==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="446131895"
Received: from dlabricc-mobl.amr.corp.intel.com (HELO [10.212.239.51]) ([10.212.239.51])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 06:43:52 -0700
Subject: Re: [PATCH v2] regmap: soundwire: remove unused header
 mod_devicetable.h
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200901111331.641072-1-vkoul@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9d4720f4-83e1-ec3d-74cc-b94474eb07e9@linux.intel.com>
Date:   Tue, 1 Sep 2020 08:43:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901111331.641072-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/20 6:13 AM, Vinod Koul wrote:
> mod_devicetable.h does not seem to be required for this file, so
> remove it.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> 
> changes in v2:
>    - fix typo in patch subject
> 
>   drivers/base/regmap/regmap-sdw.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
> index 50a66382d87d..c92d614b4943 100644
> --- a/drivers/base/regmap/regmap-sdw.c
> +++ b/drivers/base/regmap/regmap-sdw.c
> @@ -2,7 +2,6 @@
>   // Copyright(c) 2015-17 Intel Corporation.
>   
>   #include <linux/device.h>
> -#include <linux/mod_devicetable.h>
>   #include <linux/module.h>
>   #include <linux/soundwire/sdw.h>
>   #include "internal.h"
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063FF29F1BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgJ2QkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:40:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:27959 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgJ2QkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:40:19 -0400
IronPort-SDR: 5YIwb58BNwvuQfif8bzZ68p261MtzzjTjViTs6/zy/4zb1cMEjnHDQhwDNSPYAyVtT8MwtnJOD
 E/2nAfvtNkVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="232645537"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="232645537"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 09:40:18 -0700
IronPort-SDR: rhlsDb9jKbP9HmivfA60EelfBvva7vwMyla+F7xP7GJYM2vXrKjZr34cYyp9ayF3KKbtSdb+TL
 BOuH47ax5DiA==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="323762890"
Received: from mghaffa-mobl1.amr.corp.intel.com (HELO [10.212.235.9]) ([10.212.235.9])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 09:40:17 -0700
Subject: Re: [PATCH v2 5/6] ASoC: codecs: lpass-va-macro: Add support to VA
 Macro
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
 <20201029110829.16425-6-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8f33aac3-7a41-1482-ae8b-e24d13ba8f13@linux.intel.com>
Date:   Thu, 29 Oct 2020 10:56:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029110829.16425-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> new file mode 100644
> index 000000000000..8cb23c32631d
> --- /dev/null
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -0,0 +1,882 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +

Missing copyright information?

[...]

> +module_platform_driver(va_macro_driver);
> +MODULE_DESCRIPTION("VA macro driver");
> +MODULE_LICENSE("GPL v2");

"GPL" ? The v2 adds no information.

https://www.kernel.org/doc/html/latest/process/license-rules.html

“GPL”	Module is licensed under GPL version 2. This does not express any 
distinction between GPL-2.0-only or GPL-2.0-or-later. The exact license 
information can only be determined via the license information in the 
corresponding source files.

“GPL v2”	Same as “GPL”. It exists for historic reasons.

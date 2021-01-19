Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510D22FC3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbhASWqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:46:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:8054 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405541AbhASOdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:33:15 -0500
IronPort-SDR: Opw20w8fLNn1crMFmPD+xJk3olpe4Yy2n02RQERabu1ASZR4OrWgErPdoE3xoMCiRy0Zb8hPd5
 Ky7MtFP8xGeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="166600215"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="166600215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:32:34 -0800
IronPort-SDR: LohtyT3WLxV3mabovbKBQX1ophKWHTt1F1o1U4wi4yFNqs9Os+NUV6r/tkc09ptfEc39Gn4x0d
 YbHOfO5M5Kug==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="383956662"
Received: from lfrymark-mobl.ger.corp.intel.com (HELO [10.249.128.122]) ([10.249.128.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:32:33 -0800
Subject: Re: [PATCH] resource: Remove unneeded semicolon
To:     Chengyang Fan <cy.fan@huawei.com>
Cc:     guohanjun@huawei.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210118015000.2599677-1-cy.fan@huawei.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <c0bc7da5-feec-dbcd-6fdd-e0bea359572d@intel.com>
Date:   Tue, 19 Jan 2021 15:32:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118015000.2599677-1-cy.fan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/2021 2:50 AM, Chengyang Fan wrote:
> Remove a superfluous semicolon after function definition.
>
> Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
> ---
>   include/linux/ioport.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index fe48b7840665..803c10f6a6df 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -337,7 +337,7 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
>   #ifdef CONFIG_IO_STRICT_DEVMEM
>   void revoke_devmem(struct resource *res);
>   #else
> -static inline void revoke_devmem(struct resource *res) { };
> +static inline void revoke_devmem(struct resource *res) { }
>   #endif
>   
>   #endif /* __ASSEMBLY__ */

The patch is fine AFAICS, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

but I'm not sure why it has been sent to me.

It would be better to send it to Greg instead.

Thanks!



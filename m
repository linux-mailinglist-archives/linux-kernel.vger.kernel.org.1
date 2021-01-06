Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086B02EB808
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 03:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbhAFCV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 21:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbhAFCV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 21:21:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F64C061387
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 18:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=DwXo5OtthLO/ovJHBO2OaqlsvlKPhfS9FzWXNA2R03w=; b=NJ8lsE016yMA0O3c6CI+fNdOHV
        16fKw+Q3tCvv1IzaRiOJL5IQZ7UmYqB8ehMKyXJXOvuykJ9xrrR1KhRxTJyVmE9zB0yCxScRdGIlI
        xyJ+HxIzO10aSJ0hy3J4l/0hOAgO+gBzx5+GaNrRgH5hNM69MtGgaIlAF63nPVaXXavOTP/DWXeoC
        0TvHOh+3Jn8TZzYj3gDjnl40fLIYXN+j5Fuw91r5XE15GrJvizpOYGq61odHCwa+E5iSsi65EH4nP
        gFSaX33WskvgxxXLEFxBuPzn4T+VZs+80Y5WsPrl+kg12+xOlSX1S5KQnYK1rcG1i305TqM/r1rUg
        dTemnIJQ==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwyRI-001uc0-QK; Wed, 06 Jan 2021 02:21:03 +0000
Subject: Re: [PATCH 1/1] arm64: make section size configurable for memory
 hotplug
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1609895500.git.sudaraja@codeaurora.org>
 <66f79b0c06602c22df4da8ff4a5c2b97c9275250.1609895500.git.sudaraja@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1c4613bc-56e9-de99-e9de-4313b4aa88a2@infradead.org>
Date:   Tue, 5 Jan 2021 18:20:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <66f79b0c06602c22df4da8ff4a5c2b97c9275250.1609895500.git.sudaraja@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/21 5:28 PM, Sudarshan Rajagopalan wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..34124eee65da 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -294,6 +294,17 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>  config SMP
>  	def_bool y
>  
> +config HOTPLUG_SIZE_BITS
> +	int "Memory hotplug block size(29 => 512MB 30 => 1GB)"

	                    block size (29 => 512MB, 30 => 1GB)"

> +	depends on SPARSEMEM
> +	depends on MEMORY_HOTPLUG
> +	range 28 30
> +	default 30
> +	help
> +	 Selects granularity of hotplug memory. Block size for
> +	 memory hotplug is represent as a power of 2.

	                   represented

> +	 If unsure, stick with default value.

and all of the help text should be indented with 1 tab + 2 spaces.


thanks.
-- 
~Randy


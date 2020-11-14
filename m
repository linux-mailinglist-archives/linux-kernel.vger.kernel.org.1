Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B12B2A6C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 02:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgKNBTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 20:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgKNBTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 20:19:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B68C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 17:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=zIIQrfARUTCewnI9/Idpy6AZyhPBsf5Sdq2PXZ3AwO8=; b=RWXBJneL33xgN+pTofW5lIICU9
        oVTSq85pie/67NkeKUxj4TFRUjcjBVFHUyVH+tqqljMZlEZoqXwXoQb2qqWhJBeGrw61sVkgdigGS
        XtUtT2e6su2Trm0yYdZuF7YZ7ljP/jYhXFeR8T3sywWhpMXA8lO7r2NqqsmNsbCQzOG8tZiXo4UHu
        iKiURSeb6M6CCGuBQ3jzZcQXSityZF2IqlKQTsKVYg/8d7amvV+8p6SXKfRbpe/FZeBxp12Gm8Urn
        y34wDEv5Iq9f/ZiwxEG12J2kJ4T8i3K9V+77ZSgPzWM9+oQB33xgrTLjf6AcTV+C8pphm6auz3map
        YR09ZVqg==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdkEI-0002J7-1y; Sat, 14 Nov 2020 01:19:50 +0000
Subject: Re: [PATCH v2 1/2] x86/pci: use unsigned int in check_reserved_t
To:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20201114002306.4166604-1-samitolvanen@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bb843f45-1dd4-604a-dfc1-029cd9d437db@infradead.org>
Date:   Fri, 13 Nov 2020 17:19:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201114002306.4166604-1-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 4:23 PM, Sami Tolvanen wrote:
> Use unsigned int instead of raw unsigned in check_reserved_t to follow
> the kernel's style guidelines.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/x86/pci/mmconfig-shared.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 6fa42e9c4e6f..37f31dd7005a 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -425,7 +425,7 @@ static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
>  	return AE_OK;
>  }
>  
> -static bool is_acpi_reserved(u64 start, u64 end, unsigned not_used)
> +static bool is_acpi_reserved(u64 start, u64 end, unsigned int not_used)
>  {
>  	struct resource mcfg_res;
>  
> @@ -442,7 +442,7 @@ static bool is_acpi_reserved(u64 start, u64 end, unsigned not_used)
>  	return mcfg_res.flags;
>  }
>  
> -typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
> +typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned int type);
>  
>  static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  				     struct pci_mmcfg_region *cfg,
> 
> base-commit: 9e6a39eae450b81c8b2c8cbbfbdf8218e9b40c81
> 


-- 
~Randy

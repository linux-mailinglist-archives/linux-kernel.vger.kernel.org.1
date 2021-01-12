Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8892F2895
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbhALGzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbhALGzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:55:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3A2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 22:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=RiyM0c9j0TR/ZiSHWGyt7mOms657zOtCNK+WQflYxLY=; b=rJZb0wT0PD7Rd6Ba8JF8meP8qm
        n/+x3fWHp9jMKA0uMwZ3XCxDtlWL3CqIYXZ4ozWBU+8wVPdzFX3E97CEcavQFfXb+1o+bxyydi4xr
        fUl1PmiMNQkmBrzmV20oHnoVEP6O1271LuEjI/38eOPpl0p+rAsmfcayTEGGL9x8FUmjn94Hk2u5h
        4ndeSvzt5YpKoKdR0PTcP7AM47/U/aFakuLMUA5eGHfjiNtp08eI88c2PlF6aThZLB4t+KEi08/2+
        AV2opssIOj7oBLkPs6sUgEUWaDjeIVPt61RMkB0bbBfnxwB3yGX7HG4m+7QL2+Z/wlNKJlxgOL94R
        rU0luqnw==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzDZR-00084H-KP; Tue, 12 Jan 2021 06:54:25 +0000
Subject: Re: [PATCH V2] arch: x86: kernel: cpu: Takes a letter away and put a
 semicolon too, to match below stuc member
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, fenghua.yu@intel.com,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, gustavo@embeddedor.com
References: <20210112052730.24677-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ead1d179-d32d-46a7-5783-bc08298a830a@infradead.org>
Date:   Mon, 11 Jan 2021 22:54:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112052730.24677-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 9:27 PM, Bhaskar Chowdhury wrote:
> s/kernlfs/kernfs/
> 
>  A semicolon at the end of member name
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  As pointed out by Gustavo and Randy in version one of this patch
> 
>  arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ee71c47844cb..ef9e2c0809b8 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -142,7 +142,7 @@ enum rdtgrp_mode {
> 
>  /**
>   * struct mongroup - store mon group's data in resctrl fs.
> - * @mon_data_kn		kernlfs node for the mon_data directory
> + * @mon_data_kn:		kernfs node for the mon_data directory
>   * @parent:			parent rdtgrp
>   * @crdtgrp_list:		child rdtgroup node list
>   * @rmid:			rmid for this rdtgroup
> --

The patch to internal.h is OK, but as Gustavo pointed out,
the patch versioning isn't done as expected.

-- 
~Randy


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171462D9947
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393862AbgLNNyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:54:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:48480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbgLNNyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607954015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAdjzavcb3mFBEHJB874Dk5WCRXNv3K3HXp41RD9ubI=;
        b=qcicvaw/qXksidM4WAVQXpf06NH7u8U/WthgWbvG71oMO+P8DvLLjWleNjevKNMUD2Eqov
        XIBd3er3QqDwU11Lytxc5wTf4VcwMC4lmbynDIsfQbKuzd5FLw5Mbx3ptlC3Vpu1hzD6CG
        4JHbh0qPwaVovCnYAISNGq2IhA4luFY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E383DAC7F;
        Mon, 14 Dec 2020 13:53:34 +0000 (UTC)
Date:   Mon, 14 Dec 2020 14:53:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, nathanl@linux.ibm.com,
        cheloha@linux.ibm.com
Subject: Re: [PATCH] mm/memory_hotplug: quieting offline operation
Message-ID: <20201214135334.GC32193@dhcp22.suse.cz>
References: <20201211150157.91399-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211150157.91399-1-ldufour@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-12-20 16:01:57, Laurent Dufour wrote:
> On PowerPC, when dymically removing memory from a system we can see in the console a
> lot of messages like this:
> [  186.575389] Offlined Pages 4096
> 
> This message is displayed on each LMB (256MB) removed, which means that we
> removing 1TB of memory, this message is displayed 4096 times.
> 
> Moving it to DEBUG to not flood the console.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

I am wondering whether we should be dropping this altogether. Offlining
is returning an error status to its caller so e.g. userspace can find
out the failure and the error code.

Anyway, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b44d4c7ba73b..c47a53a16782 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1587,7 +1587,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  
>  	/* Mark all sections offline and remove free pages from the buddy. */
>  	__offline_isolated_pages(start_pfn, end_pfn);
> -	pr_info("Offlined Pages %ld\n", nr_pages);
> +	pr_debug("Offlined Pages %ld\n", nr_pages);
>  
>  	/*
>  	 * The memory sections are marked offline, and the pageblock flags
> -- 
> 2.29.2

-- 
Michal Hocko
SUSE Labs

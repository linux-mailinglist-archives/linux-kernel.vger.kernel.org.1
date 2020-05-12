Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036891CED48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgELGuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 02:50:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47027 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgELGuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:50:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id w7so13900762wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+XD8Y6tEmtTs7vMbjo81XnVFNhe7jSdvdt/s8YEjaHg=;
        b=fJ4NgJBitmlM4bWZgBKXY58JYV0LpHe72G28608gKXHv42HNY2LvuVq49YBxk8JuZy
         UxOEfglC3y9j6CcG7D3nAK0APAVtkzUdIWHhhssRIAPyLVHv6J0K8nIb9uNiyWzoxZ7Q
         OpkjVyST//lR8b0p+8kSGUg8dnlBriM3ckIRyTAUyfXC7r6J9C3Y+tY5+LAHLKPxc5Kh
         YD/37Agqr16mVAjaCDu1E1u5nRMf+29WzhgDUdc305w8bRhtCYKYPaGIosoTUJVM3NfR
         lWhIkjPe5qoKpiA58MPUGL2XFHrqQB2z/lC0FmHPriL87ssXLzAMHrFjOH7r18r/v15n
         usaA==
X-Gm-Message-State: AOAM532ldc29Qtt9581utA0brE3Yo/XtyhUE1U2r4jW0518OqqJKR1Xe
        khOZF+js2OO5ACJaPHSZCRQ=
X-Google-Smtp-Source: ABdhPJyFGZYUUdE1D+dABJILUqbs/VUgmZJNuPKdPWmELcviQhZMyMcGBy49OvSxvATewfewlQBtvQ==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr961988wrx.54.1589266252064;
        Mon, 11 May 2020 23:50:52 -0700 (PDT)
Received: from localhost (ip-37-188-140-86.eurotel.cz. [37.188.140.86])
        by smtp.gmail.com with ESMTPSA id 81sm13287230wme.16.2020.05.11.23.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 23:50:50 -0700 (PDT)
Date:   Tue, 12 May 2020 08:50:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm, swap: Use prandom_u32_max()
Message-ID: <20200512065049.GN29153@dhcp22.suse.cz>
References: <20200512064147.514493-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512064147.514493-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-05-20 14:41:46, Huang Ying wrote:
> To improve the code readability and get random number with higher
> quality.

I understand the readability argument but why should prandom_u32_max
(which I was not aware of) provide a higher quality randomness?

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>

To the change itself
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/swapfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index a0a123e59ce6..2ec8b21201d6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3220,7 +3220,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		 * select a random position to start with to help wear leveling
>  		 * SSD
>  		 */
> -		p->cluster_next = 1 + (prandom_u32() % p->highest_bit);
> +		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
>  		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
>  
>  		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs

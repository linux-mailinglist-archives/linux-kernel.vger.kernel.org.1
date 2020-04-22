Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35031B33FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 02:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDVAgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 20:36:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:35556 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDVAgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:36:04 -0400
IronPort-SDR: 6BH7mnelbJkIdiacr+fsCTfDW4L3aWqFsN+8I3ogpgmjpbZY+C1uH2I91OEvwr86pYL08yjdOb
 LtYPNs0OF0Pg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 17:36:04 -0700
IronPort-SDR: VK+prjcz24F4zDfuPl/MNTubRPj3dw6PxJaaHisBS9GDnCGNh5MVUwe8moasHTK/IVvQaFv3aM
 rc32sl7Glnzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="456303528"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2020 17:36:02 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <tim.c.chen@linux.intel.com>
Subject: Re: [Patch v2 1/3] mm/swapfile.c: found_free could be represented by (tmp < max)
References: <20200421213824.8099-1-richard.weiyang@gmail.com>
Date:   Wed, 22 Apr 2020 08:36:01 +0800
In-Reply-To: <20200421213824.8099-1-richard.weiyang@gmail.com> (Wei Yang's
        message of "Tue, 21 Apr 2020 21:38:22 +0000")
Message-ID: <87r1wgqrv2.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> This is not necessary to use the variable found_free to record the
> status. Just check tmp and max is enough.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

All 3 patches looks good to me.  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

> ---
>  mm/swapfile.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 469ab417ed43..d203cdc6750a 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -601,7 +601,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  {
>  	struct percpu_cluster *cluster;
>  	struct swap_cluster_info *ci;
> -	bool found_free;
>  	unsigned long tmp, max;
>  
>  new_cluster:
> @@ -623,8 +622,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  			return false;
>  	}
>  
> -	found_free = false;
> -
>  	/*
>  	 * Other CPUs can use our cluster if they can't find a free cluster,
>  	 * check if there is still free entry in the cluster
> @@ -638,21 +635,19 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  	}
>  	ci = lock_cluster(si, tmp);
>  	while (tmp < max) {
> -		if (!si->swap_map[tmp]) {
> -			found_free = true;
> +		if (!si->swap_map[tmp])
>  			break;
> -		}
>  		tmp++;
>  	}
>  	unlock_cluster(ci);
> -	if (!found_free) {
> +	if (tmp >= max) {
>  		cluster_set_null(&cluster->index);
>  		goto new_cluster;
>  	}
>  	cluster->next = tmp + 1;
>  	*offset = tmp;
>  	*scan_base = tmp;
> -	return found_free;
> +	return tmp < max;
>  }
>  
>  static void __del_from_avail_list(struct swap_info_struct *p)

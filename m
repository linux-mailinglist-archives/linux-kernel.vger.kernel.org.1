Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57C51AFF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 03:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDTBDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 21:03:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:2723 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgDTBDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:03:46 -0400
IronPort-SDR: SV1sq4NIbHFCv/Bdbxvosxc/BMQNqjVbA89U0BUUwCqaffdmwg2K0RM+mRkExAHe9IQDoI6cXA
 TCjEGTS9jiMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 18:03:46 -0700
IronPort-SDR: fW3Emu5AXRqLLewgTQcdcurUevbhcclKe+GY2wxiKpczEMkA9ZfkmyNklZVPDbuE/71bbd3jQi
 2Ob828pgvmlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="300141109"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2020 18:03:43 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 3/4] mm/swapfile.c: compare tmp and max after trying to iterate on swap_map
References: <20200419013921.14390-1-richard.weiyang@gmail.com>
        <20200419013921.14390-3-richard.weiyang@gmail.com>
Date:   Mon, 20 Apr 2020 09:03:43 +0800
In-Reply-To: <20200419013921.14390-3-richard.weiyang@gmail.com> (Wei Yang's
        message of "Sun, 19 Apr 2020 01:39:20 +0000")
Message-ID: <87ftczt1cg.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> There are two duplicate code to handle the case when there is no
> available swap entry. Just let the code go through and do the check at
> second place.
>
> No functional change is expected.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/swapfile.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 3aae700f9931..07b0bc095411 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -629,10 +629,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  	tmp = cluster->next;
>  	max = min_t(unsigned long, si->max,
>  		    (cluster_next(&cluster->index) + 1) * SWAPFILE_CLUSTER);
> -	if (tmp >= max) {
> -		cluster_set_null(&cluster->index);
> -		goto new_cluster;
> -	}

The code is to avoid to acquire the cluster lock unnecessarily.  So I think
we should keep this.

Best Regards,
Huang, Ying

>  	ci = lock_cluster(si, tmp);
>  	while (tmp < max) {
>  		if (!si->swap_map[tmp])

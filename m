Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F541AFF96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 03:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDTBlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 21:41:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:62195 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgDTBlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:41:45 -0400
IronPort-SDR: k63PrsX+EFjpAUiRPi3dYAdXjG8EGqHL497ByXXBVIHwuWrM28wfonsSS8yAVrvCKDQ6KhXLhE
 SaDWJyhZ4Htg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 18:41:45 -0700
IronPort-SDR: cQywvut7KlsssAmI6HgQ7kpCWGMEr1J7+8bZivrKwjlPT0m2qEsYrcVay35ImJ9Ich05Z+vfMv
 /YXBPe0W1wlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="455470756"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga005.fm.intel.com with ESMTP; 19 Apr 2020 18:41:44 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 4/4] mm/swapfile.c: move new_cluster to check free_clusters directly
References: <20200419013921.14390-1-richard.weiyang@gmail.com>
        <20200419013921.14390-4-richard.weiyang@gmail.com>
Date:   Mon, 20 Apr 2020 09:41:43 +0800
In-Reply-To: <20200419013921.14390-4-richard.weiyang@gmail.com> (Wei Yang's
        message of "Sun, 19 Apr 2020 01:39:21 +0000")
Message-ID: <87blnnszl4.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> Each time it needs jump to new_cluster, it is sure current
> percpu_cluster is null.
>
> Move the new_cluster to check free_clusters directly.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/swapfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 07b0bc095411..78e92ff14c79 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -603,9 +603,9 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  	struct swap_cluster_info *ci;
>  	unsigned long tmp, max;
>  
> -new_cluster:
>  	cluster = this_cpu_ptr(si->percpu_cluster);
>  	if (cluster_is_null(&cluster->index)) {
> +new_cluster:
>  		if (!cluster_list_empty(&si->free_clusters)) {
>  			cluster->index = si->free_clusters.head;
>  			cluster->next = cluster_next(&cluster->index) *

In swap_do_scheduled_discard(), we will unlock si->lock, so the
percpu_cluster may be changed after we releasing the lock.  Or the
current thread may be moved to a different CPU.

Best Regards,
Huang, Ying

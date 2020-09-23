Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B427274EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgIWCVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:21:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:8863 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgIWCVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:21:38 -0400
IronPort-SDR: eVzNexSBSx+zG0jaYBIcpUIlsRqbiGWCfmFwNkhz3+hgbqnKDOqqXomtmvYTeL/Og6P4z/L11J
 Yg7t857/d7Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="222354567"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="222354567"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 19:21:38 -0700
IronPort-SDR: tFD7JEg0OJPr9H/vZmVDu5RShbGmtbQLwpmLb5ZfLyi12BiePKKnxS5xNET3AsJIVPpCWOdbAX
 aFFv93hYXEdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="347161693"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.164])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2020 19:21:36 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer dereference
References: <20200922184838.978540-1-aquini@redhat.com>
Date:   Wed, 23 Sep 2020 10:21:36 +0800
In-Reply-To: <20200922184838.978540-1-aquini@redhat.com> (Rafael Aquini's
        message of "Tue, 22 Sep 2020 14:48:38 -0400")
Message-ID: <878sd1qllb.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael,

Rafael Aquini <aquini@redhat.com> writes:

> The swap area descriptor only gets struct swap_cluster_info *cluster_info
> allocated if the swapfile is backed by non-rotational storage.
> When the swap area is laid on top of ordinary disk spindles, lock_cluster()
> will naturally return NULL.

Thanks for reporting.  But the bug looks strange.  Because in a system
with only HDD swap devices, during THP swap out, the swap cluster
shouldn't be allocated, as in

shrink_page_list()
  add_to_swap()
    get_swap_page()
      get_swap_pages()
        swap_alloc_cluster()

Where si->free_clusters is checked, and it should be empty for HDD.  So
in shrink_page_list(), the THP should have been split.  While in
split_huge_page_to_list(), PageSwapCache() is checked before calling
split_swap_cluster().  So this appears strange.

All in all, it appears that we need to find the real root cause of the
bug.

Did you test with the latest upstream kernel?  Can you help trace the
return value of swap_alloc_cluster()?  Can you share the swap device
information?

Best Regards,
Huang, Ying

> CONFIG_THP_SWAP exposes cluster_info infrastructure to a broader number of
> use cases, and split_swap_cluster(), which is the counterpart of split_huge_page()
> for the THPs in the swapcache, misses checking the return of lock_cluster before
> operating on the cluster_info pointer.
>
> This patch addresses that issue by adding a proper check for the pointer
> not being NULL in the wrappers cluster_{is,clear}_huge(), in order to avoid
> crashes similar to the one below:
>
> [ 5758.157556] BUG: kernel NULL pointer dereference, address: 0000000000000007
> [ 5758.165331] #PF: supervisor write access in kernel mode
> [ 5758.171161] #PF: error_code(0x0002) - not-present page
> [ 5758.176894] PGD 0 P4D 0
> [ 5758.179721] Oops: 0002 [#1] SMP PTI
> [ 5758.183614] CPU: 10 PID: 316 Comm: kswapd1 Kdump: loaded Tainted: G S               --------- ---  5.9.0-0.rc3.1.tst.el8.x86_64 #1
> [ 5758.196717] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.01.0002.082220131453 08/22/2013
> [ 5758.208176] RIP: 0010:split_swap_cluster+0x47/0x60
> [ 5758.213522] Code: c1 e3 06 48 c1 eb 0f 48 8d 1c d8 48 89 df e8 d0 20 6a 00 80 63 07 fb 48 85 db 74 16 48 89 df c6 07 00 66 66 66 90 31 c0 5b c3 <80> 24 25 07 00 00 00 fb 31 c0 5b c3 b8 f0 ff ff ff 5b c3 66 0f 1f
> [ 5758.234478] RSP: 0018:ffffb147442d7af0 EFLAGS: 00010246
> [ 5758.240309] RAX: 0000000000000000 RBX: 000000000014b217 RCX: ffffb14779fd9000
> [ 5758.248281] RDX: 000000000014b217 RSI: ffff9c52f2ab1400 RDI: 000000000014b217
> [ 5758.256246] RBP: ffffe00c51168080 R08: ffffe00c5116fe08 R09: ffff9c52fffd3000
> [ 5758.264208] R10: ffffe00c511537c8 R11: ffff9c52fffd3c90 R12: 0000000000000000
> [ 5758.272172] R13: ffffe00c51170000 R14: ffffe00c51170000 R15: ffffe00c51168040
> [ 5758.280134] FS:  0000000000000000(0000) GS:ffff9c52f2a80000(0000) knlGS:0000000000000000
> [ 5758.289163] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5758.295575] CR2: 0000000000000007 CR3: 0000000022a0e003 CR4: 00000000000606e0
> [ 5758.303538] Call Trace:
> [ 5758.306273]  split_huge_page_to_list+0x88b/0x950
> [ 5758.311433]  deferred_split_scan+0x1ca/0x310
> [ 5758.316202]  do_shrink_slab+0x12c/0x2a0
> [ 5758.320491]  shrink_slab+0x20f/0x2c0
> [ 5758.324482]  shrink_node+0x240/0x6c0
> [ 5758.328469]  balance_pgdat+0x2d1/0x550
> [ 5758.332652]  kswapd+0x201/0x3c0
> [ 5758.336157]  ? finish_wait+0x80/0x80
> [ 5758.340147]  ? balance_pgdat+0x550/0x550
> [ 5758.344525]  kthread+0x114/0x130
> [ 5758.348126]  ? kthread_park+0x80/0x80
> [ 5758.352214]  ret_from_fork+0x22/0x30
> [ 5758.356203] Modules linked in: fuse zram rfkill sunrpc intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp mgag200 iTCO_wdt crct10dif_pclmul iTCO_vendor_support drm_kms_helper crc32_pclmul ghash_clmulni_intel syscopyarea sysfillrect sysimgblt fb_sys_fops cec rapl joydev intel_cstate ipmi_si ipmi_devintf drm intel_uncore i2c_i801 ipmi_msghandler pcspkr lpc_ich mei_me i2c_smbus mei ioatdma ip_tables xfs libcrc32c sr_mod sd_mod cdrom t10_pi sg igb ahci libahci i2c_algo_bit crc32c_intel libata dca wmi dm_mirror dm_region_hash dm_log dm_mod
> [ 5758.412673] CR2: 0000000000000007
> [    0.000000] Linux version 5.9.0-0.rc3.1.tst.el8.x86_64 (mockbuild@x86-vm-15.build.eng.bos.redhat.com) (gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5), GNU ld version 2.30-79.el8) #1 SMP Wed Sep 9 16:03:34 EDT 2020
>
> Fixes: 59807685a7e77 ("mm, THP, swap: support splitting THP for THP swap out")
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>  mm/swapfile.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 12f59e641b5e..37ddf5e5c53b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -324,14 +324,15 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
>  
>  static inline bool cluster_is_huge(struct swap_cluster_info *info)
>  {
> -	if (IS_ENABLED(CONFIG_THP_SWAP))
> +	if (IS_ENABLED(CONFIG_THP_SWAP) && info)
>  		return info->flags & CLUSTER_FLAG_HUGE;
>  	return false;
>  }
>  
>  static inline void cluster_clear_huge(struct swap_cluster_info *info)
>  {
> -	info->flags &= ~CLUSTER_FLAG_HUGE;
> +	if (IS_ENABLED(CONFIG_THP_SWAP) && info)
> +		info->flags &= ~CLUSTER_FLAG_HUGE;
>  }
>  
>  static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82742A01DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgJ3Jwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:52:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:16932 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgJ3Jwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:52:53 -0400
IronPort-SDR: Did4MtpWymzomyGZYH1rcGxq7GP7nKjCrSKsrLnAKCwmiY/0kIHg3r2ssa/iXp5e8DHg7aT9rG
 s4DNcFc4Ar7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="168681459"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="168681459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 02:52:51 -0700
IronPort-SDR: GAZHBb/NZ1aCxlqH/DTr6Gb2F06UdOtZdHy8Yb4FqYGhRIS38jMy9DVb8F5wJFhER+dmOJqmbN
 pgplGxfz3DBA==
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="537011039"
Received: from gcobrien-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.22.113])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 02:52:46 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: Re: [PATCH] drm/i915/gvt: use DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
In-Reply-To: <20201030032945.GA274850@my--box>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20201030032945.GA274850@my--box>
Date:   Fri, 30 Oct 2020 11:52:42 +0200
Message-ID: <87y2joghw5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020, Deepak R Varma <mh12gx2825@gmail.com> wrote:
> Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
> function in place of the debugfs_create_file() function will make the
> file operation struct "reset" aware of the file's lifetime. Additional
> details here: https://lists.archive.carbon60.com/linux/kernel/2369498

Please describe what the functional impact is in the commit message. I
don't understand what 'make the file operation struct "reset" aware of
the file's lifetime' means here.

For referencing LKML posts, please prefer https://lore.kernel.org/.

For referencing commits already in the kernel, please prefer the format
c64688081490 ("debugfs: add support for self-protecting attribute file
fops").


BR,
Jani.

>
> Issue reported by Coccinelle script:
> scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
>
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
> Please Note: This is a Outreachy project task patch.
>
>  drivers/gpu/drm/i915/gvt/debugfs.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/debugfs.c b/drivers/gpu/drm/i915/gvt/debugfs.c
> index 62e6a14ad58e..18adfa2d5f5b 100644
> --- a/drivers/gpu/drm/i915/gvt/debugfs.c
> +++ b/drivers/gpu/drm/i915/gvt/debugfs.c
> @@ -147,9 +147,8 @@ vgpu_scan_nonprivbb_set(void *data, u64 val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(vgpu_scan_nonprivbb_fops,
> -			vgpu_scan_nonprivbb_get, vgpu_scan_nonprivbb_set,
> -			"0x%llx\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(vgpu_scan_nonprivbb_fops, vgpu_scan_nonprivbb_get,
> +			 vgpu_scan_nonprivbb_set, "0x%llx\n");
>  
>  /**
>   * intel_gvt_debugfs_add_vgpu - register debugfs entries for a vGPU
> @@ -165,8 +164,8 @@ void intel_gvt_debugfs_add_vgpu(struct intel_vgpu *vgpu)
>  	debugfs_create_bool("active", 0444, vgpu->debugfs, &vgpu->active);
>  	debugfs_create_file("mmio_diff", 0444, vgpu->debugfs, vgpu,
>  			    &vgpu_mmio_diff_fops);
> -	debugfs_create_file("scan_nonprivbb", 0644, vgpu->debugfs, vgpu,
> -			    &vgpu_scan_nonprivbb_fops);
> +	debugfs_create_file_unsafe("scan_nonprivbb", 0644, vgpu->debugfs, vgpu,
> +				   &vgpu_scan_nonprivbb_fops);
>  }
>  
>  /**

-- 
Jani Nikula, Intel Open Source Graphics Center

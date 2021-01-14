Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC12F5DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhANJnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:43:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:33533 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbhANJnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:43:11 -0500
IronPort-SDR: AmNIUtv2VdQxSXwJzLV6iT2InCydonBfutcamYQzsC0eBMz9EjtJFY5L18X8CyGoQX8fGN3XBk
 iuWX5X/yWuCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="178489307"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="178489307"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 01:42:39 -0800
IronPort-SDR: 7RuN2PziES+xPYKfQmNQ7mBycANnqj+LxNRtE5BfOTGKefHp2Goz48KfttoDydmWpEHp6d3Pt9
 shhhUKwfYSgg==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="382210357"
Received: from dforourk-mobl1.ger.corp.intel.com (HELO localhost) ([10.213.254.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 01:42:35 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Yang Li <abaci-bugfix@linux.alibaba.com>, airlied@linux.ie
Cc:     sunpeng.li@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd/display: Simplify bool comparison
In-Reply-To: <1610530365-46152-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1610530365-46152-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Date:   Thu, 14 Jan 2021 11:42:32 +0200
Message-ID: <871renrh13.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021, Yang Li <abaci-bugfix@linux.alibaba.com> wrote:
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c:580:23-31:
> WARNING: Comparison to bool
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
> index 4d3f7d5..904c2d2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
> @@ -577,7 +577,7 @@ void dpp1_power_on_degamma_lut(
>  	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
>  
>  	REG_SET(CM_MEM_PWR_CTRL, 0,
> -			SHARED_MEM_PWR_DIS, power_on == true ? 0:1);
> +			SHARED_MEM_PWR_DIS, power_on ? 0:1);

Not my driver, but this is as simple as it gets:

+			SHARED_MEM_PWR_DIS, !power_on);


>  
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center

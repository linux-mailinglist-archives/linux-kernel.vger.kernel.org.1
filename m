Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC030071F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbhAVPY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:24:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:34794 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbhAVPV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:21:59 -0500
IronPort-SDR: hxDloowpHx2dVHJyR0WRNDek2ithWwkNcLSZ6u+rQdmNxLje60jeAPuZA63j3Wj6Xedci/jXpp
 DoyNrc1LjyQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="179603048"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="179603048"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 07:21:10 -0800
IronPort-SDR: houAtDeADSmmcQbQWowfw/7Ijefe89LxGOc9gRjLNXgmOmPoa4inxl58NBuD8nLYiCezx2bJ04
 e2d6BENtCOOw==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="385793960"
Received: from blaschkj-mobl.ger.corp.intel.com (HELO localhost) ([10.252.44.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 07:21:05 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin King <colin.king@canonical.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ramalingam C <ramalingam.c@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/hdcp: Fix return of value in uninitialized variable ret
In-Reply-To: <20210122150957.209779-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210122150957.209779-1-colin.king@canonical.com>
Date:   Fri, 22 Jan 2021 17:21:02 +0200
Message-ID: <87y2glj8v5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently when there are other connectors on the port using HDCP the
> function _intel_hdcp_disable returns a garbage uninitialized value in
> variable ret.  I believe the intention is to return 0, so return this
> literal value instead of the value in ret.
>
> Addresses-Coverity: ("Uninitialized scalar return")
> Fixes: 899c8762f981 ("drm/i915/hdcp: Configure HDCP2.2 MST steram encryption status")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, but there's already a fix in progress:

http://lore.kernel.org/r/20210119064655.1605-3-anshuman.gupta@intel.com

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/display/intel_hdcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
> index db8dff2eeb0a..a0e7b0bf892b 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
> @@ -883,7 +883,7 @@ static int _intel_hdcp_disable(struct intel_connector *connector)
>  	 * until it disabled HDCP encryption for all connectors in MST topology.
>  	 */
>  	if (dig_port->num_hdcp_streams > 0)
> -		return ret;
> +		return 0;
>  
>  	hdcp->hdcp_encrypted = false;
>  	intel_de_write(dev_priv, HDCP_CONF(dev_priv, cpu_transcoder, port), 0);

-- 
Jani Nikula, Intel Open Source Graphics Center

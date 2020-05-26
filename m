Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01E81A7910
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 13:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438893AbgDNLES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 07:04:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:9916 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438877AbgDNLEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:04:01 -0400
IronPort-SDR: G87AT8iLcfYbBdzAQwiatCEFDe2HKn61HykUIbJmMTY7JbhckbMoIyMUi8lP1r+NUIjkscWGko
 qr4O7WRcKQcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:03:59 -0700
IronPort-SDR: xN6M04+6XoH3Nl0a+kETp45TvlkFOiB8Z1PLiDQ1H2p9QOt7JBpVVKHg2GSDLdNi1UnytuVl2H
 rE2ACbZErW7Q==
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="427024859"
Received: from mdoerbec-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:03:56 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Aurabindo Pillai <mail@aurabindo.in>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: dpcd: Print more useful information during error
In-Reply-To: <20200409195200.5483-1-mail@aurabindo.in>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200409195200.5483-1-mail@aurabindo.in>
Date:   Tue, 14 Apr 2020 14:03:53 +0300
Message-ID: <87o8rumiqu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Apr 2020, Aurabindo Pillai <mail@aurabindo.in> wrote:
> When DPCD access errors occur, knowing the register and request
> associated with the error helps debugging, so print the
> details in the debug message.
>
> Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index a5364b519..545606aac 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -257,7 +257,9 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux, u8 request,
>  			err = ret;
>  	}
>  
> -	DRM_DEBUG_KMS("Too many retries, giving up. First error: %d\n", err);
> +	DRM_DEBUG_KMS("dpcd: Too many retries, giving up. First error: %d\t"
> +		      "address: %x\trequest: %x\t size:%zu\n",
> +		      err, msg.address, msg.request, msg.size);

Nitpicks, please don't add tabs, maybe use commas instead, and please
add 0x in front of hex.

BR,
Jani.


>  	ret = err;
>  
>  unlock:

-- 
Jani Nikula, Intel Open Source Graphics Center

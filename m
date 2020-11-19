Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6432B8EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgKSJbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:31:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:12118 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgKSJbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:31:48 -0500
IronPort-SDR: /7CGtJds3aTlIV4it7FEkrNGihx8Wk/90bd84qvdmc7yBYtdj5zWMkD+KKe0dsN9Y8e29v8IUs
 VAZpANAPW1Hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159031872"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="159031872"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 01:31:47 -0800
IronPort-SDR: SBk6uKIf0HN15Trt8wcKcBy0DjcTVAn13vX0y9a6L9f8+j/4tXvtvmucJXlVb9jGtqifvdEit7
 ceOV+Kpi6j9w==
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="341630737"
Received: from bkeavene-mobl.ger.corp.intel.com (HELO localhost) ([10.251.83.118])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 01:31:46 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org, Kalle Valo <kvalo@codeaurora.org>,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 4/6] ath11k: make relay callbacks const
In-Reply-To: <20201118165320.26829-4-jani.nikula@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20201118165320.26829-1-jani.nikula@intel.com> <20201118165320.26829-4-jani.nikula@intel.com>
Date:   Thu, 19 Nov 2020 11:31:43 +0200
Message-ID: <871rgppu9s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020, Jani Nikula <jani.nikula@intel.com> wrote:
> Now that relay_open() accepts const callbacks, make relay callbacks
> const.
>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: ath11k@lists.infradead.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Kalle, thanks for the acks on the other two ath patches - can I have
your ack on this one too please?

BR,
Jani.

> ---
>  drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
> index ac2a8cfdc1c0..1afe67759659 100644
> --- a/drivers/net/wireless/ath/ath11k/spectral.c
> +++ b/drivers/net/wireless/ath/ath11k/spectral.c
> @@ -148,7 +148,7 @@ static int remove_buf_file_handler(struct dentry *dentry)
>  	return 0;
>  }
>  
> -static struct rchan_callbacks rfs_scan_cb = {
> +static const struct rchan_callbacks rfs_scan_cb = {
>  	.create_buf_file = create_buf_file_handler,
>  	.remove_buf_file = remove_buf_file_handler,
>  };

-- 
Jani Nikula, Intel Open Source Graphics Center

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584AF2D739D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393276AbgLKKLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:11:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:25115 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389094AbgLKKL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:11:27 -0500
IronPort-SDR: mXJdiqE18RTlPvPyN+jMpjPqIpBYVQgvvIcrLj88ROyc7TdkoD84NLIn07hO9Yl6ZDIgYQjmun
 +lyUGWHaEM/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="171845135"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="171845135"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 02:09:42 -0800
IronPort-SDR: 1lPGU/+yZedtJ4rAR+753scyFR+NhlvPw02xOi+HdAvKHZATcWiPI6r+6olWZ+Ni3v2niY/pfB
 zUFp4GKdOBkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="440813553"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Dec 2020 02:09:39 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 11 Dec 2020 12:09:39 +0200
Date:   Fri, 11 Dec 2020 12:09:39 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tcpm: Fix possible buffer overflows in tcpm_queue_vdm
Message-ID: <20201211100939.GJ1594451@kuha.fi.intel.com>
References: <20201209030716.3764-1-ruc_zhangxiaohui@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209030716.3764-1-ruc_zhangxiaohui@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 09, 2020 at 11:07:16AM +0800, Xiaohui Zhang wrote:
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> 
> tcpm_queue_vdm() calls memcpy() without checking the destination
> size may trigger a buffer overflower.

Thanks for the patch, but I didn't actually see any place where that
could happen. I think the idea is that the callers make sure the count
does not exceed VDO_MAX_SIZE before calling the function.

> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 55535c4f6..fcd331f33 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1045,7 +1045,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
>  
>  	port->vdo_count = cnt + 1;

That should have been fixed as well, no?

>  	port->vdo_data[0] = header;
> -	memcpy(&port->vdo_data[1], data, sizeof(u32) * cnt);
> +	memcpy(&port->vdo_data[1], data, min_t(int, sizeof(u32) * cnt, VDO_MAX_SIZE - 1));
>  	/* Set ready, vdm state machine will actually send */
>  	port->vdm_retries = 0;
>  	port->vdm_state = VDM_STATE_READY;

Unless I'm missing something, I don't think this patch is needed.

thanks,

-- 
heikki

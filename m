Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978B926A4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIOMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:12:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:6368 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgIOMLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:11:04 -0400
IronPort-SDR: Qd309NoT7XVGEoxy23M2w6keUCRC5XJf2wwDJqzZtCy/Y+LBKcXSWgx+mSIuhU3jqR1+xWC2Xi
 BOqTYzfbBwtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="177310737"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="177310737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 05:10:37 -0700
IronPort-SDR: OsnYeyUhjhLzj0rIh8hyArv47jMbnWdcGbZIqs9vv01Sm4EQYQ1Q83yFJhpgr4Z23MYvUBu/pg
 EydOQXOUh1KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="409182511"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 05:10:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 15:10:33 +0300
Date:   Tue, 15 Sep 2020 15:10:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/14] usb: typec: tcpci: Add register definitions to
 tcpci
Message-ID: <20200915121033.GB1139641@kuha.fi.intel.com>
References: <20200901025927.3596190-1-badhri@google.com>
 <20200901025927.3596190-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-2-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:14PM -0700, Badhri Jagan Sridharan wrote:
> Add register definitions to trap extended alerts.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Change history:
> - No code changes. Update version from v1 to v6 to avoid confusion
> ---
>  drivers/usb/typec/tcpm/tcpci.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 11c36d086c86..fd26ca35814c 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -16,6 +16,7 @@
>  #define TCPC_PD_INT_REV			0xa
>  
>  #define TCPC_ALERT			0x10
> +#define TCPC_ALERT_EXTENDED_STATUS	BIT(13)
>  #define TCPC_ALERT_VBUS_DISCNCT		BIT(11)
>  #define TCPC_ALERT_RX_BUF_OVF		BIT(10)
>  #define TCPC_ALERT_FAULT		BIT(9)
> @@ -32,6 +33,10 @@
>  #define TCPC_ALERT_MASK			0x12
>  #define TCPC_POWER_STATUS_MASK		0x14
>  #define TCPC_FAULT_STATUS_MASK		0x15
> +
> +#define TCPC_EXTENDED_STATUS_MASK		0x16
> +#define TCPC_EXTENDED_STATUS_MASK_VSAFE0V	BIT(0)
> +
>  #define TCPC_CONFIG_STD_OUTPUT		0x18
>  
>  #define TCPC_TCPC_CTRL			0x19
> -- 
> 2.28.0.402.g5ffc5be6b7-goog

-- 
heikki

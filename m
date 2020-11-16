Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511A42B3EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgKPI33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:29:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:43396 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbgKPI33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:29:29 -0500
IronPort-SDR: 2YHY0o7ecBVHR6ooseAXfg7aQpoyN8r0o5hwdCmOk1EEKanSVdy0a9vNqJf+UiZZaQYMUcKs9C
 CZU6eESZYXFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="234870221"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="234870221"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 00:29:27 -0800
IronPort-SDR: ODRF0kv+gdWqUeDMdgSOymqjdHmPsEyLkhukYWmwpZWu0iqWTKoJFfyI7TMIT6QRdnYQLlL5tk
 it/yg7m0HYRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="430101055"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Nov 2020 00:29:25 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 16 Nov 2020 10:29:24 +0200
Date:   Mon, 16 Nov 2020 10:29:24 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-usb@vger.kernel.org, Wesley Cheng <wcheng@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: fix builtin build errors
Message-ID: <20201116082924.GA3124021@kuha.fi.intel.com>
References: <20201116040653.7943-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116040653.7943-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 08:06:53PM -0800, Randy Dunlap wrote:
> Fix build errors when CONFIG_TYPEC_QCOM_PMIC=y and
> CONFIG_USB_ROLE_SWITCH=m by limiting the former to =m when
> USB_ROLE_SWITCH also =m.
> 
> powerpc64-linux-ld: drivers/usb/typec/qcom-pmic-typec.o: in function `.qcom_pmic_typec_remove':
> qcom-pmic-typec.c:(.text+0x28): undefined reference to `.usb_role_switch_set_role'
> powerpc64-linux-ld: qcom-pmic-typec.c:(.text+0x64): undefined reference to `.usb_role_switch_put'
> powerpc64-linux-ld: drivers/usb/typec/qcom-pmic-typec.o: in function `.qcom_pmic_typec_check_connection':
> qcom-pmic-typec.c:(.text+0x120): undefined reference to `.usb_role_switch_set_role'
> powerpc64-linux-ld: drivers/usb/typec/qcom-pmic-typec.o: in function `.qcom_pmic_typec_probe':
> qcom-pmic-typec.c:(.text+0x360): undefined reference to `.fwnode_usb_role_switch_get'
> powerpc64-linux-ld: qcom-pmic-typec.c:(.text+0x4e4): undefined reference to `.usb_role_switch_put'
> 
> Fixes: 6c8cf3695176 ("usb: typec: Add QCOM PMIC typec detection driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: linux-usb@vger.kernel.org
> Cc: Wesley Cheng <wcheng@codeaurora.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20201113.orig/drivers/usb/typec/Kconfig
> +++ linux-next-20201113/drivers/usb/typec/Kconfig
> @@ -88,6 +88,7 @@ config TYPEC_STUSB160X
>  config TYPEC_QCOM_PMIC
>  	tristate "Qualcomm PMIC USB Type-C driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
>  	help
>  	  Driver for supporting role switch over the Qualcomm PMIC.  This will
>  	  handle the USB Type-C role and orientation detection reported by the

-- 
heikki

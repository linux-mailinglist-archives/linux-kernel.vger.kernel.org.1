Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A118D2D779F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405857AbgLKORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:17:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:41044 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392467AbgLKORN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:17:13 -0500
IronPort-SDR: qq/4De6eCPqwrVfx8GPQkXuCpgpSzD4tLD8havXGCnDnj7wMURw3K3f7DdV49vgx+NaOlFE5fp
 qIDKEyHzwWHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="173669261"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="173669261"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 06:15:24 -0800
IronPort-SDR: ENbV8zVbC8ATmpe21dWVwIvKWHRJBscF/ML/5oqXEI44K2+fV5ZbuEzVPNkCnbxdh7SaJM4iNZ
 a2R3zwhMf6mw==
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="322078624"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 06:15:22 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1knjDc-00Dfqf-PO; Fri, 11 Dec 2020 16:16:24 +0200
Date:   Fri, 11 Dec 2020 16:16:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 2/2] usb: dwc3: drd: Avoid error when extcon is missing
Message-ID: <20201211141624.GQ4077@smile.fi.intel.com>
References: <20201210203318.6914-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210203318.6914-1-semen.protsenko@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 10:33:18PM +0200, Sam Protsenko wrote:
> If "port" node is missing in PHY controller node, dwc3_get_extcon()
> isn't able to find extcon device. This is perfectly fine in case when
> "usb-role-switch" or OTG is used, but next misleading error message is
> printed in that case, from of_graph_get_remote_node():
> 
>     OF: graph: no port node found in /phy@1234abcd
> 
> Avoid printing that message by checking if port node exists in PHY node
> before calling of_graph_get_remote_node().

By some reason you have two separate messages (missed --thread when run `git
format-patch ...`?).

In any case I think it should be dropped or reworked and resent since patch 1/2
got comments.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1C29E9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgJ2K72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:59:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:27642 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgJ2K72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:59:28 -0400
IronPort-SDR: iEf/sIv1jK0B/eD4LCUC+d48s0wglOtVIgNrWgJltDtl+e9sAWIKk5wCjAGKmsRayTOtMfIFZV
 Pfkh58VphJrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="167631625"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="167631625"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 03:59:27 -0700
IronPort-SDR: 8rh6fIhWGCbwV56nxh8h1x/wD0r6FYJkTodXPC+FjocBU48Is2iWTnkWqTaLdKtpIbmITlTig+
 3lPBvVe3dF3A==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="526693385"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 03:59:26 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kY5fR-001Bxe-8C; Thu, 29 Oct 2020 13:00:29 +0200
Date:   Thu, 29 Oct 2020 13:00:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary
 CONFIG_PM_SLEEP
Message-ID: <20201029110029.GF4077@smile.fi.intel.com>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
 <20201029100647.233361-3-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100647.233361-3-coiby.xu@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 06:06:41PM +0800, Coiby Xu wrote:
> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Have you compiled this with
	% make W=1 ...
?


-- 
With Best Regards,
Andy Shevchenko



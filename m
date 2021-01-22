Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA933002A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbhAVMPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:15:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:26516 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbhAVMJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:09:54 -0500
IronPort-SDR: ho7EAmygVlqnOux4ZV3QkebNh2pBt+6BONh7Cn/+GD8FZPcuti+GJZHYKj+xE75aXSPS7hVw5r
 Q+DTS6CJcmhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179579546"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="179579546"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 04:08:07 -0800
IronPort-SDR: iXPgJx1OZ5ovYxJQ6f8M3UpruduQ2IzcCxnjNbNgVHt2GXNhYheFqh2bdbI5mrFra74Z1Nr0zr
 ANO0N21cJOMw==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="385735981"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 04:08:06 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2vFU-008qWy-Vs; Fri, 22 Jan 2021 14:09:08 +0200
Date:   Fri, 22 Jan 2021 14:09:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] platform/x86: intel_mid_thermal: Remove driver for
 deprecated platform
Message-ID: <YArAZOdRrYQ8f5Md@smile.fi.intel.com>
References: <20210122114054.38597-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122114054.38597-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 01:40:54PM +0200, Andy Shevchenko wrote:
> Intel Moorestown and Medfield are quite old Intel Atom based
> 32-bit platforms, which were in limited use in some Android phones,
> tablets and consumer electronics more than eight years ago.
> 
> There are no bugs or problems ever reported outside from Intel
> for breaking any of that platforms for years. It seems no real
> users exists who run more or less fresh kernel on it. The commit
> 05f4434bc130 ("ASoC: Intel: remove mfld_machine") also in align
> with this theory.
> 
> Due to above and to reduce a burden of supporting outdated drivers
> we remove the support of outdated platforms completely.

Please, ignore this, I just resent with proper mailing list in Cc.

-- 
With Best Regards,
Andy Shevchenko



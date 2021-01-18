Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260A52F9D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbhARKyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:54:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:30051 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389900AbhARKbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:31:23 -0500
IronPort-SDR: KpueWlmMvT2P7ohDzA7rdyRRDl032Jku9YKuM3l3zUm6gah793s76PJR0zOs7chuuubONjkt64
 yVytXKWOTFFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="158559336"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="158559336"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:29:34 -0800
IronPort-SDR: c9Ey64+XYgB7XikYd471IbsmqWTdAYwKg5zRwLVza8Z7LtnRepepc5oATNgYozAo98YUhIwc6Q
 HbXtgwGXheHw==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="426095338"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:29:32 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l1Rnv-0020AD-Mq; Mon, 18 Jan 2021 12:30:35 +0200
Date:   Mon, 18 Jan 2021 12:30:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Alder Lake PCH-P PCI IDs
Message-ID: <20210118103035.GY4077@smile.fi.intel.com>
References: <20210105153925.62283-1-andriy.shevchenko@linux.intel.com>
 <20210114102220.GS3975472@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114102220.GS3975472@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:22:20AM +0000, Lee Jones wrote:
> On Tue, 05 Jan 2021, Andy Shevchenko wrote:
> 
> > Add Intel Alder Lake LPSS PCI IDs.

> Applied, thanks.

Thanks.

Any news about [1]?


[1]: https://lore.kernel.org/lkml/20201027104616.49098-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596842E6B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbgL1W4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:50776 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgL1ViL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 16:38:11 -0500
IronPort-SDR: DpXQ08AUaBP0nPloXEQJM4OrWWc7p9T+CpnT+0R1PgCTJaMOPGXcNfFaKB4GKlFG6Fd4GEB6+z
 00WbXSZA3mBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="261177501"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="261177501"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 13:36:25 -0800
IronPort-SDR: iZEPGPr0Jfh6GikNz6/zQvGFHaHYpGl2l9uHQ/1huiAmA26RZ0yu8+3WqvdKMEzygSqiEFp2f7
 sK3NOvClG84A==
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="395193024"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 13:36:24 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ku0Ck-000I8H-5q; Mon, 28 Dec 2020 23:37:26 +0200
Date:   Mon, 28 Dec 2020 23:37:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kernel.h: Drop unneeded <linux/kernel.h> inclusion
 from other headers
Message-ID: <20201228213726.GG4077@smile.fi.intel.com>
References: <20201028172826.41635-1-andriy.shevchenko@linux.intel.com>
 <20201030083356.GC32163@willie-the-truck>
 <20201030110606.GN4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030110606.GN4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 01:06:06PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 30, 2020 at 08:33:56AM +0000, Will Deacon wrote:
> > On Wed, Oct 28, 2020 at 07:28:26PM +0200, Andy Shevchenko wrote:
> > > There is no evidence we need kernel.h inclusion in certain headers.
> > 
> > Did you run some tools to determine this or is it just a hunch?
> 
> I read files manually. So, closer to the latter.
> Also I rely on 0day and other CIs that didn't show anything for a long time.

Will, any recommendation what should I run to be solid about this change?

-- 
With Best Regards,
Andy Shevchenko



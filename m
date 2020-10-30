Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CF52A03A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgJ3LFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:05:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:15632 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgJ3LFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:05:07 -0400
IronPort-SDR: E5q65g1MID9CJgPICc9srQgyLrg10Ql3BFixI8SR01kzhh3cQwKFQLjpFI5ynuGF7xMwRSR7dS
 jf+AjhM7R1LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="167808966"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="167808966"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 04:05:06 -0700
IronPort-SDR: 9HPa8KZmR9k+jNlkzOx5clj92bvp1fNLeHqq6OtAIAqs6cNlPtQOWe51CfdeVmU84JkP52BTpA
 VuqUZJ5cB+rA==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="351825189"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 04:05:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kYSEQ-001y1B-BZ; Fri, 30 Oct 2020 13:06:06 +0200
Date:   Fri, 30 Oct 2020 13:06:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kernel.h: Drop unneeded <linux/kernel.h> inclusion
 from other headers
Message-ID: <20201030110606.GN4077@smile.fi.intel.com>
References: <20201028172826.41635-1-andriy.shevchenko@linux.intel.com>
 <20201030083356.GC32163@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030083356.GC32163@willie-the-truck>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 08:33:56AM +0000, Will Deacon wrote:
> On Wed, Oct 28, 2020 at 07:28:26PM +0200, Andy Shevchenko wrote:
> > There is no evidence we need kernel.h inclusion in certain headers.
> 
> Did you run some tools to determine this or is it just a hunch?

I read files manually. So, closer to the latter.
Also I rely on 0day and other CIs that didn't show anything for a long time.

-- 
With Best Regards,
Andy Shevchenko



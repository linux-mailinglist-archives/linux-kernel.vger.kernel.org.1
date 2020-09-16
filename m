Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB8F26CC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgIPUjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:39:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:22452 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgIPRHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:07:41 -0400
IronPort-SDR: U5dl+/a40t9q3px383jKWAEof/5mHNna5bfYNd+wYSw3g8FSyPjiyG20kPk6/Q/eLq/4WGvpZl
 i+/vwuRQM50g==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="159573139"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="159573139"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 10:07:34 -0700
IronPort-SDR: rsMdceZP7IxqDZTTjfrm1J1b7P29IrVOZFj7S0TpUbmKpr7/qPzeu3IUSHgLa7oFYStdloWbzh
 qRsERdWkw3Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="336090675"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2020 10:07:31 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kIatz-00H8Ag-V9; Wed, 16 Sep 2020 20:07:27 +0300
Date:   Wed, 16 Sep 2020 20:07:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 0/5] irqdomain: clean up, add
 irq_domain_create_legacy()
Message-ID: <20200916170727.GE3956970@smile.fi.intel.com>
References: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 07:21:30PM +0300, Andy Shevchenko wrote:
> In order to make users OF independent provide irq_domain_create_legacy() API.
> Last patch is an example of such user. First three patches are little cleanups.
> 
> Since regmap patch is dependent to what is now in regmap tree, I suggest to
> create an immutable branch in IRQ domain tree and Mark can pull it and apply
> the last one.

Rafael, can you review this? It seems stuck supposedly b/c of no review tag
given.

> Andy Shevchenko (5):
>   irqdomain: Remove unused of_device_id forward declaration
>   irqdomain: Add forward declaration of fwnode_handle
>   irqdomain: Replace open coded of_node_to_fwnode()
>   irqdomain: Introduce irq_domain_create_legacy() API
>   regmap: irq: Convert to use fwnode directly
> 
>  Documentation/core-api/irq/irq-domain.rst |  6 ++++++
>  drivers/base/regmap/regmap-irq.c          | 11 +++++------
>  include/linux/irqdomain.h                 |  8 +++++++-
>  kernel/irq/irqdomain.c                    | 19 +++++++++++++++----
>  4 files changed, 33 insertions(+), 11 deletions(-)
> 
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3172AF6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgKKQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:47:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:30950 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgKKQrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:47:21 -0500
IronPort-SDR: SALwNfhBZNDenf591k52Ny+hSFwP3e0ROX0R5eMw0YzZKb4tmzXjTsNZzErmjBdcWOheFBmQUm
 wuE3Il2AHOFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="166665042"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="166665042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 08:47:17 -0800
IronPort-SDR: taSB7atfiX84dKZCdsTjr/r7vGfhWCmZDfH93ZmS/DNjCJnF6wlZKsXv04kLN0j4WPRxPLNXHe
 SHjl32LHBvQQ==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="473915011"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 08:47:14 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kctI8-005xVm-BE; Wed, 11 Nov 2020 18:48:16 +0200
Date:   Wed, 11 Nov 2020 18:48:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: core-api/printk-formats.rst: Clarify formatting
 {cpu,node}mask
Message-ID: <20201111164816.GN4077@smile.fi.intel.com>
References: <20201110144121.3278667-1-geert+renesas@glider.be>
 <20201111152933.GA1702@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111152933.GA1702@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 04:29:33PM +0100, Petr Mladek wrote:
> On Tue 2020-11-10 15:41:21, Geert Uytterhoeven wrote:
> > Clarify how to pass the field width for bitmaps, and mention the helper
> > macros that are available to ease printing cpumask and nodemask.

...

> 	%*pb	0779
> 	%*pbl	0,3-6,8-10
> 
> For printing bitmap and its derivatives such as cpumask and nodemask.
> 
> It takes two arguments, see '*'. The first argument defines the number
> of bits in the mask. The second argument points to the mask.
> 
> %*pb outputs the bitmap as a hex number. If the size is bigger than 32-bit
> then 32-bit values are separated by a comma.
> 
> %*pbl outputs the bitmap as a range list.
> 
> The number of bits is passed by value. The mask is passed by reference.

It can be improved at least by replacing mask with bitmap here.

> Helper macros cpumask_pr_args() and nodemask_pr_args() are available to
> ease printing cpumask and nodemask.

-- 
With Best Regards,
Andy Shevchenko



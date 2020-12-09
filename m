Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30A42D421D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbgLIMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:24:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:41156 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbgLIMYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:24:47 -0500
IronPort-SDR: /hm7pLe9roI3mQCjH9AxYKUiEyg93XY+nlZbkVNEmMUZCEj0hRe7T9CF2VqF4fUey/0xgomWv5
 n+M/PR6VmMjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="170556673"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="170556673"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 04:22:59 -0800
IronPort-SDR: uroOlH1bg3Kw0cM7ge8dTtT0zTVnJSQVxPirVieEL43d7FsX+/bJkLoTaidZ2psnuvynQZfS67
 fkRpQLnlm7Ww==
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="483988158"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 04:22:57 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kmyVj-00D7B8-Db; Wed, 09 Dec 2020 14:23:59 +0200
Date:   Wed, 9 Dec 2020 14:23:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Seungil Kang <sil.kang@samsung.com>
Cc:     bhe@redhat.com, mingo@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, herbert@gondor.apana.org.au,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/cmdline: prevent unintented access to address
Message-ID: <20201209122359.GR4077@smile.fi.intel.com>
References: <CGME20200813030810epcas1p39ad56c069ab4fa41312f91f994c17cac@epcas1p3.samsung.com>
 <20200813030741.6896-1-sil.kang@samsung.com>
 <20200813140009.GX1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813140009.GX1891694@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:00:09PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 13, 2020 at 12:07:41PM +0900, Seungil Kang wrote:

> And your test case / module would help a lot, if present.

Just a heads up: I have created a cmdline_kunit.c to test functions
in the module (currently only get_option() test cases are there).
It's in Andrew's quilt, pending for v5.11-rc1.
Feel free to extend it along with amended fix (as per my comments).

-- 
With Best Regards,
Andy Shevchenko



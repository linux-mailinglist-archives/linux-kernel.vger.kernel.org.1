Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59BF3008CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbhAVQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:39:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:62989 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbhAVQcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:32:03 -0500
IronPort-SDR: KCUmIOMReC+jxMN/6Ob3Q3l1ViBrdLxpdzXdAbJUR4ef6lt9ASQYcm0bszPG2lGrIbk/PgMm5Q
 wNdZ4AuYYV5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="179549323"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="179549323"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 08:30:03 -0800
IronPort-SDR: CK80DJc6gXQWhoKGwkQHTBlkKKIE7qUeRUwU1+P6Rpznk6MmGkSJsMUB9YKZ9987CNrYPM5NVx
 ujEZxDg3BMig==
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="351995235"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 08:29:59 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2zKv-0097fs-Ap; Fri, 22 Jan 2021 18:31:01 +0200
Date:   Fri, 22 Jan 2021 18:31:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wesley Zhao <zhaowei1102@thundersoft.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org, david@redhat.com,
        dan.j.williams@intel.com, guohanjun@huawei.com,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH v3 2/2] resource: Make it possible to reserve memory on
 64bit platform
Message-ID: <YAr9xaQM3LTU8vfS@smile.fi.intel.com>
References: <1611330937-22654-1-git-send-email-zhaowei1102@thundersoft.com>
 <1611330937-22654-3-git-send-email-zhaowei1102@thundersoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611330937-22654-3-git-send-email-zhaowei1102@thundersoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 07:55:37AM -0800, Wesley Zhao wrote:
> For now "reserve=" is limitied to 32bit,not available on 64bit
> platform,so we change the get_option() to get_option_ull(added in
> patch: commit 4b6bfe96265e ("lib/cmdline: add new function
> get_option_ull()"))

Do better grammar and punctuation.

"For now "reserve=" is limited to 32bit, and not available on 64bit platform,
so we change the get_option() to get_option_ull() which is added in the
previous patch."

But!

You don't need to alter cmdline.c at all, see memparse() for the details!
And you have been told already, look at other options. You failed to mentioned
in the cover letter what's wrong with recommended memmap= approach.

-- 
With Best Regards,
Andy Shevchenko



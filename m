Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EDF3008B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbhAVQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:29:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:38826 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbhAVQ2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:28:19 -0500
IronPort-SDR: BHxn+521Zyr6hNjsEphB5N4djKH5GH91e36amYMsXm1PWaYTkPjqVpg0C0RRiRU7Dg/yKZ4YFT
 2tJqG+LRgwsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="159243618"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="159243618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 08:26:29 -0800
IronPort-SDR: UE6mXMN14lyt73Fh7qMWtKQ5itvTlLnKs41V8EwuFRkNyNZ1QOrhRTiXkRit9cVWL+Q9Iyozns
 J+LsfMBJDR3A==
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="385814158"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 08:26:24 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2zHS-0097SR-J6; Fri, 22 Jan 2021 18:27:26 +0200
Date:   Fri, 22 Jan 2021 18:27:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wesley Zhao <zhaowei1102@thundersoft.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org, david@redhat.com,
        dan.j.williams@intel.com, guohanjun@huawei.com,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH v3 1/2] lib/cmdline: add new function get_option_ull()
Message-ID: <YAr87vy45jbdcbRG@smile.fi.intel.com>
References: <1611330937-22654-1-git-send-email-zhaowei1102@thundersoft.com>
 <1611330937-22654-2-git-send-email-zhaowei1102@thundersoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611330937-22654-2-git-send-email-zhaowei1102@thundersoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 07:55:36AM -0800, Wesley Zhao wrote:
> In the future we would pass the unsigned long long parameter
> like(0x123456781234) in cmdline on the 64bit platform, so add a new
> option parse function get_option_ull()

You missed period at the end of phrase.

Overall this patch is not needed at all.

-- 
With Best Regards,
Andy Shevchenko



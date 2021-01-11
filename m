Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8762F1C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389172AbhAKRXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:23:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:60906 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbhAKRXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:23:48 -0500
IronPort-SDR: 4dlW9V7LchdIn+n3PFs7CLJihQkyFyA1wFu4F4qMAh1HjQXjv50YPUM2ZGgle69N6Dq3t92Se3
 UxR1q/f4F9pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="239442366"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="239442366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 09:22:02 -0800
IronPort-SDR: l1FN9CGAIBj9AKm0LfXGp4swwYdk9Sf37EFVlbesGyrMPFP+xDQI0FD5b+/1NEAExSdjdcnUzg
 u7edYXBHIE7Q==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="567241173"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 09:21:58 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kz0uB-00AZJR-Hu; Mon, 11 Jan 2021 19:22:59 +0200
Date:   Mon, 11 Jan 2021 19:22:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wesley Zhao <zhaowei1102@thundersoft.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org, david@redhat.com,
        dan.j.williams@intel.com, guohanjun@huawei.com,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH 1/2] lib/cmdline: add new function get_option_ull()
Message-ID: <20210111172259.GZ4077@smile.fi.intel.com>
References: <1610382798-4528-1-git-send-email-zhaowei1102@thundersoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610382798-4528-1-git-send-email-zhaowei1102@thundersoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 08:33:17AM -0800, Wesley Zhao wrote:
> From: "Wesley.Zhao" <zhaowei1102@thundersoft.com>
> 
> In the future we would pass the unsigned long long parameter
> like(0x123456781234) in cmdline on the 64bit platform, so add a new
> option parse function get_option_ull()

No negative numbers?
No test cases?
No user?

Please, address above.

Besides that, consider to deduplicate (like it's done in simple_strto*() family
of functions), so we don't have two implementation that are basically do the
same, only put result to a different type of variable.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA942F1D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390006AbhAKSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:04:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:46986 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732662AbhAKSER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:04:17 -0500
IronPort-SDR: L/PK1lEysOxWy3Je7h3f7XoiqThdFS2zVyNT063Anqr/nnGLnzIZv5pJB0QmmURJkw6Z6dATTk
 G654m+rze8Og==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="241979838"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="241979838"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 10:02:35 -0800
IronPort-SDR: XblZdyhjd3YcEM3BdLRK0SaTyZ0a2F9wI7GUUbOao+NVCpiHAADVdjB8vwkzZy5/8FXsgmuyAq
 YK/zEtAKB5pA==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="388920930"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 10:02:28 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kz1XO-00Abfy-3n; Mon, 11 Jan 2021 20:03:30 +0200
Date:   Mon, 11 Jan 2021 20:03:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wesley Zhao <zhaowei1102@thundersoft.com>,
        akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        guohanjun@huawei.com, mchehab+huawei@kernel.org
Subject: Re: [PATCH 2/2] resource: Make it possible to reserve memory on
 64bit platform
Message-ID: <20210111180330.GA4077@smile.fi.intel.com>
References: <1610382798-4528-1-git-send-email-zhaowei1102@thundersoft.com>
 <1610382798-4528-2-git-send-email-zhaowei1102@thundersoft.com>
 <0043f2fe-d936-0db6-7b12-25a5026cb106@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0043f2fe-d936-0db6-7b12-25a5026cb106@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:24:35PM +0100, David Hildenbrand wrote:
> On 11.01.21 17:33, Wesley Zhao wrote:
> > From: "Wesley.Zhao" <zhaowei1102@thundersoft.com>
> > 
> > For now "reserve=" is limitied to 32bit,not available on 64bit
> > platform,so we change the get_option() to get_option_ull(added in
> > patch: commit 4b6bfe96265e ("lib/cmdline: add new function
> > get_option_ull()"))
> 
> Curious, what's the target use case? (did not receive a cover letter,
> maybe it's buried in there)


Oh, I didn't received neither cover letter nor patch 2!

To author: please, address comments to patch 1 along with (re)sending cover
letter and include every stakeholder to the entire series.

-- 
With Best Regards,
Andy Shevchenko



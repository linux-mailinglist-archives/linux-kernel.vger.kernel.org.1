Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C62A036E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgJ3K4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:56:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:15924 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgJ3K4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:56:06 -0400
IronPort-SDR: LwHVUYN1C0iCbJfqPRGJxmbUQcrIpY8EZIDyKDlz5UEQ5/UAMhNzOttAfjEOwz7X3Qy2bxet8n
 hNJ5B5FOjhAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="148445230"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="148445230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 03:56:05 -0700
IronPort-SDR: nS9L64s7t5R4vQpINI5Y5ZhzpletvmYNGNqKG8H66PMWwQiDlUL+FeCPDG7Iip7R0hK5QDaj14
 JULuPfzHQjyA==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="351823148"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 03:56:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kYS5i-001xiM-VN; Fri, 30 Oct 2020 12:57:06 +0200
Date:   Fri, 30 Oct 2020 12:57:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] devres: zero the memory in devm_krealloc() if needed
Message-ID: <20201030105706.GK4077@smile.fi.intel.com>
References: <20201026122728.8522-1-brgl@bgdev.pl>
 <20201026131427.GF4077@smile.fi.intel.com>
 <CAMRc=MfuejMqpcfOedPMMTR3EY6s2K+4whoWyk7RmJYPaB176w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfuejMqpcfOedPMMTR3EY6s2K+4whoWyk7RmJYPaB176w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:03:50AM +0100, Bartosz Golaszewski wrote:
> On Thu, Oct 29, 2020 at 9:05 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Oct 26, 2020 at 01:27:28PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > If we're returning the same pointer (when new size is smaller or equal
> > > to the old size) we need to check if the user wants the memory zeroed
> > > and memset() it manually if so.
> >
> > Any use case? Because to me it sounds contradictory to the whole idea of [k]realloc().
> 
> This is kind of a gray area in original krealloc() too and I want to
> submit a patch for mm too. Right now krealloc ignores the __GFP_ZERO
> flag if new_size <= old_size but zeroes the memory if new_size >
> old_size.

> This should be consistent - either ignore __GFP_ZERO or
> don't ignore it in both cases. I think that not ignoring it is better
> - if user passes it then it's for a reason.

Sorry, but I consider in these two choices the best is the former one, i.e.
ignoring, because non-ignoring for sizes less than current is counter the
REalloc() by definition.

Reading realloc(3):

"If the new size is larger than the old size, the added memory will not be
initialized."

So, supports my choice over yours.

-- 
With Best Regards,
Andy Shevchenko



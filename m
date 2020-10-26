Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F429F5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgJ2UFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:05:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:56816 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ2UFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:05:37 -0400
IronPort-SDR: 3lIDUOhAjlIu+l2RhGFhiAjpjkuE4ObmUz4Fpuo4bAhM6jEBygZ6dfRCDtqyFx9ZrOjfP97noh
 d9hZztxaivmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156277426"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="156277426"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:05:36 -0700
IronPort-SDR: qTYwAZ6BG2b7vt/5azhvXjAYOh+vwOxZJ/y7lNX2/1lNLSD/jPTfPWnHI3p3LxEf/sXkDNuEjp
 tcfKINEi/0Uw==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="469262735"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:05:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kYEBy-001UIn-Ew; Thu, 29 Oct 2020 22:06:38 +0200
Date:   Mon, 26 Oct 2020 15:14:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] devres: zero the memory in devm_krealloc() if needed
Message-ID: <20201026131427.GF4077@smile.fi.intel.com>
References: <20201026122728.8522-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026122728.8522-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:27:28PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> If we're returning the same pointer (when new size is smaller or equal
> to the old size) we need to check if the user wants the memory zeroed
> and memset() it manually if so.

Any use case? Because to me it sounds contradictory to the whole idea of [k]realloc().

-- 
With Best Regards,
Andy Shevchenko



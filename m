Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361BA2D41A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgLIMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:01:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:21130 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbgLIMBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:01:38 -0500
IronPort-SDR: gVB6MMZq/aCbJq+SDrL5b6yMcGtUv8+2R/uX5vXPISCWcxntB8t2gcdxk+zTRk2tMjZx7aozf3
 ar6fpqMG2+Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="173305392"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="173305392"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 03:59:53 -0800
IronPort-SDR: su39dgwfD8KZEwyVDLAAqkgSfNXavP7Mr6sCp158d+QCmOgHo1sleTLvHREWE2Y6wNbmrehWgi
 3MRHIHG7SJDw==
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="364105280"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 03:59:52 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kmy9O-00D6uG-Ip; Wed, 09 Dec 2020 14:00:54 +0200
Date:   Wed, 9 Dec 2020 14:00:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scripts: switch explicitly to Python 3
Message-ID: <20201209120054.GQ4077@smile.fi.intel.com>
References: <20201209115017.64452-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209115017.64452-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 01:50:17PM +0200, Andy Shevchenko wrote:
> Some distributions are about to switch to Python 3 support only.
> This means that /usr/bin/python, which is Python 2, is not available
> anymore. Hence, switch scripts to use Python 3 explicitly.

Note, I converted only ones I have tested.

-- 
With Best Regards,
Andy Shevchenko



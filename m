Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115F12D4C25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgLIUqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:46:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:21847 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgLIUqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:46:31 -0500
IronPort-SDR: kOEPfRzuy2a23DCHxC5bM1Ae/jys6uY0mv4yX92RJpnWfmeZU8GFqZgxVbuNHzgO1SshLYmjA7
 uGcrJCUADHIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="170637793"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="170637793"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 12:44:45 -0800
IronPort-SDR: 9wOq4qDLWk/7gm9GP+ks1dCbv3KkWNDBLSyp58EJvtE6E+XE+m0laqy5GpddL+T5qvIkdtVRAS
 uAQbpfc6IVoQ==
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="364302740"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 12:44:44 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kn6LK-00DEEV-Dd; Wed, 09 Dec 2020 22:45:46 +0200
Date:   Wed, 9 Dec 2020 22:45:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scripts: switch explicitly to Python 3
Message-ID: <20201209204546.GW4077@smile.fi.intel.com>
References: <20201209115017.64452-1-andriy.shevchenko@linux.intel.com>
 <20201209201115.GA29040@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209201115.GA29040@duo.ucw.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 09:11:15PM +0100, Pavel Machek wrote:

> > Some distributions are about to switch to Python 3 support only.
> > This means that /usr/bin/python, which is Python 2, is not available
> > anymore. Hence, switch scripts to use Python 3 explicitly.
> 
> Should python be mentioned in Documentation/process/changes.rst ?

Dunno. There is even no Scripts section.

Anyway it's not part of this patch since we have half of the Python scripts
explicitly mentioned Python 3.


-- 
With Best Regards,
Andy Shevchenko



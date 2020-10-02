Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFC281AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbgJBSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:13:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:13505 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:13:40 -0400
IronPort-SDR: uNlKQPiu3XFayxxg1r46oUUSpU8JimzfwK7/e+fJxkgDQdf2nNuceys53nMPmzFcJAfvIZV1oa
 OTekc8lHrFng==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="142438986"
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="142438986"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 11:13:13 -0700
IronPort-SDR: sqBVUTZY/QMV4+DTdD+AaFtzRWUyVljfVSB8nPqZaakwZyUhBkyuCcDP1rHYzY2QajlOBmYmow
 m2kgkEyo2fvw==
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="385932222"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 11:13:10 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kOPYG-003nRj-P4; Fri, 02 Oct 2020 21:13:04 +0300
Date:   Fri, 2 Oct 2020 21:13:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rtanwar@maxlinear.com
Subject: Re: [PATCH v4 2/2] Add hardware monitoring driver for Moortec
 MR75203 PVT controller
Message-ID: <20201002181304.GJ3956970@smile.fi.intel.com>
References: <cover.1601621983.git.rahul.tanwar@linux.intel.com>
 <e8c462ffc826d06c108aac45f8476083097cfa55.1601621983.git.rahul.tanwar@linux.intel.com>
 <20201002181135.GI3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002181135.GI3956970@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:11:35PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2020 at 03:04:27PM +0800, Rahul Tanwar wrote:

...

> > +	case hwmon_in:
> > +		if (attr == hwmon_in_input)
> > +			return 0444;
> 
> > +		return 0;
> 
> > +	default:
> 
> > +		return 0;
> 
> break here and
> 
> > +	}
> 
> return 0; here only once.

This probably makes little sense.

-- 
With Best Regards,
Andy Shevchenko



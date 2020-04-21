Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A381B272B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 15:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgDUNJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 09:09:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:58478 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUNJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:09:37 -0400
IronPort-SDR: oosi3E3634hHsZHi8z/vFLjsby45djHgagM4cDOV3aDQYzbJDUGHo2xpk1XbHNZ9pxtnCrmb8G
 mjqUvN/rG95A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 06:09:36 -0700
IronPort-SDR: acKb8OD+LMUMZTDPA3EOUvGm41mdtIMgLoXRODLSigAqG5MOGEymEs7QDdfqIrrNTiuaxI45yP
 qzFEKZBUVMzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="290450642"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2020 06:09:35 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jQseg-002FAB-1y; Tue, 21 Apr 2020 16:09:38 +0300
Date:   Tue, 21 Apr 2020 16:09:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/3] ARM: bcm2835: Switch to use %ptT
Message-ID: <20200421130938.GN185537@smile.fi.intel.com>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415170046.33374-3-andriy.shevchenko@linux.intel.com>
 <20200416025358.GC30641@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416025358.GC30641@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:53:58AM +0900, Sergey Senozhatsky wrote:
> On (20/04/15 20:00), Andy Shevchenko wrote:
> [..]
> > diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> > index da26a584dca0..a3e85186f8e6 100644
> > --- a/drivers/firmware/raspberrypi.c
> > +++ b/drivers/firmware/raspberrypi.c
> > @@ -182,16 +182,10 @@ rpi_firmware_print_firmware_revision(struct rpi_firmware *fw)
> >  					RPI_FIRMWARE_GET_FIRMWARE_REVISION,
> >  					&packet, sizeof(packet));
> >  
> > -	if (ret == 0) {
> > -		struct tm tm;
> > -
> > -		time64_to_tm(packet, 0, &tm);
> > +	if (ret)
> > +		return;
> >  
> > -		dev_info(fw->cl.dev,
> > -			 "Attached to firmware from %04ld-%02d-%02d %02d:%02d\n",
> > -			 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> > -			 tm.tm_hour, tm.tm_min);
> > -	}
> > +	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n", &packet);
> >  }
> 
> So can this be instead:
> 
> 	struct rtc_time tm;
> 
> 	rtc_time64_to_tm(time, &tm);
> 	dev_info(.... "%ptR", &tm);
> 
> ?
> 
> If it can, then I'd probably say something like "can we then just use
> rtc_time64_to_tm()"?

Same comment as per previous patch (TL;DR: no, it can't).

-- 
With Best Regards,
Andy Shevchenko



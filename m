Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBA528075B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbgJATC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:02:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:7595 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbgJATC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:02:58 -0400
IronPort-SDR: PeV/f5p4683qYcXcxh5DC8YOoPbcYDxF600Dok6k5H13VNNFml3zwYP3cgdASTdM3D/wws3MwG
 e/Eayr+OSr4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="180964063"
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="180964063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:02:49 -0700
IronPort-SDR: C9NctXOT66oclyLtKprSyoxrfyEYPwcBuZazqsTcebjyTpRQ1tcQEwx0eyO2lk1BmkLK3lBmx1
 8/z9ucqKQY7A==
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="313189207"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:02:48 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id C10D46369;
        Thu,  1 Oct 2020 12:02:48 -0700 (PDT)
Date:   Thu, 1 Oct 2020 12:02:48 -0700
From:   mark gross <mgross@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: Re: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Message-ID: <20201001190248.GB25055@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200929025521.59573-1-divya.bharathi@dell.com>
 <20200930002319.GI19084@mtg-dev.jf.intel.com>
 <DM6PR19MB2636FB3D94EBA95B7CE0DE54FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB2636FB3D94EBA95B7CE0DE54FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 09:02:38PM +0000, Limonciello, Mario wrote:
> > > +		possible_values:	A file that can be read to obtain the possible
> > > +					values of the <attr>. Values are separated using
> > > +					semi-colon (``;``).
> > why not use set notation from math classes assuming intergers?  i.e.
> > (a, b)  all integers beween a and b but not including a or b (open set)
> > or
> > [a, b] all integerger betwen a and b including and b?  (closed set)
> > 
> > Anyway its ambiguous if the the extremes are included in the set of possible
> > values as written.
> > 
> 
> Enumeration attributes mean that there are fixed values, specifically not integers.
> Integers are in the "integer" type and explained below.
> 
> An example value that would be seen here is possible_values:
> 
> Enabled;Disabled;
I'm ok with this

> 
> > > +
> > > +	security_area_size = calculate_security_buffer();
> > > +	buffer_size = security_area_size + integer_area_size;
> > > +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> > > +	if (!buffer)
> > > +		return -ENOMEM;
> > if you hit this error return I think you will leak the wmi_priv.mutex lock.
> > I think this is a bug.
> 
> Yes, thanks this is a great finding.
> Team will fix in v6 after we have Hans' feedback for v5.
Yay! It makes me feel useful to catch stuff like this.

thanks!

--mark

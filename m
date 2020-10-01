Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FEE280768
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbgJATFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:05:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:39557 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgJATFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:05:01 -0400
IronPort-SDR: EqynEkvofLb+eFbncaaHxvBwWSgsm+g+pMvXK6U8ATyzuhUeZ5s20Va4O7VAPUtjoQ6u04BWnP
 vcSYwvOt+qZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="150448492"
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="150448492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:04:58 -0700
IronPort-SDR: rEn4SKQb/Ibvs+CtetDaB/Vp5zFSx7cc+mDkQ3KcU0LzyIfgMGCcWRAERwqk4B7R+BHjriNqZI
 U44dk2k5YpvQ==
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="385641450"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:04:58 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 9D16A6369;
        Thu,  1 Oct 2020 12:04:58 -0700 (PDT)
Date:   Thu, 1 Oct 2020 12:04:58 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: Re: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Message-ID: <20201001190458.GC25055@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200929025521.59573-1-divya.bharathi@dell.com>
 <20200930002319.GI19084@mtg-dev.jf.intel.com>
 <DM6PR19MB2636FB3D94EBA95B7CE0DE54FA330@DM6PR19MB2636.namprd19.prod.outlook.com>
 <42f8e710-38f7-6f80-9f4a-af68cd376538@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f8e710-38f7-6f80-9f4a-af68cd376538@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 11:26:36AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/30/20 11:02 PM, Limonciello, Mario wrote:
> > > > +		possible_values:	A file that can be read to obtain the possible
> > > > +					values of the <attr>. Values are separated using
> > > > +					semi-colon (``;``).
> > > why not use set notation from math classes assuming intergers?  i.e.
> > > (a, b)  all integers beween a and b but not including a or b (open set)
> > > or
> > > [a, b] all integerger betwen a and b including and b?  (closed set)
> > > 
> > > Anyway its ambiguous if the the extremes are included in the set of possible
> > > values as written.
> > > 
> > 
> > Enumeration attributes mean that there are fixed values, specifically not integers.
> > Integers are in the "integer" type and explained below.
> > 
> > An example value that would be seen here is possible_values:
> > 
> > Enabled;Disabled;
> 
> That might not be the best example, because in that case arguably we
> could export it as a boolean type (except that the WMI interface does
> not give us boolean as an explicit / separate type).
> 
> Mark these enum attributes are really like enums in C, so we
> have a fixed set of possible values which are described by
> strings, since using integers for it makes no sense from a human
> interaction pov. E.g. on the Lenovo X1C8 I have some attributes
> have the following possible value sets:
> 
>                 Package (0x03)
>                 {
>                     "High",
>                     "Normal",
>                     "Silent"
>                 },
> 
>                 Package (0x02)
>                 {
>                     "LCD",
>                     "ExternalDisplay"
>                 },
> 
>                 Package (0x02)
>                 {
>                     "Independent",
>                     "Synchronized"
>                 },
> 
> I hope this helps clarify things.
It does.  Please ignore my comment on this topic then.

thanks

--mark


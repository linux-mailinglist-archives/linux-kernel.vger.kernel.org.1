Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3CA2F4A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbhAMLns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:43:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:54283 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbhAMLns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:43:48 -0500
IronPort-SDR: 4sYI6T95gmciGQQHKPTn+iu4lXpgLVz/L3bHXFx3WXauukZin+YW65wAgStu4m+T7OooBhO6g+
 RWNxB1jUchsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="262976766"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="262976766"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:42:02 -0800
IronPort-SDR: QyHb0+wwyfDdew1SXTqz91m2ex8U1IjNi1xHHRntQ4ZrQYP3a1/pSI8B2mMTt0/p9utxTewVQx
 YgCq3UHfxRvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="464881382"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Jan 2021 03:41:59 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Jan 2021 13:41:59 +0200
Date:   Wed, 13 Jan 2021 13:41:59 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, hdegoede@redhat.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] AMS, Collision Avoidance, and Protocol Error
Message-ID: <20210113114159.GA2623935@kuha.fi.intel.com>
References: <20210105163927.1376770-1-kyletso@google.com>
 <X/2N1LAgNRCSkWrw@kroah.com>
 <20210112115913.GB2020859@kuha.fi.intel.com>
 <0fb8c97e-e071-0fd2-c235-8b9609604a9e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb8c97e-e071-0fd2-c235-8b9609604a9e@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 06:09:28AM -0800, Guenter Roeck wrote:
> On 1/12/21 3:59 AM, Heikki Krogerus wrote:
> > On Tue, Jan 12, 2021 at 12:53:56PM +0100, Greg KH wrote:
> >> On Wed, Jan 06, 2021 at 12:39:24AM +0800, Kyle Tso wrote:
> >>> This series include previous patch "[v4] AMS and Collision Avoidance"
> >>> https://lore.kernel.org/r/20201217030632.903718-1-kyletso@google.com
> >>> and two more patches "Protocol Error handling" and "Respond Wait if...".
> >>>
> >>> The patch "AMS and Collision Avoidance" in [v5] is the same as the one
> >>> in [v4] (only rebased to ToT).
> >>>
> >>> The patch "Protocol Error handling" is based on PD3 6.8.1 to fix the
> >>> wrong handling.
> >>>
> >>> The patch "Respond Wait if..." is to fix a conflict when 
> >>> DR/PR/VCONN_SWAP occurs just after the state machine enters Ready State.
> >>>
> >>> Kyle Tso (3):
> >>>   usb: typec: tcpm: AMS and Collision Avoidance
> >>>   usb: typec: tcpm: Protocol Error handling
> >>>   usb: typec: tcpm: Respond Wait if VDM state machine is running
> >>>
> >>>  drivers/usb/typec/tcpm/tcpm.c | 925 +++++++++++++++++++++++++++++-----
> >>>  include/linux/usb/pd.h        |   2 +
> >>>  include/linux/usb/tcpm.h      |   4 +
> >>>  3 files changed, 792 insertions(+), 139 deletions(-)
> >>
> >> Heikki, any thoughts about this series?
> > 
> > Sorry, I did yet go over these yet. I'll review them now.
> > 
> > Guenter, have you had time to take a look at these?
> > 
> 
> Not yet. I have been been buried lately :-(

No worries. It looks like there are now plenty of guys reviewing this.

Br,

-- 
heikki

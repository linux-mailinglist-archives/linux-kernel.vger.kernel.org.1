Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35712F2E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbhALMBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:01:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:27173 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731606AbhALMBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:01:03 -0500
IronPort-SDR: R/Hl1yEXs06u8FO2u11+i7xFSkqjrAEerYLey0NYhTi6FZibc4D3H+i1iMXMFt76EVpW8CJ7Qv
 A6FE5QMtIh+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157205902"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="157205902"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 03:59:17 -0800
IronPort-SDR: ypKEomEnaAKcpXlhn1tv5Fdigz/K/gyvkGrARNw2AOh1KfWq312h42F8Z2FGOH+PvOm8J4VL9G
 7DMZn0X3wWhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="464500260"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 12 Jan 2021 03:59:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Jan 2021 13:59:13 +0200
Date:   Tue, 12 Jan 2021 13:59:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Kyle Tso <kyletso@google.com>, hdegoede@redhat.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] AMS, Collision Avoidance, and Protocol Error
Message-ID: <20210112115913.GB2020859@kuha.fi.intel.com>
References: <20210105163927.1376770-1-kyletso@google.com>
 <X/2N1LAgNRCSkWrw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/2N1LAgNRCSkWrw@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:53:56PM +0100, Greg KH wrote:
> On Wed, Jan 06, 2021 at 12:39:24AM +0800, Kyle Tso wrote:
> > This series include previous patch "[v4] AMS and Collision Avoidance"
> > https://lore.kernel.org/r/20201217030632.903718-1-kyletso@google.com
> > and two more patches "Protocol Error handling" and "Respond Wait if...".
> > 
> > The patch "AMS and Collision Avoidance" in [v5] is the same as the one
> > in [v4] (only rebased to ToT).
> > 
> > The patch "Protocol Error handling" is based on PD3 6.8.1 to fix the
> > wrong handling.
> > 
> > The patch "Respond Wait if..." is to fix a conflict when 
> > DR/PR/VCONN_SWAP occurs just after the state machine enters Ready State.
> > 
> > Kyle Tso (3):
> >   usb: typec: tcpm: AMS and Collision Avoidance
> >   usb: typec: tcpm: Protocol Error handling
> >   usb: typec: tcpm: Respond Wait if VDM state machine is running
> > 
> >  drivers/usb/typec/tcpm/tcpm.c | 925 +++++++++++++++++++++++++++++-----
> >  include/linux/usb/pd.h        |   2 +
> >  include/linux/usb/tcpm.h      |   4 +
> >  3 files changed, 792 insertions(+), 139 deletions(-)
> 
> Heikki, any thoughts about this series?

Sorry, I did yet go over these yet. I'll review them now.

Guenter, have you had time to take a look at these?

Br,

-- 
heikki

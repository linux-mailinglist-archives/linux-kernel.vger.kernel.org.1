Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DDF2FE414
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbhAUHgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:36:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:49573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbhAUHco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:32:44 -0500
IronPort-SDR: Gl3TPYjD9nEoGTgXA6WQEnpmlfFGZAtkkHqxUqufkAI7bXWwFvOhjA9k5QHaQbVCrXKkTDXNMb
 rDrIOXctY45Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166328010"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="166328010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 23:30:49 -0800
IronPort-SDR: AOG4XXvWQN48550IygiL41XaMpoVpth4b1yFQHG8pcb02wp/T2mxes6VXVLrycUwlpNzuZb9NZ
 Dz/CnKUQ9nqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="467367000"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 Jan 2021 23:30:31 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Jan 2021 09:30:30 +0200
Date:   Thu, 21 Jan 2021 09:30:30 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Kyle Tso <kyletso@google.com>,
        linux@roeck-us.net, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] AMS, Collision Avoidance, and Protocol Error
Message-ID: <20210121073030.GA423216@kuha.fi.intel.com>
References: <20210114145053.1952756-1-kyletso@google.com>
 <2211ad43-b76c-fbe9-2cc8-bb40c4ee4e89@redhat.com>
 <YAhlrxRdURu0djbf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAhlrxRdURu0djbf@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 06:17:35PM +0100, Greg KH wrote:
> On Wed, Jan 20, 2021 at 02:45:02PM +0100, Hans de Goede wrote:
> > Hi,
> > 
> > On 1/14/21 3:50 PM, Kyle Tso wrote:
> > > v5 https://lore.kernel.org/r/20210105163927.1376770-1-kyletso@google.com
> > > 
> > > "usb: typec: tcpm: AMS and Collision Avoidance"
> > >  - removed the signed-off
> > >  - modified the coding style suggested from Heikki
> > >  - added FR_SWAP AMS handling
> > > 
> > > "usb: typec: tcpm: Protocol Error handling"
> > >  - removed the signed-off
> > >  - modified the coding style suggested from Heikki
> > >  - modified more coding style problems (line wrapping limit)
> > > 
> > > "usb: typec: tcpm: Respond Wait if VDM state machine is running"
> > >  - no change
> > 
> > I've finally gotten around to testing this. I'm happy to
> > report that the power-role swapping regression seen in one
> > of the older versions of this patch-set is gone.
> > 
> > So the entire series is:
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> Thanks for testing and the review.
> 
> Heikki, any thoughts?

Looks good to me.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki

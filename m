Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8802F32A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbhALOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:06:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:17894 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbhALOGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:06:17 -0500
IronPort-SDR: KPs+p94FnryyHSlb+O3gI7AJNWePi4gII+z9RBcD9UAOY8SV8UlWHTEYQ/SV/1Pku+lrKjAjLP
 OSfP0/WQqinQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157820138"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="157820138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 06:04:30 -0800
IronPort-SDR: 8Dd/RSc3xp6wapTxT4+kF6eCM2PnnkCGvOUlE2GeZC01qpNKszGMLreGrml+bLzxIguQ/MUn3i
 5sR8KX83q2Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="464533456"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 12 Jan 2021 06:04:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Jan 2021 16:04:26 +0200
Date:   Tue, 12 Jan 2021 16:04:26 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] AMS, Collision Avoidance, and Protocol Error
Message-ID: <20210112140426.GE2020859@kuha.fi.intel.com>
References: <20210105163927.1376770-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105163927.1376770-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 12:39:24AM +0800, Kyle Tso wrote:
> This series include previous patch "[v4] AMS and Collision Avoidance"
> https://lore.kernel.org/r/20201217030632.903718-1-kyletso@google.com
> and two more patches "Protocol Error handling" and "Respond Wait if...".
> 
> The patch "AMS and Collision Avoidance" in [v5] is the same as the one
> in [v4] (only rebased to ToT).
> 
> The patch "Protocol Error handling" is based on PD3 6.8.1 to fix the
> wrong handling.
> 
> The patch "Respond Wait if..." is to fix a conflict when 
> DR/PR/VCONN_SWAP occurs just after the state machine enters Ready State.
> 
> Kyle Tso (3):
>   usb: typec: tcpm: AMS and Collision Avoidance
>   usb: typec: tcpm: Protocol Error handling
>   usb: typec: tcpm: Respond Wait if VDM state machine is running
> 
>  drivers/usb/typec/tcpm/tcpm.c | 925 +++++++++++++++++++++++++++++-----
>  include/linux/usb/pd.h        |   2 +
>  include/linux/usb/tcpm.h      |   4 +
>  3 files changed, 792 insertions(+), 139 deletions(-)

These are OK by me. The few comments I had were all minor nitpicks,
but I would appreciate if you could fix them in any case. After that,
FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


thanks,

-- 
heikki

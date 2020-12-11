Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3978C2D71CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbgLKIcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:32:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:38041 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgLKIb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:31:59 -0500
IronPort-SDR: lIdgQnJfSbpQzP1/JtTAhX/4jzgerDrg3cLh36y8y/+hqewv6LHRL97uijPQcpffYMIF0mrRI4
 1VQdW/NXV2fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="174512474"
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="174512474"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 00:30:13 -0800
IronPort-SDR: G5RwN+FFiBea78Y2IEu5sILRHZkIKbkvln2oXvkSH3AuD+pm6ieaEvEgMgPCgnM19yFhj1jJSZ
 YCLsL+EvbUuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="440613917"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Dec 2020 00:30:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 11 Dec 2020 10:30:10 +0200
Date:   Fri, 11 Dec 2020 10:30:10 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     linux@roeck-us.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 0/5] USB: typec: various patches
Message-ID: <20201211083010.GD1594451@kuha.fi.intel.com>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:05:16PM +0100, Greg Kroah-Hartman wrote:
> In digging through a large set of proposed typec patches for the Android
> common kernel, I've picked out 5 "easy" patches that should all go
> upstream (they all should go upstream, just will take a while to clean
> them up it seems...)

Cool. Is there already support for the new Enter_USB message? Badhri,
maybe you know more about this, if somebody is working on that or not?

FWIW, for all except the first patch 1/5:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Badhri Jagan Sridharan (2):
>   USB: typec: tcpm: Prevent log overflow by removing old entries
>   USB: typec: tcpci: Add Bleed discharge to POWER_CONTROL definition
> 
> Kyle Tso (2):
>   USB: typec: tcpm: Fix PR_SWAP error handling
>   USB: typec: tcpm: Add a 30ms room for tPSSourceOn in PR_SWAP
> 
> pumahsu (1):
>   USB: typec: tcpm: Hard Reset after not receiving a Request
> 
>  drivers/usb/typec/tcpm/tcpci.h |  1 +
>  drivers/usb/typec/tcpm/tcpm.c  | 30 +++++++++++++++---------------
>  include/linux/usb/pd.h         |  1 +
>  3 files changed, 17 insertions(+), 15 deletions(-)
> 
> -- 
> 2.29.2

thanks,

-- 
heikki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6255829713A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374496AbgJWOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:21:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:10944 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373823AbgJWOVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:21:04 -0400
IronPort-SDR: 8gxkZ/JEbeRIYgfZr1HqtrUKwnkVIcBsj+gA72Q3/NfjWzUtv1j1ZzTBbV0KzZbfT1iME59r8T
 9MkEHs5H6Cgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="252379920"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="252379920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 07:21:01 -0700
IronPort-SDR: MGZKyQLRBj289A0js6fkWAKaqtHtr3cSTsFhDczinfo1hYeZIYRh8vKzfXW/J2iIVbcSilHEA4
 fhj23Pe04DdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="423437822"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2020 07:20:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 23 Oct 2020 17:20:57 +0300
Date:   Fri, 23 Oct 2020 17:20:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Benjamin Berg <bberg@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <20201023142057.GC614478@kuha.fi.intel.com>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009144047.505957-1-benjamin@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 04:40:45PM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <bberg@redhat.com>
> 
> Hi all,
> 
> so, I kept running in an issue where the UCSI port information was saying
> that power was being delivered (online: 1), while no cable was attached.
> 
> The core of the problem is that there are scenarios where UCSI change
> notifications are lost. This happens because querying the changes that
> happened is done using the GET_CONNECTOR_STATUS command while clearing the
> bitfield happens from the separate ACK command. Any change in between will
> be lost.
> 
> Note that the problem may be almost invisible in the UI as e.g. GNOME will
> still show the battery as discharging. But some policies like automatic
> suspend may be applied incorrectly.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Both patches:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Benjamin Berg (2):
>   usb: typec: ucsi: acpi: Always decode connector change information
>   usb: typec: ucsi: Work around PPM losing change information
> 
>  drivers/usb/typec/ucsi/ucsi.c      | 125 ++++++++++++++++++++++++-----
>  drivers/usb/typec/ucsi/ucsi.h      |   2 +
>  drivers/usb/typec/ucsi/ucsi_acpi.c |   5 +-
>  3 files changed, 110 insertions(+), 22 deletions(-)

thanks,

-- 
heikki

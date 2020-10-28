Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62A429D77E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbgJ1WYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbgJ1WWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:22:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB76224689;
        Wed, 28 Oct 2020 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603876192;
        bh=U8N6vg6X2eYcSrQSkrm8NKGZN+U0c9/qNL8RW2RKxFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9NrgKXpsS6WBfcM7CUhO4Y0J6crO+QvjUheK3Vjd1l/gAs06AMhfllfM1Kra4Ou2
         e3w2jfHLO/PybGblgHPD2cu6h4wYzhjh0ZcdQ3VZKrHXG8eOdgwrnyweBLK0r5C/zR
         8xxE/m2/ob9Uivgh2Mw2HlS/Q/zDGrh8OMAMpXl0=
Date:   Wed, 28 Oct 2020 10:10:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Benjamin Berg <bberg@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <20201028091043.GC1947336@kroah.com>
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
> 
> Benjamin Berg (2):
>   usb: typec: ucsi: acpi: Always decode connector change information
>   usb: typec: ucsi: Work around PPM losing change information

Do these need to be backported to stable kernel releases?  If so, how
far back?

thjanks,

greg k-h

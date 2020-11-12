Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC96E2B07EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgKLO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:57:54 -0500
Received: from foss.arm.com ([217.140.110.172]:52402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLO5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:57:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9469139F;
        Thu, 12 Nov 2020 06:57:53 -0800 (PST)
Received: from bogus (unknown [10.57.15.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E41353F73C;
        Thu, 12 Nov 2020 06:57:51 -0800 (PST)
Date:   Thu, 12 Nov 2020 14:57:44 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan.Cameron@Huawei.com
Subject: Re: [PATCH v2 1/1] firmware: arm_scmi: Add SCMI System Power Control
 driver
Message-ID: <20201112145744.wwehqweh2aqo7klp@bogus>
References: <20201026205531.25585-1-cristian.marussi@arm.com>
 <20201026205531.25585-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026205531.25585-2-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 08:55:31PM +0000, Cristian Marussi wrote:
> Add an SCMI System Power control driver to handle platform's requests
> carried by SYSTEM_POWER_STATE_NOTIFIER notifications: such platform
> requested system power state transitions are handled accordingly,
> gracefully or forcefully, depending on the notifications' message flags.
> 
> Graceful requests are by default relayed to userspace using the same
> Kernel API used to handle ACPI Shutdown bus events: alternatively, instead,
> a few available module parameters can be used to tunnel instead such
> requests to userspace via signals addressed to CAD pid.
> 
> When handling graceful requests, grant userspace processes a maximum
> (configurable) time to perform their duties and then revert to a forceful
> transition, so avoiding completely timing out platform's maximum grace time
> and hitting possible abrupt power-cuts.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/Kconfig                      |  12 +
>  drivers/firmware/arm_scmi/Makefile            |   1 +
>  .../firmware/arm_scmi/scmi_power_control.c    | 387 ++++++++++++++++++
>  3 files changed, 400 insertions(+)
>  create mode 100644 drivers/firmware/arm_scmi/scmi_power_control.c
>

[nit] Since you have just one patch, it is generally preferred to place
all the extra non commit messages here after diff stat to have a single
thread of discussion.

Anyways, probably ccing Arnd/Greg/or anyone who has made some feature
changes in this area(e.g. kernel/reboot.c) might help to get some useful
feedback here.

-- 
Regards,
Sudeep

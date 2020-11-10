Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32C82ADF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbgKJTTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:19:38 -0500
Received: from foss.arm.com ([217.140.110.172]:60258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgKJTTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:19:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC99D1063;
        Tue, 10 Nov 2020 11:19:36 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 713533F7BB;
        Tue, 10 Nov 2020 11:19:35 -0800 (PST)
Date:   Tue, 10 Nov 2020 19:19:33 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v2 2/6] firmware: arm_scmi: add SCMIv3.0 Sensors
 descriptors extensions
Message-ID: <20201110191933.GG42652@e120937-lin>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
 <20201026201007.23591-3-cristian.marussi@arm.com>
 <d4c3fe2f-831b-da04-792d-18650471cd60@mailbox.org>
 <20201110172120.GF42652@e120937-lin>
 <a51fecaa-4495-6d8e-9b16-598bbe47b1cd@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a51fecaa-4495-6d8e-9b16-598bbe47b1cd@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 06:50:04PM +0100, Peter Hilber wrote:
> Hi Cristian,
> 
> sorry, I mistakenly used the wrong sender ("Mailing Lists") for the
> original comment mail. Please see below for my reply.
> 
> On 10.11.20 18:21, Cristian Marussi wrote:
> > On Tue, Nov 10, 2020 at 05:00:05PM +0100, Mailing Lists wrote:
> >> On 26.10.20 21:10, Cristian Marussi wrote:
> >>> Add support for new SCMIv3.0 Sensors extensions related to new sensors'
> >>> features, like multiple axis and update intervals, while keeping
> >>> compatibility with SCMIv2.0 features.
> >>> While at that, refactor and simplify all the internal helpers macros and
> >>> move struct scmi_sensor_info to use only non-fixed-size typing.
> >>>
> >>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >>> ---
> >>> v1 --> v2
> >>> - restrict segmented intervals descriptors to single triplet
> >>> - add proper usage of scmi_reset_rx_to_maxsz
> >>> ---
> >>>  drivers/firmware/arm_scmi/sensors.c | 391 ++++++++++++++++++++++++++--
> >>>  include/linux/scmi_protocol.h       | 219 +++++++++++++++-
> >>>  2 files changed, 584 insertions(+), 26 deletions(-)
> >>>
> >>> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> >>> index 6aaff478d032..5a18f8c84bef 100644
> >>> --- a/drivers/firmware/arm_scmi/sensors.c
> >>> +++ b/drivers/firmware/arm_scmi/sensors.c
> >>> @@ -7,16 +7,21 @@
> >>>
> >>>  #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
> >>>
> >>> +#include <linux/bitfield.h>
> >>>  #include <linux/scmi_protocol.h>
> >>>
> >>>  #include "common.h"
> >>>  #include "notify.h"
> >>>
> >>> +#define SCMI_MAX_NUM_SENSOR_AXIS   64
> >>
> >> IMHO the related 6 bit wide fields, like SENSOR_DESCRIPTION_GET "Number
> >> of axes", should determine the maximum value, so 64 -> 63.
> >>
> > 
> > Yes, bits [21:16] 'Number of Axes' in sensor_attributes_high, but this
> > #define was meant to represent the maximum number of sensor axis (64...ranging
> > from 0 to 63) not the highest possible numbered (63).
> > 
> 
> But in my understanding the actual maximum number of sensor axes is 63
> due to the maximum value 63 of 'Number of Axes', 64 would overflow
> already. The ids would range from 0 to 62.

Ah damn, you're right ... maximum that I can set in 5 bits is anyway 63.
I'll fix.

Thanks

Cristian

> 
> That said, in my understanding there is no problem with retaining a
> higher value ATM.
> 
> Best regards,
> 
> Peter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF592B9289
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKSMYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:24:25 -0500
Received: from foss.arm.com ([217.140.110.172]:55718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgKSMYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:24:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D0891396;
        Thu, 19 Nov 2020 04:24:25 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A594F3F718;
        Thu, 19 Nov 2020 04:24:23 -0800 (PST)
Date:   Thu, 19 Nov 2020 12:24:21 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v3 4/6] firmware: arm_scmi: add SCMIv3.0 Sensors
 timestamped reads
Message-ID: <20201119122421.GC56553@e120937-lin>
References: <20201118162905.10439-1-cristian.marussi@arm.com>
 <20201118162905.10439-5-cristian.marussi@arm.com>
 <20201119114216.qqprw2rydmi2wfop@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119114216.qqprw2rydmi2wfop@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:42:16AM +0000, Sudeep Holla wrote:
> On Wed, Nov 18, 2020 at 04:29:03PM +0000, Cristian Marussi wrote:
> > Add new .reading_get_timestamped() method to sensor_ops to support SCMIv3.0
> > timestamped reads.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > V2 --> v3
> > - setting rx_size to 0 in sensor_reading_get to allow fw to send
> >   both v2 and v3 replies...even if sensor_reading_get() only handles
> >   v2 spec and returns one single value
> > - using get_unaligned_le64 in lieu of le64_to_cpu
> > - removed refs to v2.1
> > ---
> >  drivers/firmware/arm_scmi/sensors.c | 137 ++++++++++++++++++++++++++--
> >  include/linux/scmi_protocol.h       |  22 +++++
> >  2 files changed, 152 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> > index 1c83aaae0012..0adc545116a4 100644
> > --- a/drivers/firmware/arm_scmi/sensors.c
> > +++ b/drivers/firmware/arm_scmi/sensors.c
> > @@ -156,6 +156,27 @@ struct scmi_msg_sensor_reading_get {
> >  #define SENSOR_READ_ASYNC	BIT(0)
> >  };
> >  
> > +struct scmi_resp_sensor_reading_get {
> > +	__le64 readings;
> 
> Generally I have avoided such single element structures so far. Any
> particular reasons for having it ?
> 
 Just because there are a few of them so I found it easy and preferable
 to have some typing to distinguish them, but I can drop it.

 Cristian

> -- 
> Regards,
> Sudeep

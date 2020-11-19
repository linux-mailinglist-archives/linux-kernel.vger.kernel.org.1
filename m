Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BCC2B94ED
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgKSOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:40:31 -0500
Received: from foss.arm.com ([217.140.110.172]:59186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbgKSOkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:40:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3707111D4;
        Thu, 19 Nov 2020 06:40:30 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB5213F719;
        Thu, 19 Nov 2020 06:40:28 -0800 (PST)
Date:   Thu, 19 Nov 2020 14:40:26 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v3 2/6] firmware: arm_scmi: add SCMIv3.0 Sensors
 descriptors extensions
Message-ID: <20201119144026.opawwlgianhe2ptq@bogus>
References: <20201118162905.10439-1-cristian.marussi@arm.com>
 <20201118162905.10439-3-cristian.marussi@arm.com>
 <20201119113900.rtuyw34sw6uzb3in@bogus>
 <20201119122028.GA56553@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119122028.GA56553@e120937-lin>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:20:29PM +0000, Cristian Marussi wrote:
> Hi Sudeep
>

[...]

> > > +					S32_EXT(SENSOR_RES_EXP(ares));
> > > +				dsize += sizeof(adesc->resolution);
> > > +
> > > +				scmi_parse_range_attrs(&a->attrs,
> > > +						       &adesc->attrs);
> > > +				dsize += sizeof(adesc->attrs);
> > > +			}
> > > +
> > > +			adesc = (typeof(adesc))((u8 *)adesc + dsize);
> >
> > Just thinking if we can avoid this my having union comprising of v1 and v2
> > structures ?
> >
>
> Not sure to understand, axis_descr are only v3.0 and in fact this is
> called only for v > 2 I think, BUT the problem is that both this and the
> main sensor descriptor v3 msg payloads are runtime variable, so that it
> is stated in the msg->extended_attrs itself if that particular sensor desc
> response that I'm parsing has the additional extended fields or not:
> so the dance with dsize to keep track of where the current response ends
> and when the next starts...but maybe I've not got really what you meant.
>

No worries, we can always improve later if possible, you can keep it as
for now.

[...]

> > > +				 * retrieved via a dedicated (optional) command.
> > > +				 * Since the command is optional, on error carry
> > > +				 * on without any update interval.
> > > +				 */
> > > +				if (scmi_sensor_update_intervals(handle, s))
> > > +					dev_info(handle->dev,
> > > +						 "Update Intervals not available for sensor ID:%d\n",
> > > +						 s->id);
> >
> > Can we drop the logging or make it _dbg ? Make flood in a system with 100s of
> > sensors.
> >
>
> Sure, I was wondering in fact what to do with this: because the command
> is optional but it seemed odd to me that an SCMIv3.0 sensor does not
> expose any update interval so I wanted to log somehow this anomaly.
> (but maybe it's just not an anomaly)
>

Anything optional can never be anomaly, there is high chance that f/w
authors will drop it as it is optional unless it is absolutely necessary.

--
Regards,
Sudeep

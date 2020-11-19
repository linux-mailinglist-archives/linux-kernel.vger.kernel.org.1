Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11302B9288
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgKSMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:22:58 -0500
Received: from foss.arm.com ([217.140.110.172]:55644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgKSMW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:22:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D3BA1396;
        Thu, 19 Nov 2020 04:22:57 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B29B03F718;
        Thu, 19 Nov 2020 04:22:55 -0800 (PST)
Date:   Thu, 19 Nov 2020 12:22:49 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v3 3/6] hwmon: scmi: update hwmon internal scale data type
Message-ID: <20201119122235.GB56553@e120937-lin>
References: <20201118162905.10439-1-cristian.marussi@arm.com>
 <20201118162905.10439-4-cristian.marussi@arm.com>
 <20201119114029.w5hqcquhsyxcp5s3@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119114029.w5hqcquhsyxcp5s3@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:40:29AM +0000, Sudeep Holla wrote:
> On Wed, Nov 18, 2020 at 04:29:02PM +0000, Cristian Marussi wrote:
> > Use an int to calculate scale values inside scmi_hwmon_scale() to match
> > the updated scale data type in struct scmi_sensor_info.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/hwmon/scmi-hwmon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> > index 09ce30cba54b..17d064e58938 100644
> > --- a/drivers/hwmon/scmi-hwmon.c
> > +++ b/drivers/hwmon/scmi-hwmon.c
> > @@ -30,7 +30,7 @@ static inline u64 __pow10(u8 x)
> >  
> >  static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
> >  {
> > -	s8 scale = sensor->scale;
> > +	int scale = sensor->scale;
> 
> Can this go independent of the series ? You haven't cc-ed the hwmon maintainer
> and the list. We need their ack if we have to take it as part of the series.
> 
Sure, I did not know in fact what's better to in this case (maybe
bouncing/fwd the single patch ? CC the whole series ? ).
I'll split and send to the maintainer

Cheers

Cristian

> -- 
> Regards,
> Sudeep

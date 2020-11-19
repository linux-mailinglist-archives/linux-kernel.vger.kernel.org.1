Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E692B94B2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgKSOfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:35:18 -0500
Received: from foss.arm.com ([217.140.110.172]:59074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgKSOfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:35:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ACC71042;
        Thu, 19 Nov 2020 06:35:16 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFE273F719;
        Thu, 19 Nov 2020 06:35:14 -0800 (PST)
Date:   Thu, 19 Nov 2020 14:35:12 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v3 3/6] hwmon: scmi: update hwmon internal scale data type
Message-ID: <20201119143512.ucfztxczpde7jvpo@bogus>
References: <20201118162905.10439-1-cristian.marussi@arm.com>
 <20201118162905.10439-4-cristian.marussi@arm.com>
 <20201119114029.w5hqcquhsyxcp5s3@bogus>
 <20201119122235.GB56553@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201119122235.GB56553@e120937-lin>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:22:49PM +0000, Cristian Marussi wrote:
> On Thu, Nov 19, 2020 at 11:40:29AM +0000, Sudeep Holla wrote:
> > On Wed, Nov 18, 2020 at 04:29:02PM +0000, Cristian Marussi wrote:
> > > Use an int to calculate scale values inside scmi_hwmon_scale() to match
> > > the updated scale data type in struct scmi_sensor_info.
> > > 
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > >  drivers/hwmon/scmi-hwmon.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> > > index 09ce30cba54b..17d064e58938 100644
> > > --- a/drivers/hwmon/scmi-hwmon.c
> > > +++ b/drivers/hwmon/scmi-hwmon.c
> > > @@ -30,7 +30,7 @@ static inline u64 __pow10(u8 x)
> > >  
> > >  static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
> > >  {
> > > -	s8 scale = sensor->scale;
> > > +	int scale = sensor->scale;
> > 
> > Can this go independent of the series ? You haven't cc-ed the hwmon maintainer
> > and the list. We need their ack if we have to take it as part of the series.
> > 
> Sure, I did not know in fact what's better to in this case (maybe
> bouncing/fwd the single patch ? CC the whole series ? ).
> I'll split and send to the maintainer

I see this can be independent of the series. I can provide my review/ack
tag once the maintainer is in cc. No point giving that here 😄 

-- 
Regards,
Sudeep

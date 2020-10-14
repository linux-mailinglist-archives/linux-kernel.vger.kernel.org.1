Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A028E7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgJNUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:20:10 -0400
Received: from foss.arm.com ([217.140.110.172]:58100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJNUUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:20:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5E79D6E;
        Wed, 14 Oct 2020 13:20:09 -0700 (PDT)
Received: from bogus (unknown [10.57.12.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10A703F719;
        Wed, 14 Oct 2020 13:20:06 -0700 (PDT)
Date:   Wed, 14 Oct 2020 21:20:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 01/11] firmware: arm_scmi: review protocol registration
 interface
Message-ID: <20201014202000.3f57rx73d2vele47@bogus>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-2-cristian.marussi@arm.com>
 <1b461304-2c25-3206-5799-b561ac6e0bd2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b461304-2c25-3206-5799-b561ac6e0bd2@gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 12:03:45PM -0700, Florian Fainelli wrote:
> On 10/14/20 8:05 AM, Cristian Marussi wrote:
> > Extend common protocol registration routines and provide some new generic
> > protocols' init/deinit helpers that tracks protocols' users and automatically
> > perform the proper initialization/de-initialization on demand.
> > 
> > Convert all protocols to use new registration schema while modifying only Base
> > protocol to use also the new initialization helpers.
> > 
> > All other standard protocols' initialization is still umodified and bound to
> > SCMI devices probing.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> 

[...]

> 
> > +	struct scmi_protocol_instance *protocols[SCMI_MAX_PROTO];
> 
> Humm that would be 2048 bytes on a 64-bit platform and 1024 bytes on a
> 32-bit platform, this is not so bad, but it is a bit wasteful given that
> 6-7 standard protocols are typically found, and most often no
> proprietary protocols are registered. Not necessarily to be addressed
> right now.
>

Thanks for looking at these patches so quickly, much appreciated.

I haven't looked at this series in detail yet. But this is something that
caught my attention too when I glanced at these patches. I mentioned the
same to Cristian. Indeed we can address that separately, we have even this
for notification, we need to see if we can put all such info in a container
structure and then use hashtable or idr.

--
Regards,
Sudeep

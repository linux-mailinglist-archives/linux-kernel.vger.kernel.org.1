Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751DB294B44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441765AbgJUKaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:30:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410020AbgJUKaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:30:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F306A1FB;
        Wed, 21 Oct 2020 03:30:11 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 526433F66E;
        Wed, 21 Oct 2020 03:30:10 -0700 (PDT)
Date:   Wed, 21 Oct 2020 11:30:08 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 06/11] firmware: arm_scmi: add support for protocol
 modularization
Message-ID: <20201021103008.GC20482@e120937-lin>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-7-cristian.marussi@arm.com>
 <c52f9598-eb33-767c-8181-6e839c884313@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c52f9598-eb33-767c-8181-6e839c884313@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:47:28PM -0400, Thara Gopinath wrote:
> 
> 
> On 10/14/20 11:05 AM, Cristian Marussi wrote:
> > Modify protocol initialization callback adding a new parameter representing
> > a reference to the available xfer core operations and introduce a macro to
> > simply register with the core new protocols as loadable drivers.
> > Keep standard protocols as builtin.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/base.c    | 56 ++++++++++--------
> >   drivers/firmware/arm_scmi/bus.c     | 14 ++++-
> >   drivers/firmware/arm_scmi/clock.c   | 56 +++++++++---------
> >   drivers/firmware/arm_scmi/common.h  | 42 +++++++++-----
> >   drivers/firmware/arm_scmi/driver.c  | 50 ++++++++++------
> >   drivers/firmware/arm_scmi/perf.c    | 88 +++++++++++++++--------------
> >   drivers/firmware/arm_scmi/power.c   | 46 ++++++++-------
> >   drivers/firmware/arm_scmi/reset.c   | 46 ++++++++-------
> >   drivers/firmware/arm_scmi/sensors.c | 52 +++++++++--------
> >   drivers/firmware/arm_scmi/system.c  | 16 ++++--
> >   include/linux/scmi_protocol.h       | 18 +++++-
> >   11 files changed, 288 insertions(+), 196 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> > index f40821eeb103..8d7214fd2187 100644
> > --- a/drivers/firmware/arm_scmi/base.c
> > +++ b/drivers/firmware/arm_scmi/base.c
> > @@ -15,6 +15,8 @@
> >   #define SCMI_BASE_NUM_SOURCES		1
> >   #define SCMI_BASE_MAX_CMD_ERR_COUNT	1024
> > +static const struct scmi_xfer_ops *ops;
> 
> Minor nit. I would consider renaming ops to something more
> meaningful like xfer_ops (or anything that makes sense). ops by
> itself leads to confusion with ops in scmo_protocol and  in
> scmi_protocol_events.
> 
> Same suggestion for all other declarations of ops in this patch.
> 
I agree, but I'm in fact reworking deeply the interface for protocols
initialization (following some idea from Florian) in order to pass down
a protocol object including the xfer_ops instead of a handle+ops like
now, so this hopefully will solve also this concern.

Thanks

Cristian
> -- 
> Warm Regards
> Thara

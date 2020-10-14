Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC828E4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgJNQoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:44:54 -0400
Received: from foss.arm.com ([217.140.110.172]:53456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387565AbgJNQox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:44:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3882D6E;
        Wed, 14 Oct 2020 09:44:52 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 425CC3F71F;
        Wed, 14 Oct 2020 09:44:51 -0700 (PDT)
Date:   Wed, 14 Oct 2020 17:44:45 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH 09/11] [DEBUG] firmware: arm_scmi: add example SCMI
 driver for custom protocol
Message-ID: <20201014164445.GA50090@e120937-lin>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-10-cristian.marussi@arm.com>
 <8f879e6b-8be2-1186-6620-f54762bd35e0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f879e6b-8be2-1186-6620-f54762bd35e0@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, Oct 14, 2020 at 08:55:08AM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 10/14/20 8:05 AM, Cristian Marussi wrote:
> > Add an example SCMI driver using custom vendor protocol 0x99 and also
> > registering for Performance protocol notifications.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/Kconfig                      |   7 +
> >  drivers/firmware/arm_scmi/Makefile            |   2 +
> >  drivers/firmware/arm_scmi/scmi_custom_dummy.c | 126 ++++++++++++++++++
> >  3 files changed, 135 insertions(+)
> >  create mode 100644 drivers/firmware/arm_scmi/scmi_custom_dummy.c
> > 
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index 75e2668a6490..d209df6fd3ee 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -48,6 +48,13 @@ config ARM_SCMI_POWER_DOMAIN
> >  	  will be called scmi_pm_domain. Note this may needed early in boot
> >  	  before rootfs may be available.
> >  
> > +config ARM_SCMI_CUSTOM_DUMMY
> > +	tristate "SCMI Custom Dummy driver"
> > +	depends on ARM_SCMI_PROTOCOL_CUSTOM || (COMPILE_TEST && OF)
> 
> Just an info note here: <linux/of.h> has lots of stubs for when CONFIG_OF is not
> set/enabled, so COMPILE_TEST is usually enough of a dependency without adding "OF".
> 

That's good to know, because even though this specific patch is just
example code not for upstream, I think we mostly use the above kind of
'depends' in other places... so thanks for the heads up I'll investigate
those other usages across the SCMI stack if we really need '&& OF'.

Thanks

Cristian

> > +	default n
> > +	help
> > +	  Custom Dummy driver
> 
> 
> -- 
> ~Randy
> 

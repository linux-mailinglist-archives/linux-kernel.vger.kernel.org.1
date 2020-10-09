Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01977288904
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgJIMlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:41:23 -0400
Received: from foss.arm.com ([217.140.110.172]:50198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731643AbgJIMlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:41:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03B981063;
        Fri,  9 Oct 2020 05:41:22 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4AA3F70D;
        Fri,  9 Oct 2020 05:41:20 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:42:48 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh@kernel.org, satyakim@qti.qualcomm.com, sudeep.holla@arm.com,
        broonie@kernel.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 0/4] Add support for SCMIv3.0 Voltage Domain Protocol and
 SCMI-Regulator
Message-ID: <20201009124056.GB32363@e119603-lin.cambridge.arm.com>
References: <20201005222623.1123-1-cristian.marussi@arm.com>
 <8483165a-e413-b2f8-bd33-6da07fe56d62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8483165a-e413-b2f8-bd33-6da07fe56d62@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:38:52PM -0700, Florian Fainelli wrote:
> 
> 
> On 10/5/2020 3:26 PM, Cristian Marussi wrote:
> >Hi,
> >
> >this series introduces the support for the new SCMI Voltage Domain Protocol
> >defined by the upcoming SCMIv3.0 specification, whose BETA release is
> >available at [1].
> >
> >Afterwards, a new generic SCMI Regulator driver is developed on top of the
> >new SCMI VD Protocol.
> >
> >The series is currently based on for-next/scmi [2] on top of:
> >
> >commit 66d90f6ecee7 ("firmware: arm_scmi: Enable building as a single
> >		     module")
> >
> >Any feedback welcome,
> 
> Well, this is just great! We were right about to develop a proprietary SCMI
> protocol in order to control a locked down PMIC accessible behind a secured
> firmware. We would have done essentially just that since the use case is to
> control the various regulators exposed by this PMIC over SCMI. Thanks a lot!
> 

You're welcome :D ... any feedback from your independent testing will be
appreciated.

Thanks

Cristian
> >
> >Thanks,
> >
> >Cristian
> >
> >[1]:https://developer.arm.com/documentation/den0056/c/
> >[2]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi
> >
> >
> >Cristian Marussi (4):
> >   firmware: arm_scmi: Add Voltage Domain Support
> >   firmware: arm_scmi: add SCMI Voltage Domain devname
> >   regulator: add SCMI driver
> >   dt-bindings: arm: add support for SCMI Regulators
> >
> >  .../devicetree/bindings/arm/arm,scmi.txt      |  44 ++
> >  drivers/firmware/arm_scmi/Makefile            |   2 +-
> >  drivers/firmware/arm_scmi/common.h            |   1 +
> >  drivers/firmware/arm_scmi/driver.c            |   3 +
> >  drivers/firmware/arm_scmi/voltage.c           | 378 ++++++++++++++
> >  drivers/regulator/Kconfig                     |   9 +
> >  drivers/regulator/Makefile                    |   1 +
> >  drivers/regulator/scmi-regulator.c            | 488 ++++++++++++++++++
> >  include/linux/scmi_protocol.h                 |  64 +++
> >  9 files changed, 989 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/firmware/arm_scmi/voltage.c
> >  create mode 100644 drivers/regulator/scmi-regulator.c
> >
> 
> -- 
> Florian

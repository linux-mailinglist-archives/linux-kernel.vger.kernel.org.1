Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FFA28F5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbgJOPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:38:22 -0400
Received: from foss.arm.com ([217.140.110.172]:46962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389250AbgJOPiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:38:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCE5613D5;
        Thu, 15 Oct 2020 08:38:21 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FE803F719;
        Thu, 15 Oct 2020 08:38:20 -0700 (PDT)
Date:   Thu, 15 Oct 2020 16:38:18 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org
Subject: Re: [PATCH 3/4] regulator: add SCMI driver
Message-ID: <20201015153818.GD34395@e120937-lin>
References: <20201005222623.1123-1-cristian.marussi@arm.com>
 <20201005222623.1123-4-cristian.marussi@arm.com>
 <20201006105637.GB5259@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006105637.GB5259@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

sorry for the late reply.

On Tue, Oct 06, 2020 at 11:56:37AM +0100, Mark Brown wrote:
> On Mon, Oct 05, 2020 at 11:26:22PM +0100, Cristian Marussi wrote:
> 
> > - .get_voltage / .set_voltage: routed via SCMI Voltage Domain Protocol
> > - .get_voltage_sel/.set_voltage_sel: using regulator framework helpers
> 
> You should not be implementing both of these interfaces, pick one.  It
> looks like the direct voltage operations are the redundant ones here,
> while the protocol uses actual voltages to communicate with the firmware
> which makes the direct voltage operations a better fit it seems like the
> expectation is that only a limited set of voltages is supported (as is
> normal for the underlying physical regulators) so you want selectors.
> 

I'm dropping non _sel methods in V2.

> > +	sreg->name = devm_kasprintf(dev, GFP_KERNEL, "%s", vinfo->name);
> > +	sreg->desc.name = devm_kasprintf(dev, GFP_KERNEL,
> > +					 "Vscmi.%s", sreg->name);
> > +	if (!sreg->name || !sreg->desc.name)
> > +		return -ENOMEM;
> 
> Why are we using different names here?
> 

Not really a good reason...dropping internal name and "Vscmi" prefix
in V2.

> > +	num_doms = handle->voltage_ops->num_domains_get(handle);
> > +	if (num_doms <= 0) {
> > +		dev_err(&sdev->dev, "number of voltage domains invalid\n");
> > +		return num_doms ?: -EINVAL;
> 
> Please write normal conditional statements to improve legibility.

Ok.

Thanks

Cristian



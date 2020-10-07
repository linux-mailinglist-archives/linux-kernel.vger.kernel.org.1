Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F80285A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgJGIEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:04:39 -0400
Received: from foss.arm.com ([217.140.110.172]:39524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgJGIEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:04:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E28113E;
        Wed,  7 Oct 2020 01:04:37 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [10.57.50.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 231963F66B;
        Wed,  7 Oct 2020 01:04:36 -0700 (PDT)
Date:   Wed, 7 Oct 2020 09:06:01 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org
Subject: Re: [PATCH 4/4] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201007080601.GA21759@e119603-lin.cambridge.arm.com>
References: <20201005222623.1123-1-cristian.marussi@arm.com>
 <20201005222623.1123-5-cristian.marussi@arm.com>
 <20201006105922.GC5259@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006105922.GC5259@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

thanks for reviewing this series.
 
On Tue, Oct 06, 2020 at 11:59:22AM +0100, Mark Brown wrote:
> On Mon, Oct 05, 2020 at 11:26:23PM +0100, Cristian Marussi wrote:
> 
> > +An SCMI Regulator is permanently bound to a well defined SCMI Voltage Domain,
> > +and should be always positioned as a root regulator.
> > +It does not support negative voltages nor any current operation.
> 
> Support for negative voltages is an implementation detail of Linux, IIRC
> there's nothing in the generic regulator binding preventing it and even
> if there were updates to the generic binding are what are relevant here
> - they could start working with no updates to this binding.
> 
> > +Optional properties:
> > + - regulator-min-microvolt: when defined should be non-negative.
> > + - regulator-max-microvolt: when defined should be non-negative.
> 
> These are covered by the generic regulator binding, no need to duplicate
> the documentation here.

Right I'll drop this references to negative voltages in the bindings.

Anyway, the underlying SCMI Voltage Domain protocol do support negatives
and just expose a negative_volts_allowed flags in the Voltage descriptor
if the domain is advertised by fw as supporting negatives.

Based on that, since the regulator framework as of now cannot report
negative voltages (since the .get ops return an int which is used also
for reporting negative error codes), the SCMI regulator driver in this
series just checks for that flag on every found Voltage Domain and refuse
to handle it like:

if (vinfo->negative_volts_allowed) {
+		dev_warn(dev, "Negative voltages NOT supported...skip %s\n",
+			 sreg->of_node->full_name);
+		return -EOPNOTSUPP;
+	}

So the driver itself will need to be patched in this regards the day the
regulator framework should support negatives, it won't just work.
(but I suppose this is not a problem since it will need to be changed anyway
to use properly this possible new API handling negatives.)

Thanks

Cristian


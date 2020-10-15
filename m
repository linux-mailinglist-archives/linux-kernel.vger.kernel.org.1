Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82128EECD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgJOIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:53:07 -0400
Received: from foss.arm.com ([217.140.110.172]:48216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgJOIxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:53:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 048BDD6E;
        Thu, 15 Oct 2020 01:53:06 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CCA33F66B;
        Thu, 15 Oct 2020 01:53:04 -0700 (PDT)
Date:   Thu, 15 Oct 2020 09:52:58 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 02/11] firmware: arm_scmi: hide protocols' private data
Message-ID: <20201015085258.GB34395@e120937-lin>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-3-cristian.marussi@arm.com>
 <ae5b36f6-68de-d764-636d-ad12d3276302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae5b36f6-68de-d764-636d-ad12d3276302@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 12:19:43PM -0700, Florian Fainelli wrote:
> On 10/14/20 8:05 AM, Cristian Marussi wrote:
> > Protocols private data were meant to be used exclusively by protocol code
> > but they are currently exposed through the handle, so available also to
> > SCMI drivers: move them away from handle into instance specific data and
> > provide internal helpers to let protocols implementation set/get their own
> > private data from protocol code.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> [snip]
> 
> 
> > diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> > index 94bcad9a7d19..4e8dafc36d7e 100644
> > --- a/drivers/firmware/arm_scmi/clock.c
> > +++ b/drivers/firmware/arm_scmi/clock.c
> > @@ -240,7 +240,8 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
> >  	u32 flags = 0;
> >  	struct scmi_xfer *t;
> >  	struct scmi_clock_set_rate *cfg;
> > -	struct clock_info *ci = handle->clk_priv;
> > +	struct clock_info *ci =
> > +		scmi_get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
> 
> Having to repeat the protocol identifier is a bit error prone, does not
> scale really and it will not change throughout the lifecycle of the
> protocol handler. This is the least path of resistance though so it
> makes sense you went that route for now.
> 
> Instead of exposing scmi_handle towards the various operations what you
> could do is just pass down an encapsulating object which is comprised of
> a scmi_handle reference and the protocol's private structure already
> resolved?

That's really a good point.

Later on in the series when modularization is introduced you'll see that
I modified the protocol init callback to receive the core xfer_ops as a
parameter so that any protocol even if loaded as a module can use the
core xfer ops to built and generate SCMI msgs (without EXPORTing them),
but one thing which is not addressed by this series still, is the fact
that this way each protocol would have to specify for each of this ops
a protocol_id param, thing which, beside being cumbersome as you said,
lets the protocol potentially cheat, registering itself for protocol X
but then potentially building and sending SCMI msgs for any other
protocol: so your proposed solution could address also this case.

Thanks for the hint !

Cristian

> -- 
> Florian

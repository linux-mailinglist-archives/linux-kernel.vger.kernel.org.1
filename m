Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F722C13DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgKWSuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:50:06 -0500
Received: from foss.arm.com ([217.140.110.172]:36844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgKWSuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:50:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3746101E;
        Mon, 23 Nov 2020 10:50:04 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21C5F3F70D;
        Mon, 23 Nov 2020 10:50:03 -0800 (PST)
Date:   Mon, 23 Nov 2020 18:49:56 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 5/5] regulator: add SCMI driver
Message-ID: <20201123184956.GD56553@e120937-lin>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
 <20201119191051.46363-6-cristian.marussi@arm.com>
 <20201123174941.GM6322@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123174941.GM6322@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On Mon, Nov 23, 2020 at 05:49:41PM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2020 at 07:10:51PM +0000, Cristian Marussi wrote:
> 
> > +	ret = handle->voltage_ops->config_get(handle, sreg->id,
> > +					      &config);
> > +	if (ret) {
> > +		dev_err(&sreg->sdev->dev,
> > +			"Error %d reading regulator %s status.\n",
> > +			ret, sreg->desc.name);
> > +		return 0;
> > +	}
> 
> If we failed to read the status we should return an error rather than
> claim the regulator is off, other functions return errors so I'm not
> sure why this one would be different.
> 

Yes this seems a bug, I'll fix.

> > +	vinfo = handle->voltage_ops->info_get(handle, sreg->id);
> > +	if (!vinfo) {
> > +		dev_warn(dev, "Skipping invalid voltage domain %d\n",
> > +			 sreg->id);
> > +		return -ENODEV;
> 
> I'm not sure that this error message is the most informative - the issue
> is that we failed to read information, we don't know if that information
> would have been valid or not.  Same for some of the other enumeration,
> it's a failure to read not a lack of validity isn't it?
> 

In fact not reading information here could be due to a failure to
communicate with fw or to the fact that the underlying Voltage Domain
protocol during its initialization failed to validate the domain for
some reason (like getting garbage reads of implauusible out of spec
levels from the FW) and so VD decided not to expose the domain entry
identified by id.

I'll report a generic "Failure to get voltage domain" here at this
point if it's fine.

> > +	/* Allocate pointers' array for all possible domains */
> 
> No '
> 

Ok

> > +	rinfo->num_doms = num_doms;
> > +	/*
> 
> Several places like this with missing blank lines.

What do you mean ? a blank before the comment ?
Sorry but checkpatch --strict does not complain, I was not aware of
this styling. I'll do (if you confirm that's what you want)

How do you prefer these changes (and the DT one) ? 
All as followup patches in a V7 series on top of
sudeep/for-next/scmi-voltage ?

Thanks

Cristian



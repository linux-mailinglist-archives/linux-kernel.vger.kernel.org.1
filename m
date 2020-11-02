Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E352A267F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgKBJBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:01:25 -0500
Received: from foss.arm.com ([217.140.110.172]:56168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgKBJBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:01:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C665101E;
        Mon,  2 Nov 2020 01:01:25 -0800 (PST)
Received: from bogus (unknown [10.57.13.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A6713F718;
        Mon,  2 Nov 2020 01:01:22 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:01:20 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>, souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 4/4] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201102090120.xb7ghg6kfh3unisr@bogus>
References: <20201026203148.47416-1-cristian.marussi@arm.com>
 <20201026203148.47416-5-cristian.marussi@arm.com>
 <20201030185514.GA4129214@bogus>
 <20201030190606.GL4405@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201030190606.GL4405@sirena.org.uk>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 07:06:07PM +0000, Mark Brown wrote:
> On Fri, Oct 30, 2020 at 01:55:14PM -0500, Rob Herring wrote:
>
> > I'm a bit worried that now we're changing CPUs (at least?) from clocks
> > to 'performance domains' while at the same time here we're adding
> > low level, virtual regulators. Are we going to end up wanting something
> > more abstract here too?

Valid concern and I too am with the same opinion. However as Mark Brown
points out this was added to just satisfy some exiting consumers that
rely on regulators.

I had or still argue that we need a way to check if this is not getting
misused with devices like CPUs. I was thinking of some check with DT where
such properties are not allowed in certain device type.

>
> My understanding is that this is aimed at systems which have done the
> more abstract thing where regulators just aren't visible at all to the
> kernel but then find that they actually need to control some of the
> regulators explicitly for things like MMC so need a mechanism for the
> firmware to expose select regulators.

Thanks Mark for the explaining this, saved me time 😄.

-- 
Regards,
Sudeep

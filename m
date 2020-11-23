Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF11E2C13E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgKWSwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:52:17 -0500
Received: from foss.arm.com ([217.140.110.172]:36966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729837AbgKWSwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:52:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75CDC101E;
        Mon, 23 Nov 2020 10:52:16 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97FBF3F70D;
        Mon, 23 Nov 2020 10:52:14 -0800 (PST)
Date:   Mon, 23 Nov 2020 18:52:08 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 4/5] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201123185141.GE56553@e120937-lin>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
 <20201119191051.46363-5-cristian.marussi@arm.com>
 <20201123173008.GK6322@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123173008.GK6322@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 05:30:08PM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2020 at 07:10:50PM +0000, Cristian Marussi wrote:
> 
> > +This binding uses the common regulator binding[6] but, due to SCMI abstractions,
> > +supports only a subset of its properties as specified below amongst Optional
> > +properties.
> 
> > +Required properties:
> > + - reg : shall identify an existent SCMI Voltage Domain.
> 
> > +Optional properties:
> > + - regulator-name
> > + - regulator-min-microvolt / regulator-max-microvolt
> > + - regulator-always-on / regulator-boot-on
> > + - regulator-max-step-microvolt
> > + - regulator-coupled-with / regulator-coupled-max-spread
> 
> Please send a followup patch removing this stuff about only specific
> properties being supported, that's just asking for bitrot and is equally
> true for most regulator drivers - people shouldn't have to do do an
> audit of every single regulator driver to add a generic feature.

Ok I'll remove any reference to partial SCMI regulator support.

Thanks

Cristian



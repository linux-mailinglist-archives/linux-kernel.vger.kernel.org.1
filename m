Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4E2B9939
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgKSRY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:24:57 -0500
Received: from foss.arm.com ([217.140.110.172]:35730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgKSRY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:24:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E2951396;
        Thu, 19 Nov 2020 09:24:56 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 852CD3F718;
        Thu, 19 Nov 2020 09:24:54 -0800 (PST)
Date:   Thu, 19 Nov 2020 17:24:52 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v5 4/5] regulator: add SCMI driver
Message-ID: <20201119172452.ns3ebteu45n7amkz@bogus>
References: <20201117123415.55105-1-cristian.marussi@arm.com>
 <20201117123415.55105-5-cristian.marussi@arm.com>
 <20201119161308.xhyohop5fspb4b5l@bogus>
 <20201119163949.GF5554@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119163949.GF5554@sirena.org.uk>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:39:49PM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2020 at 04:13:08PM +0000, Sudeep Holla wrote:
> 
> > I was thinking about how to merge this if and when you have reviewed it
> > and happy with it. Is it OK to take via ARM SoC with dependent and other
> > SCMI changes ? Or we can merge the SCMI part next release and the regulator
> > in the following, up to you.
> 
> I was expecting you to send me a pull request for the firmware bits once
> you've applied them.

Sure, I can do that.

-- 
Regards,
Sudeep

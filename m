Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27C92B97DC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgKSQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:26:48 -0500
Received: from foss.arm.com ([217.140.110.172]:33902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgKSQ0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:26:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B755C15AD;
        Thu, 19 Nov 2020 08:26:47 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56A553F719;
        Thu, 19 Nov 2020 08:26:45 -0800 (PST)
Date:   Thu, 19 Nov 2020 16:26:38 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v5 4/5] regulator: add SCMI driver
Message-ID: <20201119162638.GA16158@e120937-lin>
References: <20201117123415.55105-1-cristian.marussi@arm.com>
 <20201117123415.55105-5-cristian.marussi@arm.com>
 <20201119161308.xhyohop5fspb4b5l@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119161308.xhyohop5fspb4b5l@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:13:08PM +0000, Sudeep Holla wrote:
> Hi Mark,
> 
> On Tue, Nov 17, 2020 at 12:34:14PM +0000, Cristian Marussi wrote:
> > Add a simple regulator based on SCMI Voltage Domain Protocol.
> >
> 
> I was thinking about how to merge this if and when you have reviewed it
> and happy with it. Is it OK to take via ARM SoC with dependent and other
> SCMI changes ? Or we can merge the SCMI part next release and the regulator
> in the following, up to you.
> 

Mark, please note that since v4, to address some modifications on DT I
added for the core too:

[PATCH v5 3/5] regulator: core: add of_match_full_name boolean flag

Thanks

Cristian

> --
> Regards,
> Sudeep

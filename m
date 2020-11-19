Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5291F2B9B39
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKSTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:09:20 -0500
Received: from foss.arm.com ([217.140.110.172]:37860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbgKSTJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:09:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE621396;
        Thu, 19 Nov 2020 11:09:19 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DE2E3F70D;
        Thu, 19 Nov 2020 11:09:17 -0800 (PST)
Date:   Thu, 19 Nov 2020 19:09:15 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, broonie@kernel.org, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v5 5/5] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201119190915.GC16158@e120937-lin>
References: <20201117123415.55105-1-cristian.marussi@arm.com>
 <20201117123415.55105-6-cristian.marussi@arm.com>
 <20201119152719.pkba7bz23s4bzo46@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119152719.pkba7bz23s4bzo46@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:27:19PM +0000, Sudeep Holla wrote:
> On Tue, Nov 17, 2020 at 12:34:15PM +0000, Cristian Marussi wrote:
> > Add devicetree bindings to support regulators based on SCMI Voltage
> > Domain Protocol.
> >
> 
> Ideally, the DT binding should be first one, rather before the binding
> is used in the code. I can move the order while applying.
> 

I'll do in v6

Cristian
> -- 
> Regards,
> Sudeep

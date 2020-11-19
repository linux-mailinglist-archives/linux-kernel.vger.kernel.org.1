Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB82B9639
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgKSP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:27:26 -0500
Received: from foss.arm.com ([217.140.110.172]:60380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbgKSP1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:27:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B44411D4;
        Thu, 19 Nov 2020 07:27:24 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B69E93F719;
        Thu, 19 Nov 2020 07:27:21 -0800 (PST)
Date:   Thu, 19 Nov 2020 15:27:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, lukasz.luba@arm.com,
        Jonathan.Cameron@Huawei.com, broonie@kernel.org, robh@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 5/5] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201119152719.pkba7bz23s4bzo46@bogus>
References: <20201117123415.55105-1-cristian.marussi@arm.com>
 <20201117123415.55105-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117123415.55105-6-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 12:34:15PM +0000, Cristian Marussi wrote:
> Add devicetree bindings to support regulators based on SCMI Voltage
> Domain Protocol.
>

Ideally, the DT binding should be first one, rather before the binding
is used in the code. I can move the order while applying.

-- 
Regards,
Sudeep

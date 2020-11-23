Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA4D2C0318
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgKWKSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:18:13 -0500
Received: from foss.arm.com ([217.140.110.172]:40346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgKWKSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:18:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32CED101E;
        Mon, 23 Nov 2020 02:18:12 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 489743F70D;
        Mon, 23 Nov 2020 02:18:10 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, broonie@kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, f.fainelli@gmail.com,
        satyakim@qti.qualcomm.com, souvik.chakravarty@arm.com,
        etienne.carriere@linaro.org, Jonathan.Cameron@Huawei.com,
        vincent.guittot@linaro.org, james.quinlan@broadcom.com,
        lukasz.luba@arm.com, robh@kernel.org
Subject: Re: [PATCH v6 0/5] Add support for SCMIv3.0 Voltage Domain Protocol and SCMI-Regulator
Date:   Mon, 23 Nov 2020 10:18:01 +0000
Message-Id: <160612640234.1278741.10147060324304611609.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119191051.46363-1-cristian.marussi@arm.com>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 19:10:46 +0000, Cristian Marussi wrote:
> this series introduces the support for the new SCMI Voltage Domain Protocol
> defined by the upcoming SCMIv3.0 specification, whose BETA release is
> available at [1].
> 
> Afterwards, a new generic SCMI Regulator driver is developed on top of the
> new SCMI VD Protocol.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi-voltage), thanks!

I will soon send pull request to Mark Brown so tha he can pick by the
regulator driver patches with these as agreed.

[4/5] dt-bindings: arm: Add support for SCMI Regulators
      https://git.kernel.org/sudeep.holla/c/0f80fcec08
[1/5] firmware: arm_scmi: Add voltage domain management protocol support
      https://git.kernel.org/sudeep.holla/c/2add5cacff
[2/5] firmware: arm_scmi: Add support to enumerated SCMI voltage domain device
      https://git.kernel.org/sudeep.holla/c/ec88381936

--
Regards,
Sudeep


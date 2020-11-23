Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F702C17ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgKWVqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730528AbgKWVqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:46:51 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E2520663;
        Mon, 23 Nov 2020 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606168011;
        bh=38TPUx93n5nrbmLWAUeIvjbbon9+6jzZvK8m2u3g+os=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ffZBrqmRo+7iWL3XzP59JgSrqY8kQGGBn7DeZYQFGGkw8w194yD24kPAxNz1ug166
         68CM1DVxDxL8ae52mlUgwXeFqcOSkay+rPt02uj8YnHwpoL8l3JUCB2AIgRhs5Snl5
         ozzlxnSqgq7gwZzOCETeqiU54iE+ghSB+ML7iMfc=
Date:   Mon, 23 Nov 2020 21:46:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Jonathan.Cameron@Huawei.com, souvik.chakravarty@arm.com,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        etienne.carriere@linaro.org, james.quinlan@broadcom.com,
        satyakim@qti.qualcomm.com, vincent.guittot@linaro.org,
        f.fainelli@gmail.com, robh@kernel.org
In-Reply-To: <20201123202336.46701-1-cristian.marussi@arm.com>
References: <20201123202336.46701-1-cristian.marussi@arm.com>
Subject: Re: [PATCH v7 0/3] Add support for SCMI-Regulator
Message-Id: <160616798790.26619.2814900248177756212.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 20:23:33 +0000, Cristian Marussi wrote:
> this series introduces the support for a new generic SCMI Regulator driver
> developed on top of the recently introduced SCMI Voltage Domain Protocol
> support as specified in the upcoming SCMIv3.0 specification. [1]
> 
> The underlying SCMI VD Protocol support, which was originally part of this
> series, is now applied on for-next/scmi-voltage [2], and this series,
> reduced to its SCMI Regulator support and dt-bindings fixes is similarly
> based on top of [2]:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: arm: remove optional properties for SCMI Regulators
      commit: e8056bf01080eeb13b0229f3fa4cb25a5a2de6a5
[2/2] regulator: add SCMI driver
      commit: 0fbeae70ee7ce98e18a47337cd1f205dd88589e9

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

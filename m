Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98AD2C16F9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgKWUjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:39:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbgKWUjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:39:14 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB5A2075A;
        Mon, 23 Nov 2020 20:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606163954;
        bh=fXQ4kN1fuSAB93w2X+YhBILhqVMOtBEUFEyMF7r+PeA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lMxGtfJCzFcPLYicvJCUEje3aujstAcVr4HgOJ5HgBWmKm0H8ujxueD3zp6YH6K+i
         /KDZxICOrncrcaZz5xVyVo2x4acFYcgEJk5ocF5U2uO0f6tXfTRrcZFfKvfEuzBwam
         PdBfdeHnxLqHHaPhCwJ9rG7z+4lFCdKWgv87u3zc=
Date:   Mon, 23 Nov 2020 20:38:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, f.fainelli@gmail.com, sudeep.holla@arm.com,
        vincent.guittot@linaro.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, souvik.chakravarty@arm.com,
        robh@kernel.org, etienne.carriere@linaro.org,
        satyakim@qti.qualcomm.com
In-Reply-To: <20201119191051.46363-1-cristian.marussi@arm.com>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
Subject: Re: [PATCH v6 0/5] Add support for SCMIv3.0 Voltage Domain Protocol and SCMI-Regulator
Message-Id: <160616392670.21180.3656165882434093831.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: add of_match_full_name boolean flag
      commit: e7095c35abfc5a5d566941a87434c0fd5ffb570f

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8587A2EE681
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbhAGUCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbhAGUCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75566233A0;
        Thu,  7 Jan 2021 20:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610049731;
        bh=Hjb0WoImAYyFBiHs18Z5+0sK1Hc3pMQCLXgVJ9802lg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZBJW4/WWuVbhgn2B04BV1+IxqlJtuFMbDB39YX8N4wjQTjfZ6At9yvgnfDAtN3k8r
         toysdWWjhGYXsjIAtsOCzOd26zQ+EWqSlSGSWPsRBss74xwlc2twl+GN6i1EHqPl3f
         gDyjnGPUtuosraTH5pyE0XJoUS8leaswSHcEonNHM2CwKdxHEoc4Jy+RHeFUeOrkFP
         QFBNyay4VyiblWFtdlQPvtPILJcC1SkmhRudhySctABMrD+bi15bJZ6+m3UZYhTwXA
         1yeS8M6BbLNm2GiPwbA5ZldNUp8t57HgKEFPxj6zGi+77aJY95m4QixygzZBvBamEN
         Kt3EMcov/ySTA==
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
References: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 0/3] regulator: mcp16502: make lpm pin optional
Message-Id: <161004969536.33528.6887560007908923999.b4-ty@kernel.org>
Date:   Thu, 07 Jan 2021 20:01:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 16:15:24 +0200, Claudiu Beznea wrote:
> This patch makes the LPM pin as optional as this may be controlled
> in the last phase of suspend procedure to decrease the power consumption
> while suspended. Along w/ this update the MAINTAINERS entry for this
> driver.
> 
> Thank you,
> Claudiu Beznea
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: regulator: mcp16502: document lpm as optional
      commit: eea0b4e213232b28a25de5b88af9e25667e8d2f2
[2/3] regulator: mcp16502: lpm pin can be optional on some platforms
      commit: 3c42728c18d093e8951ad6caf7daa89fa2f54702
[3/3] MAINTAINERS: add myself as maintainer for mcp16502
      commit: 8aad7fabce6ad9491cc7d23f85d9798a4a0ce399

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

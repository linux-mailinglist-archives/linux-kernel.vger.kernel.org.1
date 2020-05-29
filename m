Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86CB1E8B7A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 00:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgE2Wnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 18:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgE2Wnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:43:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D37B20721;
        Fri, 29 May 2020 22:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590792232;
        bh=F36tumY24OA8I0LFqgr30aImSly++T+0JOpG+SSVSiI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LyI4xifH5b4lqDmakekfmTL729ejSf90vQvaQwd8ZGkGAxygQuD2/v9lFHdMVo+ux
         +Rh8l99xmQ46I1BQE9Y18nGzlMIPvPOq0xKmE63Sjz0jDXxJ5BqBGjXIC55BwFLico
         Jbo+drOcp4AZsTpQ5Bi/iNtetGvUVih8Fve6wmCw=
Date:   Fri, 29 May 2020 23:43:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul.liu@linaro.org
Cc:     Linux-imx@nxp.com
In-Reply-To: <1590717551-20772-1-git-send-email-Anson.Huang@nxp.com>
References: <1590717551-20772-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V2] dt-bindings: regulator: Convert anatop regulator to json-schema
Message-Id: <159079222930.20907.2199510160969522457.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 09:59:11 +0800, Anson Huang wrote:
> Convert the anatop regulator binding to DT schema format using json-schema.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: Convert anatop regulator to json-schema
      commit: 81227f49bd272cbcd9bb4650b250519c8aa22065

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

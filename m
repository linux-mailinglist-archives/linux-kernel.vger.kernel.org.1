Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E912D7D49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436551AbgLKRvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436544AbgLKRu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:50:56 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Sameer Pujar <spujar@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org
In-Reply-To: <1607006202-4078-1-git-send-email-spujar@nvidia.com>
References: <1607006202-4078-1-git-send-email-spujar@nvidia.com>
Subject: Re: [RESEND PATCH 0/2] Convert Tegra HDA doc to json-schema
Message-Id: <160770898108.26354.183397284224263445.b4-ty@kernel.org>
Date:   Fri, 11 Dec 2020 17:49:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 20:06:40 +0530, Sameer Pujar wrote:
> Convert Tegra HDA doc to YAML format. Ran binding validation checks to
> ensure there are no warnings/errors for HDA.
> 
> Patch "arm64: tegra: Fix Tegra194 HDA {clock,reset}-names ordering" is
> already merged and hence not included here.
> 
> Sameer Pujar (2):
>   dt-bindings: tegra: Convert HDA doc to json-schema
>   dt-bindings: tegra: Add missing HDA properties
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tegra: Convert HDA doc to json-schema
      commit: 2d8f8955fe02c1f5d41c283f48d8c6a2a02ae17f
[2/2] dt-bindings: tegra: Add missing HDA properties
      commit: 3759d5edc07598d55124d87bd292a95f79f47997

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

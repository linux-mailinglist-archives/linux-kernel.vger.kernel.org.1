Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82B2FA5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406332AbhARQL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:11:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406331AbhARQEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:04:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 534CB22C9D;
        Mon, 18 Jan 2021 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610985804;
        bh=j/mLnGJZdEDCGUguiqM8BNqaZ8IfO8PfJpKq8eHNvPc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PbBmdoHa6WgJ1Q11AuyM+P295Y0nl4vY/GDtrRUytLmVbvViFZgeq5RbLPaQ5clI/
         NUvgucfazuO2NHmEX+ojCIc1fprssx1STvmAR+BkI8mzX+u9xxWpxbvKf9/W8V9M3L
         /bP/OmHhfeUG86r8T13wIeaPh6sYKbMyu+Z0tnKX+UFwJhWzxdoAl458TBagt1QB5X
         Dh2bWA0zL47nPcpJXcnSuKlZRMkjTm4MtQ4gUJ+zf5j0XrHcy7YB89d5FqYr9kcLYB
         yCOQvLxowLgyVbBqdct3BR5x2IDKrt2DEr9PmIeBpAi1XSwmO+ev5AkokgQcBuu0nw
         hn2qR8kTEhdKQ==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, kuninori.morimoto.gx@renesas.com
In-Reply-To: <1610948585-16286-1-git-send-email-spujar@nvidia.com>
References: <1610948585-16286-1-git-send-email-spujar@nvidia.com>
Subject: Re: [RESEND PATCH] ASoC: audio-graph-card: Drop remote-endpoint as required property
Message-Id: <161098576158.26872.13693675515772808569.b4-ty@kernel.org>
Date:   Mon, 18 Jan 2021 16:02:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 11:13:05 +0530, Sameer Pujar wrote:
> The remote-endpoint may not be available if it is part of some
> pluggable module. One such example would be an audio card, the
> Codec endpoint will not be available until it is plugged in.
> Hence drop 'remote-endpoint' as a required property.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph-card: Drop remote-endpoint as required property
      commit: 57c412d43d71b12df9aa414ec27cd793e9821274

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

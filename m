Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E222B77B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgGWUUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgGWUUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:20:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5979820B1F;
        Thu, 23 Jul 2020 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595535620;
        bh=LAhMqvfEs+etTZ4a9zE5Wb1PwG/5eexU9ix48zE0uHY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=AtByFzwe3FV8zOR5RXV2pJ0rR8bD85mMsHrSFWarGAXHqidjg/feYLgkzo61nKiBV
         sglmdAHwSi8zyRaJ7nah7LSMLGrQEJtgyeNj5GGBm84jrh/FIqRh4Fs5ynZfS3UGpA
         wsA4kNJeqPeWM6VuzwxcieBZMKN+l9ytzSinxGHk=
Date:   Thu, 23 Jul 2020 21:20:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org
In-Reply-To: <20200722174215.988974-1-katsuhiro@katsuster.net>
References: <20200722174215.988974-1-katsuhiro@katsuster.net>
Subject: Re: [PATCH v2] dt-bindings: sound: convert ROHM BD28623 amplifier binding to yaml
Message-Id: <159553557414.41908.16965363721793838358.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 02:42:15 +0900, Katsuhiro Suzuki wrote:
> This patch converts ROHM BD28623UMV class D speaker amplifier binding
> to DT schema.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: convert ROHM BD28623 amplifier binding to yaml
      commit: 7349885d87c66cfd5bd99332283d92ff509f15ff

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

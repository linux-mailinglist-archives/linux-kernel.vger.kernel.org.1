Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A002D4BC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbgLIU2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbgLIU2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:28:09 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
References: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: add simple-audio-mux binding
Message-Id: <160754563667.43974.695690086980158511.b4-ty@kernel.org>
Date:   Wed, 09 Dec 2020 20:27:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Dec 2020 01:15:07 +0100, Alexandre Belloni wrote:
> Add devicetree documentation for simple audio multiplexers

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: add simple-audio-mux binding
      commit: f17a7db22b8ff1688f30bb66aeeaa8cc088e5230
[2/2] ASoC: add simple-mux
      commit: 342fbb7578d1741ff646d7b08e14e8753267b9fa

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

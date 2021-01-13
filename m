Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B842F4E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbhAMP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbhAMP2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:28:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4006623383;
        Wed, 13 Jan 2021 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551653;
        bh=k2kOu5zJDWWhpwx+mxdpIH4sDQN4oRf9zgl/PRgOkX8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XnXa1s1OfjzSKrAZHb+JJmqttkWwME3iR1fuFtgAKPHspMVddTVF29e/Rbg3h703j
         YO0A6+frdl/FvVVlzI3zukkHbOuXxqJCgOFoKQNZnFMYtIs8vQ0wOe+mgkvTSxYWer
         5g7woz5iqiT8n2hHPdoZKzccKwGabXb8lmdtnyfoBR+yFtKX/1PcJi1JRWKLni6jUx
         cw+6kFbERLXoxjyKVzVv+ugZZsL0ODQfpi5wYZG3Nr1GkJj+EPetTQA6WnIizbHrpo
         cB9iL0q+PtwkR6/xyB1sp2KwtXzkLMcS5PNpOaop0JL1lloXYR59Fg5tYlqIf3O0oP
         pKxIlC+0m3JBA==
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
In-Reply-To: <03950bbd5cf7bac10eaaff3725e283d3ec2538c5.1610536535.git.mchehab+huawei@kernel.org>
References: <03950bbd5cf7bac10eaaff3725e283d3ec2538c5.1610536535.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update references to stm32 audio bindings
Message-Id: <161055160366.21623.12493006101494306505.b4-ty@kernel.org>
Date:   Wed, 13 Jan 2021 15:26:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 12:15:43 +0100, Mauro Carvalho Chehab wrote:
> Changeset 81437cc3b0d9 ("Merge series "dt-bindings: stm32: convert audio dfsdm to json-schema" from Olivier Moysan <olivier.moysan@st.com>:")
> removed bindings/sound/st,stm32-adfsdm.txt, as stm32-* audio
> bindings are now under: bindings/iio/adc/st,stm32-*.yaml.
> 
> Update cross-references to them accordingly.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: update references to stm32 audio bindings
      commit: 0d38fd8d252446d39050578ea32ed89b9adeb202

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA61E275D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbgEZQpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 12:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388339AbgEZQpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:45:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E92B20787;
        Tue, 26 May 2020 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590511544;
        bh=tJ9FbVqns1orYj2OI8Q7PaS75f7ujA0N3F+MvNp0aag=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=L9g8ieFH0Pb6ZBWYqWQd/yGSizqsM5DJN0FSi0OrEfmDKAgXYhZUBdUqeM0GCkXVn
         E5Z8hXAqOzvbIOnnfR5fGbwU+X258jz3bV3qhqTGLTwy3QICgNsJnFDRpPeiLfvCRs
         JwFoxLxKFYtm+7bvo2drNZoGpZcDg9lySg+PFzJ0=
Date:   Tue, 26 May 2020 17:45:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kjlu@umn.edu, Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        alsa-devel@alsa-project.org, Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200525071732.5887-1-dinghao.liu@zju.edu.cn>
References: <20200525071732.5887-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] ASoC: tas2552: Fix runtime PM imbalance in tas2552_component_probe
Message-Id: <159051153753.36309.16172218299424026187.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 15:17:30 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2552: Fix runtime PM imbalance in tas2552_component_probe
      commit: 0d71a5cf691a8226151ceeb79fb872925f053df5

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

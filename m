Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA21DBAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgETRRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgETRRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:17:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB8642070A;
        Wed, 20 May 2020 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589995036;
        bh=yHlEbQ436cPIfFD1oyX4yafwtT/b8QhDnXnebWNb7uI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ynn89FV//DJviWXl6X8oOoC21Q7k+6hWKM1eZBYrz4keTcj42CUPLWUe56fw5A/2G
         J6Z92s/1dy/WlzVZPc+/jW/CIiejOpM40IUHOa90ZxrDtjddVZN9hCn16vuDbcD8Ps
         CkDE5/BD6CRQXP7RfRyBngvDqT9P8ZGR6bpNbNZY=
Date:   Wed, 20 May 2020 18:17:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20200520083516.2120802-1-lkundrak@v3.sk>
References: <20200520083516.2120802-1-lkundrak@v3.sk>
Subject: Re: [PATCH] ASoC: mmp-sspa: Fix the error handling in probe()
Message-Id: <158999503367.4807.15705967670453692304.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 10:35:16 +0200, Lubomir Rintel wrote:
> If we fail after pm_runtime_enable(), we fail to undo it. Same with
> clk_prepare_enable(). Let's order them after all things that can fail.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mmp-sspa: Fix the error handling in probe()
      commit: 6ea460d52299f7febd408f2710d7c43ce505bc2c

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

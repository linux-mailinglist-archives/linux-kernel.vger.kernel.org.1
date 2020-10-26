Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3165A299AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408322AbgJZXqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408275AbgJZXql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:46:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8D320882;
        Mon, 26 Oct 2020 23:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756001;
        bh=LKn6oqIl5RpMUcNIMotdIsHsUfcUCV5vWMfGhdPikTQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=p0dsSoumzWgHa6VY5Ue7pGk9dQ0AM6FOJnMD/FCAZJbBCoRGq/b9E55hCJUvWTQKB
         kNPbOdC9Wj114QRer4SiuUaMgBan9G6DHdLteAAb7RGLLJK9sxeIZl8FGGoYsa91Jh
         N59fzGLSnT0H9ScwBeH2hwEce7Y/hS0iAoC6sAD8=
Date:   Mon, 26 Oct 2020 23:46:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Virendra-Pratap.Arya@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Prike.Liang@amd.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Murali-krishna.Vemuri@amd.com
In-Reply-To: <1603476441-3506-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1603476441-3506-1-git-send-email-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: support other audio modes for raven
Message-Id: <160375592348.31132.12853019912954709165.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 23:37:17 +0530, Vijendar Mukunda wrote:
> ACP supports different audio configurations other than I2S.
> This patch will fix acp driver probe failure for other audio
> configurations.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: support other audio modes for raven
      commit: efb38304c550cd7abf1a855074a73dc4a8874aa0

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

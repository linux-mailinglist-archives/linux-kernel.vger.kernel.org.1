Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FEC1E6196
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbgE1NCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390108AbgE1NCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:02:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A36C720814;
        Thu, 28 May 2020 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590670936;
        bh=VoSQzKYtLCUTsa0AKZn5+payN+7CBZ4eEixg97++jr4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=R4sSAYEaKJLFNGTOX08qI/mjhEJsSTgRZ3OWq7Ck/1tZe0E89BphMRX+W1ueVgIe4
         BKwJdlOKJDBX/w1oH9ibA6cBsLeo7p9v4dC8se/xD5M2DIWjVMczIE2FhzILoXvMv8
         UKhZYwKnS+Y9FCj8cMjbOvf/5Ax87l21qHWKQI7E=
Date:   Thu, 28 May 2020 14:02:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Alexander.Deucher@amd.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <1590652337-21587-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1590652337-21587-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Subject: Re: [PATCH] ASoC: amd: Removing unnecessary instance initialization
Message-Id: <159067091851.53762.1508093910500624788.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 13:22:16 +0530, Ravulapati Vishnu vardhan rao wrote:
> In DMA pointer the initialzation of instance is of no use.
> In fact it will reinitialize the instance variable which is already
> opened and functional.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Removing unnecessary instance initialization
      commit: 4a0434502191347ba8f99468f2fb2cdddc20d381

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

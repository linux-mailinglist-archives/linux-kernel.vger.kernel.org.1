Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD612C8A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgK3Q4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgK3Q4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:56:40 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9492076B;
        Mon, 30 Nov 2020 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606755359;
        bh=7Vk28EpWuHZuMnrQqTFNVfiCs4UlJCZKrdZFJcP3amk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=PWlBhokstXIrt3HShF+u0MtDphfvLTvqH/VUpu4q1S5g7N1fbQjHvJ9uzeb6VVqLM
         YaHrWqeAEvSiw4KWEXyYy+byh161jIrXzbHhv9Tis+sOfIJCXnPM7wpoXSEVFo1vR9
         rDSAMxpKEY+xOzmDG8uqQ+QEdF0pS0Z4GRLLYx88=
Date:   Mon, 30 Nov 2020 16:55:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lumi Lee <Lumi.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Lumi Lee <lumi.lee@mediatek.com>, linux-kernel@vger.kernel.org,
        Shane.Chien@mediatek.com, eason.yen@mediatek.com,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-mediatek@lists.infradead.org, jiaxin.yu@mediatek.com,
        alsa-devel@alsa-project.org
In-Reply-To: <1606705875-1940-1-git-send-email-Lumi.Lee@mediatek.com>
References: <1606705875-1940-1-git-send-email-Lumi.Lee@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: btcvsd fix tx stream assign
Message-Id: <160675530955.30326.8266521477804403197.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 11:11:15 +0800, Lumi Lee wrote:
> Fix tx/rx stream assign in write.
> Write should use tx instead of rx.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: btcvsd fix tx stream assign
      commit: bbe1f69dce94089943cc407a88325ae7e851d49c

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

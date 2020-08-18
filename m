Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAEB248C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgHRQyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgHRQya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:54:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5FE207D3;
        Tue, 18 Aug 2020 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769670;
        bh=PMfzfiAqcPXlXu5+PpIhojgS7cmHoB6sX8LG4lMXi2w=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=YFq50sSU6RhGrWc8t9xZbk8wknnIp+Ww/9n7oWuNyKIZZbeAPtGN4NZQc4ZZ5rd6Q
         zQG4Y2V5KY26/BDLJIX3GqzgqJzQEfsazBMxEADKagIDb2LaDbfXpD/5e9YIQSkdG1
         IfNVshfsGPXBVidoAt8+RmCd+motEqtqWb6Vf/xE=
Date:   Tue, 18 Aug 2020 17:53:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200808012156.10827-1-rdunlap@infradead.org>
References: <20200808012156.10827-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: SOF: delete repeated words in comments
Message-Id: <159776961931.56094.1084906977146137662.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 18:21:56 -0700, Randy Dunlap wrote:
> Drop the repeated words {that, the} in comments.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: delete repeated words in comments
      commit: 8932f0cb20e815478a5aaa6ff2850ff25f10a2fe

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

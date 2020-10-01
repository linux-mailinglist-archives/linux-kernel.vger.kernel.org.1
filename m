Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD72280A71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbgJAWrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgJAWrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:47:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13172074B;
        Thu,  1 Oct 2020 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601592459;
        bh=HaZK10shVaF0sGBaLYo+hXt29nlPICTj9C3MPvCxu7g=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=unZSUCVlkb3tzf5YIxFgWSj54QCJtrbpghNBF2+OQwr6GQDmuQEtpvZWl0vgvgsha
         gE/2fTuvyM5PLlQlZP3EzNKr+fG+le7Q7ZUcjTgSRXlG/2Vh8oaImbVhMX7bh4uVw7
         76BSP5vprMUx0G+Q1wMZj8WfKDIhQlN1eXWj/oDo=
Date:   Thu, 01 Oct 2020 23:46:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200826184851.3431531-1-robh@kernel.org>
References: <20200826184851.3431531-1-robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: sound: Remove unused 'linux,hdmi-audio'
Message-Id: <160159237545.44588.11956509419329615135.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 12:48:49 -0600, Rob Herring wrote:
> The binding was added in 2013 and has had no driver since 2015.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Remove unused 'linux,hdmi-audio'
      commit: 08dd413b9ddf253ec3ee783a0a21df3754823be9

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A50268E95
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgINO5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgINOwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:52:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2A020936;
        Mon, 14 Sep 2020 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095123;
        bh=1qKTCFyAmrhl/DWjwf+6VgDKAdfgJ17CixfdpPZvgzg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xK9lRKLus8ZTZ5sP7mazOB8h5jM837B0pptkzyLD7irDdWvrqWKnFOsSh1FQKxzaG
         SD9XV4grMNOZdvog2Y5Jgr/u+ynVWIydfGDhPRSTjw5deRqvotddJbb0lVL9IaRBB1
         pyqgJpp/UhbMLVVR5MGBbR/5ktLTsFN23YwgzodY=
Date:   Mon, 14 Sep 2020 15:51:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        lgirdwood@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200910124110.19361-1-peter.ujfalusi@ti.com>
References: <20200910124110.19361-1-peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/2] ASoC: ti: j721e-evm: Support for j7200 variant
Message-Id: <160009506911.439.3955483489656494834.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 15:41:08 +0300, Peter Ujfalusi wrote:
> Changes since v1:
> - Suffix the 2359296000 constant with 'u' to silence C90 warning
> 
> When j7200 SOM is connected to the CPB, the audio setup is a bit different:
> Only 48KHz family have clock path, 44.1KHz is not supported.
> 
> Update the binding documentation and add support for the j7200 version of CPB
> to the driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: ti, j721e-cpb-audio: Document support for j7200-cpb
      commit: 18790b1b514a202bae2863a4206b731d95302c85
[2/2] ASoC: ti: j721e-evm: Add support for j7200-cpb audio
      commit: 18c140f4a2de8fa674d52fe522a47133bc124f81

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

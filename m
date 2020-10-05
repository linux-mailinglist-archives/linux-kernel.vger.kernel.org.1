Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE190283DD1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgJERz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJERz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:55:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19E7207EA;
        Mon,  5 Oct 2020 17:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601920526;
        bh=4FL2WP+sZ5wxfVSHRf2Y6lLmzew/o0G2OM8zh3xVsgw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sy3wEbq/l2yutVhDD2hGkwz1WUK8j4qOScd7ZFRSQlm4SWtQOnIc2+OMaQtkwWBbf
         UFUEjIwAaYj8lqzdtK3KvKFG7hrnnMWy2LHSRYwQsr3cttxIGShJ57YnANGcK091nm
         /MqmBFstgWsr3QTM8hQYx8IgT8Ugf9LI4Iw+NIrA=
Date:   Mon, 05 Oct 2020 18:54:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3d92de2085f0c074929861a2f791bf4070920e83.1601885841.git.matti.vaittinen@fi.rohmeurope.com>
References: <3d92de2085f0c074929861a2f791bf4070920e83.1601885841.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 1/2] dt_bindings: bd9576: fix regulator binfdings dt node names
Message-Id: <160192046344.23248.15447268991853037169.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 11:18:19 +0300, Matti Vaittinen wrote:
> Add regulator- prefix to allowed regulator node names. Prefix is expected
> by the driver and the actual binding yaml description.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: bd9576: fix regulator binfdings dt node names
      commit: f2deb05688c25ac124a7e33bc15b1ab13d7fb1a7
[2/2] regulator: bd9576: Fix print
      commit: 184cdb8f6d391b379bb768b0c203600f5657176b

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

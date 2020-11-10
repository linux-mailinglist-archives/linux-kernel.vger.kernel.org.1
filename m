Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5A12AE1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbgKJVil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731835AbgKJVih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:38:37 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CC220781;
        Tue, 10 Nov 2020 21:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044316;
        bh=dgOd62ts9MM78yNB2GQQA/SbpUMuq+0/JcYE5GzSNHk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=PpH6qh3oOVThWo1xCQTDrVXxhEdJlhwxLro6vqIlESdpEJucyUlv2guRYgVkShd0j
         TKKjVZn6ApkfA8TzDAMibv1n2OJTg98RrEEQhvPyLr4AQLjWSM7DniecDnFKRqn1mX
         JieFoOvuBIVRHGsB5H1RQnC3fVoM0IQyLpEDVeus=
Date:   Tue, 10 Nov 2020 21:38:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        matti.vaittinen@gmail.com, mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
In-Reply-To: <cover.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH 0/3] regulator: bd718x7: support voltage scaling
Message-Id: <160504430244.42164.13300869438079572457.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 10:19:16 +0200, Matti Vaittinen wrote:
> RFC for adding a support for typical voltage scaling connection
> 
> In few occasions there has been a need to scale the voltage output
> from bucks on BD71837. Usually this is done when buck8 is used to
> power specific GPU which can utilize voltages down to 0.7V. As lowest
> the buck8 on BD71837 can go is 0.8V, and external connection is used to
> scale the voltages.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: BD71837 support commonly used feedback connection
      commit: 1e908b2419ea828dfad9819e5c01322a93665356
[2/3] regulator: BD71847 support commonly used feedback connection
      commit: b54a27d8109fc8f18cec3e0663f8e81ea727e3c6
[3/3] regulator: bd718x7: Support external connection to scale voltages
      commit: d2ad981151b3a812e961c8ee0ffd7e349b4027d6

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

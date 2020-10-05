Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749D3283DD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgJERzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJERzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:55:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0AA20853;
        Mon,  5 Oct 2020 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601920531;
        bh=jp+U+ck1Rqz4JGgglDfEzY71ZyC8Djdl4McACEYAssQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=i0CnABv00N3WhW0gIr3a8jbMnsWSi5dhvCamNun595pa2tVq6YjLj9YXpDQwHfZHJ
         1tYJRvUljdx+LHPra39ponk1H3a/0r72EKazkwW48BVbrSQ4M/g3PjcdgCMFqlcQ8n
         V98sRbsuQY1fBk8b1lmyn0sQH+zLDQFYM4TE02tw=
Date:   Mon, 05 Oct 2020 18:54:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20201005131546.22448-1-geert+renesas@glider.be>
References: <20201005131546.22448-1-geert+renesas@glider.be>
Subject: Re: [PATCH] regulator: Make constraint debug processing conditional on DEBUG
Message-Id: <160192046344.23248.4806900613531187946.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 15:15:46 +0200, Geert Uytterhoeven wrote:
> If debugging is disabled, print_constraints() does not print the actual
> constraints, but still performs some processing and string formatting,
> only to throw away the result later.
> 
> Fix this by moving all constraint debug processing to a separate
> function, and replacing it by a dummy when debugging is disabled.
> This reduces kernel size by almost 800 bytes (on arm/arm64).

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Make constraint debug processing conditional on DEBUG
      commit: c845f21ad86528f888db27849f2d315e08126816

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

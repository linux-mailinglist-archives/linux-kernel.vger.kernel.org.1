Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567FE248C33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHRQ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728542AbgHRQ5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:57:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1255420786;
        Tue, 18 Aug 2020 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769824;
        bh=XZEu+054owukh/CD+zNMN7eD5GYsUepDZpyJCKR6s9o=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kjl1W+h48zNGn1DkV/nuYz5gHXURZ/VOcNokiiHZY1MngzhZQkSWwLF3rmjIh5Zn6
         a2IOMKFvbeFrmzIj3wm+I8XvySQB+zlqrnA3G0br10VOUamMW5gM/+iPkDs5AVPBPc
         7w//2jRnS0JTH1rCfKZEvNoFsmS0397+iBbYFitg=
Date:   Tue, 18 Aug 2020 17:56:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        cy_huang <u0084500@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, gene_chen@richtek.com
In-Reply-To: <1597418824-15906-1-git-send-email-u0084500@gmail.com>
References: <1597418824-15906-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH 1/2] regulator: rt4801: Add support for RT4801 Display Bias regulator driver
Message-Id: <159776976828.56451.5989906126815444846.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 23:27:03 +0800, cy_huang wrote:
> Adds support for the RT4801 DSV. It has two regulators (DSVP/DSVN) with
> an I2C interface. DSVP/DSVN can provide the display panel module for the
> positive/negative voltage range from (+/-)4V to (+/-)6V.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rt4801: Add support for RT4801 Display Bias regulator driver
      commit: 5bbbfc7f7f0a44b7a85ab3872dd2ccce7019f7b1
[2/2] regulator: rt4801: Add DT binding documentation
      commit: fd6b928db8a05fcd8629320c52eae214a8615aae

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

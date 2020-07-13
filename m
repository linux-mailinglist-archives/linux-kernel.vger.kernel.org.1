Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF6921B9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 17:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGJPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 11:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGJPkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:40:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC607207BB;
        Fri, 10 Jul 2020 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594395610;
        bh=VAfyhdyVlJGukXymuaJOOOe9OISmXnSeudSlcdj0CKA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HXCFt5lKqBTaZNileVrl5UQGw4G1ThBW4KQN7hJsuKoLeIKCaTT6UoKEslJcEx3+k
         cvyQ9WUlJbMBTJ55ndadH2U7lZBUMGx7u3NK/rLIBcEbVIvmHcV8SLNTrDqt8UvjYH
         Z6Fys5QKkTNj4x5J+YYQOXRHNUA86eezb1lb3ae0=
Date:   Fri, 10 Jul 2020 16:40:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Message-Id: <159439560434.49155.3221697114342541605.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 19:12:32 +0300, Andy Shevchenko wrote:
> Make regmap firmware node type agnostic by switching it to use fwnode.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Switch to use fwnode instead of OF one
      commit: c916d6ef53aa6cf0187d33dfab51a2917d4117b7

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

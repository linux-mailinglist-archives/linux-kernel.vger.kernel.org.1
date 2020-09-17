Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1FB26E4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIQS77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbgIQS6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F64A2220A;
        Thu, 17 Sep 2020 18:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369129;
        bh=yTLI+rmR2x0YXqF9pQB/9hS2QvuhEFgDgNGVM0hRdXY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hMQ56Weu1ZshVjxQe++IJl/0TryM4A9lUz6NicFMk2VCtho6sqWkAYy2sqyFJbJhk
         fxJ0lQLuu3wjdnuZ01e13qT/tpRVQuRprawS/fLpe6QimlTCdw+4NQqUe1kasrG9R1
         xkQPzh/+X2ir+pJrFL2aCaADkdddjCTuKFmXDggo=
Date:   Thu, 17 Sep 2020 19:57:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200917114727.1120373-1-ribalda@kernel.org>
References: <20200917114727.1120373-1-ribalda@kernel.org>
Subject: Re: [PATCH v2] regmap: Add support for 12/20 register formatting
Message-Id: <160036907918.20286.2083108060428504385.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 13:47:27 +0200, Ricardo Ribalda wrote:
> Devices such as the AD5628 require 32 bits of data divided in 12 bits
> for dummy, command and address, and 20 for data and dummy. Eg:
> 
> XXXXCCCCAAAADDDDDDDDDDDDDDDDXXXX
> 
> Where X is dont care, C is command, A is address and D is data bits.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Add support for 12/20 register formatting
      commit: 0c2191c3da345e0fe73118445ddb1f0df114aadf

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

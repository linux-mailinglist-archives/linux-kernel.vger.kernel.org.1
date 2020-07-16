Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78166222F86
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 01:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGPX6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 19:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:58:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B0320760;
        Thu, 16 Jul 2020 23:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943888;
        bh=f8n5yjqBAbcLQ1byrTMj/qrzXAasvoVcBJkg0yYapgQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=R3/tV7x8LIFXv96pWMl8xnNheXxCzbAMZLbl7UiBH3zyaEeEqLMJ1srAbF2PfeXUo
         jXyQyETOaRJffFQZ1bhNOg0jNduT+GEBGDU7JLLwE/KfCONZ9uQt4oY6fVtQDjCUWH
         0FMQr9E5+GupvpYwix9MmUtIUGDWI8dj833Tk6tE=
Date:   Fri, 17 Jul 2020 00:57:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Richard Fitzgerald <rf@opensource.wolfsonmicro.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rohit Kumar <rohitkr@codeaurora.org>
In-Reply-To: <20200715164611.1.I35b3533e8a80efde0cec1cc70f71e1e74b2fa0da@changeid>
References: <20200715164611.1.I35b3533e8a80efde0cec1cc70f71e1e74b2fa0da@changeid>
Subject: Re: [PATCH] regmap: debugfs: Don't sleep while atomic for fast_io regmaps
Message-Id: <159494387342.42385.3653769837072833103.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 16:46:15 -0700, Douglas Anderson wrote:
> If a regmap has "fast_io" set then its lock function uses a spinlock.
> That doesn't work so well with the functions:
> * regmap_cache_only_write_file()
> * regmap_cache_bypass_write_file()
> 
> Both of the above functions have the pattern:
> 1. Lock the regmap.
> 2. Call:
>    debugfs_write_file_bool()
>      copy_from_user()
>        __might_fault()
>          __might_sleep()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: debugfs: Don't sleep while atomic for fast_io regmaps
      commit: 299632e54b2e692d2830af84be51172480dc1e26

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

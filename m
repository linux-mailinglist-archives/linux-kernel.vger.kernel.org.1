Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02A0248C24
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgHRQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgHRQ4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:56:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A4C2083B;
        Tue, 18 Aug 2020 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769766;
        bh=V0gIKXHRc7WtWMad/EM5E+ugoy/k2S15r42+s4jRwKc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=M+v6KNQuO27FHS4W3SHPLdfaWTenkNBBzqpOzqo9m3odkILqw06/K7NL+JdGz506q
         ElUfIzlp09qs15ActbjcLVky8gV/PmC2Q1iqWa4QkVIQ1yy/R6+V4h6e6EthEHysej
         gQQNTq497RV5ygGJdY4uktGTjSmtSXtQ95ThAaHc=
Date:   Tue, 18 Aug 2020 17:55:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Youling Tang <tangyouling@loongson.cn>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <1597299157-32221-1-git-send-email-tangyouling@loongson.cn>
References: <1597299157-32221-1-git-send-email-tangyouling@loongson.cn>
Subject: Re: [PATCH] sound/soc/intel: Fix spelling mistake "cant" --> "can't"
Message-Id: <159776961932.56094.17997972202673075473.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 14:12:37 +0800, Youling Tang wrote:
> There is some spelling mistakes in a dev_err message. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound/soc/intel: Fix spelling mistake "cant" --> "can't"
      commit: ade5376dff579e759cd40cf7831306173bb875cf

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

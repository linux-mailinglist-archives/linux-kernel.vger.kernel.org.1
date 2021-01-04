Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B706D2E9C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbhADRlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:41:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbhADRlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:41:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCCC9206A4;
        Mon,  4 Jan 2021 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609782069;
        bh=kpsTHALVkfBJDu2JCXHzvLv++yXy1rO2x/VySKZPe2Q=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ZDLZsRT1/HasZN03n0qC7MqTNZ/DUc+unriRciKwd56dD4Vst1cCYDzcTP/0NhmuU
         jRw4QUVVceOQ96QBOBNM9FLr3ILrR31ObhZ15B2oa0++fnKG/7pDR1tgjnfrROANPb
         mH/xEfaZbk3oYIKgJLlRbj3exWklHB3rHo11lL09DfAEV7vI2G2VHNwPAcTBMIgVzV
         K8Tpf6t5i/WTTARriZ/Wsl6n3bqXU8hwhPLArwO/XWeCx876jQwKEWllrXVFqyAEmB
         qcOtdd3leohXnYuJngbl1xcgV+ZCWBYV3jbS7LrRHNHXH/m8NfIS4awwxQpLnpjQCv
         YDPN9xAF0DzLg==
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Scally <djrscally@gmail.com>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210103165541.784360-1-djrscally@gmail.com>
References: <20210103165541.784360-1-djrscally@gmail.com>
Subject: Re: [PATCH] regulator: core.c: Replace references to non-existent function
Message-Id: <160978203769.14485.1414576589830773531.b4-ty@kernel.org>
Date:   Mon, 04 Jan 2021 17:40:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jan 2021 16:55:41 +0000, Daniel Scally wrote:
> The function regulator_set_device_supply() is referenced a few times in
> comments in regulator/core.c; however this function was removed a long
> time ago by commit a5766f11cfd3 ("regulator: core - Rework machine API to
> remove string based functions."). Update those references to point to
> set_consumer_device_supply(), which replaced the old function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core.c: Replace references to non-existent function
      commit: 90cf443d841e41af7fceb26aed6553e43670fe42

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

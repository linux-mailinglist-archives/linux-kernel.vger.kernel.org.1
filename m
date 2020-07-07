Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28C216E85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGGORa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 10:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGGOR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:17:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CD920773;
        Tue,  7 Jul 2020 14:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594131449;
        bh=JvMHWS5oVH4hJWhlbLg3xOagK5SJNSGlwa487H/MIj0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sAfOmiyf8FHFWKOA6FwaxwupDn1VBbapkTzn+i6k/rVy8xYFmWsZn5ZYG3i5u/jm7
         Ip0g94Gq0sMn6tahJkEelS0HPHNK4BnzNDrUJLNoe4UPdYVDvhfBd2GQIrulNt1aRx
         atJusenmrdQQCelNdL6Ew9Q0dZLKWmxR1sc4I8AI=
Date:   Tue, 07 Jul 2020 15:17:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     timur@tabi.org, shengjiu.wang@nxp.com,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Li.Xiubo@freescale.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20200702193102.25282-1-nicoleotsuka@gmail.com>
References: <20200702193102.25282-1-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
Message-Id: <159413142466.34737.11451730915770619660.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 12:31:02 -0700, Nicolin Chen wrote:
> Add Shengjiu who's actively working on the latest fsl/nxp audio drivers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
      commit: 503ed52225ed3d369c8e0dedf13556a7bc1e5c2b

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

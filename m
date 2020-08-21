Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89EB24DB81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgHUQmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 12:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbgHUQkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:40:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CA620732;
        Fri, 21 Aug 2020 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598028041;
        bh=1MocLwdctpw0AUTznGyYSSK7o0P/XgjT00MHoXd4ZwM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ryEEqGRnrEERt6cHfGWHz564SS3jhVD3Iwh/UiId5k0yWJxYDRTrDlFZtCNndjF6S
         nswehkbNAps20X4XVcBF41iga1gMjeuQKUag4nenMrA0KCDCBOlEK80qY+XWLjmJQU
         mydhZdAgqNRlMZKcocpvELQSclnDJZ92n2snS32s=
Date:   Fri, 21 Aug 2020 17:40:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200821142229.12087-1-festevam@gmail.com>
References: <20200821142229.12087-1-festevam@gmail.com>
Subject: Re: [PATCH] regulator: dbx500: Remove unused debugfs goto label
Message-Id: <159802800846.25815.13450132464470566684.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 11:22:29 -0300, Fabio Estevam wrote:
> The following build warning is seen after commit 8bdaa43808b7 ("regulator:
> dbx500: no need to check return value of debugfs_create functions"):
> 
> drivers/regulator/dbx500-prcmu.c:144:1: warning: label 'exit_no_debugfs' defined but not used [-Wunused-label]
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Remove the unused label and its associated error message.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dbx500: Remove unused debugfs goto label
      commit: c0e53a448637366064d4b9ce586b68ced679cd22

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

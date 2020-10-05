Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D32283DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgJERzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJERzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:55:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B8E20853;
        Mon,  5 Oct 2020 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601920520;
        bh=gXDwOT6c/AYgJbKA0QoG04IhnuZ9Nx84FNSyNaJebGY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lKwnfQViORZmt+YhR/2raWfayhg0gvgcMcPUpATrurYBErJnq0bNJLTzYUJFg/e7y
         qRdmb3NYfpBwoq3aKGfbAAeEaUB50ELkVTeaW/3Lchp1SpFuv8SybEZGjDf3s5ubol
         9Ckp324H4ppJL/QBfJkMsVOU6Ma87F/yN6amT8ao=
Date:   Mon, 05 Oct 2020 18:54:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.kandagatla@linaro.org
In-Reply-To: <1601907440-13373-1-git-send-email-lkasam@codeaurora.org>
References: <1601907440-13373-1-git-send-email-lkasam@codeaurora.org>
Subject: Re: [PATCH v3] regmap: irq: Add support to clear ack registers
Message-Id: <160192045755.23221.11220963370176448691.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 19:47:19 +0530, Laxminath Kasam wrote:
> For particular codec HWs have requirement to toggle interrupt clear
> register twice 0->1->0. To accommodate it, need to add one more field
> (clear_ack) in the regmap_irq struct and update regmap-irq driver to
> support it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: irq: Add support to clear ack registers
      commit: 3a6f0fb7b8eb5ef0447da1332225b8c87ee207d0

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

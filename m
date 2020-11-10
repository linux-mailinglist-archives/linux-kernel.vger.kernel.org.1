Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9EB2ADB24
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgKJQC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731147AbgKJQC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:02:58 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42076206E3;
        Tue, 10 Nov 2020 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605024177;
        bh=WJXkq/qLfyFh+DckIEnAcIep+CU9DCKkiyIv2h4DaAQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ztGWDagnj0CVj5lK0DWRoyRfrfi34z17w/bnM1KqBFCDhDMXCDVLyrEQH/sjEJW0C
         6etHtbnkrQPb+OXt7ADwznVBjbDH+iUZj8riUog3l+4y3wzBg6n4Cxm0npMIuIFXml
         mltGcr0THDT1vpNd3OC2LgRWPFHg0e2styF5GdaQ=
Date:   Tue, 10 Nov 2020 16:02:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, jiaxin.yu@mediatek.com,
        devicetree@vger.kernel.org, chipeng.chang@mediatek.com
In-Reply-To: <1604975492-6142-1-git-send-email-shane.chien@mediatek.com>
References: <1604975492-6142-1-git-send-email-shane.chien@mediatek.com>
Subject: Re: [PATCH v3 0/2] Fix vaud18 power leakage of mt6359
Message-Id: <160502414080.45830.9030480275474005075.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 10:31:30 +0800, Shane Chien wrote:
> This series of patches is to fix vaud18 power leakage problem.
> vaud18 will be enable only when mt6359 audio path is turned on.
> 
> Change since v2:
>  - fix dt-binnding syntex error
> 
> Change since v1:
>  - use dapm regulator supply widget for vaud18 control.
>  - add vaud18 regulator property in mt6359 dt-binding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Fix vaud18 power leakage of mt6359
      commit: 64a70744b77898a15d7a5b2b4dc0fa9523a75cde
[2/2] dt-bindings: mediatek: mt6359: Add new property for mt6359
      commit: 08651373808e16b01d3b12207f52504c17b6774c

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

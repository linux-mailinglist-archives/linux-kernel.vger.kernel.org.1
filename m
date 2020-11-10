Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3142ADB22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbgKJQCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731147AbgKJQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:02:52 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C7B9206E3;
        Tue, 10 Nov 2020 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605024171;
        bh=zXJzxlqrDXjwHoe0WtD8Q+HuDkefhOc5640F5QOPA0g=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=shQWMVPOIBNQn2K+LVpo1Uw7Tnb7WyHmJdF4Dds5ULdWGCSkzfSRffYw5hdcZ6VcO
         WfVRpZAhYT2Hopewd4EKiCqd8IWwu7u1YfJQtum24uN/ncNrnZEpu7nWh9rh1i7hNT
         t+6uwYoW8fqQEh4Y7JeoRpE8udsUVRU3RNSrqykw=
Date:   Tue, 10 Nov 2020 16:02:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        linux-kernel@vger.kernel.org, jiaxin.yu@mediatek.com,
        devicetree@vger.kernel.org, chipeng.chang@mediatek.com
In-Reply-To: <1604914209-9174-1-git-send-email-shane.chien@mediatek.com>
References: <1604914209-9174-1-git-send-email-shane.chien@mediatek.com>
Subject: Re: [PATCH v2 0/2] Fix vaud18 power leakage of mt6359
Message-Id: <160502414079.45830.15406364369794796791.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 17:30:07 +0800, Shane Chien wrote:
> This series of patches is to fix vaud18 power leakage problem.
> vaud18 will be enable only when mt6359 audio path is turned on.
> 
> Change since v1:
>  - use dapm regulator supply widget for vaud18 control.
>  - add vaud18 regulator property in mt6359 dt-binding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Fix vaud18 power leakage of mt6359
      commit: 64a70744b77898a15d7a5b2b4dc0fa9523a75cde

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C029281D38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJBU5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBU5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:57:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D35E206B6;
        Fri,  2 Oct 2020 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601672274;
        bh=S2pK2zZphyllgyoDUlqH+n0UMNxZEfNf9+OmkuBwScQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pLwh4XEcLHi7PZ5/bow9lhh+VH5AwTBKsvoc37/61s0PqAxj/C1HgTVWOCZQEEzpf
         Mj0Mbm9oluHysFQou+S9mE3O9cDg3boPZDxWDCnMWzjfvplglxho0c+fzaH5RqGv3Z
         9R0kr/jhyDMhOh6ks9fQNHvzbRofwGL7+sA8wAP4=
Date:   Fri, 02 Oct 2020 21:56:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Cc:     robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        lgirdwood@gmail.com, nicolas.ferre@microchip.com, tiwai@suse.com,
        ludovic.desroches@microchip.com
In-Reply-To: <20201002160305.815523-1-codrin.ciubotariu@microchip.com>
References: <20201002160305.815523-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH 0/2] Add driver for Microchip S/PDIF RX
Message-Id: <160167211499.21762.18186234770386677649.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 19:03:03 +0300, Codrin Ciubotariu wrote:
> The Sony/Philips Digital Interface Receiver (SPDIFRX) is a serial port
> compliant with the IEC-60958 standard. Among its caracteristics, we
> mention the following:
>  - SPDIF/AES-EBU Compatible Serial Port
>  - 32 Samples FIFO
>  - Data Width Configurable to 24 bits, 20 bits or 16 bits
>  - Packed and Unpacked Data Support for System Memory Optimization
>  - Line State Events Report and Source of Interrupt
>  - Line Error Rate Report
>  - Full Memory Map of 192 bits for Channel 1 and Channel 2 Status and
>    User Data
>  - First 32-bit Status A, Status B Change Report and Source of Interrupt
>  - Line Digital Filter
>  - Register Write Protection
>  - Abnormal Software Access and Internal Sequencer Integrity Check Reports
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: add DT bindings for Microchip S/PDIF RX Controller
      commit: 80db8751d7c0bebe11e62df19cec9cb0a392c354
[2/2] ASoC: mchp-spdifrx: add driver for SPDIF RX
      commit: ef265c55c1ac0f02c74a33d8e054547f7eafc81b

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634E72AC560
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbgKITsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730858AbgKITsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:48:14 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066FB2074F;
        Mon,  9 Nov 2020 19:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951293;
        bh=wqG6ZhGfatserg4suD0f4VsjtlLGT91eR9zQ6qB+ucc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ovBiSLiaqUwvgL/D6qNgTpVEze3Mc/BDLims+fDnvSjIjCP2nx2dVfSAMhM66SQR3
         WxDjh+Vh7daM4WLqWzYZuRcQFnY3psY2LIn2rPDmsf4L0e2CMgIv26yx6LHqtdtBlh
         I8uVMgrQdkLXfFw7R8MpkIwj+VqMU/5qT2aFyYGo=
Date:   Mon, 09 Nov 2020 19:47:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     devicetree@vger.kernel.org, kernel@axis.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201109085438.16230-1-vincent.whitchurch@axis.com>
References: <20201109085438.16230-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH] dt-bindings: regulator: da9121: Use additionalProperties
Message-Id: <160495127967.49303.8652990185515477963.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 09:54:37 +0100, Vincent Whitchurch wrote:
> There's no $ref at the top level so use additionalProperties instead of
> unevaluatedProperties.
> 
> This fixes the following warning with the latest dtschema:
> 
>  Documentation/devicetree/bindings/regulator/dlg,da9121.yaml:
>  'additionalProperties' is a required property

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: Use additionalProperties
      commit: 285654130d5c1bed000be6b94cd43b5110d16090

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

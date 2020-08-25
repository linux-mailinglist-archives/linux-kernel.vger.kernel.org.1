Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15E22521D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHYUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 16:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYUUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:20:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 399262074D;
        Tue, 25 Aug 2020 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598386815;
        bh=AEwYsU17mS1t1jHrYO6/FQ0OsOkQ1xN3BKyIkh1Lvno=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=o1Xjbv7ysOfZo36TYkwoF58ZvMptTifpe17VSMxic9/3DqU+VwFdwTEYJany6169U
         X7FBGyDWsATHOPPrYfaYUUuapP7nufLdVz1fclsf+fdbmawYcM+SrHhh30eW18e3Ww
         +2+UdPZ1AR+vQci9WCEnPj+5LnhL8CfSCHxXQV7Q=
Date:   Tue, 25 Aug 2020 21:19:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Cc:     lgirdwood@gmail.com, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200825101250.9485-1-broonie@kernel.org>
References: <20200825101250.9485-1-broonie@kernel.org>
Subject: Re: [PATCH] regulator: rt4801: Specify additionalProperties: false
Message-Id: <159838678020.41693.8110070729465787800.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 11:12:50 +0100, Mark Brown wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt4801: Specify additionalProperties: false
      commit: ab6019d7fe81ecd28eff8ea87bb2388e56212200

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

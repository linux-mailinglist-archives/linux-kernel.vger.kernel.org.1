Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C502C1C8A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEGMSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 08:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgEGMSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:18:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AA23208E4;
        Thu,  7 May 2020 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588853896;
        bh=MSkChxFZqIspRLCauSd0CqP4IKv9LrIyPZ388vIuY7k=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HdHgVWug8sOeiIUH0XthCnuDAbPqcWRNCMQy+00dXYQ/3BGhDowdVJCi+5oT+fiVi
         2j8PCk9mYTnbPiHxkicqfuuDr3evannnwYXnw8zrjlcmKlad4XgzqzD/9OAAfuvUeN
         EqP19g+z2+/OzJq7BVp4kT05T+biuRQ1l5d8vP7g=
Date:   Thu, 07 May 2020 13:18:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, ChenTao <chentao107@huawei.com>,
        Xiubo.Lee@gmail.com, timur@kernel.org, nicoleotsuka@gmail.com
Cc:     festevam@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200507022959.183739-1-chentao107@huawei.com>
References: <20200507022959.183739-1-chentao107@huawei.com>
Subject: Re: [PATCH -next] soc: fsl_asrc: Make some functions static
Message-Id: <158885389338.38935.7126937131103152522.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 10:29:59 +0800, ChenTao wrote:
> Fix the following warning:
> 
> sound/soc/fsl/fsl_asrc.c:157:5: warning:
> symbol 'fsl_asrc_request_pair' was not declared. Should it be static?
> sound/soc/fsl/fsl_asrc.c:200:6: warning:
> symbol 'fsl_asrc_release_pair' was not declared. Should it be static?
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] soc: fsl_asrc: Make some functions static
      commit: c16e923dd635d383026a306acea540b8e0706c88

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

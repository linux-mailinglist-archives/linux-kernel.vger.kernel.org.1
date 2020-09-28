Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0611E27B4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgI1Sw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:52:58 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:18121 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgI1Sw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:52:57 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4C0WqV6RpFz3c;
        Mon, 28 Sep 2020 20:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601319175; bh=tRBvRQ9B3uw5joCA9ZCRpoEKWd6VUc0RpYzRqXVkJJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1lG081JBniHBcrmTjVWaM8/+Qs0GuKcfhfgYwBa2UaCJMQdAR6lp3/wqwsJm0TTz
         /ODBo+YnWH9XvptmZP4pTov6m5EDiJHI1AS9Kh0ZKnrakB6COivieyopyzFbC/ih20
         RlrRbsUHym/Vu4Pam1XofMQ5vIztHvRmBWD/V0a+rQevLO/Fr7Mgr7a3+Ig8oLDCOl
         hv0JOTTkzDhvSNh/BydKP25kho5t5L7ZdxP6ohu3YC4BhsVyY6mq3sXBBsQoHVDcEw
         w+eLzRq0Z6lahU7boMwzA0GcoYtkKgAOAwNecYKjCa02Elys2ztcOBNxl+sAYHlRpl
         fEDPyDo8zCuUg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 28 Sep 2020 20:52:53 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tegra20-spdif: remove "default m"
Message-ID: <20200928185253.GB25616@qmqm.qmqm.pl>
References: <ede103cf7f6914054a73cf8f1d9725ee13a7cf5d.1601149261.git.mirq-linux@rere.qmqm.pl>
 <20200928081026.GH2837573@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928081026.GH2837573@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:10:26AM +0200, Thierry Reding wrote:
> On Sat, Sep 26, 2020 at 09:42:40PM +0200, Micha³ Miros³aw wrote:
> > Make tegra20-spdif default to N as all other drivers do.
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > Fixes: 774fec338bfc ("ASoC: Tegra: Implement SPDIF CPU DAI")
> 
> I don't think this is warranted. This doesn't fix a bug or anything.
> It's merely a change in the default configuration. The presence of a
> Fixes: tag is typically used as a hint for people to pick this up into
> stable releases, but I don't think this qualifies.
[...]

Fixes is just for pointing where the bug or issue originated.  I usually
include it to help you -- the reviewer -- and backporters if they ever
want to use this patch. It is not specific to stable-directed patches.

For stable candidates there is 'Cc: stable' tag (no need for this patch).

> So now by default this driver will be disabled, which means that Linux
> is going to regress for people that rely on this driver.

The bug is that this driver (and only this driver in the whole
sound/soc/tegra directory) defaults to m, where all other drivers default
to n (as the policy aboud drivers seems to be [1]). This won't affect
oldconfig, allyesconfig nor allmodconfig, but will not be selected now
for clean builds - meaning less work for those not building for Tegra2.

[1] https://lkml.org/lkml/2017/11/18/257

> You need to at least follow this up with a patch that makes the
> corresponding change in both tegra_defconfig and multi_v7_defconfig to
> ensure that this driver is going to get built by default.

This I can do. Not all such drivers are enabled, though: eg. AHUB driver
is not. Maybe we need bigger refresh of the defconfigs instead?

> Given the above it's probably also a good idea to explain a bit more in
> the commit message about what you're trying to achieve. Yes, "default n"
> is usually the right thing to do and I'm honestly not sure why Stephen
> chose to make this "default m" back in the day. Given that it depends on
> SND_SOC_TEGRA, which itself is "default n", I think this makes some
> sense, even if in retrospect it ended up being a bit inconsistent (you
> could probably argue that all patches after this are the ones that were
> inconsistent instead). This was merged over 9 years ago and a lot of
> common practices have changed over that period of time.

Yes, this is a cleanup. :-)

Best Regards
Micha³ Miros³aw

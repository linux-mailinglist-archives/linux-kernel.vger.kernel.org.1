Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68363261C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgIHTOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:14:44 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41536 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731185AbgIHQEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:04:51 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3D3EEA0049;
        Tue,  8 Sep 2020 14:07:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3D3EEA0049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1599566846; bh=LS1tspQNZeiW+c3AFuszS5oyvdkH2Pdm62xxJvtgfU8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m4s2/YDCaBYRi7bdk4G/s4abyTWt71ZOimdap2NfUJM3cTnYebFwqkHczXwhd52HH
         hdQBhlBjz+P2HiK/G+lndxxyd520lIn6CgI/9XsC2tL10IKKBbV9WxEXK0CaXrJLu4
         VUkmvgt3TlNPG55e8nilhNqZ0x+m0oUb6rayGxpU=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  8 Sep 2020 14:07:09 +0200 (CEST)
Subject: Re: [PATCH 0/7] soundwire: filter out invalid PARITY errors
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <e63f8306-ed00-3f53-cc72-abb9e6f0e5cc@perex.cz>
Date:   Tue, 8 Sep 2020 14:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 18. 08. 20 v 16:06 Bard Liao napsal(a):
> Some codecs may report fake PARITY errors in the initial state. This
> series will filter them out.
> 
> Pierre-Louis Bossart (7):
>   soundwire: bus: use property to set interrupt masks
>   soundwire: bus: filter-out unwanted interrupt reports
>   soundwire: slave: add first_interrupt_done status
>   soundwire: bus: use quirk to filter out invalid parity errors
>   ASoC: codecs: realtek-soundwire: ignore initial PARITY errors
>   soundwire: bus: export broadcast read/write capability for tests
>   soundwire: cadence: add parity error injection through debugfs
> 
>  drivers/soundwire/bus.c            | 93 ++++++++++++++++++++++++------
>  drivers/soundwire/bus.h            |  4 ++
>  drivers/soundwire/cadence_master.c | 86 +++++++++++++++++++++++++++
>  drivers/soundwire/slave.c          |  1 +
>  include/linux/soundwire/sdw.h      |  9 +++
>  sound/soc/codecs/max98373-sdw.c    |  3 +
>  sound/soc/codecs/rt1308-sdw.c      |  3 +
>  sound/soc/codecs/rt5682-sdw.c      |  5 ++
>  sound/soc/codecs/rt700-sdw.c       |  5 ++
>  sound/soc/codecs/rt711-sdw.c       |  5 ++
>  sound/soc/codecs/rt715-sdw.c       |  5 ++
>  sound/soc/codecs/wsa881x.c         |  1 +
>  12 files changed, 202 insertions(+), 18 deletions(-)
> 

I tested the changes and it works on my test system. The changes are straight.
For all:

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

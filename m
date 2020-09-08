Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A77261770
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbgIHReR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 13:34:17 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41556 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731358AbgIHQPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:15:13 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8487BA0056;
        Tue,  8 Sep 2020 14:45:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 8487BA0056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1599569114; bh=b/A9QPQeR8HGF5I3TJZV1+lxFGDVaYfuxBJZUNhPV+o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TzCYYeaw9POFp0HwiKuqLbC3IcaDqlMpRHYzm/XbsldHvouu0SEZJhX6Ub7jMNWdf
         I66kqeB2khEsI0RfRKMXYFHI5weYKuCtayS9Y7w8mV5+g5C85XYbsJbojkWNINaJ1/
         zVrCmcYNFrCWVdl6WuDkvyjneHofjrywzjHWsXpI=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  8 Sep 2020 14:44:57 +0200 (CEST)
Subject: Re: [PATCH v2 0/4] soundwire: Remove sdw stream operations from Intel
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <28bd0f89-3dc5-0bf4-bf2a-dca62fddc507@perex.cz>
Date:   Tue, 8 Sep 2020 14:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 03. 09. 20 v 22:47 Bard Liao napsal(a):
> Sdw stream operation APIs can be called once per stream. Move these
> operations to dailink ops. The linked series is "ASoC: Add sdw stream
> operations to dailink ops".
> 
> Pierre-Louis Bossart (4):
>   soundwire: stream: fix NULL/IS_ERR confusion
>   soundwire: intel: fix NULL/ERR_PTR confusion
>   soundwire: intel: remove .trigger operation
>   soundwire: intel: remove stream handling from .prepare and .hw_free
> 
>  drivers/soundwire/intel.c  | 60 +++++---------------------------------
>  drivers/soundwire/stream.c |  2 +-
>  2 files changed, 9 insertions(+), 53 deletions(-)
> 

Straight patches. I tested them. For all:

Acked-by: Jaroslav Kysela <perex@perex.cz>

Note: The ASoC part must be merged in sync -
  "[PATCH v3 0/3] ASoC: Add sdw stream operations to dailink ops."

						Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

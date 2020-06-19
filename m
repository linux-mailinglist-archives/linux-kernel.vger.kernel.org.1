Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28871201525
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405610AbgFSQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 12:18:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:53537 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394578AbgFSQSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:18:32 -0400
IronPort-SDR: Yj30y8Hd6IKKG+fHb0jExhhhDmxuMjvFpUH9ZOd/BnFnzRUURVgjRu2ymtd+tgi2CjZc0JXN05
 ycSgxJ4jRUWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="141277888"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="141277888"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 09:18:32 -0700
IronPort-SDR: /DmFc+3cPqdIRaz3sIKgfeJEkOARq2UBRc1SRgPSYVfFs06DmDEwDZlGOBMJJY15Bto79enO74
 0qF3y6avS/cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="318155789"
Received: from lewest-mobl1.amr.corp.intel.com (HELO [10.255.230.148]) ([10.255.230.148])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2020 09:18:31 -0700
Subject: Re: [PATCH 2/3] ALSA: compress: document the compress gapless audio
 state machine
To:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-3-vkoul@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5c878ccf-43dd-4e13-aa6b-a6cb1e82af72@linux.intel.com>
Date:   Fri, 19 Jun 2020 09:27:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619045449.3966868-3-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +For Gapless, we move from running state to partial drain and back, along
> +with setting of meta_data and signalling for next track ::
> +
> +
> +                                        +----------+
> +                compr_drain_notify()    |          |
> +              +------------------------>|  RUNNING |
> +              |                         |          |
> +              |                         +----------+
> +              |                              |
> +              |                              |
> +              |                              | compr_next_track()
> +              |                              |
> +              |                              V
> +              |                         +----------+
> +              |                         |          |
> +              |                         |NEXT_TRACK|
> +              |                         |          |
> +              |                         +----------+
> +              |                              |
> +              |                              |
> +              |                              | compr_partial_drain()
> +              |                              |
> +              |                              V
> +              |                         +----------+
> +              |                         |          |
> +              +------------------------ | PARTIAL_ |
> +                                        |  DRAIN   |
> +                                        +----------+

May I suggest having a single state machine, not a big one and an 
additional partial one. It would help explain why in one case 
compr_drain_notify() triggers a transition to RUNNING while in the other 
one it goes to SETUP.

I realize it's more complicated to edit but it'd be easier on 
reviewers/users.

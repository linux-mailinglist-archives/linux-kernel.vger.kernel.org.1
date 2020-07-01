Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0488A210E51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbgGAPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 11:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731039AbgGAPEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:04:16 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C42420702;
        Wed,  1 Jul 2020 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593615856;
        bh=hjhEj1kmt32ON01AiaQ46U1TlOLLBrgSiID3pKEF4Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0d5o1da3fLwEiMclM/eWi3jgM7r4JKqDohkZXx+8IBbCn5CoDZhw/VYem/vlOxWzR
         Q5z6bLbTTb1h4nKrjEff2GI5zs/zuzsqDe1Ak1P27ebiCBhnasykBTdv+hhWIiJZUa
         6Om3t8BS2MQQoyi8YUufZF6UAIzhhrRBh8QRqZLA=
Date:   Wed, 1 Jul 2020 20:34:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] ALSA: compress: fix partial_drain completion state
Message-ID: <20200701150412.GC2599@vkoul-mobl>
References: <20200629134737.105993-1-vkoul@kernel.org>
 <20200629134737.105993-4-vkoul@kernel.org>
 <20200701142032.GG71940@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701142032.GG71940@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-20, 14:20, Charles Keepax wrote:
> On Mon, Jun 29, 2020 at 07:17:37PM +0530, Vinod Koul wrote:
> > On partial_drain completion we should be in SNDRV_PCM_STATE_RUNNING
> > state, so set that for partially draining streams in
> > snd_compr_drain_notify() and use a flag for partially draining streams
> > 
> > While at it, add locks for stream state change in
> > snd_compr_drain_notify() as well.
> > 
> > Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
> > Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> 
> Worth noting I haven't actually tested the gapless, but keeps all
> the compressed capture stuff happy.

Thanks for testing and review Charles. 

Btw Srini is adding support to fcplay so that we can do gapless testing
without using HALs/players. Now that we have an public board (RB3) where
compress works out of box, we should build more things on top :)

-- 
~Vinod

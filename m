Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D210295C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896270AbgJVKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:03:30 -0400
Received: from mail1.perex.cz ([77.48.224.245]:45458 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896242AbgJVKDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:03:30 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3EB98A0040;
        Thu, 22 Oct 2020 12:03:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3EB98A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1603361008; bh=lXoh+KKoCCjpmbseFyBsxIaO14Gfb2SvYAq3LoV3XpQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NVNO0hPS0PB46y98mKoU43gSrfjrLeM+6k4x+areXIrgcSKhmUf6h0jkTiQz4K+/6
         NUQAWQjI2K3wzlweVtoxyzDdSOXp8Rya+PwUwm6Lp1dgpuUmsMtXPFE6aseloANrDK
         NKFQ9mksgdiOCNY1j8t4VQ95LNui0CuCI3oha6aw=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu, 22 Oct 2020 12:03:19 +0200 (CEST)
Subject: Re: Context expectations in ALSA
To:     Maxime Ripard <maxime@cerno.tech>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20201022095041.44jytaelnlako54w@gilmour.lan>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <30226f94-72e9-34d2-17d0-11d2501053f0@perex.cz>
Date:   Thu, 22 Oct 2020 12:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022095041.44jytaelnlako54w@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 22. 10. 20 v 11:50 Maxime Ripard napsal(a):

> So, I'm not really sure what I'm supposed to do here. The drivers
> involved don't appear to be doing anything extraordinary, but the issues
> lockdep report are definitely valid too. What are the expectations in
> terms of context from ALSA when running the callbacks, and how can we
> fix it?

I think that you should set the non-atomic flag and wake up the workqueue or
so from interrupt handler in this case. Call snd_pcm_period_elapsed() from the
workqueue not the interrupt handler context.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

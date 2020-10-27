Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38ED29A688
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894764AbgJ0IYy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Oct 2020 04:24:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50364 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394931AbgJ0IYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:24:40 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kXKHV-00052P-MT
        for linux-kernel@vger.kernel.org; Tue, 27 Oct 2020 08:24:37 +0000
Received: by mail-pl1-f200.google.com with SMTP id x9so514980pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 01:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SFlJSj1q7ASCYrGYYql1T2iPE3cfJ9xUSF5ewwsu+fw=;
        b=Ki1AAEaoxD8c1YSxBQAdag3N4wi8yMuYXYPjqMJy23vz7QOh/lCtj5jDg3O8pyo6XF
         ytXgQqQvWkH7IjZbO1/I12dst3AQkAJq5dMsxN4nJ5s4CvN63PLWuCB/xik8wbo71mo1
         FuU1Iz/2g3T+oZiV7Ft5T6Q7wLJOdJqByJspiEGWYcIlGL4N/1iuy5CQ53ziXpzdIu4V
         njlQ/1kZZjgmLtwqhDl0jB4UtDH6H+zk/cr7VbVRkhtQ+/ydeGJYO0n+fjG0PmayIl3e
         sJnozOUmuRoAS5DRAu1p4YV8xxKw3DOVsRON3JYKQLN0+UENx1xG1wx1tUPRCZdHLPWT
         oD9w==
X-Gm-Message-State: AOAM531ZtxiBQPSgcrGSPGNTLVm17TaPq3uFMxm0uHyanMjMfaYASMhN
        sHELLavjH/jbI8+sDkeMEQcACES3LD2Tqt/9QfhyLA7LtZW1tycRPFAuVrFQq83JiHlWAossTxP
        Hj8Pr1wxwekxoMkSallODTPgDNRDoPPP6Cg6Jum5ZpQ==
X-Received: by 2002:a63:2b53:: with SMTP id r80mr937289pgr.439.1603787076321;
        Tue, 27 Oct 2020 01:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDWJ42nV2998HOqGb8LW3xxFBVpSepmFlAkoLUdN6qQWEtwNtB3zUkFHd+97bs19ZDzFpqTA==
X-Received: by 2002:a63:2b53:: with SMTP id r80mr937273pgr.439.1603787075958;
        Tue, 27 Oct 2020 01:24:35 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a18sm1042842pgw.50.2020.10.27.01.24.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:24:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 3/4] ALSA: hda: Separate runtime and system suspend
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hft602ifo.wl-tiwai@suse.de>
Date:   Tue, 27 Oct 2020 16:24:32 +0800
Cc:     tiwai@suse.com, perex@perex.cz, hui.wang@canonical.com,
        kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <585925F6-8262-41BB-A21D-EBCE6EBF9B5D@canonical.com>
References: <20201027054001.1800-1-kai.heng.feng@canonical.com>
 <20201027054001.1800-4-kai.heng.feng@canonical.com>
 <s5hlffs2jsy.wl-tiwai@suse.de> <s5himaw2ilk.wl-tiwai@suse.de>
 <s5hft602ifo.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 27, 2020, at 16:15, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Tue, 27 Oct 2020 09:12:07 +0100,
> Takashi Iwai wrote:
>> 
>> On Tue, 27 Oct 2020 08:46:05 +0100,
>> Takashi Iwai wrote:
>>>> @@ -1103,10 +1115,8 @@ static int azx_runtime_suspend(struct device *dev)
>>>> 	chip = card->private_data;
>>>> 
>>>> 	/* enable controller wake up event */
>>>> -	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0) {
>>>> -		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
>>>> -			   STATESTS_INT_MASK);
>>>> -	}
>>>> +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
>>>> +		   STATESTS_INT_MASK);
>>> 
>>> ... here we should have the check of chip->prepared, and set WAKEEN
>>> only when it's false.  Otherwise WAKEEN is set up for the system
>>> suspend, and it might lead to spurious wakeups.  (IOW, checking the
>>> flag at resume doesn't help for preventing the spurious wakeup :)
>> 
>> Scratch my comment above; it's the code path only for the runtime
>> suspend in your new code, then this cleanup makes sense.
> 
> Also, as one more cleanup: from_rt in __azx_runtime_resume() can be
> replaced with !chip->prepared flag, so the extra argument can be
> dropped.

Ok, will send v3 to address it.

Kai-Heng

> 
> 
> Takashi


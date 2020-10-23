Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B96296FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372601AbgJWNCo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Oct 2020 09:02:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35766 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897567AbgJWNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:02:43 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kVwiP-00042O-Io
        for linux-kernel@vger.kernel.org; Fri, 23 Oct 2020 13:02:41 +0000
Received: by mail-pf1-f200.google.com with SMTP id 23so1068873pfp.21
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BC7zuAF/NnofAdEYaPZZnotmNh+X8UYz50UWmTChF4E=;
        b=NjCmKxnMnJoCRHp3x71OIlCTuVSxQe5XbekpgB14vihUHStKWiwwFLyHp5aUjkjdTz
         Xl1Rtwm0/6mOZ8GYC40fx6V3TbWOMzR7hBY6wrG4uvOd22f8swEi/e1j7lXLiqFxKtYp
         ipKyCw/SnqhuAAMwNT5+6JLntgMmUteqLLhQvNUle7Dv6iqLlW83B6wTykmbuvtsOLwN
         BVXTrcrbyZb0caeq62p88iUAJgWMbcb2Xbcq3ihIF8pc1YIN6dmy1ruYtvZq9YCtby2u
         gT29RtJ0IWrQStzibLypNIvurToDtgu9FVS4YQeTW7VUFMYc0y6mBHp9XhjEfb84L7ch
         u/oQ==
X-Gm-Message-State: AOAM530VeExFkPELfOGB0JQJpiBRPJk5ZljFIXc4RQFxRXgSFspkswRe
        1kDSYe9jcVhrkWgGCg29cpY7ADfEk4ma2R2UNJKSK6KQeM+bcGOHbVEWw8p+c/dZJaxOpuzsrFj
        Gs3aurMPMA+jpUZVDHoR3shoWLzI5RRegYooB79ti7A==
X-Received: by 2002:a17:90a:b389:: with SMTP id e9mr2557894pjr.191.1603458160052;
        Fri, 23 Oct 2020 06:02:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvEIAgPmABYBsijwFB/Gv0lqHcDeu3MV3SXDfFg4I9rrJJW6DNpSiF/GvDPDdMYJxc5gfw3g==
X-Received: by 2002:a17:90a:b389:: with SMTP id e9mr2557863pjr.191.1603458159758;
        Fri, 23 Oct 2020 06:02:39 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id t13sm2232981pfc.1.2020.10.23.06.02.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 06:02:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 3/4] ALSA: hda: Refactor controller PM to use
 direct-complete optimization
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hh7ql898j.wl-tiwai@suse.de>
Date:   Fri, 23 Oct 2020 21:02:35 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <98CFD5BD-3BA0-4A7A-8C24-D6004F019CDF@canonical.com>
References: <20201023102340.25494-1-kai.heng.feng@canonical.com>
 <20201023102340.25494-3-kai.heng.feng@canonical.com>
 <s5hh7ql898j.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 23, 2020, at 19:36, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Fri, 23 Oct 2020 12:23:37 +0200,
> Kai-Heng Feng wrote:
>> @@ -1103,10 +1096,8 @@ static int azx_runtime_suspend(struct device *dev)
>> 	chip = card->private_data;
>> 
>> 	/* enable controller wake up event */
>> -	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0) {
>> -		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
>> -			   STATESTS_INT_MASK);
>> -	}
>> +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
>> +		   STATESTS_INT_MASK);
> 
> Hrm, this doesn't look safe.  Applying WAKEEN unconditionally means
> that the machine may get woken up from the system suspend, and we
> don't want that.

Yes, WAKEEN should be enabled for runtime suspend and disabled for system suspend.
In principle we should always do runtime-resume -> suspend flow when runtime and system PM requires different wakeup settings.

That also means HDA controllers can't use direct-complete at all.

However, I did some testing on keeping WAKEEN enabled for graphics card's audio controller, and they didn't wake system up.
But yes, in principle they are not safe, I'll change it in v2.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi


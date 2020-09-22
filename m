Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C127450A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIVPNN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Sep 2020 11:13:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46091 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIVPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:13:13 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kKjyg-0002c7-Ps
        for linux-kernel@vger.kernel.org; Tue, 22 Sep 2020 15:13:10 +0000
Received: by mail-pj1-f72.google.com with SMTP id p11so2527556pjv.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BSQ4bIjbcJDcJHLvA5qILAa+y6sr+Z4P/Y/Y2pdWQ/g=;
        b=ODbskzVexa2bT9scN4d/4+aUFwft3kzA0C+SbKi5mHS1HO0rrVyfANS/RcS2G4vZSk
         KEY47ked/jRDM76HfQB28awcogdamRPMHbXhKcwaYM6zMbTL4f/t1cX4KCOCiITv5xCp
         sOr/wNAfqF8c9Z9i3Afp531kHWdhBIZBXzM7qq1CXRpZzYqwWUa9DeX8gHQhklCvn5ZW
         LIF9aGP0UM4acCk/P0YtaQRavuZWpJs4icpzBLghNoqQfov9PK2FYXzDmMWj3pdzjAOa
         nTacaftKm2j/11ZErCd87MIM1MrAXKqrQVOXju/2bMAaciiDae7xyEh3qCaWaiTgh8j9
         FEqA==
X-Gm-Message-State: AOAM531Nes8H4ANG+zKKLaw86rSM/jkTQnHi44XqMQkymU4UCvg50FnE
        73y/Pid+dnKrrN7EbhxY7nvO6ayX8el1wr7iunin2wcJnGzAvdDJvFSHf+vkH96fk0iwWHyBrRq
        vIXnTIWl2xvqiBhFV04OM6DH+D2jZLsVcrV5AnaiHXg==
X-Received: by 2002:a17:90b:33cb:: with SMTP id lk11mr4158369pjb.98.1600787589325;
        Tue, 22 Sep 2020 08:13:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy06QZEsty6qUF/pd/barVDXCqGXHP/EBpcUfPdxZyoSpkJZtz7BMniX0+B563RJE9cSkl23Q==
X-Received: by 2002:a17:90b:33cb:: with SMTP id lk11mr4158339pjb.98.1600787588975;
        Tue, 22 Sep 2020 08:13:08 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id g192sm15431457pfb.168.2020.09.22.08.13.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:13:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Revert "ALSA: usb-audio: Disable Lenovo P620 Rear line-in
 volume control"
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hsgbbplok.wl-tiwai@suse.de>
Date:   Tue, 22 Sep 2020 23:13:05 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Andrew Oakley <andrew@adoakley.name>,
        Chris Boyle <chris@boyle.name>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A3819F83-2574-4BE4-824B-7464776D865E@canonical.com>
References: <20200915103925.12777-1-kai.heng.feng@canonical.com>
 <s5hsgbbplok.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 21, 2020, at 16:40, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Tue, 15 Sep 2020 12:39:23 +0200,
> Kai-Heng Feng wrote:
>> 
>> This reverts commit 34dedd2a83b241ba6aeb290260313c65dc58660e.
>> 
>> According to Realtek, volume FU works for line-in.
>> 
>> I can confirm volume control works after device firmware is updated.
> 
> A slight concern is what happens if you apply this change to the
> device before the firmware update.

The desktop that equips with the USB audio device hasn't released to the market yet, so I am not really worried about this.

> 
> Also, after this revert, does the mixer control appear properly?

Yes it does.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> sound/usb/mixer_maps.c | 1 -
>> 1 file changed, 1 deletion(-)
>> 
>> diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
>> index 5b43e9e40e49..c369c81e74c4 100644
>> --- a/sound/usb/mixer_maps.c
>> +++ b/sound/usb/mixer_maps.c
>> @@ -371,7 +371,6 @@ static const struct usbmix_name_map asus_rog_map[] = {
>> };
>> 
>> static const struct usbmix_name_map lenovo_p620_rear_map[] = {
>> -	{ 19, NULL, 2 }, /* FU, Volume */
>> 	{ 19, NULL, 12 }, /* FU, Input Gain Pad */
>> 	{}
>> };
>> -- 
>> 2.17.1
>> 


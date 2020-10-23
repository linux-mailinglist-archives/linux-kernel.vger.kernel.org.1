Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78603296F97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463976AbgJWMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:44:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35134 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463968AbgJWMo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:44:27 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kVwQj-0002RE-Gu
        for linux-kernel@vger.kernel.org; Fri, 23 Oct 2020 12:44:25 +0000
Received: by mail-pf1-f198.google.com with SMTP id m64so1044948pfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ss/2egyBfIZAiVE1IR9ul+5JtgcnBAIRvrLL4JsLF5Q=;
        b=DgcCEq50lLcsUtxwPlfG2+CrHo8dupz3lwjGchgtJuMenTisrvumN22Y1NLUbk8N2J
         cnB7O5aOCjYbI5zp+ldtzl4E7rnBztcQSLz0PXhDRO/hkMGGTxs7d0Btmom1u/r6bpFm
         Fbix2tqskYbL6295zUj/RxeEfVIKOUVVjprURPQzfvLsswe0Kj9+5YZ5EvVXSKZOVhbE
         Oh/XnbLP5zNaufSHOAyCeXlEayIyE5bi3LEQX3SZQzeGCuc1RDNlAwQZLEsJMx6Y+M8o
         QWtTAOCmj/rGoWFY/+Fubr4DoVCl36aQ2Iybko24bU46Yds/PeON4pI3qa7YFPDsLywO
         LxzQ==
X-Gm-Message-State: AOAM532zN7p82rcBKKxghxvo6/U2BfxbGlDNgJH/vEqZ5H7oFO8TXczt
        PiOtCEDEu5FkZoW6JD34OWakeqmPh7qsFIaUFIzgeIcWjLnXFvDqax78eCHe/L0Wu/08rkpW7r2
        0SsUCzN3ycVqdsR2qAQhWslavOPb9uGQwtps69nUlPg==
X-Received: by 2002:a17:90a:1596:: with SMTP id m22mr2330755pja.189.1603457064105;
        Fri, 23 Oct 2020 05:44:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6WrdLJEpNg0KYKwPikTKprEryePQjp/3SPSByjnLdoLTieJcrcAUKrt7vXluOMlPGu0y8rg==
X-Received: by 2002:a17:90a:1596:: with SMTP id m22mr2330726pja.189.1603457063688;
        Fri, 23 Oct 2020 05:44:23 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id js21sm2572456pjb.14.2020.10.23.05.44.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 05:44:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/4] ALSA: hda: Refactor codec PM to use direct-complete
 optimization
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hk0vh89fv.wl-tiwai@suse.de>
Date:   Fri, 23 Oct 2020 20:44:18 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Harsha Priya <harshapriya.n@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9D7D9C4C-3245-41A3-B0C4-D74FBB5FE91A@canonical.com>
References: <20201023102340.25494-1-kai.heng.feng@canonical.com>
 <s5hk0vh89fv.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 23, 2020, at 19:32, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Fri, 23 Oct 2020 12:23:35 +0200,
> Kai-Heng Feng wrote:
>> 
>> +static void hda_codec_pm_complete(struct device *dev)
>> {
>> 	struct hda_codec *codec = dev_to_hda_codec(dev);
>> -	int ret;
>> 
>> -	ret = pm_runtime_force_resume(dev);
>> -	/* schedule jackpoll work for jack detection update */
>> -	if (codec->jackpoll_interval ||
>> -	    (pm_runtime_suspended(dev) && hda_codec_need_resume(codec)))
>> -		schedule_delayed_work(&codec->jackpoll_work,
>> -				      codec->jackpoll_interval);
>> -	return ret;
>> +	if (pm_runtime_suspended(dev) &&
>> +	    (hda_codec_need_resume(codec) || codec->forced_resume))
>> +		pm_request_resume(dev);
> 
> You shouldn't drop the check of codec->jackpoll_interval.  If this
> field is set, the codec driver has to resume no matter what it was, so
> that the polling can start up again.

Ok, will address in v2.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi


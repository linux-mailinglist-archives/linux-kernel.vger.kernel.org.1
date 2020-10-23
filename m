Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D8F296FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464098AbgJWMxR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Oct 2020 08:53:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35470 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464051AbgJWMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:53:16 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kVwZG-0003FN-R2
        for linux-kernel@vger.kernel.org; Fri, 23 Oct 2020 12:53:15 +0000
Received: by mail-pg1-f197.google.com with SMTP id t195so1088011pgb.15
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eQD5RdIj2axOzAgoVfN+eJW9uUKoyO8pNPOdpJJuNKI=;
        b=niUhsWADi5liLGAqin1qGf421UT6axAJwFjUBiP35igVbXA0yAh1GCY5L+xlBjzBqO
         VDNuKesbkU/YtEexoo7lvaWZHArxmgvs9kSD/kCGJxqAZ0EybZSQqq/qaHlUSZGfmFW1
         U7grycyPeXOUr5r/yA6KzMNaW9l87Zsszei0191bG350XuOnACDtX9Lb/MMvgmZYzD7h
         y7w8zRUy0UoLyo1LEsrtg1DYrTa8mnhDzrvmursyNA3O1X/KNLZ5urobuulT+64zALrt
         HO7nA40al8A99NYE8ijqV0cjpOexVvMj7mAYgw0p/YfKbc9iNSAyYMuYqnMQlvuphW4n
         83Og==
X-Gm-Message-State: AOAM533RL94y8xe4KRPraQEev2Dl2f2qpiGfnnHqv09M5f53gdJSJq1J
        bZU489UBpmlYE+/ewRUyyl/N9IB8mrKk/wRo1xG9bTddYNKsYxQq/bRqCZvFex25lhzNfVf1fDY
        Upb59wfAWB/CF430diFt76enPrqDy7oAnW9MLKhWfZQ==
X-Received: by 2002:a63:2d87:: with SMTP id t129mr1974766pgt.206.1603457593161;
        Fri, 23 Oct 2020 05:53:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI8syoCoaAVfWjq6dOj4WJZk2nF7k2P6xmGzSO6nyVBO3DgpxHg96Dl4Num9hvY5LtX2lw5w==
X-Received: by 2002:a63:2d87:: with SMTP id t129mr1974749pgt.206.1603457592863;
        Fri, 23 Oct 2020 05:53:12 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id ls8sm2336497pjb.54.2020.10.23.05.53.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 05:53:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/4] ALSA: hda: Stop mangling PCI MSI
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5himb189by.wl-tiwai@suse.de>
Date:   Fri, 23 Oct 2020 20:53:08 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6562A60B-C27C-4912-94AE-6A23839DABF4@canonical.com>
References: <20201023102340.25494-1-kai.heng.feng@canonical.com>
 <20201023102340.25494-2-kai.heng.feng@canonical.com>
 <s5himb189by.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 23, 2020, at 19:34, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Fri, 23 Oct 2020 12:23:36 +0200,
> Kai-Heng Feng wrote:
>> 
>> @@ -1038,14 +1036,6 @@ static int azx_suspend(struct device *dev)
>> 		__azx_runtime_suspend(chip);
>> 	else
>> 		pm_runtime_force_suspend(dev);
>> -	if (bus->irq >= 0) {
>> -		free_irq(bus->irq, chip);
>> -		bus->irq = -1;
>> -		chip->card->sync_irq = -1;
>> -	}
> 
> This release of irq has nothing to do with MSI.  There has been PCI
> controllers that assign to a different IRQ line after the resume.

Can this issue happened before commit 41017f0cac925 ("[PATCH] PCI: MSI(X) save/restore for suspend/resume") was merged?

Kai-Heng

> 
>> -	if (azx_acquire_irq(chip, 1) < 0)
>> -		return -EIO;
> 
> Ditto.
> 
> 
> thanks,
> 
> Takashi


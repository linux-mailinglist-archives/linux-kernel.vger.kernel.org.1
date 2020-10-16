Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B8A290B14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390928AbgJPSFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390770AbgJPSFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:05:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA8CC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:05:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so1922332pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lstQ2Z70FH3wyPnp+HqoxtSj5rPcg2/41zwZVIkct8c=;
        b=awm5/19UPz2M0E4ycu7+1ioAE+jZd3anvlQXZ4l3NUeA1EpyB/0stdCEy9k2vOoYOw
         XRnXvNL/Mds0BmVz6azbKku0tTofKH3KuZF3UIXpjWC9otjSYHeNB0tNz8Rb3sY49qHO
         gYCX7k4V2AlWjLxTTSAcxn8myMPKxFX69iCm+SiXoXZ/qd5P0egrxd0K92qFn1rTcepz
         zqyD9z1Gd+lWVHpIH2+9nnGZGLI2I0JPYBOLU6X5v9VUhWU/ArSwHM1CIDi4QYTTwbs/
         qgMcW/U2OY5q/PvCsLO0SJKXS8lBvh9izMwyHRLlON+1UmNBUNYLec2LnuH9ATcUPhmN
         sntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lstQ2Z70FH3wyPnp+HqoxtSj5rPcg2/41zwZVIkct8c=;
        b=q+oPFWPUkpo8giLX0OAm2OIsV0EkG62nunPc5BcVCvvMCjnjL1WczqNMrBAuLmfGQp
         RKYGPFtpnPDPtkHSVgrnxDuLnvyi7lHAAP6PlTIxOT3TkOshFSqbGbsz9bADd1b3V0BB
         hfpTpGSbnhTYbOMB5Nvkx/8uoCrzD2AfesDN+09WHZk+uLnSzPyHK6W4Z8pKmodgOC/l
         jD5Sxw8FHdw+KOEk1veZso8sLi+VeVsk3fhO+pTEVhSmht36fpsqYzSojWQKSQdITN+Q
         qfocMDHle7zJUnRwCb+D7anK/JnnzEJ4HmYA7jasxZopdzrKgssK+3ggUM7Nb6WKmEmO
         GX4w==
X-Gm-Message-State: AOAM533+nKCWOwGWCv61+XqDwhWlDkUXDV1Ra8gWPA902dUCwLdEfJy9
        0MUSe64hAwC5L3bLaLH6bdxZcg==
X-Google-Smtp-Source: ABdhPJzmvXyJ5VEstqxjlUGRcXManh5vIBl3gwE/eQHWKVVW76Inr0FfAEuxrM8eyDoxCWhq8bA6AQ==
X-Received: by 2002:a63:3fc7:: with SMTP id m190mr4079513pga.293.1602871552667;
        Fri, 16 Oct 2020 11:05:52 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j11sm3513818pfh.143.2020.10.16.11.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 11:05:52 -0700 (PDT)
Subject: Re: [PATCH 5/5] task_work: use TIF_NOTIFY_SIGNAL if available
To:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, Roman Gershman <romger@amazon.com>
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-6-axboe@kernel.dk> <20201015154953.GM24156@redhat.com>
 <e17cd91e-97b2-1eae-964b-fc90f8f9ef31@kernel.dk>
 <87a6wmv93v.fsf@nanos.tec.linutronix.de>
 <871rhyv7a8.fsf@nanos.tec.linutronix.de>
 <fbaab94b-dd85-9756-7a99-06bf684b80a4@kernel.dk>
 <87a6wmtfvb.fsf@nanos.tec.linutronix.de> <20201016145138.GB21989@redhat.com>
 <1a89eacd-830e-7310-0e56-9b4b389cdc5d@kernel.dk>
 <874kmuaw13.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ce2160c6-666b-0231-3c8d-499958ef733d@kernel.dk>
Date:   Fri, 16 Oct 2020 12:05:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <874kmuaw13.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 12:03 PM, Thomas Gleixner wrote:
> On Fri, Oct 16 2020 at 08:53, Jens Axboe wrote:
>> On 10/16/20 8:51 AM, Oleg Nesterov wrote:
>>> On 10/16, Thomas Gleixner wrote:
>>>>
>>>> With moving the handling into get_signal() you don't need more changes
>>>> to arch/* than adding the TIF bit, right?
>>>
>>> we still need to do something like
>>>
>>> 	-	if (thread_flags & _TIF_SIGPENDING)
>>> 	+	if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>>> 			do_signal(...);
>>>
>>> and add _TIF_NOTIFY_SIGNAL to the WORK-PENDING mask in arch/* code.
>>
>> Yes, but it becomes really minimal at that point, and just that. There's
>> no touching any of the arch do_signal() code.
>>
>> Just finished the update of the branch to this model, and it does simplify
>> things quite a bit! Most arch patches are now exactly just what you write
>> above, no more.
> 
> Except for all the nasty ones which have these checks in ASM :)

Actually not that many of them, and the biggest part of that set are
easy enough too (just adding the mask to the check). The only exceptions
are where TIF_NOTIFY_SIGNAL end up spilling over 8/16-bit, and the
particular arch currently uses some mask compare variant that now needs
to be modified. powerpc was the worst there, but I'm told a free bit
will show up in the merge window so all my powerpc asm fiddling was for
naught :-)

Only remaining issue I'm aware of in the arch conversions is arm, which
runs into this exact issue. Need to check with some arm guys on what the
best approach is there...

-- 
Jens Axboe


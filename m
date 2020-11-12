Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685F42B0B45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKLR2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgKLR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:28:39 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D01C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 09:28:37 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so6608818wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 09:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8acZiaXncTb/Z6bOtXPMVOr+zZt2ayoyTGtTR+SBy+o=;
        b=f8+XOJzu9FadXhtbFyLtZpTMBGKvuS39pcu07GyR3xRGVslBPzT4zwsMtjVdQEjW/R
         zMJklQYYbvze0KsVez9vcOU3uOKvDQfoLnsAMGiRCSR8qqQW48ViOFgOu+SAebYynzgb
         qqeCqtLO+DbKlGPr6fEAHsACwiTl7eOJhKSfnwSAQA4rOJDET1Gm+wI7i3N3oezSFcCF
         HCvEX1j9nZL/9i2KAr8g4TboIZloNgDeR6tTpNJzbGuDltzHME6847oUC/omcjwFkKbd
         F4dqyitT6fEmOYOCCMuH35YZcsOMDErtPZklzCE5wxUPYPh8jylHJB5vA4RT6g/245Me
         mzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8acZiaXncTb/Z6bOtXPMVOr+zZt2ayoyTGtTR+SBy+o=;
        b=Lfcjg06bFLMQgsGhhtr8FVzPgycVWubj+T8bXlB71gR56b3Sgxa5mhU0DbkcugTQXj
         mn0C9Easa7G4iDZ7HXpz9D3A3Kw1lac+4MUDNfTmtWznTDu5joDNpcoU5UVf2TCye0Ff
         Q3sqylniSJvDXbBXlXBYpVjMV/cXMuL26c4IUfw1B4ZuCsqJT9MmkfD6UlR2vSkCu4j8
         9+5ysNSBENZV2UR6nlenCK0Z9nInTzc3tjDjrk0qDjQaSr5M9zJ8MpiOXOAamF0fTSuV
         gzFBUwosEJU5OHe7PhP51IaESopJPxcr4Odbtds+/bmp4WLD8umwLzazDiUBLfOBAIpa
         AobA==
X-Gm-Message-State: AOAM5310yMMX/Wo9wxUsZjhEV2qbU7iJi349kEuR9buvID0URQ9Zt1ss
        vcJESnVNOg8FR3DqNKOupvrpRP6EjNn0M/xq
X-Google-Smtp-Source: ABdhPJw3Dvh4z08DYy29ZRv1YzAfs8KphV3kd1YNMMWMJpyciANjB0pAEV/uYdZ5p/mKVh7fyKLgyw==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr636483wmk.125.1605202116205;
        Thu, 12 Nov 2020 09:28:36 -0800 (PST)
Received: from ?IPv6:2001:861:3a84:7260:5d3c:83d5:8524:33ca? ([2001:861:3a84:7260:5d3c:83d5:8524:33ca])
        by smtp.gmail.com with ESMTPSA id f17sm7060158wmh.10.2020.11.12.09.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 09:28:35 -0800 (PST)
Subject: Re: [PATCH v2 1/2] reset: brcmstb rescal: implement {de}assert()
 instead of reset()
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201106191743.40457-1-james.quinlan@broadcom.com>
 <20201106191743.40457-2-james.quinlan@broadcom.com>
 <64aa1f860bf60ddac7a2015c87896c8a7b13b161.camel@pengutronix.de>
 <CA+-6iNzMAbvhODSX_Kn_DWe_T=9F3xzu5khdh-zdGNPyPs6FdA@mail.gmail.com>
 <2ee2fb9170e127d583e19062a791f3b1767d44fc.camel@pengutronix.de>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Message-ID: <eb0d2af6-a7df-6ab1-1dfe-615675a841da@baylibre.com>
Date:   Thu, 12 Nov 2020 18:28:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2ee2fb9170e127d583e19062a791f3b1767d44fc.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,


On 09/11/2020 18:25, Philipp Zabel wrote:
> On Mon, 2020-11-09 at 11:21 -0500, Jim Quinlan wrote:
>> On Mon, Nov 9, 2020 at 5:05 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>>> Hi Jim,
>>>
>>> On Fri, 2020-11-06 at 14:17 -0500, Jim Quinlan wrote:
>>>> Before, only control_reset() was implemented.  However, the reset core only
>>>> invokes control_reset() once in its lifetime.  Because we need it to invoke
>>>> control_reset() again after resume out of S2 or S3, we have switched to
>>>> putting the reset functionality into the control_deassert() method and
>>>> having an empty control_assert() method.
>>>>
>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> You are switching to the wrong abstraction to work around a deficiency
>>> of the reset controller framework. Instead, it would be better to allow
>>> to "reactivate" shared pulsed resets so they can be triggered again.
>> True.
>>> Could you please have a look at [1], which tries to implement this with
>>> a new API call, and check if this can fix your problem? If so, it would
>>> be great if you could coordinate with Amjad to see this fixed in the
>>> core.
>>>
>>> [1] https://lore.kernel.org/lkml/20201001132758.12280-1-aouledameur@baylibre.com/
>> Yes, this would work for our usage.  Amjad please let me know if I can
>> help here.  The only "nit" I have is that I favor the name 'unreset'
>> over 'resettable' but truly I don't care one way or the other.

My pleasure, I will send a V2 soon of the patch, when it is done, please
let me know if I can add anything that would suit best your use case as well.

> Both unreset and resettable are adjectives, maybe it would be better to
> have an imperative verb like the other API functions. I would have liked
> reset_control_trigger/rearm as a pair, but I can't find anything I like
> that fits with the somewhat unfortunate reset_control_reset name in my
> mind.
> In that sense, I don't have a preference one way or the other either.

I think reset_control_rearm would be a very good candidate, resettable
is quite representative but I think it is best to keep using verbs for
the sake of homogeneity

>
> regards
> Philipp

Sincerely,

Amjad


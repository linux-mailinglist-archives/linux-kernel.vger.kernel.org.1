Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62D8210AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgGAMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbgGAMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:13:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5713DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:13:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so6697502wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=36Rdlv4HCit+buU+nGQUelnhzD705QsSVBz4bAQcgV8=;
        b=E42DMvK0MtHtwtKuxE7/3asHCY49FrguUSRXvkfkXjKnKX4Eyf+hYX5dgc0SWicUqx
         RqSA2xg6/fXG4hIQ1FY1xZZJuDd3xmI79vH6Cy7lZBFCbg9C1ApTL7lOaOgloNSJDBZC
         rC2BT7oTMRHnRJhFaaCdaAtuPA6c5KGmBJF839PegAKb99lKV7BL9CyHS5m89s+ilEFd
         SJqUO5ce97PI+u4b8siqd1UAA0uB5F7B9nExRUHWvb7K4z4A0dPscp9yK/r+4RoHZEb+
         cEG3xw+GXQoyG3TtQC10rV/8BInK01Rtg9iLESDyX0jMDKG0B6yqpaR5DRhC1rKUIWsO
         ndww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36Rdlv4HCit+buU+nGQUelnhzD705QsSVBz4bAQcgV8=;
        b=Pmz0JPiDiZoZhaG/mSAhCwn3t4Eb7FaZWX2FIehJLPw0v49kqWkLpnBa/Qk0x+0ba/
         YYAJJKr5PqIv8lHAxZ3yDwkyV2d0Gj9kSPORW6zM5N/n61gBnBH+u1XGRsAb/Pfr9DxX
         Tg0z1wzA7sKop+uMC6HxMVacvOv+IER/AV3afZ22E9khokokW3mB+013Htzk2PuTILHJ
         k9IAv4x14fwTxhqiwiim45hlNOctxyqUXO62QZAmY6wfl8xrpT8qH2+Rqv3Xen6iI0gb
         /asFs0Ye2m2uyUm6C5IPSZq5lhBTLE8RPjvyW8Um9kOsjRB6naCPuVoLnylbsEyLLEjd
         QcsQ==
X-Gm-Message-State: AOAM533F9eKSKlVASRrCdcxIFb89+yiNr8K3225hX96oFvsgPjLleA2l
        M9QhBpGZuH6mjGcqFl0VgbltNwQ/ZL0=
X-Google-Smtp-Source: ABdhPJwsIgwqaWKXArfWPW61iIeQQD1yndav5I/DH52zb3ks7tfaJ/qsFv9EM/powgfPjuEu9sFcYQ==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr26079690wml.92.1593605634644;
        Wed, 01 Jul 2020 05:13:54 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id x11sm6660826wmc.26.2020.07.01.05.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 05:13:53 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] thermal: core: Remove old uapi generic netlink
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <20200625144509.17918-3-daniel.lezcano@linaro.org>
 <CAP245DUMjTQr2vKirZ+FxEYWC=VQ_k+OegxQgXcKDU8ThWuCsQ@mail.gmail.com>
 <0fe6837f-9b44-4578-23f2-3e4932d01122@linaro.org>
 <CAP245DUG-OsSD-_CucMMQ26HpzjJhn0emfq_go923NsDq6RqOg@mail.gmail.com>
 <c664d247-7f9b-603f-c318-48e534aedfc9@linaro.org>
 <CAP245DV8jT5vj7v6vybw3Eec7wGMXRwFm=Xum5i_n4sMCHHAfg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3fa94347-8392-5324-da0a-91ff97f6ecfc@linaro.org>
Date:   Wed, 1 Jul 2020 14:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP245DV8jT5vj7v6vybw3Eec7wGMXRwFm=Xum5i_n4sMCHHAfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 14:10, Amit Kucheria wrote:
> On Wed, Jul 1, 2020 at 3:15 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 01/07/2020 11:33, Amit Kucheria wrote:
>>> On Wed, Jul 1, 2020 at 2:56 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 30/06/2020 13:47, Amit Kucheria wrote:
>>>>> On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>>
> 
>>>>>>  /* Adding event notification support elements */
>>>>>>  #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
>>>>>> -#define THERMAL_GENL_VERSION                    0x01
>>>>>> +#define THERMAL_GENL_VERSION                    0x02
>>>>>
>>>>> This hunk should be removed since you set version back to 1 in the
>>>>> next patch and we don't actually intend to bump the version yet.
>>>>
>>>> Well, I've been very strict here for git-bisecting.
>>>>
>>>> I move to V2 because of the removal, but when adding the new genetlink
>>>> code, the family name changed, so we returned back to the V1 as it is a
>>>> new genetlink thermal brand.
>>>
>>> I don't understand the move to v2 for an empty skeleton UAPI. For the
>>> purposes of bisection, couldn't you just remove all the v1 UAPI (w/o
>>> bumping to v2) and then add a new UAPI in the next patch?
>>>
>>>> The name is change because it is no longer event based but also sampling
>>>> and commands.
>>>
>>> In this case, just to avoid any confusion, the new UAPI could be v2
>>> making the transition clear in case of bisection.
>>>
>>> I'm afraid the v1->v2->v1 is a bit more confusing.
>>
>> Let me elaborate a bit:
>>
>> Why there is this patch ?
>> - By removing this code first, the next patch will just contain
>> additions, I thought it would be clearer
>>
>> Why increase the version here ?
>> - Code must continue to compile and as the 'thermal_event' family is now
>> different from V1, the version is changed
>>
>> Why the version goes to V1 in the next patch ?
>> - The family name is changed as it is not doing event only, so it is a
>> new netlink thermal protocol and we begin at V1
>>
>> So the main reason of this patch is to be very strict in the iteration
>> changes. May be it is too much, in this case I can merge this patch with
>> 4/5, the old netlink protocol removal will be lost in the addition of
>> the new protocol. I'm fine with that if you think it is simpler.
> 
> Considering that there are no users of v1 currently, it feels a bit
> over engineered, IMHO.
> 
> Also, the new UAPI doesn't need to begin at v1. Just having it start
> at v2 will avoid this confusion, no?

Ok, I will merge both patches but I will keep the V1 because the netlink
protocol is a new one.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

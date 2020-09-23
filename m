Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A6B275D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIWQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIWQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:25:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C37C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:25:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so667534wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TL550vpV9vvwO6gByxegQJTJCQglv96mFmOszOGj/Wc=;
        b=ueztojDbxMaO3ix3kcYHw8Uad1Exy3Z+VjV1Ll8+Qzidrealat7RoGozflgeOnbCQo
         B9vPyJkhVNzyfByquiRD8VRR6i+OdOrcf3WRv760j36aTFL+AZeLHhUrLEsnE7MrOMwb
         mdJE6VqeCtn42OxTRmUiYPlwkLB6L94mjIe3wscvMYPg2mXTnO/27cr+u06t9fFTArGE
         T5/3XZQ/dKaWyC1QlgYe5nQX59KKNA6pZ3aSUG4yiSza0K12NhAhCAKjZwROdwNUR+h4
         GwFLOtLlOaKInpNF0Es/ZtxqCCjeUdfr2/1t8Qu5w/TwMTzX+Si9oWxkpezBYZTEQG1P
         87Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TL550vpV9vvwO6gByxegQJTJCQglv96mFmOszOGj/Wc=;
        b=M2YkxhhZh4v2gSeZ64gbvwwQgOm2pFOXgmfAMl1ZkTpaDZqPFdSfaEdw65GqmCvp3U
         EQJsudfC9NEmzgOIlor8HUcpHxKWV+gjjnYMf+tEtQKHtvju5n/eQ/aXxcvj/4qZcRvb
         I/1YMmvvjtVaB3d7VuUiU9F1lwT32wYXJK6Ur3oHmWB9E4Jt/Cwh2mBU7rnUXoXq+SI+
         eGRCMQyHaLSd1jxK5Rg91zAVPsUaPuCXR+An88SkJTsSWgWZC9gjHCQ+jSA1jzktLzZP
         VlmprMUwe30cPJwfEQAJ8qd4ZitH83rBXiGTuLHlDohdE8N3vfA86UnKKxwlQ/DtkCPj
         XWRA==
X-Gm-Message-State: AOAM531gkh10Ds8MAsAfRSKO6HQg+RtmT8rnYAYVOFzbOnxRUTv7ei9i
        lglpZkdlXRM8oTCgMwtX2GvKH9oStmGFXA==
X-Google-Smtp-Source: ABdhPJybHYTNDEN+P+o5se3IKjYN1gG4txH0l5J2Qaz2mJf3Ddkt4+v3DQC17ikxhxizOSrJoCtmqg==
X-Received: by 2002:a5d:554c:: with SMTP id g12mr490819wrw.294.1600878307105;
        Wed, 23 Sep 2020 09:25:07 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id g12sm290449wro.89.2020.09.23.09.25.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 09:25:06 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200923135343.16565-1-vadym.kochan@plvision.eu>
 <7a072204-a4b8-e5ef-9ce2-4db176f70366@linaro.org>
 <20200923141334.GA16798@plvision.eu>
 <1f65dc6a-50f3-d4e5-f1ce-7a68fddde287@linaro.org>
 <20200923145107.GB16798@plvision.eu>
 <19c5fa23-41c9-f5c7-beaf-aeb9655bfefd@linaro.org>
 <20200923162314.GF16798@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cec8a363-0c2b-2746-d986-f239f74eaff7@linaro.org>
Date:   Wed, 23 Sep 2020 17:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200923162314.GF16798@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2020 17:23, Vadym Kochan wrote:
> On Wed, Sep 23, 2020 at 04:51:06PM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 23/09/2020 15:51, Vadym Kochan wrote:
>>>> -       return nvmem_cell_write(&cell, buf, cell.bytes);
>>>> +       rc = nvmem_cell_write(&cell, buf, cell.bytes);
>>>> +       if (rc)
>>>> +               kfree_const(cell->name);
>>>> +
>>>> +       return rc;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
>>>>    ------------------------>cut<---------------------------
>>>>
>>>> --srini
>>>>
>>> But is it really needed to kstrdup(cell->name) for nvmem_device_cell_{read,write} ?
>> This boils down to if we want to use same api to parse nvmem_cell_info or
>> not!
>>
>> If we want to keep this simple, we can either explicitly add free for
>> successful caller to nvmem_cell_info_to_nvmem_cell()!
>>
>> Or
>>
>> use something like what you did, but new api needs more clarity!
>> May be renaming __nvmem_cell_info_to_nvmem_cell to
>> nvmem_cell_info_to_nvmem_cell_no_alloc would clarify that a bit!
>>
> 
> Naming is most difficult thing, what about __nvmem_cell_info_to_nvmem_cell_{unsafe,nodup}() ?
> At least this is an indication to be carefully here.

nvmem_cell_info_to_nvmem_cell_nodup() should be good!

--srini
> 
>> Also can you make sure that linewrapping on function names be inline with
>> existing code.
>>
>> Please send v3 with that changes!
>>
>>
>> --srini
>>> It is used only for log error in case the unaligned access did not
>>> pass the check

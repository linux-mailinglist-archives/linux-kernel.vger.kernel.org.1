Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D164F2FBD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391445AbhASRUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391454AbhASRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:18:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA00FC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:18:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c12so1974550wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PX8jr8Vol/FRGp2UsPj8sDZPjVgGqVfVrry+qL8uzSI=;
        b=HQ62BOIwPxntJC5g9aANwDM3cB1Q2qOY90oFj4gO6Pfcj6HhOhENOxwtHo5XiK6mKF
         Up1URUpJm/0+sIdw/j78rrT2QH7JU3oG90kne3CFKN6utKTk693LsuSjM2fjOBH/0RhQ
         kVkDvSDND/ZAk5QQcpgrmRqhWbSvowMK6RYhwi94b9eOWTRolCsy8SfKqNP9U98mPq3o
         rUnBFRHh5HP8pl3O/Y5gxz443GTH2ctNWUpp2jumg0u+Kg31BcTj/oBcrIRaFbs8eUOP
         JSurL8r4tSbXaGCs+g1MptUa4b2e7HjBjQLBWe5PivvCRAvKGOILv3Do6ZdPYCuc2GUv
         a8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PX8jr8Vol/FRGp2UsPj8sDZPjVgGqVfVrry+qL8uzSI=;
        b=ijIVmCPXfjJfW3gk1RNjH9/8nfzdr/q0M4tqwxS6LGhJinLPwwV9VspRLs0Y+TEtKG
         Wr3uPnpb5YRXnSOXrtG7wI62e74XH5SmiA3op08NBeI7sS0KT78X1ohI3OFXo8qZkoCE
         6OShK6W+x3nnfo3yN+ZNegGgArJty8zR3UGolfqO1hauU4bwlZ89c9mlW6Jr9RLYOUwZ
         sHASbFWTJhjZDosO9Vo61ueMVZXzzaJTqRT/+34zvObxSR4zqh1683WP0/XVvcD8Kpfe
         Z4ycgJW9RIFm+Uhlzfuq5YEn3HGLhrYOiTvuk1bMFa0SAEObSR0JVI46fEpMxlAYcf0H
         w9lg==
X-Gm-Message-State: AOAM532CccyvZK3WIlElntqIDtKaJUBRooxwegXXb1uuNXa7d/EIlZbb
        SvvhNYVOEIhNCiOU8Xz+m4TZXA==
X-Google-Smtp-Source: ABdhPJzwNASgk/oldbP8/0Yg312a6aP5Lt7vjj+T3gJkpWKzNyXUsEINQRu9oIBJciWdNyIffDprlA==
X-Received: by 2002:adf:f590:: with SMTP id f16mr5503102wro.40.1611076680563;
        Tue, 19 Jan 2021 09:18:00 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n11sm41822628wra.9.2021.01.19.09.17.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 09:17:59 -0800 (PST)
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
Date:   Tue, 19 Jan 2021 17:17:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/01/2021 15:54, Pierre-Louis Bossart wrote:
> 
> 
> On 1/19/21 8:52 AM, Vinod Koul wrote:
>> On 15-01-21, 16:25, Srinivas Kandagatla wrote:
>>> link_id can be zero and if we have multiple controller instances
>>> in a system like Qualcomm debugfs will end-up with duplicate namespace
>>> resulting in incorrect debugfs entries.
>>>
>>> Using id should give a unique debugfs directory entry and should fix 
>>> below
>>> warning too.
>>> "debugfs: Directory 'master-0' with parent 'soundwire' already present!"
>>
>> Yeah id is guaranteed to be unique so this will work.
>>
>> Applied, thanks
> 
> This patch is a no-op for Intel, but I am not convinced it's the right 
> fix or the definitions are not consistent.

It depends if the intention is to represent full Hierarchy in debugfs, 
then I agree. Its was consistent even before!

currently we have
/sys/kernel/debug/soundwire/master-*

Are you suggesting that we have something like this:

/sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID> ??
/sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID>/xyz-slave/master-<LINK-ID> 
??


Or may be something much simpler like:

/sys/kernel/debug/soundwire/master-<ID>.<LINK_ID>


--srini

> 
>   * @link_id: Link id number, can be 0 to N, unique for each Master
>   * @id: bus system-wide unique id
> 
> In the MIPI/DisCo definitions, a controller can have multiple masters. 
> if you have multiple controllers, each of them should have their own 
> debugfs directory IMHO. It's totally fine to have multiple bus/masters 
> with a link_id == 0.

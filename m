Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C163027C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbhAYQYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbhAYQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:24:19 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:23:39 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d16so12688586wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8ntcyKS2z/vURCjFfNTXCa/WB0rFRGasD9K1aMBQeVg=;
        b=YOrhvTmgbPBursMMTpLVLMkWmwTlD4zQcAxCRsGWKu0dPOiVQaHQo0K/W+Doa1OhVR
         pkbf723h2oTPMzDgVpANcT1wGGCRUv59qw3VhKnw9jvrrZ7/TMzi/KoiB1+rA07m3ENR
         JBSZjmEMl7uBvqtCps3sRB0rXjvV/J3IBtlL1882V1JRzHvSqnFb7DlZnKITiUGSwHpH
         N+rf3UQr56Ek1eShxSmJtOB7HH90xicJZqXJiZEmqRqEyUwjvVoZsVxxZs1k2TGBVySf
         Pt14PjFCY9dPTpc+yzZkjN0pSoFvddf9J04hvlKVFW3GQxRvbpRyl+4EPC2TFG3hj8Y/
         Monw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ntcyKS2z/vURCjFfNTXCa/WB0rFRGasD9K1aMBQeVg=;
        b=ZO5KTx25vOemgxFbdluSk6AZNtqKlLY3eIUy15i7K3VM2JHQ89s8vGkgRYHMjnAISH
         QPs1yBzAGz6qhv7uDIbUrDv8T/vDDYw3r7TTQT182g/hwCpBmJDPbt106+hC+VsGX54w
         xwvMF0v4XLvIfm0kNBquAJuT58MbZ0akW/YLnQbFM79WxdC9zakRWVLWT0QpyqbKTCx4
         OxVIjO5P+dCXKpDQdntbiuvmI1LfRMMG6x/WVqAcldJ3MHoAcPEVZ//z2MWIh3uCCsYP
         4ytCA8iUcTM3Etx4Fgj0eN6TgLgcFu8oXLnOuEqqX+qj8wUdzDaAFo9iRgCFiQJSduBs
         W4Rg==
X-Gm-Message-State: AOAM532DkMo7G6UchPlkWf5Mp15PtsIooCoPRJTfu36JUqN4RM8K4LQE
        c4+N1TyxK7bvUNVAfSDtPki76Q05coIEYQ==
X-Google-Smtp-Source: ABdhPJznz/oZIZRIgTjD6QnaUMMHl8/spzDxYWNM3AlfDKD5kHjOUMDsxEXuMaoOrrd0+uy+dPzOpQ==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr1819480wru.201.1611591817453;
        Mon, 25 Jan 2021 08:23:37 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id w14sm11646805wro.86.2021.01.25.08.23.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:23:36 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     gregkh@linuxfoundation.org, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
 <20210120180110.8357-2-srinivas.kandagatla@linaro.org>
 <fcc1b199-644d-8c7f-5e8b-d12b0d9c9a04@linux.intel.com>
 <0a2bbbe5-821a-34dd-e893-fef42baaad2b@linaro.org>
 <9a688b02-80a6-fb1f-d6fa-36ba2d88d3b9@linux.intel.com>
 <c6278763-57d9-2631-7b43-829259a9ea1f@linaro.org>
 <3ee60ad9-9635-649e-ba67-d40a96b25256@linux.intel.com>
 <487c91f9-f6ea-75c2-9150-52db2de42a3a@linaro.org>
 <eaf13d70-86fe-3e18-7a5a-4043f2d8a22d@linux.intel.com>
 <aaf34f07-5eed-3045-e4c6-dc9416689b20@linaro.org>
 <f960757f-ec8b-6d3f-f00e-27242c687926@linux.intel.com>
 <e962caa8-89c3-4a22-5932-4498c406e8f8@linaro.org>
 <adb91730-35db-db7a-75b3-4771723de945@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <31ff9d2b-760a-374e-5b37-45d8e8116f7b@linaro.org>
Date:   Mon, 25 Jan 2021 16:23:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <adb91730-35db-db7a-75b3-4771723de945@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/01/2021 16:42, Pierre-Louis Bossart wrote:
>>>
>>> if you completely remove the stream and re-add it with updated 
>>> configuration things should work.
>>
>> That's exactly what we do currently!
>>
>> The updated ports due to new configuration ex: for "mic capture" 
>> dailink needs to be communicated from slave(codec) to master so that 
>> it can allocate correct ports. That is what this patch is trying to do 
>> (share current port map information).
> 
> .. we have a disconnect on how to do this configuration update.
> 
> The 'stream' support was designed so that a stream can be split across 
> multiple devices (both masters and slaves). With this design we need to 
> have a central configuration and distribute the information to all 
> devices taking part of the stream.
> 
> It seems you are in a different solution-space, where the codec driver 
> needs to notify the master of which ports it needs to use?

Correct! As Codec is the place where we have mixer controls ant it can 
clearly tell which master ports should be used for that particular 
configuration.

> 
> I also don't see where the mapping is actually set. Patch 2 uses a 
> mapping but there's no codec driver change that defines the mapping?
> 
> Do you actually call sdw_stream_add_slave() with a new mapping?
> 
Yes, currently am working on a codec driver for WCD938x Codec, which I 
will posting very soon!

> It feels we are missing the codec part to really see what you are trying 
> to do?
My WIP code is at 
https://git.linaro.org/people/srinivas.kandagatla/linux.git/tree/sound/soc/codecs/wcd938x.c?h=wcd938x/wip#n4526

Currently the master ports are hardcoded in the driver for now, but 
these will come from DT.

--srini

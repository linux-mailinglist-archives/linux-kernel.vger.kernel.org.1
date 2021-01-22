Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFC73009FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbhAVRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbhAVPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:46:59 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A8C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:46:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m187so4704662wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6BJVBNYMAJnjXGQAp7Nl9aAWAa4hMHVCTub9r3HEuIs=;
        b=t2l/9z+E+Tiv3gbTjNXHfYhOgbJ8go4nblFHGfFlq1kW9fRXX9/PqfGVW7n1TxtD6P
         xdjzuoB9YDJ+Gp+ixZctAdMrW09FCsOlshd7bxoEWYE03cuv5OrQeyxqtEkbkiQRkc6I
         /M+ZPhQPcBwesVZbazRwMCOLWkOjLe64h3NLBS/POLjVo46YRkuQqa7660kH1W8ocuJQ
         hUEzE3lsFw1L51/ER7hRQOqFy8cOSfIavTedSrP4T26UtifIfcpCB2TXs6nYRm63VuBb
         vrvotGi7XMYbgzosLGkl21WL7IXCqtf+k8lE5VVhh1W50lIwPkDExRNTGZPtMXuLsVpD
         5HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6BJVBNYMAJnjXGQAp7Nl9aAWAa4hMHVCTub9r3HEuIs=;
        b=q9rvz1UcxBgB6DF/rLKjlTfXQkj7V6J032uVh6JncnJ7SHGGDizdFO3Ot4mMvtw4Cu
         0o7Bg1HF5/LtIdWOk714X8pwm7xiXL8+Npw+g/g+EASJDOqZT4HfY5H2k1Bjm89VgMW6
         TRyqVNPDKbMwgQbjWUIIJbJErbABrNgAbho4e27XtHrpBSyNJLwm3odnSghuqZiS4o6P
         jWawMUqxTjBL8ksX/UziPkOAv5fa/aGjhaSSYeIj2PIgRT1fH9AAB73HPHFyk4i4lpzh
         3FuEq4SrtTkH3IlKldZpnkweS/C5MbgDQU3DJU1EikA6IcmFZHIP+rBzA0wUaZ8IP/ga
         fYMg==
X-Gm-Message-State: AOAM5328TmCmlZc5lvpFEpX1NlSfj1NACFEiJsJy1VLdBqfvMP+eSqIh
        FZNQZAzwemQcmcsBe1Rb3Axbkh6hxCd3Zg==
X-Google-Smtp-Source: ABdhPJyFNpDKV7btmzNe492kbobgkiH71L8veh/Za9wqnSB3viv/K7LYABMcZgMPFHF3eTPqZ50V8g==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr4673219wmm.4.1611330377499;
        Fri, 22 Jan 2021 07:46:17 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n12sm13731221wrg.76.2021.01.22.07.46.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:46:16 -0800 (PST)
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e962caa8-89c3-4a22-5932-4498c406e8f8@linaro.org>
Date:   Fri, 22 Jan 2021 15:46:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f960757f-ec8b-6d3f-f00e-27242c687926@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/01/2021 15:32, Pierre-Louis Bossart wrote:
>>
>> Are you suggesting that we have dailink for each usecase like:
>>
>> "headset capture"
>> "Analog MIC1 capture"
>> "Analog MIC2 Capture"
>>
>> ...
>>
>> "Analog MIC4 Capture"
>>
>> ...
>>
>> "DMIC0 capture"
>> "DMIC1 Capture"
>> "DMIC2 Capture"
>>
>> ...
>>
>> "DMIC7 Capture"
>> ..
>> "Headset Playback"
>> "Ear Playback"
>> ..
>> "Aux Playback"
>> ...
>>
>> this is not really doable!
> 
> No, what I was saying is that you need to define multiple streams e.g.
> - headset capture (configured with or without click suppression)
> - mic capture (configured with AMICs or DMICs)
> - playback (or possibly different endpoint specific streams depending on 
> whether concurrency between endpoint is possible)
> 
> if you change the configuration, you have to tear down the stream and 
> reconfigure it - and for this we already have the required API and you 
> can guarantee that the configuration for that stream is consistent 
> between master and slave(s).

Yes, we make sure that new configuration is only applied before the 
stream is started, and not in middle of already started stream.
> 
>> All am saying is that codec can decide which ports it has to select 
>> based on mixer setting before the stream is setup/started. This 
>> updated mapping between slv port and master ports is passed as part of 
>> the port_config in sdw_stream_add_slave().
> 
> if you completely remove the stream and re-add it with updated 
> configuration things should work.

That's exactly what we do currently!

The updated ports due to new configuration ex: for "mic capture" dailink 
needs to be communicated from slave(codec) to master so that it can 
allocate correct ports. That is what this patch is trying to do (share 
current port map information).

--srini

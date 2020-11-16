Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C229A2B4C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbgKPRVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731167AbgKPRVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:21:04 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8280FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:21:04 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so24343936wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TVNxZXvAFGfvI59JHTRQIvmx9Brpc+QhKNZqlXN27jU=;
        b=sgazbp/NsB8wEURe90/LiMH/0EqmS0+eHFiUVCcUXvBV7Zaa/frnYy5saNPCvV+zGq
         z3lCXuN7LuVlZX29J9nQGi6BG1ahBIpyXoNm9plHVBj8K42qMLdXODPKANb79m1d0Ay3
         NtukVdRqxO43sGyyfXWv/9yCDPD+ckUf9OGdSkS3Crn3yumizDZ9mK5YtNw2qGXz78tZ
         o15lx2H9Fu2IT8Kbb1AArjG6efzDNeVqWJHu8vqA7W4xiGt0QyyPqMQ3cgn2DW15NJmg
         e37xKWJ5hT7AHE9NuIUhjf7jMmDWVbReYDyzEGaqiXSvr55TqkzI5TAzO/0GYXz+Tj9E
         xzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TVNxZXvAFGfvI59JHTRQIvmx9Brpc+QhKNZqlXN27jU=;
        b=eUvmJEck34KA2bfL0+jgkSGz+ocDBDfJQD9xQDw+eQmxZborPMmHSMuJ4S5Szaooxl
         FHrkRrt9R59caSGV0aAf/LxmK4DSqpzXGNVZk6Py7Rk9iAVI5lYzRqXpajWSYer/tuRr
         JnjBUtmx0ES28qkMfdbGinftKQTtq06rLeQMe8MlqQg0k77EwWlpBHG5xPXrmGIjAK4d
         qZGgAnVGBo9C/wv9UFGjjteYuoHdE1e/HZJGWXJDetM4obYzt636PLdl+g22db+DoMXe
         1QfvQebjrsdNYBoybCcbWOnwPPRArbIeJZAf1jA6oAh9CvI70lWW2PEvsqUPYVu/LEGa
         Cqbg==
X-Gm-Message-State: AOAM532bgiGmuI/ebiqecL0W06ec69Gk+tGWcmiRBAsUhFxWxJsHRSqJ
        3Le7ehoENLgm7D7uPeg4Q6NBcQ==
X-Google-Smtp-Source: ABdhPJwKXAH5BZYXrvvZIcd2M31ocnd8TGD8ZEgObeXRu5mlr0GO3843pNYIqy6d9J38kooRsprkDw==
X-Received: by 2002:a1c:9ad3:: with SMTP id c202mr16034393wme.43.1605547263323;
        Mon, 16 Nov 2020 09:21:03 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id z189sm15667693wme.23.2020.11.16.09.21.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 09:21:02 -0800 (PST)
Subject: Re: [PATCH v3 0/2] nvmem: skip nodes with compatibles other than
 "nvmem-cell"
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, ceggers@arri.de,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
 <20200512141834.GA3023@bogus>
 <f03ecee7-c4b6-7a59-7ab8-42c5dfcaffc4@pengutronix.de>
 <3f050e96-8bd3-a77e-b1cf-1739a1be0c2d@pengutronix.de>
 <adb40d7d-c5e9-19b7-a561-10c33a6cf8ab@pengutronix.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <58738d86-7822-cd9f-6f05-6333d9251bf9@linaro.org>
Date:   Mon, 16 Nov 2020 17:21:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <adb40d7d-c5e9-19b7-a561-10c33a6cf8ab@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2020 17:04, Ahmad Fatoum wrote:
>>> To allow for co-existence of NVMEM cells and other subnodes, would following patch be
>>> acceptable to you and Srini?
>> Gentle ping. Would the patch below be acceptable?
> Did you have time to look at this?
> 

I did reply back to this thread way back in June saying that

"Thanks for the patch, this looks good to me, lets wait for Rob to ack 
the bindings! "


--srini

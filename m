Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FF82906B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408414AbgJPN6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408348AbgJPN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:57:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB55C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:57:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n15so3074664wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+Oj1pj0xy3pRTG2tbwccw/BvWEVT+/elwc8Xpf2+ms=;
        b=DDXq+5dREgrKBdNS5zYxq9+ypSTjRgAp/ciRqn8b3/yWoQO2NQcZ3qiGzZihicFwzh
         OSKVorGcQ+Nw+fctsSOaK5KbLncywVTX6ZuiK7mYSElwllKamCMVemviNWnqq1mbVdtB
         zerN5dGDQTbe+ce2xHxE+2CB/JjMsaM/DyltB/GU9ugfzCxsKo75b1wnRifLtiv4w11p
         eAw2D0DRUadQ5veCRDIBh+upOxC6bBZG+rOz9YQOl6LAbreGYEdBfQm34Pe68SJzxNxv
         uoDOxmBUXzdEq3n9iM5hslW6fmLNP2BhjDJ3CjLd/ZbibEyBz/Nz/KVVV+rEm13xevMp
         6q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+Oj1pj0xy3pRTG2tbwccw/BvWEVT+/elwc8Xpf2+ms=;
        b=et0K5fV7RLJ6DN1AGGLOG9M4AeOgB1ZMJrdUwe0bVIGjYD8LVAuZaNYGLoh5y7l2xC
         UKMWFyd32RvY0Aq08zJHzBVSHrsf+ALllkxcQ8/Bntk17HwUB5VABHDur4c300bQoCwv
         UZmpZ5t8k2eEx3cHK7v+4eMrBW/DoGvWI5WqakKHrL+yPvGOoTH0dPiOnLCGHvQqH5sl
         G02gGn5qdojTtQpdoivwpZOke3ceKZPse+m8T6H3lh4IJzNvpS59peVGHt+ikBhIBqmw
         B8NguRA19w/QkXvYosAPuS6nORfvOxC72LORPhSyFLDU5WzK4YNUhdbfpmY1s0lQOu7d
         jKlA==
X-Gm-Message-State: AOAM532I3gdmkGZdGX1jPjE08DEtpMpb//y4tk3nL7jPu9UcYNEnT1sA
        S8APSqFlveFZGIiRwtPwwUxJGgVox1LEiw==
X-Google-Smtp-Source: ABdhPJzQWk0tbOyCNjqeSDXRj8WMg9EHO3/jd1ZjGhTEY6ctOFAVVz4uMWlvIssusgBkeMNP4rmQsw==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr4220816wrq.106.1602856675984;
        Fri, 16 Oct 2020 06:57:55 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id u15sm2791368wml.21.2020.10.16.06.57.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2020 06:57:55 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] clk: qcom : add sm8250 LPASS GFM drivers
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200925103115.15191-1-srinivas.kandagatla@linaro.org>
 <160263991247.310579.116180302037536226@swboyd.mtv.corp.google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <19d0f252-924c-eece-0788-a24d9c7b9645@linaro.org>
Date:   Fri, 16 Oct 2020 14:57:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <160263991247.310579.116180302037536226@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks Stephen,

On 14/10/2020 02:45, Stephen Boyd wrote:
>> Changes since v1:
>>   -removed unnecessary Kconfig dependencies
>>   - cleaned up header includes.
>>   - moved to using pm_clk
>>   - Moved to right place in Makefile
>>   - moved to use module_platform_driver instead of builtin_platform_driver
>>   - add null check for of_device_get_match_data
>>
>> verified dt_binding_check to pass on linux nexthttps://paste.ubuntu.com/p/6nVzjRwvsW/
> Rob's bot complained again. Can you run with

Yes, I think the bot is probably checking against linus master branch.
Now the dependent patches are merged in master.
dt_binding_check passes, I will send v3 with the suggested changes!


--srini

> 
>    make DT_SCHEMA_FILES=<path to schema file.yaml> dt_binding_check
> 
> and make sure the schema is up to date?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F052FA4F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392934AbhARPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392420AbhARPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:35:43 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509FEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:35:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j18so2980138wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PU8JAhvN4zUsrfhkKJ3/U+lzCe3kpuol8jLKQfI+x5M=;
        b=Ft3KErTXOHq5QcXbEobfzgK8Gf7EjBtWIZDiuSkD72B8gK7VvfcLCtPp/hZ8JuHuaj
         uroX8moLdNwpGW0foiUal0VbqQayQsWQUG6ONnnYmsLnxql436zRI8QWaT4MomVExnPj
         JRajFo8XyBfDGfRtXuZupfM3rbwmEKnNr30oLneAZJPwBSGkYW1WKrF+mRld47INz4W2
         qTUsFItaXxifel9I3qeFAztbcdz6vaT8mmwJ48IszxZkklexnWu4siLs+URTz2kXhAlV
         ndP8E3pla+lmvJzApg893H+KsiUGj0TPLKWAdaZs79xH5kBl4+YPu/LNmlYjE0yWEKsA
         bOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PU8JAhvN4zUsrfhkKJ3/U+lzCe3kpuol8jLKQfI+x5M=;
        b=MFxnb8mZ8tDaja4dz6r7j9h4KQ7DYr3HqFAQTH/dunaAgfnmW1mlzMkcJQpt7mEBdh
         Ve3qOeKR1UxOlhPwCNoOSePveaF7giLyOZGmv4DEpBK67fP6rFk9wmiX+wCv2TWaN5Wf
         ZkJk22hEUVcKfaJrfRi2J3YoaBHJjahaNLwblpSrawg33JGLk9Pn351ZBOi5zNgPO4Eb
         WIBG12nmY6YRJCWDhKRxum8i7TYMhWRHRL9kjYhmhocdy0kh6v/Wm4tPirpyw9aSU6d5
         iCvZ3IC+ej2+CJOLIFpNSYzEzMoVt0HkGm8iiE7SsO2JqS6VTT9BUTDw+erepHKAOeXw
         LP5A==
X-Gm-Message-State: AOAM531T/QXP480p1K0howNhhwf5hZdjj3BnYLU4KOJaMk7jcJk3CyK7
        gWIxLwXxTJ/GSS/42nxX5af5QQ==
X-Google-Smtp-Source: ABdhPJy7Qf+dR3dTGNomfdXFejG6kvnctAApzuCxs3vM5dctK4LY7mW25LdpmWsSzHonrRc5DG4brw==
X-Received: by 2002:a1c:c205:: with SMTP id s5mr7211954wmf.129.1610984100986;
        Mon, 18 Jan 2021 07:35:00 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:2095:8614:d69:136f? ([2a01:e34:ed2f:f020:2095:8614:d69:136f])
        by smtp.googlemail.com with ESMTPSA id c16sm30141331wrx.51.2021.01.18.07.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:35:00 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Add drivers for Intel Keem Bay SoC timer block
To:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Seow, Chen Yong" <chen.yong.seow@intel.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <DM6PR11MB4250A1E8C1F2CA97516A2E59FBA90@DM6PR11MB4250.namprd11.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <98fd451c-828e-e2e4-8462-51f9c88b6f1e@linaro.org>
Date:   Mon, 18 Jan 2021 16:34:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB4250A1E8C1F2CA97516A2E59FBA90@DM6PR11MB4250.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2021 11:54, Ayyathurai, Vijayakannan wrote:
> Hi,
> 
>> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>>
>> Changes since v1:
>>  - Add support for KEEMBAY_TIMER to get selected through Kconfig.platforms.
>>  - Add CLOCK_EVT_FEAT_DYNIRQ as part of clockevent feature.
>>  - Avoid overlapping reg regions across 2 device nodes.
>>  - Simplify 2 device nodes as 1 because both are from same IP block.
>>  - Adapt the driver code according to the new simplified devicetree.
>>
>> Vijayakannan Ayyathurai (2):
>>   dt-bindings: timer: Add bindings for Intel Keem Bay SoC timer
>>   clocksource: Add Intel Keem Bay Timer Support
> 
> Kindly help us to review this updated patch(v2) set.

Review in progress ... :)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

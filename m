Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD92C6A62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbgK0RFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgK0RFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:05:21 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6AC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:05:20 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b63so5062530pfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GCdHVf2ICkAUP9obNLlG0gSbXX2SG/cCp028LtcKKmc=;
        b=QGGOiCRS0e7CQUUODmnZ9oOa9PWPYTAS6SA47WLmPyk3jtjG07lpJ3EXOhJHgXtG0G
         4XHMinYFdGJABx6VRcZhLmS9j3PzUJ/m1RaBKpaUCptKBzWn5TKh5mB7Wl7aa98JQlqj
         RwZbeCjoj+Nz/J7nqMJzVWfrZ/PWuqi0LKGoL43Oo6N/cXGNHQT128QqVzsJrIVWGd5h
         Us7igudgypt18aHIHuIw3SiWjDphyFTvGt/khsgsgx/OvlZs/0y07OBhBHbojQP8Xq7E
         lPtUtNBPHwJCX9sn/jglOkIeIJLN+ZIOBczJCK/gWiA3Updl5t/CEJMpVmYje8mphX/X
         WVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GCdHVf2ICkAUP9obNLlG0gSbXX2SG/cCp028LtcKKmc=;
        b=AIpvvSsi+Uj0mf+VUEDMnKQrEBU2/APiyeUaT2DdX7VreRPNchLrGR1pKTo996Bve3
         yPyjCcoTK1tXsiIcmq0mSJUxaMy3Wej6XzPP6gbWmnvGSUGvgPM5sK+Un/qDKLWz4Nv4
         xvNSPsO1TaZCQDKLHGRtv1Os/6ZNY54e2CCMG7CJPbC34W/vqldwdXFID7wg16nWgP+y
         tgqWcHSpwnwbNgfaHe2lN6Ehlyo5QJPfTymBfaY6m9J1RO8zWLLAt6d/Mk9WsGMy25zX
         qr7q+4wtFgbUGyzehbmGbAx3NqOoiJoK8bR3oyOE+/O0TmvGfsVOYansQYOjouv00hky
         jYUQ==
X-Gm-Message-State: AOAM533Jm0HoZqW1ZHFs4/uS5QCNhBFvgoX0RDFmjx2e2RXccT2yPZ0u
        RoV1PdgozggLYngEq4lazweCjU+XB8Q=
X-Google-Smtp-Source: ABdhPJyiZC8mHzU//5Z6K7FPTOmdrrXqNDBMhybwSJ38YPp++kGcFTHCeVCKghY89O2zxhZXUW9HxA==
X-Received: by 2002:a63:3309:: with SMTP id z9mr7201024pgz.243.1606496718976;
        Fri, 27 Nov 2020 09:05:18 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y24sm7885929pfn.176.2020.11.27.09.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 09:05:17 -0800 (PST)
Subject: Re: [PATCH 01/25] soc: bcm: brcmstb: pm: pm-arm: Provide prototype
 for brcmstb_pm_s3_finish()
To:     Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-2-lee.jones@linaro.org>
 <20201104032507.565008-1-f.fainelli@gmail.com>
 <20201126092039.GB2455276@dell>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c26a73e6-93b9-cc95-903c-020e4fdeb3ff@gmail.com>
Date:   Fri, 27 Nov 2020 09:05:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126092039.GB2455276@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2020 1:20 AM, Lee Jones wrote:
> On Tue, 03 Nov 2020, Florian Fainelli wrote:
> 
>> On Tue,  3 Nov 2020 15:28:14 +0000, Lee Jones <lee.jones@linaro.org> wrote:
>>> brcmstb_pm_s3_finish() cannot be made static because it is referenced
>>> from brcmstb_pm_s3(), so let's provide a prototype for it instead.
>>>
>>> Fixes the following W=1 kernel build warning(s):
>>>
>>>  drivers/soc/bcm/brcmstb/pm/pm-arm.c:395:14: warning: no previous prototype for ‘brcmstb_pm_s3_finish’ [-Wmissing-prototypes]
>>>
>>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>>> Cc: bcm-kernel-feedback-list@broadcom.com
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>
>> Applied to drivers/next, thanks!
> 
> Does your branch not get sucked into -next?

It does not, but rest assured this will make it into 5.11 and you will
be copied on the pull request. I will work with Stephen to get the
stblinux git tree added to -next.
-- 
Florian

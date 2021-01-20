Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442A02FDA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbhATT7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbhATT7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:59:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51462C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:58:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id kx7so2856104pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MfaXz7q7ypMtoFRywWb/uSXNLRR1HjaD0R8NKRuWUg4=;
        b=ccMMj1sAdOtFgYcc0N7T8pYGOxwNh7HmovjcTEcrdfcpHA9BxdACdW0SYZPRj9a0Ug
         G4RaBeMTK6G9dZ/Icyhgmc4n+8vs+PiGLyzvPn6UOB2/l2m0r6bKkbJu3WJQ2aqM/3HT
         UY2nJZfKaataiSyXv6sB8bxLA9u1NXR3pa3ZBNHlAcAWuHz9CCjOOl5nIMex+TiFvpu8
         is14uJpdTlHm4MceIgOntbb6+oZpzeEKB5MnA88yBMdeu3xHgmq7Ks9QzkNF1tWvp5ns
         bSq8tDBOH6B1ajOfnxnaaLvkSqNEOeKwkg/Cnk6UY7Bb7NxGcXM3FYBk3pyffXn/xWo6
         U77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MfaXz7q7ypMtoFRywWb/uSXNLRR1HjaD0R8NKRuWUg4=;
        b=LHpq9xi3Bf/+F/PXEd3vsXNP32o/AfX4Ro2DADjwV5AJAakg2jjpLawIrxjK1jCIqP
         ijk1h6haih8u9esrHoqBO1KbLWx5A2Z2Q5UAubAdudLDoJMfh0VnBEC9hS7dCJ1Zfrjr
         IqUd1D7A3jxWfgK28hhit0+Nrlxww7O+NMogSRumnn4x+iWai1kFMfSlbgUYO2hynHK4
         5JvVmzJRIJHebhX/j3fZDTuAiQ48LwJpiCKw4PglNplf2AwCLlaqf8ZVX+aAWdl3xNWl
         w6O6OpvKxAYaruOYQx8V/1snPn1BwHRz4JKeC46Fcw9QqVGT+xqRiXolkCpzDZF6Ekuu
         jNKA==
X-Gm-Message-State: AOAM533SFzFyt6gKN0xICpwCrGQCIW/5zw3ehLhVFyW8PK6zeC1hL0ox
        VtAiXg3bJF+cMAJkwPhCzxhEu96aZGE=
X-Google-Smtp-Source: ABdhPJz7rtyoV+q+46eu7o5FAVAUkdWMv6ob6yFK5W8/fFyQiJ3AdtPcI0fTgPWHPMVML1zGUOr+gQ==
X-Received: by 2002:a17:902:e5cc:b029:df:bc77:3aba with SMTP id u12-20020a170902e5ccb02900dfbc773abamr5909743plf.72.1611172718701;
        Wed, 20 Jan 2021 11:58:38 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x23sm3277744pgk.14.2021.01.20.11.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:58:37 -0800 (PST)
Subject: Re: [PATCH Broadcom/stblinux] soc: brcmstb: add stubs for getting
 platform IDs
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20210114105318.14970-1-zajec5@gmail.com>
 <20210120194851.2775816-1-f.fainelli@gmail.com>
Message-ID: <bb5980c6-87ba-ad26-c1fb-353735fd9181@gmail.com>
Date:   Wed, 20 Jan 2021 11:58:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120194851.2775816-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2021 11:48 AM, Florian Fainelli wrote:
> On Thu, 14 Jan 2021 11:53:18 +0100, Rafał Miłecki <zajec5@gmail.com> wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Some brcmstb drivers may be shared with other SoC families. E.g. the
>> same USB PHY block is shared by brcmstb and BCM4908.
>>
>> To avoid building brcmstb common code on non-brcmstb platforms we need
>> stubs for:
>> 1. brcmstb_get_family_id()
>> 2. brcmstb_get_product_id()
>> (to avoid "undefined reference to" errors).
>>
>> With this change PHY_BRCM_USB will not have to unconditionally select
>> SOC_BRCMSTB anymore.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
> 
> Applied to drivers/next, thanks!

Made some tweaks to the patch:

- subject is prefixed with: soc: bcm: brcmstb to match previous patches
- used IS_ENABLED() instead of #ifdef because this may have to be a
loadable module in the future (because of GKI)

Thanks!
-- 
Florian

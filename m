Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241072DCC4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 07:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgLQGBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 01:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgLQGBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 01:01:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924ACC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 22:00:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g185so4560235wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 22:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UWUGj7vRR1Ra7bgeGXHDGwnpi7LWLsFY/4lY0Q3LcxI=;
        b=lN7BiMtiodNlR3/k9qYiT21EC2DhnAhv0O3G3JQM2jGQCvWf+0vc9GQH00kiQQrSlg
         FwuxZW3Ui/Jd2hp9bPDR38p7XMoskQNbPEPK6VlGR4NIMFf+bhjdbc8WceDrHGlfu2P9
         /yKYB2eKeQxRN+h4USTzdTJKimh9rmjBlhRhq65ODAzR29T7rmFZMaOH0PLEyvbsRckq
         zPpiod9d6+OGi6BG1Jm1c14qnsu3GvFB2il2WjBvw/jUQfdqI9HlCbpUxrMGAsf5sHYV
         wArBz5kxBtdd0yC1VsUIJkeppsXhSR5AsTozA/xD75/RSTWd4LOp3MWxPCIoZTCFbWdN
         oclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UWUGj7vRR1Ra7bgeGXHDGwnpi7LWLsFY/4lY0Q3LcxI=;
        b=eetc8vXiPYy9Mp1kT0uMc3F0g4gYHTtyFMVNayZ/8Nqh6zrtreZqVZ0P6L1JCVWBLv
         CKN60/o7SaIeUgo/l2HrW2LsrQjuU2l61b9vyP67THm9fp3R9HYYTe89PTgZTAdIIsh8
         MTYOx8lQ1/A3OZY9BzhNbnoSCztuWgVG4uosNuYHLHVY5/fV0C09w/u50ZuvIIjp1uFb
         K29+zjspylj8fd2pa6/zZTlDdbdFH28ZOVsVR/fifzwWN3cll/8TYcOxfw27gtvZyuLP
         KWgu1MPlBrRvHlsMoqmceLjAJjfhhfEzgJ5HKkEGSnf6xOs6ajISHcge7dLMagA7p0J0
         q47A==
X-Gm-Message-State: AOAM532Y1l7aCDV1ymhtqf/4oalsnFokOQ3jKS+ywr+K4t1Hhm6OtWtH
        WEBo8zB7KYPXZAmkuqHKLoCGGQ==
X-Google-Smtp-Source: ABdhPJya424XSHoCxm4FRdCMnOQstNEHYDGUW5H/aLIHtUrslwbEA2UyxcnG3A6rNrzkB5i0uUikkw==
X-Received: by 2002:a1c:9dd8:: with SMTP id g207mr6664076wme.15.1608184822061;
        Wed, 16 Dec 2020 22:00:22 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:601a:58a2:ee98:f8a1? ([2a01:e34:ed2f:f020:601a:58a2:ee98:f8a1])
        by smtp.googlemail.com with ESMTPSA id h98sm7698614wrh.69.2020.12.16.22.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 22:00:21 -0800 (PST)
Subject: Re: [PATCH v2 3/3] thermal/core: Remove ms based delay fields
To:     =?UTF-8?Q?Peter_K=c3=a4stle?= <peter@piie.net>, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, platform-driver-x86@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20201216220337.839878-3-daniel.lezcano@linaro.org>
 <20201216220337.839878-1-daniel.lezcano@linaro.org>
 <00766bd10b90c0c3bebf25738b782ec9@piie.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <01b55dc9-0b17-4ccd-e930-5318c0693e30@linaro.org>
Date:   Thu, 17 Dec 2020 07:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00766bd10b90c0c3bebf25738b782ec9@piie.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2020 23:35, Peter Kästle wrote:
> 16. Dezember 2020 23:04, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:
> 
>> The code does no longer use the ms unit based fields to set the
>> delays as they are replaced by the jiffies.
>>
>> Remove them and replace their user to use the jiffies version instead.
>>
>> Cc: Thara Gopinath <thara.gopinath@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> drivers/platform/x86/acerhdf.c | 3 ++-
> 
> Reviewed-by: Peter Kästle <peter@piie.net>

Thanks for reviewing

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CC02DE175
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbgLRKqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733146AbgLRKqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:46:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF7C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 02:45:44 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r7so1633392wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 02:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=58X31zZpONeEKwQdcdX8fGmd9oTd9u4c+E9558qGKSU=;
        b=JlW8X6b2tP9pUaPsTXXX5hdRh+Qn4YzkBdbOVjAsGpiQsBThpDT0M6ux6qPrdVA/Ad
         /J8fcH+6jYPPuiEXgUCBR+fQHRgkFopX5abwCdFaq9TqcZEZPwTMVzT4Oun5c6AnqqeI
         GeC1Oj92H9Ae6GHgNGxuf6xgTytKZsaOGwha0fbAVOk/ZGgC6Nn/NOsuG+r8b4yX1voX
         pwprJ8pXqDxRDtQTgpo8aFIUCHTI06J6OhLyuTmTlmEQzISfHjauvvaP+a0zJoREX5jm
         ium7SY7q+qMONEkuvC881zsg6MjDU99qD464siHR2Y3sIcBmZf1wfYtqcxIXliD8gVmR
         MZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=58X31zZpONeEKwQdcdX8fGmd9oTd9u4c+E9558qGKSU=;
        b=JLNigy55OViCYSqCyZybAzMxvHADfP/MZKLxpjeOYDJ6TMA9aH0jklIoTwaQ4tx8ss
         DkeVddjx7TVIg6gLMdv2391PCvKkdQQetteaHxoX0CZ3GVrEdG/r9Dzgh7IaCbXjXWQ/
         gDEcizGBroiCgsmv47/8loJejKuUEeCXD9MJWa4sWVZ1tNEGOazXprvg5m/4GgMlk6n9
         j/lPi1WPnvPS0jVkG4v1gtAPrcWNj7T7kqNhsmMeoaGAufFVQ7ZnZnZxubokjhrGWDUm
         y/Lfhjz6iK9RiCj3HjghuJoTu0K40sPVptzzeIyNTQ50Q+2pc+u2HzTrmLYo9jXETVkP
         Z2+A==
X-Gm-Message-State: AOAM532PFXiru1HUokU0wSA9sn6XO5AorsacdEthZr2VECfVv+0Jkchf
        OX3oeapsXEZT8h26icl1ptXZ7A==
X-Google-Smtp-Source: ABdhPJw3rMz0JuHJtNI5TvKJwMhRsZYFrmay2JwIOybU3txdcxLex/rnUmjfipG0+04WxeZ0WnDGDw==
X-Received: by 2002:adf:a319:: with SMTP id c25mr3778258wrb.262.1608288342621;
        Fri, 18 Dec 2020 02:45:42 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9551:6b47:8c25:8c7f? ([2a01:e34:ed2f:f020:9551:6b47:8c25:8c7f])
        by smtp.googlemail.com with ESMTPSA id h16sm12882095wrq.29.2020.12.18.02.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 02:45:41 -0800 (PST)
Subject: Re: [PATCH v2 3/3] thermal/core: Remove ms based delay fields
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
References: <20201216220337.839878-1-daniel.lezcano@linaro.org>
 <20201216220337.839878-3-daniel.lezcano@linaro.org>
 <PR3PR10MB414206497B833D717BC627A280C30@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0f9ef932-b49c-9a1f-71a8-1c9dbf5de520@linaro.org>
Date:   Fri, 18 Dec 2020 11:45:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <PR3PR10MB414206497B833D717BC627A280C30@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2020 11:16, Adam Thomson wrote:
> On 16 December 2020 22:04, Daniel Lezcano wrote:
> 
>> The code does no longer use the ms unit based fields to set the
>> delays as they are replaced by the jiffies.
>>
>> Remove them and replace their user to use the jiffies version instead.
>>
>> Cc: Thara Gopinath <thara.gopinath@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> For DA9062: Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Thanks !


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

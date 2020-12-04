Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97E2CE4AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgLDBCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLDBCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:02:44 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D9C061A4F;
        Thu,  3 Dec 2020 17:02:04 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o4so2512150pgj.0;
        Thu, 03 Dec 2020 17:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+k4B/H3vzmToeDmgTEl/tBZ/Z3trqu0Vfopl/HAWVbU=;
        b=PlFMalRnzad67ULuWCrUCJ7tSt6b10UeKjOOpecBgy4+Ucx4HxbOfAEF5D+sYrfK4u
         Myft8BTTEgDlTozdYkXkN1SLJnExxbSqDUOYPQIOUQwC8NI3zaagKM2rQyM2aVwXBHKG
         CK9/WK6+hckH6fhgDhlrTA/fvhKWrSuERWO2uvTa7rauO87bK0tNEnPh1j86viIGcLHV
         mlbpHZGVzzfBS8e28Ux3rHsgITcOqx0cHyrfGfsPi4HOOvmp9vpkx4xhQF5mnNNPxgkI
         4nJsnFWAYZQlZOTYddHpKXYGTaEwIhdpUarcdnPBFGuY2ieuVsPME32iNTZJ9adkAjVL
         vJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+k4B/H3vzmToeDmgTEl/tBZ/Z3trqu0Vfopl/HAWVbU=;
        b=Hbf8W8huWVnkMSupm3YKYLfJUIHufIifETDrDUv044l0rUjjSaqV0saRd9OCdkqcS4
         lddbyXQHLX6RLViOMmKBd/QNiD//xt+/B6O+J+2mLJUjq/z/EqZA5p8VzQK6Xws5nIwq
         T7l0X5czSohteXUX3Sz9eab9TttBom4LVxn1zCZmQ3TVLry6x4WhuFGbql/7eFLcYOAw
         yfL920Xjl6XLX0uPmvMf3bdyYoV3PTUh7vtl6YtktbXHOoUiT/9Z35ysrmpS2Oycjuui
         WoiVdAB+zE+Nk9qAor3FT3TqLzNtpqQWQggfDs8e7LPOGtlJJgWw3WLdaDJ/dLBzQx1u
         wOXQ==
X-Gm-Message-State: AOAM530SKF11y04XyrYqJbjDxcb3UQ7bKRaXgZJ95eSdJsedWe2lfqi2
        E3cw82XDvqWaO7XEBjHKJSo=
X-Google-Smtp-Source: ABdhPJx0cmn7UDpPn24WNrHRSy4DINS4UcehR/0yc6O0Ap5eHPixjc50wQNrWDLZFYasilknGCA31Q==
X-Received: by 2002:a63:1959:: with SMTP id 25mr5378796pgz.201.1607043723792;
        Thu, 03 Dec 2020 17:02:03 -0800 (PST)
Received: from [10.10.15.233] (220-135-135-179.HINET-IP.hinet.net. [220.135.135.179])
        by smtp.gmail.com with ESMTPSA id gw21sm452406pjb.28.2020.12.03.17.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 17:02:02 -0800 (PST)
Subject: Re: [PATCH v6] hwmon: Add driver for STMicroelectronics PM6764
 Voltage Regulator
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        alan@redhat.com
References: <20201202132334.GA168086@roeck-us.net>
 <339c66fe-e946-d8b7-1ca7-aa33c3ad1eb3@gmail.com>
 <20201203154814.GA85686@roeck-us.net>
From:   Charles <hsu.yungteng@gmail.com>
Message-ID: <b43f18ba-b67e-bd0b-79da-a057d3ee3843@gmail.com>
Date:   Fri, 4 Dec 2020 09:02:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203154814.GA85686@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/2020 下午11:48, Guenter Roeck wrote:
> On Thu, Dec 03, 2020 at 08:34:32PM +0800, Charles wrote:
> [ ... ]
>> It's really weird. I sent a mail to myself, and it looks good.
>> @@ -220,6 +220,15 @@ config SENSORS_MP2975
>>   	  This driver can also be built as a module. If so, the module will
>>   	  be called mp2975.
>> +config SENSORS_PM6764TR
>>
> But the above doesn't look good. The empty line is again missing.
> It looks like your e-mail system manipulates/modifies the message
> and removes that line.
>
>> I have applied my patch with "git am", and it did work.
>> Applying: Add-driver-for-STMicroelectronics-PM6764-Voltage-Regulator
>>
>> I think I should use another e-mail system.
> That may be a good idea. FWIW, I use msmtp, and git send-email.
>
> Thanks,
> Guenter

I will try this way to send my patch, thank you.

Charles


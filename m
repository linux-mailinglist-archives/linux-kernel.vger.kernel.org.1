Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF3A2CFB73
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 14:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgLENFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 08:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLEM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 07:56:18 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CEFC09424F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 04:55:24 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v3so4632767plz.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 04:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jccCTPX9VhL5a2HCkZ+hZzqNYA4bwr/fx20iblsQvxQ=;
        b=udldAPaYB3xIhdH1Dg90hV7/C0rScENP88UR5AD+PTa+81OdRmiZOZ0DGy+m1dG7ML
         +OChn2mFoaPBQu3gMpnaASzQTCQhL8KMeHlyg82EF9eq2ysBfALcNzRwe3wfo9Pe/gyh
         9Bj2vXY232oKW0zvVkT8iUiyytd1abqQDGtAp63oAdkgZ7mr9zgS0ExN9gSQJ9UoK73e
         ygh3jM98TVu3fOIlfDxo0kZgXYB9pF/h2cO7KMuMvXzMjXDiZCIJCmbzh04sITnp8v3q
         547eGxvs777gH7mdcbR9S0AfZFVlL+iW4HM7HLWIKB3jq1260SujB7iq6BodLKTxJbpM
         gahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jccCTPX9VhL5a2HCkZ+hZzqNYA4bwr/fx20iblsQvxQ=;
        b=J1TNaNrkWZLYR5wiR8kvtehynB57fNl9J0q0wSb3lGVhex3cYjtb2/XKiDZbYzpyqc
         4/7aV0DPxrJUVgfz3GurWQBeGaOTNTOlC05rM954ieDtEn4mvhdysvGCLQFnESndL1zi
         2be7tw7Upx2yOYUFMCqeTViHkRipGcBLhdDlvlFf5tEEMOkg1QCElWF410Dxd5pfNcvQ
         S1HiHbxO6IroXBGjfbkDmA5K9Re/XDdYXwz7iPC85BZ02wEvrRAUEunvYeZM+kmsHR8u
         BZESS67WEDF4fDDrpjTS08eXjntyMzChjix6tTmC4OGl0fG9bBlISK29Cr3lKgzvHbfb
         c52Q==
X-Gm-Message-State: AOAM533tOp6BWebvPMDDEYtWztSYrg4qG1FhZhb/iMEAy3lXTD9iIPjC
        +vzrUJQLJs6d63n18rhIx/i+eXR5lGuOvg==
X-Google-Smtp-Source: ABdhPJwlGVoj99/KpO+ODTm4FNwirRLr4NgiwdDEZUT8gdUdypX9kW94MDELGPBhonEUwf0mDTvSUA==
X-Received: by 2002:a17:90a:df10:: with SMTP id gp16mr8255948pjb.149.1607172923526;
        Sat, 05 Dec 2020 04:55:23 -0800 (PST)
Received: from ?IPv6:2402:3a80:405:a0b2:f8e7:94b7:3acf:b58e? ([2402:3a80:405:a0b2:f8e7:94b7:3acf:b58e])
        by smtp.gmail.com with ESMTPSA id b37sm6719948pgl.31.2020.12.05.04.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 04:55:23 -0800 (PST)
Subject: Re: [PATCH v6] checkpatch: add fix for non-standard signature -
 co-authored-by
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, daniel@iogearbox.net,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
 <20201204144000.21734-1-yashsri421@gmail.com>
 <b9048b9c-22cb-fc47-8e87-1c091a9cc822@gmail.com>
 <7b8289150f47b1fe32fc85f2082a4b727f2b1664.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <43856cf4-c826-3fc7-1595-76734e535688@gmail.com>
Date:   Sat, 5 Dec 2020 18:25:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7b8289150f47b1fe32fc85f2082a4b727f2b1664.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/20 5:33 pm, Joe Perches wrote:
> On Sat, 2020-12-05 at 15:52 +0530, Aditya wrote:
>> On 4/12/20 8:10 pm, Aditya Srivastava wrote:
>>> Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
>>> non-standard signatures.
> []
>>> The standard signature equivalent for 'Co-authored-by' is
>>> 'Co-developed-by'.
>>>
>>> Provide a fix by suggesting users with this signature alternative and
>>> replacing.
> 
>> we were planning to introduce a fix for
>> suggesting users to use "Co-developed-by" tag over "Co-authored-by"
>> and I noticed that you have earlier used "Co-authored-by" tag.
>>
>> We feel that users perhaps use this tag as they are unaware of its
>> standard equivalent tag, "Co-developed-by"
> 
> As I do not particularly approve of this patch,
> "we" does not include "me", nor is it I presume
> the royal usage.
> 
> Please specify who the "we" is here.
> 

Hi Daniel and Peter
Sorry to disturb you. Actually we (me and Lukas) were planning to
introduce a fix for suggesting users to use "Co-developed-by" tag over
"Co-authored-by" and I noticed that you have earlier used
"Co-authored-by" tag.

I feel that users perhaps use this tag as they are unaware of its
standard equivalent tag, "Co-developed-by"

Do you think that this fix will be beneficial for future users? If so,
can you please add your Acked-by to the patch?

Thanks
Aditya

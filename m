Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEECC26992E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgINWqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgINWqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:46:00 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64FCC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:45:57 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t76so1632722oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ADdOiRlxHtqfzA0ZlcozbdOV0SpOJ7KQLXfL5/ZYJiY=;
        b=GPNneH+IqBwD4ZmEwgddOS2dOxfT8wd/OnYy36RZU8fHEb7gckUDswCY8aE6gy36jM
         LlCigYUWEs2Gxx+SRiGaRMry6B/k5mz3HregsA1ErzFiIqPNxH7q3LEXt3uYeYkNkNdP
         xN7lkzkM7zTMK2AMSFnswnsuhlrNC0su6AHNKFUa0N4oDwKsmI8enSFAHsn/zlwH9/+P
         qVjrS5j2yKpUaxRepFCeDU0zL2ldekYmLECRNhhSyUXcoHMAL6oqI2KUiz90wlHgZMdM
         +y/C3gBfuFW1ASd2TGclLhTudZ4JYwdZwpMhq1mQkuhYRPwnKO2LBBRfE6MqP9H2gtR1
         qpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ADdOiRlxHtqfzA0ZlcozbdOV0SpOJ7KQLXfL5/ZYJiY=;
        b=Kz79Bp8Etcguq01AjjWwAff19ZV5R0groV1JO7Xggi3n0+029O9KE4v6pbuo1WRTHR
         J45Adclb7AYpP1XlicsdvfcnY1YuKb72tW6mWS6XbDxw6UPetKtXwp76YKuFcHGNcVw4
         Ef5/ElAJUq7l1e2IQhHokDM3rW3z9wHftgrIGLFyEQBIUSC/Zfn2BMGP8EvraX/qiwlh
         9JSqvV3aP6/89PaSIy+kuREiPHTo5ZeT06m22+FezKYG8EDHfkttehIAtY2md3cDFuY+
         YulWPMf3w8g2KSxfskY6XYzrTdeZjRFLaERVHCtmRFwzgoYbbBaH2gaPMpZR6WH9Xg8L
         IVmg==
X-Gm-Message-State: AOAM530PtTVWDhLpsXkl1gWly+E+bp5Xir7NQKSiOdc7xIYzdZDFBAWS
        jP+ursHOsftq3UkRTpcqJ0bl1g==
X-Google-Smtp-Source: ABdhPJyWHNzptsXVSpiHfr8mOHg6F486g9xmY1vROWoILvxnGqE71mrfZXzRylW3WbR4ze7shw41og==
X-Received: by 2002:aca:1006:: with SMTP id 6mr1116323oiq.2.1600123557091;
        Mon, 14 Sep 2020 15:45:57 -0700 (PDT)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id s124sm3298555oia.38.2020.09.14.15.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 15:45:56 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: sdm845: Fixup OPP table for all qup devices
To:     John Stultz <john.stultz@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>, tdas@codeaurora.org
References: <1597227730-16477-1-git-send-email-rnayak@codeaurora.org>
 <CALAqxLVQ1uB5Zy1DrFP6K4FgZ0U9rwGterhvzcTws_9O9wWE2g@mail.gmail.com>
 <CALAqxLUr9ahtxkQSXnBG7k092bXxM7yANM0RX7jyVksYzhi-ZA@mail.gmail.com>
 <CALAqxLV4ZiqWZaZV5E6KJQRoqrvWrSWqvVTfkk-P_DDNpdcioA@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <9b201b02-814b-5f56-df97-916e2c927bf5@kali.org>
Date:   Mon, 14 Sep 2020 17:45:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLV4ZiqWZaZV5E6KJQRoqrvWrSWqvVTfkk-P_DDNpdcioA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/20 4:53 PM, John Stultz wrote:
> On Mon, Sep 7, 2020 at 1:37 PM John Stultz <john.stultz@linaro.org> wrote:
>> On Mon, Aug 31, 2020 at 9:04 PM John Stultz <john.stultz@linaro.org> wrote:
>>> On Wed, Aug 12, 2020 at 3:23 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>>> This OPP table was based on the clock VDD-FMAX tables seen in
>>>> downstream code, however it turns out the downstream clock
>>>> driver does update these tables based on later/production
>>>> rev of the chip and whats seen in the tables belongs to an
>>>> early engineering rev of the SoC.
>>>> Fix up the OPP tables such that it now matches with the
>>>> production rev of sdm845 SoC.
>>>>
>>>> Fixes: 13cadb34e593 ("arm64: dts: sdm845: Add OPP table for all qup
>>>> devices")
>>>> Reported-by: John Stultz <john.stultz@linaro.org>
>>>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>>>> ---
>>> Just wanted to follow up on this, as it's still missing from 5.9-rc3
>>> and is needed to fix a bluetooth regression on db845c from 5.9-rc1.
>>>
>>> Amit has already validated it (on PocoF1 as well), but just in case its useful:
>>> Tested-by: John Stultz <john.stultz@linaro.org>
>> Hey Everyone,
>>   Just wanted to nag folks on this again as it is still missing from
>> upstream and resolves a bluetooth regression from 5.9-rc1.
> Hey Everyone,
>  Just your weekly nag on this patch that is still missing upstream.
> This patch fixes bluetooth regressions that started w/ 5.9-rc1. It
> would be great to see it land before 5.9 is finalized.
>
> thanks
> -john

Also tested that this fixes it for the Lenovo Yoga C630

Tested-By: Steev Klimaszewski <steev@kali.org>


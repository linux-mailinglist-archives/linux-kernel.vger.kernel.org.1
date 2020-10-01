Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B751B27F802
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgJACi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJACi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:38:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:38:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t7so1118414pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a0nZvmLGuxssVk3Te667uzYZium2xJpXVVf3+GebwuI=;
        b=P5r/2kc4nBSKCeWW1KfkqD4symJfkff0sleWJz6FrrgylPkx/oShGKRO1Kc8HK4ipv
         H+gWfQkTBQgreUY+OX7PYC6JyTVYSkpalJnwhvMiFMPkuJWO/Y5mncLqc2jH2YvPSJ0Z
         l1wpw48sIseUTvXSX2sfB/XexJHkYUN3oP4VB2oJcSaqioVEIieM+sKTaNVB//aNWCYH
         J9zuQboYeFYrxU9DxTeY6JD2QLPEGpDmfQSWQzwl9HYhxcCNNTG8my+DJuKyu2Cn+qhG
         eWapmUw4nhMmTX0cA4SySKGUVkde0zKS+Qm7V6KEQ2lSJux3S3tQRHBwVXCt8NbfMXnx
         B8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0nZvmLGuxssVk3Te667uzYZium2xJpXVVf3+GebwuI=;
        b=JDb8E2rQ4CJ0ExUiCPYQjQLmEVs0HbwrLd0yMa5rdW+ToEwOUmw3e0sGBGh11kD6Kc
         babIaIgP6e8k8Z10m2IQ0uuJiVK6djTGWJ6j/r78D8PDctX7n/sYDZaXbDbR72j2UZRa
         X4cTBu4Zjo3cCanlAM4yfJBjbrCLtu9/aZLqok43qyeb35dTI1Up9/0LqX8XbnHU7SXq
         6hGcTJ/pEIpYWWV2GrnTHD0vjWBbaXIz1EOkMwvRKIgiuDoP6bcLNdckk1Nm5DvwdvWE
         AdOnNp6+r5efl51hIgmlX429kDYFk9Jr95Zn7rItmNY7qWJWhw73uTQZ0hVScQbKDaPJ
         jh5w==
X-Gm-Message-State: AOAM531mTq435YRQX6xwaV6uuZ/wYHnwdrSA4wckgywhMATN09DQ+vr6
        3fwBHmoDMLKsJo2+c/ZYaPDeTsiOdNrMtg==
X-Google-Smtp-Source: ABdhPJwMfoCleuSePGjUMoav9b5qcbGERtXy7JjLgs6lNLzH51IzbmqwYQWuVJVxV2hzf7CWT0mWMQ==
X-Received: by 2002:a17:90a:d703:: with SMTP id y3mr5148588pju.183.1601519938501;
        Wed, 30 Sep 2020 19:38:58 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x4sm3967821pff.57.2020.09.30.19.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 19:38:57 -0700 (PDT)
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20201001012810.4172-1-scott.branden@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v5 00/15] Add Broadcom VK driver
Message-ID: <e5855e95-dcae-351e-3351-ed1ba9170f7e@gmail.com>
Date:   Wed, 30 Sep 2020 19:38:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001012810.4172-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2020 6:27 PM, Scott Branden wrote:
> This patch series drops previous patches in [1]
> that were incorporated by Kees Cook into patch series
> "Introduce partial kernel_read_file() support" [2].
> 
> Remaining patches are contained in this series to add Broadcom VK driver.
> (which depends on request_firmware_into_buf API addition in
> other patch series [2] being applied first).
> 
> Please note this patch series will not compile without [2].
> 
> [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> [2] https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/

Disclaimer: I am well aware that it is the complete wild west right now 
as far as accelerators go and that every vendor (that I happen to work 
for, just not in the same group as Scott) is just seeking to get their 
drivers included upstream and hopefully for good reasons.

 From a cursory look however, it sounds like there could be a little 
better re-utilization of standards, standard framework and interfaces:

- about 2/3 of your sysfs attributes should incline you to implement a 
HWMON device, not a complicated one, but anything that indicates 
current, power, temperature, alerts etc. should be considered

- cannot the firmware loading be supported over remoteproc somehow?

- could not the TTY interface be using virtio or an existing UART?

- what is the format of the message over BAR2 that you expose in patch 13?

Is there a reference user-space implementation that you can link to this 
patch submission in case people are curious?

Thanks
-- 
Florian

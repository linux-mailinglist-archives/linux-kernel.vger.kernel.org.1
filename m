Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846162F4352
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhAMErN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAMErN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:47:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D171FC061794;
        Tue, 12 Jan 2021 20:46:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l23so391048pjg.1;
        Tue, 12 Jan 2021 20:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wsH511uVTx8En12N2xkRYY/EWxwzRWT77TKtD0W9zkg=;
        b=RIIJpECEt8DcW04/KRZRW3SbTyAg9O+VF7pyA6xxA0Y5ay2d1sujo/ylbdoUx+dwmN
         oPlGWiy8pPqJXgwBrRwZUcDZesRmyc1Vul52/IhC3XbQFcCwJZbkmrDWB6h2OVcnXawB
         Kaq0RkkcKgrt4NnjF40q1lENY9PgzVHlrD5mAg6Z2t5JRyHOpBej33u5uWIQhmHqL1pF
         OQc67g47GZ96B15ivJMGhTa8tA6Z0uGz3z+ydLNNYvyua5zSCgVCMdh9dLgmY5jBxx6I
         fdljdSb6I3U+pgAE4xsVLwe9Kh12TxI8c2o50gE2UhRpPMc2hXNKt3Kv9FTFFY0EaJd6
         +cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wsH511uVTx8En12N2xkRYY/EWxwzRWT77TKtD0W9zkg=;
        b=R6JHdDZw/eVaU9UXihNj26TrF14xpt5oNuU2BbLLRPIuCOogAFA7zS2P19/nc20pLn
         j87QW7Vpc9+Mo5VBXJR6F57+AO4poM+jaRJJTutAsWWMBuRdy4qtSEplZGck5VwNOdGk
         qXMfizySTlorA4eKxYKLqWwqMFPZsJBFkTXI/A/Z29pPvIBa0QmVw1AMno9E3UTxzjDZ
         lHgZiUvYvcAyWJ54ZvZEAUeypf4grePBzoBRCOLXUuOzqVFr9SF46ndhhioJf8SdmD/x
         QtyAiQtpJCYXOSkJd2aZgK9XWPJwXf1TCsFUF661UgUWaRRXsfzLLGVnEZAjeC5oxgXt
         GcjQ==
X-Gm-Message-State: AOAM531jC1ySBvwkjuuZquHSqJ9T01B7hRA9TsCEMSAx0/nrRWvdRpe8
        VASAr2PhYBo90EaDhZiX57U=
X-Google-Smtp-Source: ABdhPJyI66w3akbSvDIGrnXliV0dgKl1F16PHaZriZhZPtI7msewPjn1vOreijeTOlGX/364MbTrvQ==
X-Received: by 2002:a17:902:426:b029:db:65c4:dbf7 with SMTP id 35-20020a1709020426b02900db65c4dbf7mr483076ple.3.1610513192383;
        Tue, 12 Jan 2021 20:46:32 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w90sm737242pjw.10.2021.01.12.20.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 20:46:31 -0800 (PST)
Subject: Re: [PATCH V2 0/2] Broadcom's PMB (Power Management Bus) support
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201214180743.14584-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b3836eff-ea33-1779-5e33-a569ae2d38e8@gmail.com>
Date:   Tue, 12 Jan 2021 20:46:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201214180743.14584-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/2020 10:07 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> PMB is a hardware block used for powering SoC devices like PCIe, USB,
> SATA. Initially I planned to treat it as a reset controller and Philipp
> pointed out in review that PMB driver should use a power subsystem.
> 
> This is my refactored support.
> 
> ***
> 
> Please note one difference when compared to the initial reset attempt.
> 
> As I store info about SoC devices in the driver now, I had to put
> support for multiple buses there. That's required to avoid things like:
> 
> compatible = "brcm,bcm4908-pmb-no-1";
> compatible = "brcm,bcm4908-pmb-no-2";
> 
> So now a single "reg" covers bigger buses (e.g. 0x40) in size, see:
> 
> reg = <0x802800e0 0x40>;
> 
> Other SoCs my use something like:
> 
> reg = <0x802800e0 0x20>;
> reg = <0x802800e0 0x60>;
> 
> ***
> 
> AFAIU this should go through Florian's tree. I based in on top of the
> soc-arm64/next.
> 
> V2: Use drivers/soc/bcm/bcm63xx/ and add Kconfig help message

Series applied to drivers/next, thanks!
-- 
Florian

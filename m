Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8A2C65D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgK0Mmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgK0Mmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:42:37 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23CC0613D1;
        Fri, 27 Nov 2020 04:42:37 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so5410044wrr.12;
        Fri, 27 Nov 2020 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V+UYY93bQCO8HGvd/dOd/Rhtb0qsy0CmlK8sEYhElKA=;
        b=GA7fGSjs3q6PrvswwEX9lGKUTiREVTe9Yob+iavzXSR3VV4fxkwC9WDdbzG66uqDRu
         xV6AuGIOcIwOg8jYnj5QxOkncmsnxfCMenoYtVL+fKxDeLfPt+Mm5FnknXfNAF81ipi1
         /AYi415kQ9YupGtZYCymGwtDYtgfOcCLtSdSEjQzKuPyewgDdxcUl6mugZnZrEJT6A7L
         lxqnE+D3cPfOBRrPh+ik/CUZYkEeNvrSfpSPDmfo97txrh9isM3zJNrkhgm3NQJsnl9o
         ZgYzIFjNbNINeW5ZhWqBE5qgGelIUm/hTyAN3u/i7J5F7n8OhsrjLgNK0KUt3JAxLSk+
         f93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+UYY93bQCO8HGvd/dOd/Rhtb0qsy0CmlK8sEYhElKA=;
        b=YTln3PLs/rxgz+EZ68xMNhZ/tX9xBkYD6BwqMCcH9UdJZGv2bZdJxVHiMNns28JNnv
         caPYSI4jw1/iBREimP65kpkCIIKdep8qYFWh/Nk1puupjGoEUvpKmgWYsR0uQNWsK0Ma
         i/+ud9wIDnAnQoLS7BD9Y9oNxoTbzzv97lvK1X3I0L7B2xJY2I86fTNt5+D8SjXhCqiq
         FbEVQzrM6gN4yd0IRkjJW2ig/r9WuYmJnIGL7nWUhcgNtM7O0QEjhIvIsfgrgWmIJcel
         /v0ykqzFzJDpDBEN4mb4ibGXdU+A7Wne+kOZnt4BEnG15ey+Yrg7R6IevmHFdi23eLFQ
         ci0Q==
X-Gm-Message-State: AOAM5310Fo3TRSQ/DdX4wQqOh5VQ0HTBCSPmYIjvUO0pqcG1jV5kEJ66
        Wx4AvonsCqPEQDdZsoYAItY=
X-Google-Smtp-Source: ABdhPJxYnDUaWz2GemI+sa/5eWMlJkVIio89EdsiU4JRnbiE02Bpz4xHERnzKBCs2dycUYuHqPQcSQ==
X-Received: by 2002:a5d:4a07:: with SMTP id m7mr10130310wrq.316.1606480955830;
        Fri, 27 Nov 2020 04:42:35 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id o134sm1707856wme.6.2020.11.27.04.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 04:42:35 -0800 (PST)
Subject: Re: [PATCH v3] arm64: dts: mediatek: Add mt8192 power domains
 controller
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
References: <1605782884-19741-1-git-send-email-weiyi.lu@mediatek.com>
 <CAFqH_522NuGY9c-_XWhHxoa3QkrdoM92qTOLxgM8PpOU=-ttbw@mail.gmail.com>
 <1605791419.19819.4.camel@mtksdaap41>
 <CAFqH_51m5Pg9ny4HWt1iwf8wtsGSdShpDCVaGwac=v9BBDj2vg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <1f25cc3f-324a-0020-7bf2-e5a915291522@gmail.com>
Date:   Fri, 27 Nov 2020 13:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAFqH_51m5Pg9ny4HWt1iwf8wtsGSdShpDCVaGwac=v9BBDj2vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/2020 15:13, Enric Balletbo Serra wrote:
> Hi Weiyi,
> 
> Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dj., 19 de nov.
> 2020 a les 14:10:
>>
>> On Thu, 2020-11-19 at 13:13 +0100, Enric Balletbo Serra wrote:
>>> Hi Weiyi,
>>>
>>> Thank you for the patch
>>>
>>> Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dj., 19 de nov.
>>> 2020 a les 11:48:
>>>>
>>>> Add power domains controller node for SoC mt8192
>>>>
>>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>>> ---
[...]
>>>> +                       /* System Power Manager */
>>>> +                       spm: power-controller {
>>>> +                               compatible = "mediatek,mt8192-power-controller";
>>>> +                               #address-cells = <1>;
>>>> +                               #size-cells = <0>;
>>>> +                               #power-domain-cells = <1>;
>>>> +
>>>> +                               /* power domain of the SoC */
>>>> +                               audio@MT8192_POWER_DOMAIN_AUDIO {
>>>
>>> If you run the dt_bindings_check it should return some errors, as all
>>> these node names should be 'power-domain@'. Which is a bit annoying
>>> because then you will get a bunch of errors like this:
>>>
>>> [    1.969110] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    1.976997] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    1.984828] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    1.992657] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.000685] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.008566] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.016395] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.024221] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.032049] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.039874] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.047699] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.055524] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.063352] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>> [    2.071176] debugfs: Directory 'power-domain' with parent
>>> 'pm_genpd' already present!
>>>
>>> But that's another problem that should be handled in debugfs system.
>>>
>>
>> Indeed...so I chose to use different name in dts to avoid problems in
>> debugfs. It does violate the naming rules.
>>
> 
> But your binding will not pass (or trigger warnings) the dtb check
> then. Rob was clear that names should be generic. Proper fix is fix
> debugfs not the binding.
> 

By the way, is anybody working on this debugfs issue?

Regards,
Matthias

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35829304621
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394517AbhAZSRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393900AbhAZSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:01:14 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0BC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:58:16 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id i7so11923577pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RDm2OirofydeAGi2UzCXyHwfZoshTv5RXUU/yzFZW2s=;
        b=hhH2jgXiwcjmkK7Paxy/tz4Va3CSikmfLMQ7W8gieh8GyVQBke5te16GIGiVr5ikbj
         +zVwohJVG4D2I8k9zFZx3Hdx3CcEWWWOWirMZR7QGmdQ+iZC0dw7lRTcrGR6rh/4wiOL
         c91cTA4zydCFTLkwQk8px4QsCF/N2JJ1MZ6ZbTgekEdie/FRfZB4JgNvZE4wM5zAhwsr
         1Zf9FX/+G4Vf1GXBVtYinlsptM60d0M8nEUcVmyGmNAIzzt4fQ+d2ad98yl8Vw9O2nE4
         v6tK4ge1yQJv7zi10zTL5zZPq9VUuZxvXUUl68Rp6XIcWC/dRZwFlks5XOSal5rY/H1C
         dlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDm2OirofydeAGi2UzCXyHwfZoshTv5RXUU/yzFZW2s=;
        b=k6qhzwnF7UJT9vxU9LmCPMq+cPTLlKU8Y71vYjsRkBmNApT3jFcNrxVxAgT2HWHz7R
         u9g87oql7JU/wcv1Hv1ZRr7S03CGBx+bcyMoGp0qO3gHZuPyXlBYX/nrE5Wm5N1cA33C
         sRN/PE/sT70QTpL19VDabEvZe+Xh2Os57oxRYKY8QDKo4KQtdb0kHZate7QhS9fA94Do
         Mb9P9Hb5iBP6W9flUjPsYDx0HZX+Hze6m+F/P2WZ99ZuAJydYbGyT+QuCPd5cQwT1HpH
         k1cqWbyyW73HYgLWc7/9vW0CYISkW1mWzwld9EfOc8t2rsxwmUurFLvldEIFaRcfi4QZ
         Rpew==
X-Gm-Message-State: AOAM530hfkF+gst/AuVzvnUN5jEIQvi1qi1cTDs3pkGhg+HjGyXR6vD2
        jyaOglC90DQ4zlqlrB4IkdY=
X-Google-Smtp-Source: ABdhPJwbCz4XTe3FTfTzZX8mZf/7CgxkQeIj1sH05qZh66UAehgB2YUOeD8ObrD9vaaKkNIjGnkdyg==
X-Received: by 2002:aa7:8426:0:b029:1be:ed6b:9e27 with SMTP id q6-20020aa784260000b02901beed6b9e27mr6241642pfn.13.1611683895618;
        Tue, 26 Jan 2021 09:58:15 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i26sm19945261pfq.219.2021.01.26.09.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 09:58:14 -0800 (PST)
Subject: Re: [GIT PULL 4/4] bcm2835-soc-next-2021-01-25
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210125210131.14969-1-nsaenzjulienne@suse.de>
 <20210125210131.14969-4-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f35b1dae-3073-0f13-c4c4-6ea2351feb7e@gmail.com>
Date:   Tue, 26 Jan 2021 09:58:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125210131.14969-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2021 1:01 PM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-soc-next-2021-01-25
> 
> for you to fetch changes up to 5674e314e674d5a7c4d38d8e9beed14b91ef04d3:
> 
>   ARM: bcm: Select BRCMSTB_L2_IRQ for bcm2835 (2021-01-25 21:59:06 +0100)
> 
> ----------------------------------------------------------------
> Select BRCMSTB_L2_IRQ as it's now used on Raspberry Pi 4
> 
> ----------------------------------------------------------------

Merged into soc/next, thanks Nicolas!
-- 
Florian

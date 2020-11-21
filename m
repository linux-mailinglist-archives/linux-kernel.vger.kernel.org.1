Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2C2BBC9C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 04:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgKUDNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 22:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgKUDNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 22:13:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA149C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:13:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l11so5909463plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0FBHQ3NOlUQn/NYjHs7YzIcfLo09F/xQJGf2GH92ijI=;
        b=ZrLtyloKf+cnZ5RTekSyz2at5vTAVa+qESGMeP4Man6gaHsIeS2PfdRO2rOZFtyZCr
         ayBuodK2IerYaMojv+dXz6wUjOBzQchdCuvQb2dn46Ora0Db9Q2QHj1wvXHabXL36+Id
         C/T85uXRbwi4oDoy9tiykYSuRQpxriYWyCttEGYYmFc/P87YM4IE2LbQkYX/7CTvBmzD
         mcENgRE/mM1G0yka6wO/Juc/FOEWBuEDCtwD+Xil8TnqIb05naqASBZpt73tasWBKc2C
         L142rrbPI/6tBP1JVeXxAVSs8ZyuusX7BYm2LlEKLKUOqHFpHzCu/S/bBVMDma1asvnU
         qwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0FBHQ3NOlUQn/NYjHs7YzIcfLo09F/xQJGf2GH92ijI=;
        b=J22sk/9j+yRdic+qv4DO64KywjW1gggn+vGaHZ3wucK87uBbg/JT0P1H0yO0iKyksn
         h/w9rTozR6K7lFfmAp3E1zkf8Yv2PCIvM+qF3+sme3W67DKLDChCtxt4iPhOMgXgmE8/
         NvEjZf6GMTQTkjYGL5H3VLJv7Up3T98e88wDo1C+EayqIYzV+yCu5MtQO1PTa6A5vvpy
         rWydTSqb37eWdJH4cQPYTWpqcpTXSzvVEBPJ2CBlfACcB4J1wH01MEu70kYybtPKWHBx
         sxXJSLOtTYsSQDB9RTsREEeyA8Q7k787XYXOURuWtX9s9o6XeOlcWz/HUH1tc1b/bAwe
         EPxw==
X-Gm-Message-State: AOAM5330kxSYxBzOtJ1FOFKpGOJQI+84O6png/IapWstslpW4+zXvslg
        1Z/7S5qL6+Hno/C8Gl6p5/Q=
X-Google-Smtp-Source: ABdhPJxvuRUi8aZAEErwpd8gRXGoQ7tHhGiO4b3JicMJKmN3rdmgxBHiZvbZ2llSEq4PWMgAIfAPtQ==
X-Received: by 2002:a17:902:8549:b029:d9:de5d:e005 with SMTP id d9-20020a1709028549b02900d9de5de005mr8982349plo.46.1605928421283;
        Fri, 20 Nov 2020 19:13:41 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c20sm4192395pfb.133.2020.11.20.19.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 19:13:40 -0800 (PST)
Subject: Re: [GIT PULL 1/1] bcm2835-dt-next-2020-11-20
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20201120165256.22439-1-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <90a6aef8-8b36-1650-028e-efc4739aa06e@gmail.com>
Date:   Fri, 20 Nov 2020 19:13:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201120165256.22439-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2020 8:52 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> 
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2020-11-20
> 
> for you to fetch changes up to 278407a53c3b33fb820332c4d39eb39316c3879a:
> 
>   ARM: dts: bcm283x: increase dwc2's RX FIFO size (2020-11-20 17:43:10 +0100)
> 
> ----------------------------------------------------------------
> - Maxime introduces a quirk to avoid EMI between WiFi and HDMI@1440p on
> RPi4b.
> 
> - Pavel fixes dwc2's fifo size to properly support isochronous
> transfers.
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Nicolas!
-- 
Florian

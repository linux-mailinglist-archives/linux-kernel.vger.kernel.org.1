Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6142DB3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgLOSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731322AbgLOSYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:24:54 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE35EC06179C;
        Tue, 15 Dec 2020 10:24:13 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id g20so10647866plo.2;
        Tue, 15 Dec 2020 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wyTce4BwMKT40r8Wh7Iv+0YuAsPNo6CPnJs7cfZJbrw=;
        b=PqHkAGeC5Gq6KLzOEoBPEo8HkJEoQcZceYFAx2H5x7IgoeNZtsSjI8+jlUYJHJfvKF
         rLUIfGxJnvHDkf8MLwUzfYvavd2MxCoSv0M111tZf63YyTZUBcyH52zNGZMHpaO+2GmZ
         +VrrydM3s1B+0ltY/td8t8ns8i86/2lyNM9ahAoeaisH+PpP0eMX0yvyGMQPQMdloXJ4
         US6p7nJjJeNCtGXHn3WEair0tpksDjiLidBPZ3ibNBDQZ1OGuzapuAOhkmUJwy4ZjpCx
         sM0WgCD2hNdbxQO4pjN7+mhBMu8h/0EM/ZRGj1nX4M8BOKqa5SeLNavrfXMmmVg9gYnf
         XxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wyTce4BwMKT40r8Wh7Iv+0YuAsPNo6CPnJs7cfZJbrw=;
        b=s6V2qoSahLEqb3eKGqcVWwhlQXWyteQmS/H2jmXF/kriCdgGNIn6sTTQLJN7UqyNpJ
         zMmhTlwcO/Wjcii8z4bJ55rK2zCHU/Yz0QnOBvj+SvQWCOoKuYUfrytku5UoLPJxOu6Y
         ZMQUBQXXgAwHKpm00ajBqlTBNAiQn3K78gyqAtIu14NweBelfqM92qRIQzXEKrWqHxle
         P7PMJZzZqdpB3tyCCHwOIfnrUdbK+vxW3z0APQNxBbhgKyjJphjCsNzkmDetbWu+HwW6
         RSUQ6jw+9z0i1snBskKOMYAOJisq6w3IwrI1OZUYjPgj+nWIcFVlF1/Uxspi1nd8vRaV
         E9WQ==
X-Gm-Message-State: AOAM533+gCGMS5st3CoD/VUMi3qLT6A4H8R8iK2dl4Eq2uXzzruXAsfa
        cBgJbECpY9PrODms3tOOv3Z0bAy0eGg=
X-Google-Smtp-Source: ABdhPJxx8zGOoao0n+Rf6TGxJgQdoQTLTClY1/O/Hv91zeCPGUY41/Oqqpsa0Kg6d+F+yy2tltxKGg==
X-Received: by 2002:a17:90a:7c44:: with SMTP id e4mr154021pjl.138.1608056653515;
        Tue, 15 Dec 2020 10:24:13 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m15sm25714105pfa.72.2020.12.15.10.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 10:24:12 -0800 (PST)
Subject: Re: [PATCH V2 2/2] soc: bcm: add PM driver for Broadcom's PMB
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201214180743.14584-1-zajec5@gmail.com>
 <20201214180743.14584-3-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4c80450f-cf38-190f-0a0f-83f8f116b373@gmail.com>
Date:   Tue, 15 Dec 2020 10:24:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201214180743.14584-3-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/2020 10:07 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> PMB originally comes from BCM63138 but can be also found on many other
> chipsets (e.g. BCM4908). It's needed to power on and off SoC blocks like
> PCIe, SATA, USB.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

From a driver perspective this looks good to me and thanks for putting
it under drivers/soc/bcm/bcm63xx. Ulf, Kevin, I would need an Ack from
you so I can carry this through the Broadcom SoCs pull requests for
v5.12, thanks!
-- 
Florian

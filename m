Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D6F2918A9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgJRRkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRRkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:40:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B5C061755;
        Sun, 18 Oct 2020 10:40:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d24so8690807ljg.10;
        Sun, 18 Oct 2020 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CZ5/1YNy2bWo7Jp+UxAXqknDLVCcYm3vq3FYtrYD/QY=;
        b=l6u3B8phZSYgy1V4b9FLJO+NLWfYJD3epja1Etg9m4quhshmTJ8GtBeaFevy9ziDsI
         hre+pYMJZAMuQJGksbOlWryhYW6ift3IyFD+jr62MCy7jZcBlYLRpP9qXsnZyriPdZgk
         UeaKIB8G1IblZxUp5pLoK9koCuDwC76n70rnFkbXKFMt7NKSdCIbS6OQROuESLAppTj6
         hae4vXEZZce1WieTsDf2Jm64ea7vP28tcSslN4YevjMJj0gbI2zsPuKOMTrIRO5WsT/V
         rhgsrcAcvpyPLpjioSCsAn8OVFOyn2VA2Fs+szWw/u5O+fxe45XK2XayWb0Rq2U+MGg/
         bspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZ5/1YNy2bWo7Jp+UxAXqknDLVCcYm3vq3FYtrYD/QY=;
        b=PSoPfbwi7H2YpBBHUnwkms+88JKHwYZJjBYeBbKb65hPav/Dw36YuaVTPQDsLHNnbL
         0IwX5tTxf3/o5l1cx34N3i6fePfCtXngLXnuav3yUoA0nXlEKKm+/oK7hTVLoi8c8PLI
         vHN3/kJj0CDRW6W1XVd6aCYpOQ9sJj1HIizAL+10a4dp+fTOrZ2uHWTu74s6ZxlJ1WoY
         tTvyoBFl2kxrWbR3Ca+ouItzhZ8W+nDjFlj6b7HbQNGKnUPo2RnnVkGkEqBbjI/pIYdC
         RL2ogmF5+PLvEvBpRMDVdjEppZc2LqVLmwPBPMGPNc/ZK35Mbw8JHwX3YaSKQ6XngikR
         uQ+A==
X-Gm-Message-State: AOAM530aJ1yXm+9ChYbi0hn4ODHJ6YtJ8SzUKv5CvzwtpYWUXLdsnmKD
        GY7lD7ueRRSzaj++f9zqlHqPUhO0vrpcOg==
X-Google-Smtp-Source: ABdhPJxMUy/3JQXqufHrNfxcxp+8pLkSS1BbN7I5aOJx8L6RKPOrWgvCnIRR/6i3SGAyiXcKPsSTiQ==
X-Received: by 2002:a2e:9c52:: with SMTP id t18mr4941259ljj.65.1603042803010;
        Sun, 18 Oct 2020 10:40:03 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:42a2:d0b3:f3e9:8103:3101:8ef6? ([2a00:1fa0:42a2:d0b3:f3e9:8103:3101:8ef6])
        by smtp.gmail.com with ESMTPSA id p26sm2900343lfd.262.2020.10.18.10.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 10:40:02 -0700 (PDT)
Subject: Re: [PATCH v1] usb: dwc3: core: fix a issue about clear connect state
To:     Dejin Zheng <zhengdejin5@gmail.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20201018134734.10406-1-zhengdejin5@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <4dcdcdcf-2878-f6b1-e85a-6cb2a478ed1a@gmail.com>
Date:   Sun, 18 Oct 2020 20:40:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201018134734.10406-1-zhengdejin5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/18/20 4:47 PM, Dejin Zheng wrote:

> According to Synopsys Programming Guide chapter 2.2 Register Resets,
> it cannot reset the DCTL register by set DCTL.CSFTRST for Core Soft Reset,

   s/set/setting/.

> if DWC3 controller as a slave device and stay connected with a usb host,
> then, reboot linux, it will fail to reinitialize dwc3 as a slave device

   s/reboot/while rebooting/.

> when the DWC3 controller did not power off. because the connection status
> is incorrect, so we also need clear DCTL.RUN_STOP bit for disable connect
                               ^ to                               ^ ing

> when do core soft reset.
         ^ ing

> Fixes: f59dcab176293b6 ("usb: dwc3: core: improve reset sequence")
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
[...]

MBR, Sergei

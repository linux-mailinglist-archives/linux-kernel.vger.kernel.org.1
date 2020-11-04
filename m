Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C362A6EEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgKDUht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbgKDUht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:37:49 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33382C0613D3;
        Wed,  4 Nov 2020 12:37:49 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i26so17548822pgl.5;
        Wed, 04 Nov 2020 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qGRnNkkxpRVD69BezOYvPTk5XFbMXLkBvXWqHdARBMo=;
        b=SeSiK/iKkGerC+qKjDbHg6y4moOKJfp1HPPObRHrjBtQmwCARQBs+Orbf9JmSGHsif
         15d8Ez06KkesRYBYIEZ8opzd4Zhc02oJwNz+k0LFUlPkv+4/FY+sFISuTxwP3wqvoQLA
         MbegXb3qQ8VuRYIIkA7GXhz09EzFX4RK2/tP59zJI8rpGOUIVnrntXwzAPCMnwWnN3we
         0lmxaVShhqFG+NvLGEadkZF9quGPd3TG6p6wKQd0o9WgHSKJmltUEgBdUAUP/F9v6nLE
         r02f9G0Y+IHplFXjztl+7md/V/o3tym/6eIq1wEONu1+y0hG81wgVn23ueNsbXygEzC+
         2DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qGRnNkkxpRVD69BezOYvPTk5XFbMXLkBvXWqHdARBMo=;
        b=MS8/mFiIjpEcuE8sZA0CXGBs/9HZm6VkGo16D5QIHx/rn+7Qjdp4TycEReBLTXLHge
         dHIPtM3uYMwjlso9Bc0Te1QerRIlGKXUyt+p0hmE6HzlYU94Fm/CsTmpj+A1qejYYqab
         IgQ75O6czYAuoS+ziFlOrwwClX/ariPKPfGb7Rz2oDHmuydAEKgjWqFFJ2sEISrRHBXL
         FLxprk41D7kmLq0qdW3mV9O+GR5UYtFtk9AhH3X15VpduLrj/Nx6XXL4OXYSiqrR9CdM
         b5DxW4RuTHfyOBcqCAPneKSq9CP66dYR/rh7hm4t4S5hCcuqpEWhgKgpZvV0M0Ye317J
         bPuQ==
X-Gm-Message-State: AOAM533aX2Dda2hcwHce6qaYktOSNlWthdXX5tTJskZh/P6/Jezuxh0C
        53AQykvcN8+tcTY8Nokt/suuGLTH7rg=
X-Google-Smtp-Source: ABdhPJwPoIUBPY/ewaa/0/2oB66C33JMawShX1mXhn0VpXvttcFVNsVhabChOUwj+8hQSb6jDSMhgw==
X-Received: by 2002:a17:90a:bf03:: with SMTP id c3mr6223874pjs.65.1604522268173;
        Wed, 04 Nov 2020 12:37:48 -0800 (PST)
Received: from [10.230.28.234] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q18sm2651038pfs.150.2020.11.04.12.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 12:37:47 -0800 (PST)
Subject: Re: [PATCH v2 2/2] ARM: dts: BCM5301X: Linksys EA9500 make use of
 pinctrl
To:     Vivek Unune <npcomplete13@gmail.com>, hauke@hauke-m.de,
        zajec5@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201104202952.783724-1-npcomplete13@gmail.com>
 <20201104202952.783724-3-npcomplete13@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c0d62a2e-59e2-c811-f5bd-e7299f540ca3@gmail.com>
Date:   Wed, 4 Nov 2020 12:37:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104202952.783724-3-npcomplete13@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2020 12:29 PM, Vivek Unune wrote:
> Now that we have a pin controller, use that instead of manuplating the
> mdio/mdc pins directly. i.e. we no longer require the mdio-mii-mux

I am a bit confused here as I thought the mux was intended to
dynamically switch the pins in order to support both internal and
external MDIO devices but given the register ranges that were used,
these were actually the pinmux configuration for the MDC and MDIO pins.

This does not break USB and/or PCIe PHY communication does it?
-- 
Florian

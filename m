Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D692C705A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbgK1Rzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 12:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbgK1FK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 00:10:27 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B638C0613D1;
        Fri, 27 Nov 2020 21:10:24 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id s21so6188493pfu.13;
        Fri, 27 Nov 2020 21:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F0vFc3NvYkJ/R9GXcnF7D7uFfZEUtnoEPN18dRbTCIs=;
        b=BkUIOa05Xxp/i2gv8hzMv3s3DF7vYjG5XEH1coC42F8iLecKWdgk+Tij35Y2xkA1op
         ADEriz34wRXYEO0PxPYtAEBhrD5nixV+Ic6RpjfgwfNjgXaBBfVMTQqMp13LBUZh8205
         eZD6daYOC8JL71kGt1CHxl8IjYVg977ExFtBR4YjGDVpnvxM0Pt135exiR9IkiPfiayk
         R0obarrUGtxL/ld9ToTGnOSCZRHlrB9/RvjGvuLSWRanQUMnTW0lGgMScTnc+h5dbcYH
         D5K8xD7PECmML7KX1CRzTtzLN1cuM77wL7jPwF45XmbvnNx2pBXEWv1UC5X+z1ofGU+g
         DxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F0vFc3NvYkJ/R9GXcnF7D7uFfZEUtnoEPN18dRbTCIs=;
        b=nWHIk2ENCZ/kIF6nNlZUt65gIEHXtZ0EB95nUxIhf1QANUNOuQ9NbseOl7J0xoM+2T
         CfuA2XEZ80DlE1ZeWkFic/R88yswtcyrXA+92yvVG8AKm+m0k06eiMDWOEJ1eS2RH6I8
         I4H3ZcRM4u2/fSWFXdvBhs+WPrjapsNrUIFGRvdU/Nnqz13V8PFL7RxfPAlUDRW7pXhV
         +TrCIhU/V917JuJQuIL96P8/9I0Xu5cNpkxAbdThlFp8ybWMFBY4anhBrE2mYzdkQNSk
         f1Wcj157e5aPsvdOVzop6zKMypQmCwyhGaQYM8Dh8uhALEMYvmhy3j7ZezLR2Dw/jZ2c
         dMAQ==
X-Gm-Message-State: AOAM532li8Lnw1eBMHbpz17lGEgFIEOb2Oijc9RP/OeVea9QUfW2RyUg
        dN4p6pE6P1GkPd/7Y3wXPHI=
X-Google-Smtp-Source: ABdhPJx/u5upM3Ts10qWAJjCMXJXFdgrYrZNliTRrDifPLWk1kt7+xSML0mblu642DoH6AzAMt2rSw==
X-Received: by 2002:a62:2947:0:b029:196:6931:572e with SMTP id p68-20020a6229470000b02901966931572emr9953790pfp.79.1606540224166;
        Fri, 27 Nov 2020 21:10:24 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s18sm9473647pfc.5.2020.11.27.21.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 21:10:23 -0800 (PST)
Subject: Re: [PATCH 2/2] reset: simple: add BCM4908 MISC PCIe reset controller
 support
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201127111442.1096-1-zajec5@gmail.com>
 <20201127111442.1096-2-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <81562023-d99b-4f60-212a-7cb3ee9661ed@gmail.com>
Date:   Fri, 27 Nov 2020 21:10:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127111442.1096-2-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2020 3:14 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> It's a trivial reset controller. One register with bit per PCIe core.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

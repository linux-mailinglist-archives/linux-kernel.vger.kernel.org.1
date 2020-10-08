Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6249287687
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgJHO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgJHO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:58:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07635C061755;
        Thu,  8 Oct 2020 07:58:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y14so4476195pgf.12;
        Thu, 08 Oct 2020 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ooZjKz5uSjTKoQI2IxfmGtOoaA/YElVdEKthcp4JCy0=;
        b=kYRqTRYPJwu/u/x+JWPji3EJLHY8iHLCu0fp4xrK8eN44hz/EKpsrCwGy2J5jQsqUl
         1pmSvEyy75FzbU76a72nI370rkQ5V0ltSuG8uqjwViEvbOA6Y1BdMeodJyl4ywvaa5GI
         X0aggxGC9vHlDMi7AOLvnaCf/YdyjpXvZwsagPkxvTJfM6tIBlarogipQQi9iEfSV7av
         eZrACIDjS4Bm6BFPSm7hnhsFT3pgQY9pYlmZ0vveaqcWsYZMQZIhInyPFG8WEcSOPlwD
         xJqbPsVKBEHObi2GksOrrBOOHg4o2O584suy8PfZUTICerVyOM4cb729k5WJ0qvGpqor
         DxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ooZjKz5uSjTKoQI2IxfmGtOoaA/YElVdEKthcp4JCy0=;
        b=rnAHLTToso4FNdMl8UtPb9jTJ1G0o8TQKLaRe7HwU+X/5MB7hG9OgIPSLG+UkdYU2i
         zs3+FwrTyfOq9koNNamjlwErY5zDcRCtqQhxncRHPiZst0QQWql9Zkt3qHnyIXKGd0fI
         zyrsHbTaLVO0D2cRITAcZ9ukv4DURjrVzpFipN5Zi/TGqTbeFwyj4cpM0KeyqHrExXxg
         SXMrX+cOg+nuR810BEGJEjaec+btnfQNUYiKou1U7FUDNzBPcijiDaAPonMPLGecwGfX
         sWkaEzCyw0lLl4DsRJHeY3MI2yzwFNMqsHM1pKgZWIPEKDZazueCvcbFhP2+UgqVczjt
         /3hw==
X-Gm-Message-State: AOAM533UhuSEQQppsU3TomxXGnCX01147ERlmqngEWLZRaPehvNezF2v
        74/uIGtZdTUK9Q0ypy5A1lk=
X-Google-Smtp-Source: ABdhPJy0eL9K5c2FxGv07NPIdvY7W6v4AtwKGIOyCaMbhX2X4MJexS8uTGuygF9J3KZAT6flcWW3hA==
X-Received: by 2002:a65:6487:: with SMTP id e7mr7513174pgv.409.1602169118483;
        Thu, 08 Oct 2020 07:58:38 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id z20sm7718395pfk.199.2020.10.08.07.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:58:37 -0700 (PDT)
Subject: Re: [PATCH 2/3] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and
 port 7
To:     Andrew Lunn <andrew@lunn.ch>, Vivek Unune <npcomplete13@gmail.com>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <cover.1601655904.git.npcomplete13@gmail.com>
 <cd64e0ccae3e5785c80ad4d73af533a40fc15876.1601655904.git.npcomplete13@gmail.com>
 <20201007210327.GE112961@lunn.ch> <20201007220718.GB1972@ubuntu>
 <20201008003241.GG112961@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9c6e4da5-033e-6b30-4525-9f3a7b4ba01f@gmail.com>
Date:   Thu, 8 Oct 2020 07:58:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008003241.GG112961@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2020 5:32 PM, Andrew Lunn wrote:
>> This router is currently not enabled in Openwrt
> 
> You have to be careful here. Not everything runs OpenWRT. You cannot
> break backwards compatibility in mainline, simple as that. You need to
> ensure that mainline does not see a change in the CPU port.

I don't think this is breaking anything, in premise all 3 CPU interfaces 
are completely interchangeable, with the notable fact that port 8 
happens to have the flow accelerator block available for re-circulation 
of packets if we wanted to support a NATP offload at some point in the 
future.

Vivek, maybe you can add ports 5 and 7 in the Device Tree and mark them 
as disabled for now.
-- 
Florian

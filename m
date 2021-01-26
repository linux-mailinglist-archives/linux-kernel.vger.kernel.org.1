Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45B4304F95
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhA0DP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405399AbhAZUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:10:44 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D0C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:09:54 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w14so11101248pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qk2PO2MbANVrlX0xIKJKJxVfvdQIlWTTAdM2rav13JQ=;
        b=H03trmFdyNKzaHuFjSAa35vmyTMyF4QGyU1UDRwd2iuf672hXxobPYgIyQkXdajLnj
         XFpC6gWW36KSr8L6lFhk+AGJDQLYx9a+/liKgW5E5OBTobFBMqz2v9GYYw99ugNDKkIQ
         gQbX5coTg+LA0zbztV4abk0uti+iZ6N+3OqlUEDlmHi9+rNH6cLmRe0wZMWQl6VaEki7
         8xwqJzCQ1+TxDDLVkYk7z6tRAfrgJq52FUKylX8KpUtmDNa99GtuT5BL80Ie+VeihWlu
         LvjjRgL/sp4FQ/rfmYp+Zz+LtzaHab2j+25FpfwPOSg6rgLHFscw1wDp385eI0m2Hmpt
         7OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qk2PO2MbANVrlX0xIKJKJxVfvdQIlWTTAdM2rav13JQ=;
        b=mlW019pjhpgLZ2GxXPe8kOkiG6KKQPJcYxy9EZvw+CiSaICnqjqOY4DK4zd/cX9Usq
         iud2mVQBmbvVg/QkOqh0mEgqclbpTRwZrC0tJ1gdO4aIps13Xq0SSTfwJoEFNQSg0Arq
         4iHAiysRZtI4uMH0WlFoFmBCoRXpman8j2taWlj59srXEnHIOIEmq4GPDfTx0WRowC1F
         3XTEuv6E+rT47OOocYKmsmDSJtQR8i7OlDNI5RQYzveamgnyIirkJpUY6EVVxXfbVmUT
         q8mxyZ50qLiItub6H5LN5JXzSeV0xBk1keYsviyDYZAMkh5EKwTw95xNoyrHmvMOg1Go
         QQbQ==
X-Gm-Message-State: AOAM532pMBKvTUj9OC2H54fcWxbg359Ulazih0opGKAn3dzr5ilgp++Y
        /vsHMoWMNSuTIT73yUWrTNohacJAAWBrAw==
X-Google-Smtp-Source: ABdhPJwsILUYV8pBdbVxOqAkqLtRApBpCCdVZ5Miq3C6AblXsTg9tgeHSz2NCNQJyW5N/yPD9InTDQ==
X-Received: by 2002:a63:a10a:: with SMTP id b10mr7064693pgf.121.1611691794020;
        Tue, 26 Jan 2021 12:09:54 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id gl6sm2995411pjb.3.2021.01.26.12.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:09:53 -0800 (PST)
Subject: Re: [PATCH 0/2] mtip32xx: minor PCI cleanups
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210126200433.2911982-1-helgaas@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20ce0ad8-50e7-2f23-a66c-1c956494d790@kernel.dk>
Date:   Tue, 26 Jan 2021 13:09:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126200433.2911982-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 1:04 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use PCI #defines and the special accessors for the PCIe capability.
> 
> Bjorn Helgaas (2):
>   mtip32xx: use PCI #defines instead of numbers
>   mtip32xx: prefer pcie_capability_read_word()
> 
>  drivers/block/mtip32xx/mtip32xx.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB762C6EEA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 06:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgK1FM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 00:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgK1FKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 00:10:00 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8AC0613D1;
        Fri, 27 Nov 2020 21:10:00 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x24so6211398pfn.6;
        Fri, 27 Nov 2020 21:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ekzVp0S27wCY2zcIgfKwKMVRvUi5oxvr2OBxMCOWQKI=;
        b=dEL5T16yjEZQq2c5q2zB6DIA4WKyN5a1oyo2WdIb43UA4kCURXPDfJ738Tek7LStLW
         1Cag+zdkx60hhRJtZRFS3EB9b/424vQmfmRSWMdY+hDUvFNQY3ecgx5B6FMmu/uBnc5C
         IBcXpwLVNnkgXYLTuZjZUq+x1lNlACkeUpMwrWgr4pIIibc/RoX/J7gfoTC9j0aPF8pL
         oWirBx42wvte7w3cu+W3nmaPIGbVaybgp3zkalSXDub7PNh8k2n/N9KyAA54hGfKHNXO
         z517GYlILLiVeakta0XHXOG9ky5SAHZzycqav8a0tTOZMLzB351aCDhepgaoiGDpxs8H
         ILPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ekzVp0S27wCY2zcIgfKwKMVRvUi5oxvr2OBxMCOWQKI=;
        b=U08hhD/1O7YHnKthsX0fXYTq1kEUfI5ZfRxjzKQVwAsmSpIsNJfOb8hCIE1qpXKUhG
         lYKyUI4nr1Qxn+HPiKaAJIoJhjK3Hkwl3uHlhMOEqLZnKzM3deDTXWG0LVTZLcrYbwhZ
         FZA6EmW/adyLJzkH0n9J82UXxKD3EJj4giLcrBIZJ57nSTEGghX9MJKjF5R1nAfL0HOR
         THKqnvq52QbbcwnU9ehrI2yA1lRGBPr5hqA0vT//F7A7A5oOPjmxQhRTZVpZj22BQNsO
         IIUYovV5HbCQekmsdS3XgHIRswYXDChPfydD4rV9Dvgb6OgWWWId7bK2zRJP+v/iz1v7
         Sicg==
X-Gm-Message-State: AOAM531nEcmeaY0OMxUzFAU+ne0PNb01OVU/adjbWBw+8I9ybwXPJ1Js
        sEs1Yi5oYbiTdZqSB6qlDlU=
X-Google-Smtp-Source: ABdhPJxpn7ppkDtFo0P6hf/73q9kv63y9JBYmKvD6AHWiy79S5ovjWP66I8+GCkDqnumKMPHBvc77g==
X-Received: by 2002:a62:a11a:0:b029:18a:df9e:f537 with SMTP id b26-20020a62a11a0000b029018adf9ef537mr10055925pff.29.1606540199913;
        Fri, 27 Nov 2020 21:09:59 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 22sm12520904pjw.56.2020.11.27.21.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 21:09:59 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: reset: document Broadcom's BCM4908 PCIe
 reset binding
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201127111442.1096-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f8447728-5b05-a6b9-fa5c-233625046a9c@gmail.com>
Date:   Fri, 27 Nov 2020 21:09:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127111442.1096-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2020 3:14 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 was built using older PCIe hardware block that requires using
> external reset block controlling PERST# signals.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

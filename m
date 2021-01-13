Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6097D2F4CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbhAMOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbhAMOQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:16:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9CBE233FB;
        Wed, 13 Jan 2021 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610547357;
        bh=3H1/0VlWx3J/wJnLTMTVLnx6NOXmPlyunqm/AiQM8oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CccyngmqSe1lhtixq/KSzhHoQhAlJFp2b2ZBm2l7uAXhxebJGm4ZD04jxDsFNR8I/
         nIlJqGtG9jgycW4IOzNzC+KEUpZjilEF02fI2mEk1z4+EPkBXLtTCzMmxabSMBKjSH
         1NDBzHsec+bk5Fv77Yhe5IUi9RfLUuyQhknpcwOTA7okC5NssekOOItDqyGi4Wv0+L
         hkZNtRQiBQm1g9dwIekXLSROMG39kUr/a+e3JydUR3dRiK1CwEn0xjCWiBHLC0xzzV
         4SYqDVEZ4DBN/tUEnA94NGZSi72tVicyukQewuAi+07TCt+5/NK3hmGxnk+wg/KmEK
         c7RkLxlxh/t1Q==
Date:   Wed, 13 Jan 2021 19:45:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V4 1/3] dt-bindings: phy: brcm,brcmstb-usb-phy: convert
 to the json-schema
Message-ID: <20210113141551.GS2771@vkoul-mobl>
References: <20210106205838.10964-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210106205838.10964-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-01-21, 21:58, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Changes that require mentioning:
> 1. interrupt-names
>    Name "wakeup" was changed to the "wake". It matches example and what
>    Linux driver looks for in the first place
> 2. brcm,ipp and brcm,ioc
>    Both were described as booleans with 0 / 1 values. In examples they
>    were integers and Linux checks for int as well. Both got uint32.
> 3. Added minimal description

Applied, thanks

-- 
~Vinod

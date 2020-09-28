Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A1C27B354
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1RfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1RfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:35:04 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E5C061755;
        Mon, 28 Sep 2020 10:35:03 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u126so2195166oif.13;
        Mon, 28 Sep 2020 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cHeddmIby2Yg+GgQapoLIFLAlWUnpJGP7Gp7MUzz0bY=;
        b=DI6aNpIpT5iu4BF2iczg6Z7bBHuhKgv6+XFL2ut8XuYRWGXW5B/RNIxBre8iCn0o1Z
         AkQWDPpXIhpg7KFoNOrIsjuZRNSHCvg+prq+iQokg1q2asdc404Z9m5Er+5Utak6qeFj
         8anamImWkv14eFZkgDMtIBK00aZVySJEtcA9H1zefiumuQi+6AhCBCQnwQN57sexIZLm
         5/TCtOBxsXIeip6ri+Tnhe/a9aoSgmIw2f8r05sok0UdPNQDjFNBtxFIuT+2TWrbRIGp
         PbEO0C9fvf8Tgvk8uGH/vE2sZJUlgucOrcrtMsI/It29TCkJq3LLt+na15fQ13q9g/ng
         hZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cHeddmIby2Yg+GgQapoLIFLAlWUnpJGP7Gp7MUzz0bY=;
        b=Q7ettKtGyy12hZ50oquWNMln0Eq8B4aCPrWAS+4F0aLF9KcqEeFi7TvKDXYtcHZTv2
         Z32rmgYHJ1miJeJgakJ6OOTBFC/Cd5be0jeNZJ2+gMJ9aRvCzR6VdGKPgYiF+xtDrl4x
         1Rq+DHXgTFEhHHtjvrSTX/pUxe69idhbvlHd9Z9AVUaVIqLj0oroc7fFVaFDdDXeHdls
         mSh+a6RsvgeGDIkKTsnW6t7QtgLJd87bX4djdNM7oQI8MDMKwVCqkniRorLggc9DrmDw
         8QZw0Cjd0tc20J1Clj/AK/7RzPpMi4GkKUCYNLSDn9GQ06c0sj+1VR47awjrbcTuxO2Z
         DnaA==
X-Gm-Message-State: AOAM531hGL8gkWl+3j8LJe6ziA14XhS6ZPoA8ZhATMABgU93S6x8hsCz
        JoOKlT3495FjNI2A2xv21hE=
X-Google-Smtp-Source: ABdhPJz3D+z1zDnELhofjOQVPb93zdmjz9/EG9DwISeTLP4F26JGh3F2E8SfbrvGye4DW8FgUwO4/Q==
X-Received: by 2002:aca:1806:: with SMTP id h6mr8849oih.88.1601314503350;
        Mon, 28 Sep 2020 10:35:03 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id 68sm378448otw.3.2020.09.28.10.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 10:35:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/bridge: sii902x: Enable I/O and core VCC supplies
 if present
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Mark Brown <broonie@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
 <20200926184919.GB98875@ravnborg.org>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <9c3ce766-743c-705f-7926-21e753c2d02d@gmail.com>
Date:   Mon, 28 Sep 2020 12:35:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926184919.GB98875@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/20 1:49 PM, Sam Ravnborg wrote:
> Hi Alexandru
> 
> On Thu, Sep 24, 2020 at 03:05:05PM -0500, Alexandru Gagniuc wrote:
>> On the SII9022, the IOVCC and CVCC12 supplies must reach the correct
>> voltage before the reset sequence is initiated. On most boards, this
>> assumption is true at boot-up, so initialization succeeds.
>>
>> However, when we try to initialize the chip with incorrect supply
>> voltages, it will not respond to I2C requests. sii902x_probe() fails
>> with -ENXIO.
>>
>> To resolve this, look for the "iovcc" and "cvcc12" regulators, and
>> make sure they are enabled before starting the reset sequence. If
>> these supplies are not available in devicetree, then they will default
>> to dummy-regulator. In that case everything will work like before.
>>
>> This was observed on a STM32MP157C-DK2 booting in u-boot falcon mode.
>> On this board, the supplies would be set by the second stage
>> bootloader, which does not run in falcon mode.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> One nitpick here. The binding should be present in the tree before
> you start using it. So this patch should be applied after the binding.

It is :)
   * arch/arm/boot/dts/stm32mp15xx-dkx.dtsi

Alex

> One detail below - I think others have already commented on the rest.
[snip]

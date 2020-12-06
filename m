Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D322D0569
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 15:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgLFOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 09:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgLFOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 09:11:41 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACACC0613D0;
        Sun,  6 Dec 2020 06:11:01 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id m19so15625372ejj.11;
        Sun, 06 Dec 2020 06:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/RgJjBEQoVIkABw7Jb2fNf8DyaI9+NUyzNSN0w5nfXA=;
        b=WdjNSYh1Sto3FtBPYgC78hlN7/WclPuHaq+F5OqhcbFQrGfFrDCcWHl8mg5+K18yZz
         LSxia3ycSp6Fg71qiBfk2SBf9IKrN265yG+GDXrkag8nzNa9AZIGIOUm1WnrGr5eYX9Y
         8OziztcV0yVcdwKBSehcGyql82aDhRAt+mfsuf9ia7zuQNzX5YKPHkddMAqwXTQPK8Q6
         zu82QhPozfh0cMP82GQxtusibLUtpoAgBoPuesN9H01igztfXWDDuRkEI5df0WgYYf+v
         Ri+MIAwCeF7OCQbovDLCc9ZB+ymsHjfpwOHESeQbZa882ZJSSjbHi7Mwf3hlBXPNCvj+
         N7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RgJjBEQoVIkABw7Jb2fNf8DyaI9+NUyzNSN0w5nfXA=;
        b=gfByL1sBNb7L6NNptQ4XkG8jlQrwoh/GbParBUdSjtDDsVgI063O2XXdhkP/nHopTQ
         e1Nc00wg22AHDlkWVuHUfukmdyYk6Mv9wOdzuOzWdcy+fS2dzDQJrOwzOiEGAuKHkDkO
         K0ZI/1URigMDxbRgZdyv8YPEZbG+lF5dky8Sjg5Gq/UnOQ7Fc2B1TSWYUyV9V3FHLUqd
         gqKWlF7e3UQRKKPqkWZzTr4m6ZYH5Zr5Xn5jQTqUfWBtyHzts7LuMm1lI2YrNfOiQsOa
         rHOarMC/mV2eeBLCXPBlsFETCbSuFgUuknOAgef94+JnSnFHmYwvRTIfKIXMZQ4cofZJ
         F27w==
X-Gm-Message-State: AOAM531DDw/YsJMO3Yf3+zLfkrGCRWi0qqTgdMLDbl42oOjwnTeGIlKm
        Cbl5ovbvuEzhCOSfyqLRoaI=
X-Google-Smtp-Source: ABdhPJyU1tPKn/+7HnquyPAOFSe0G2xWs6loGWNz+59Qh9fmZk1mbrCYZGzF+/ILnh9Sw0CxJRLw0Q==
X-Received: by 2002:a17:906:e212:: with SMTP id gf18mr15408859ejb.551.1607263859782;
        Sun, 06 Dec 2020 06:10:59 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q25sm3871452eds.85.2020.12.06.06.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 06:10:59 -0800 (PST)
Subject: Re: [PATCH v15 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
From:   Johan Jonker <jbx6244@gmail.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20201130100031.22083-1-yifeng.zhao@rock-chips.com>
 <20201130100031.22083-3-yifeng.zhao@rock-chips.com>
 <0abf1dbd-13bb-cd92-907c-849f05ea887c@gmail.com>
Message-ID: <259fe1ce-6bcb-3a26-493d-87bbd2eaff5e@gmail.com>
Date:   Sun, 6 Dec 2020 15:10:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0abf1dbd-13bb-cd92-907c-849f05ea887c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Meanwhile, could you post a RFC version for Uboot based on this version
plus comments, so people can test the whole process from programming,
booting and kernel?

On 11/30/20 1:49 PM, Johan Jonker wrote:
> Hi,
> 
> Looks good to me.
> Do the maintainers or someone else have any major issues?
> Could Miquel indicate if a version 16 must be send for that 'ret'
> variable alone or is it OK now?
> 
> 
> On 11/30/20 11:00 AM, Yifeng Zhao wrote:
>> This driver supports Rockchip NFC (NAND Flash Controller) found on RK3308,
>> RK2928, RKPX30, RV1108 and other SOCs. The driver has been tested using
>> 8-bit NAND interface on the ARM based RK3308 platform.

[..]

>> +/**
>> + * struct rk_ecc_cnt_status: represent a ecc status data.

represent the ECC status data.

>> + * @err_flag_bit: error flag bit index at register.
>> + * @low: ECC count low bit index at register.
>> + * @low_mask: mask bit.
>> + * @low_bn: ECC count low bit number.
>> + * @high: ECC count high bit index at register.
>> + * @high_mask: mask bit
>> + */

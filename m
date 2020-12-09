Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8532D43D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgLIOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgLIOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:04:30 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C77C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 06:03:49 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k4so1691858edl.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 06:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rwyXR4GCCDEPxxWkiI2Maxz/5/zNR8+GQnuigyrmFrM=;
        b=BVslt2iA4zQGGUZMwjjObsPcWfP7TDZav84f9qtxhA3y0h0PJ3siXGJFlbXHYM/Dn7
         VGHrd8RxAd4C/iNQB4reQPr2g3UAA7J1JNQ3Ml9HqgeuhzpU8kFGnpOd1hj9QUWT/lZU
         awNXAGIXvACr4TpBn5/pGDOLR9bwS+u8VS8/PkqfvekmJ8A3KEOIPwTaqvRHSy67swN/
         dIfo24U33cDkTOMixS7g05Ts7fNC5+iDrpFHevupeiyFAOoMOJW8LpL5f5uP86GY5oC1
         9FPJgaZZ4tndMdgjHLXd0mg6eLvcBfcoTbrUViRM1NsC2PUFDD714Q+oV8H2yDUReiiZ
         Lq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rwyXR4GCCDEPxxWkiI2Maxz/5/zNR8+GQnuigyrmFrM=;
        b=RYnUe+qp5sruCs/CvX4Oi37gtqN7rJlzpZZv8B+9p/6+f31nZtyejjuLat10SB5eLu
         GrZQTxdYY2Lhyp6wYzsZMLJZFO4BwwX6z3f2lCi9xUrEwaBVoWgu08JLaD7WhyjVFkjH
         gWf5Je3hpu/gz5+q4XYLiLGgvqIsS9LucRVctkjUfAT6EcEKhyPHnmjmN8WFw06nee0Q
         jbkLCpGsjOe8Awv6sZOcyMm+l4e3WonYo65aTAazr5f8Lvv4H1hwKGr3x9Z4NtJ57pyz
         JoQf2dKGYBSzvf3LawTmm3EW23LNKSrkD1hzHA+p7yc7P20/7a1SzKF56QFkirj9/3Po
         IB/w==
X-Gm-Message-State: AOAM531sNzUWKLSssJXw6ITK0rZ4/k8zmbDIifOeC5U7I7MqQo4MgjY3
        xvLhiA7oX84UKlDec0C7jFicJA==
X-Google-Smtp-Source: ABdhPJzzpiSjOJ/GRwVj/WnLxLgN1bpqDjOay0c5mhUVsCn5PkmGPotE1D2PyMGswZ2e+S2Bp2vF9Q==
X-Received: by 2002:a50:bacb:: with SMTP id x69mr2115968ede.39.1607522628663;
        Wed, 09 Dec 2020 06:03:48 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id gn21sm1433131ejc.27.2020.12.09.06.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 06:03:47 -0800 (PST)
Subject: Re: [PATCH v2 0/3] firmware: xilinx: Clean up series
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1606894725.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <6170bc93-b427-ec9b-8d6c-81a811c1dc27@monstr.eu>
Date:   Wed, 9 Dec 2020 15:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1606894725.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02. 12. 20 8:38, Michal Simek wrote:
> Hi,
> 
> for being able to review new changes more effectively it is good to get rid
> of existing kernel-doc and checkpatch violations.
> That's why this small clean up series.
> 
> Based on
> https://lore.kernel.org/r/e606233d15bfdc594535dd34eb85472b42f61830.1606832997.git.michal.simek@xilinx.com
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - keep variable name and type on the same line - reported by Joe Perches
> 
> Michal Simek (3):
>   firmware: xilinx: Remove additional newline
>   firmware: xilinx: Add a blank line after function declaration
>   firmware: xilinx: Properly align function parameter
> 
>  include/linux/firmware/xlnx-zynqmp.h | 43 ++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 

Applied all.
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


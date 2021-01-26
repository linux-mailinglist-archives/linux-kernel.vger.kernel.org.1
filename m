Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C207304EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbhA0Apg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392187AbhAZR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:58:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF4C061797
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:58:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p15so2444214pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jBa5e1aeDwRwUDVoq1xh4qoAq04GVr9xLp5iesBV+e0=;
        b=m6Yl66H+720x4f468XXJsZALyIocjiBziWv9c2r2LJ5na69FAPrDRqP4JO9lvU3eBw
         6IyTNVv24EOxMsHIpAtMtCbMYLGwg2fiq5g5B1p96jZnkwM2Dio19XRo8xtODIpAOkP2
         c6bDUUpNOuRdEwmCeBmf/oaq65dMNQ8MBLL1sRPMbNuuwopXI088MmVTmuoktLauRnQ4
         GBPV+wJb/HZtBsuEQK73PziWDLGcyrrjrwmek+ldZI03s8KIxobuMOe2d6Eo+yvRsfIS
         1oxThOp8Na4zWf5aR40Zv3T9NmCAE5PZh67NrlMyt5nY/bQrpEcC40vfZEur7p+KqoXE
         Ue9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jBa5e1aeDwRwUDVoq1xh4qoAq04GVr9xLp5iesBV+e0=;
        b=ECVLajkFJZNdTJP6XVVEsb2FvBIFsdYiMPi88eNHH+wngSTFTganj4ntzH25ppZyQD
         cDW9Wh4ElfJ8LCTu76ljA8s0JlZjb9T3Tpdl/t5v9Slu7DWt2TrfMkJhZafDkkak8BK8
         913dbRo2lGupzik1vQ+DZ5CsfOePJuoAEUJGhkPkbpZuYwFE7sm+BFkp1byPb3QIefnR
         zU8+CJ6WGHEZaVLpV5rn129ShenPJQWlxmVVr4ciIDIAH8EsVn8fWVwqXuLFY0JWGyfx
         s/rMHW4JpKeS8NZmBaHOqdoX7Ul8rhpkNG5olKa23JqsvWDTluCTNxUToZDGMFQh3Pu0
         czhg==
X-Gm-Message-State: AOAM530CUuZnWGwnsWfpUJQzcMwhZLkEag/ku7b/AwJRC6xM5R/V5c6J
        Ujrg495jXnGvtJm0IifmIAHz1Y4GYMg=
X-Google-Smtp-Source: ABdhPJxd1bx/4bLAflESefKWcvV1cQF6PjzXo9t4CYXVyWTE/uzDi1qpe265TQqZbaUbg+LpD63hxg==
X-Received: by 2002:a17:902:a5c5:b029:de:30b0:f1d with SMTP id t5-20020a170902a5c5b02900de30b00f1dmr7061230plq.1.1611683881410;
        Tue, 26 Jan 2021 09:58:01 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5sm2848787pjz.23.2021.01.26.09.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 09:58:00 -0800 (PST)
Subject: Re: [GIT PULL 3/4] bcm2835-defconfig-arm64-next-2021-01-25
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210125210131.14969-1-nsaenzjulienne@suse.de>
 <20210125210131.14969-3-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6e703797-748c-c08f-3729-6a0a1ba8f850@gmail.com>
Date:   Tue, 26 Jan 2021 09:57:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125210131.14969-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2021 1:01 PM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-defconfig-arm64-next-2021-01-25
> 
> for you to fetch changes up to b4192249b0c66e0ad177cdab87ea863220a7e455:
> 
>   arm64: defconfig: Enable nvmem's rmem driver (2021-01-25 21:55:18 +0100)
> 
> ----------------------------------------------------------------
> Enable NVMEM_RMEM as module to expose RPi4's bootloader configuration to
> userspace
> 
> ----------------------------------------------------------------

Merged into defconfig-arm64/next, thanks Nicolas!
-- 
Florian

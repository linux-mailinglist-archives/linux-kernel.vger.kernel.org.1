Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB341D04D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 04:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgEMCWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 22:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgEMCWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:22:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589C6C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:22:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id a4so7095594pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WL6LqGqep6zlwpLFE3J2WtwpQ1zPXw+qIg3YMMRroEc=;
        b=ODn9WEuN3+VIjabru6hxefEEFpSjA/Z6TMKlCJQ8GFk0WbZMHU01ilMeVQ152xyzqB
         /ksC/wI4GAaRQFkGM4O8JOaS/B0eqajte+SZj6KRKLnHLQ8BqUJms9eBz8gZVf8sT6gV
         MoCCRNsdZpC+0NXfAmksqDDFCsvvztUei3BoG6I5rR0YbrFIBysb1pPrU1j9tKPVybkN
         hU/iMaSGS8dfUMgTLlPIhNgX+Mj7E2r3jd4gIO+F+Kans8g9jnYAXmfI9bSUnWZWBHAn
         VSI0wXCKKLevcpVOIqC0zrrM+vKsBtVAQN1CYpeHITQ6o1hMFVH/d7MNQadn5AZVVH74
         9dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WL6LqGqep6zlwpLFE3J2WtwpQ1zPXw+qIg3YMMRroEc=;
        b=GqQ9ZpwggLlmTF6CZTBQUNrhED/F9NWrokfn8BIh9FDTYeOsNDahBpiC84+zvDSZy3
         OOkB/7OOtUQ97d51Lqwe3ZDfGeD41yiYleXKQnf3yEGSPzXYXEEGVSucupanoEtaoQrg
         0I8DdjQvWTgp4Xp2ylcqLy+12vr3k17t+2sBtKw4snlAYddHVxBCYC+ZFlQmWWltDivZ
         FN29flNSbg2wTOsvIywbj6Ksg4/iYLnLdxsUWydMQuIy1SPY1Bnw9ouaSJpfnkIYOiGp
         UeGVdkYOhiGI8u0RQYFxVELBECtgz529MyQB7P0BBRV2+XslXSjZel8KFMllUop8tN6L
         nglw==
X-Gm-Message-State: AOAM530fUPH0JA1sfshkTvi7xvqL9DgFtWmLpbItItlN3kUzooSWEstT
        NwUQnZoCR1fvpvgp1wzmevn1BA==
X-Google-Smtp-Source: ABdhPJzBWEZaQALZkzwtMiPWjqkVlIGIbT1og0SaBl+rDkzzwKyMIYkI6jc8cPk19OESIVSdFHSnCA==
X-Received: by 2002:a65:40c3:: with SMTP id u3mr9448390pgp.305.1589336531879;
        Tue, 12 May 2020 19:22:11 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:1d8:eb9:1d84:211c? ([2605:e000:100e:8c61:1d8:eb9:1d84:211c])
        by smtp.gmail.com with ESMTPSA id k10sm13228551pfa.163.2020.05.12.19.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:22:10 -0700 (PDT)
Subject: Re: BUG:loop:blk_update_request: I/O error, dev loop6, sector 49674
 op 0x9:(WRITE_ZEROES)
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <dac81506-0065-ee64-fcd1-c9f1d002b4fb@windriver.com>
 <c51460e0-1abb-799d-9ee9-de9c39315eda@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8f3eeb22-2e85-aa3f-6287-b3c467d39a8e@kernel.dk>
Date:   Tue, 12 May 2020 20:22:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c51460e0-1abb-799d-9ee9-de9c39315eda@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/20 8:14 PM, Xu, Yanfei wrote:
> Hi,
> 
> After operating the /dev/loop which losetup with an image placed in**tmpfs,
> 
> I got the following ERROR messages:
> 
> ----------------[cut here]---------------------
> 
> [  183.110770] blk_update_request: I/O error, dev loop6, sector 524160 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> [  183.123949] blk_update_request: I/O error, dev loop6, sector 522 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> [  183.137123] blk_update_request: I/O error, dev loop6, sector 16906 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> [  183.150314] blk_update_request: I/O error, dev loop6, sector 32774 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> [  183.163551] blk_update_request: I/O error, dev loop6, sector 49674 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> [  183.176824] blk_update_request: I/O error, dev loop6, sector 65542 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> [  183.190029] blk_update_request: I/O error, dev loop6, sector 82442 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> [  183.203281] blk_update_request: I/O error, dev loop6, sector 98310 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> [  183.216531] blk_update_request: I/O error, dev loop6, sector 115210 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> [  183.229914] blk_update_request: I/O error, dev loop6, sector 131078 op 0x9:(WRITE_ZEROES) flags 0x1000800 phys_seg 0 prio class 0
> 
> 
> I have found the commit which introduce this issue by git bisect :
> 
>     commit :efcfec57[loop: fix no-unmap write-zeroes request behavior]

Please CC the author of that commit too. Leaving the rest quoted below.

> Kernrel version: Linux version 5.6.0
> 
> Frequency: everytime
> 
> steps to reproduce:
> 
>   1.git clone mainline kernel
> 
>   2.compile kernel with ARCH=x86_64, and then boot the system with it
> 
>     (seems other arch also can reproduce it )
> 
>   3.make an image by "dd of=/tmp/image if=/dev/zero bs=1M count=256"
> 
>   *4.**place the image in tmpfs directory*
> 
>   5.losetup /dev/loop6 /PATH/TO/image
> 
>   6.mkfs.ext2 /dev/loop6
> 
> 
> Any comments will be appreciated.
> 
> 
> Thanks,
> 
> Yanfei
> 
> 
> 
> 
> 


-- 
Jens Axboe


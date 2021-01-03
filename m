Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACE2E8DB6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 19:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbhACSQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 13:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbhACSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 13:16:21 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1710C0613C1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 10:15:41 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v19so17273508pgj.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 10:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=waGowa0FtUQXfzT4adOsmLs9T/6QK5vr6HCcoxT4PQo=;
        b=tVgBEoM7045AKWVnj071upgZvLNTCb8RMz9CMoXFhf3cd2hIsjpcLqEyZ103uuQrL/
         cQBuvsFJnPZPXrCbuX7xyve4n4Dp9OXi2oCejxFYu8tRcBkkQi0D3Kv60rhloghzszLL
         2w7pgFBeKwQVq2SaRt6+GOdUoJHE/gVswXLKFdqTpp1qeXG2x7fTThJVYYh0iObmZDUb
         OsF4uT5jtVG49aJu4Z+fiUvcK94vxKCVdJ1w33cW7QWIG6WvHg2+/cs7zfz10heFD6vY
         +gPFy4x9cF7UeEDxW3uV588Bxd9MEt4cIQnbu7QJQnkSH7ZivScyvGE+d26NmgzsPT8F
         mgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=waGowa0FtUQXfzT4adOsmLs9T/6QK5vr6HCcoxT4PQo=;
        b=t+td1FwSMn4fdVl8XJaK163OTjiENnSFw5OQT+zwNNDsuYkLlr/3vbbXoup1QhmPit
         zxeij6PIE0t9Abr8Rxa4+MK9OcH/05SdECnGM+MDc7jtW+YQ8fuEeSxR+S2bbRkiUk6T
         G5ZSevAdFssblzoBtCMKKC2jpCDRLZFPzHyupxY9Kbgc8DInqDuKEMNESwB3nfkK3ZnJ
         OoYeOhbiO2qNCpOnPN62QIzcGWihhKRTgn8xkoZVGNwTqYvnM3KwsUhgQm68/zrSL4tp
         pFxUBcfbt7ctz4747ErrJtpPuyp656TH8s4f8bihxW2IXkNRM/1KQHis6vOgHVF78MBl
         Xgng==
X-Gm-Message-State: AOAM533cZceG67xYdJ4kaBxPRcDxDIR8vy6w0BxrwQxoqEYgHKOysHQg
        sOyeca41PTyDV1ExOEnqcZIHtbuZ5v98Vw==
X-Google-Smtp-Source: ABdhPJyKM0mUtKxSmTJiYR8vTOfM23/ZX6k1LtMsY/K64o6H/xEW1HWWHyeWnqis5IZ2VIp5DEWgFA==
X-Received: by 2002:a63:7503:: with SMTP id q3mr11823621pgc.318.1609697740789;
        Sun, 03 Jan 2021 10:15:40 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id cl23sm18307308pjb.23.2021.01.03.10.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 10:15:40 -0800 (PST)
Subject: Re: [PATCH RESEND] ide/falconide: Fix module unload
To:     Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <63369c9b96673442a4bd653fe92acda99172123a.1605847196.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.23.453.2101031017290.12@nippy.intranet>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d7fd7bb-1bb8-a21c-61d8-4d1046f92ca8@kernel.dk>
Date:   Sun, 3 Jan 2021 11:15:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2101031017290.12@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/21 4:29 PM, Finn Thain wrote:
> Hi All,
> 
> This patch was sent in September and subsequently resent in November. I've 
> since learned that the maintainer has been ill. What's the best way 
> forward for fixes like this?

I can queue it up.

-- 
Jens Axboe


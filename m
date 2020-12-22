Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82992DD363
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgLQO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgLQO4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:56:45 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2630C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:56:05 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id m23so12974356ioy.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yQMMQRJfHmfoxJzCu4koSF5OsXDJ3Q26oRNE3NT4X98=;
        b=lh49v0AnBoU3gkPUY1YwcxziE2KyIshv1oxK0pox9tUBjs9FYok4TuPCtyCAkB+AHL
         7aHSFYnDZQlHTpf5l0DGn4z9b2SiYGAkgmmHh7Xpwf1lz37MFdgm2zIJMyObl/LNV1D1
         6aXiyeL9GNS+FMXQ9sIYEg1adkvh+d529mCIGocEOo3uiX0fWeGf8MnHD7MY5a0RD/Fn
         oDI9Ww+b4qu8QJmXsH5DQ96JWENgz6TM9iZQGmkN9y7Hb2Eyc/x6uAON7U88MacjvPRX
         gMdpzIykit1KeDi4QDQ/TKdwh0yyacBP2jtY3OYXksLxgy9l0JiWZ18PMT8wv/PyLKoX
         wReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQMMQRJfHmfoxJzCu4koSF5OsXDJ3Q26oRNE3NT4X98=;
        b=llPUerVKQfpZQ4TCxmHx/AXmKt2l7YcnO2jm8ksWhJF4Q8tzqsPxPk6b9rraoeRuFG
         Ulk8VupWN+eQdX5skyyHupyk9fPk1nLL+oEBYiu6YufU4DPRPJBuRTiJU0iRoJboclum
         WvqM37PFimPUtNDU05ML5bEBwucDEphs42eVUBQORAKxBxsA+8CUXPrEqcdy/PgpQq+X
         w2gXlALC/uK2kTYchTciQk8cShshre/SLMCWwIwpzxRWixKABYjwKdJuwVESwUxmf6hW
         GgmhTpvUV+MbQrfuPtt2EOKigCb4a2NPW1lhKxcstGAeJO+YL8Owx235Xv3jhE6yDT85
         ZQEg==
X-Gm-Message-State: AOAM532+/Zceogz/QwhKLesEtmYTevpIe4aZuZ2HwHgevqSd6l1GzYDQ
        KwFJ0+Po4Izd9r3M84m5qHsHKFbnPGeo5g==
X-Google-Smtp-Source: ABdhPJxpDKcFkxqVdPahjyRDt+cOtXnVa3b03yAOSiOuL4iYnR1H9k/WYbU59F0oLCPBLZBBgVXufg==
X-Received: by 2002:a02:3e86:: with SMTP id s128mr48089048jas.131.1608216964967;
        Thu, 17 Dec 2020 06:56:04 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r10sm3312303ilo.34.2020.12.17.06.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:56:04 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-iocost: Add iocg idle state tracepoint
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
 <3aa9c1a1-5640-b60c-4fab-22ee7de40539@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe7435d3-a167-f7f1-54d7-d97c38453c0a@kernel.dk>
Date:   Thu, 17 Dec 2020 07:56:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3aa9c1a1-5640-b60c-4fab-22ee7de40539@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 12:57 AM, Baolin Wang wrote:
> Hi Jens,
> 
>> It will be helpful to trace the iocg's whole state, including active and
>> idle state. And we can easily expand the original iocost_iocg_activate
>> trace event to support a state trace class, including active and idle
>> state tracing.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Could you pick up patch 1 which was already acked by Tejun. Thanks.

Done, thanks.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE722E8E98
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 22:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbhACVzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 16:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbhACVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:55:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F9C0613C1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 13:54:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id lj6so8608146pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q5mLi1qo1IvniJ/lg8x05dulOHxR+g5L4Otl0FpGxeo=;
        b=Zm8cFyx61w8VNooVwux4OSVgWoFC0L/VNSpg6N1plJYyty6xvPZ79xT0Ecv45mJaBy
         +504YGPF72+1F1WVKMEZQVjca2IH1mHBibyF/6StM90cm2JpKWQm4mTWSrft9r3+uErB
         AWEQ3C8+6DHBSCDm8LFwhz/xmnSp1kWqe86pggGssGKTsmjnHMO0260U7Mu1Jk2PQBs7
         5LdpBCT43X5XTCHNL5dHhYiyWawjjEGDiqURwJMIsKMlQcRpa+sEpN+NNs3tCXlYavFI
         Szvw9JlZZLVQZyh6Yi8jhvUlAF+b89Yn8xE0suJaMy8HaMEgS+prj4VtMBKXkjOzTyD7
         tD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q5mLi1qo1IvniJ/lg8x05dulOHxR+g5L4Otl0FpGxeo=;
        b=LCyS/bWvK2YTK3tYfKDm+soDL+AkKDP1m2D//JCyZdMX/iM2ZOPP9avXO4W8HAQpD8
         euGxFJCXQCDb5eeLiTFVvZTPXfru6XB4w9eLyZdbiVtRHeg6aFxdIM+7pyz/Qs2zQYNE
         rxmHNiecSrNxBUwNZJk+9e77pQEmey8+AhFHRWv8Qta25dsFXC+POcEvxIICPjPC1VN4
         Jk3S6IMya25kBA8ZXvbTz8JH3u5xcHN+2vVQtos0mSqCHZ7PqBkCWu0sO+NTaw+X4ZIg
         +FId/6bugLz30g3EbWWDczwQWWcoauylQxinZT8aaaxaNmWV/fGm/3O+agG0OKrMqrDh
         ag3Q==
X-Gm-Message-State: AOAM532BJdEz6j6u4HJo4iHqGN0kouPbVRTUDUxd+seOcgrTMhIYmJWf
        /7mB0lr95gr4EFCCKRVDpszCTsziaypA3w==
X-Google-Smtp-Source: ABdhPJyPlNxLHz9ZxDwdqXdCeF/3G7Y3n+hEdqmWtcg/tF1iQwG/dO9760WCBt4a2+gWDHEfnnM+Bg==
X-Received: by 2002:a17:902:c104:b029:da:5206:8b9b with SMTP id 4-20020a170902c104b02900da52068b9bmr69469586pli.46.1609710899060;
        Sun, 03 Jan 2021 13:54:59 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 32sm45045920pgq.80.2021.01.03.13.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 13:54:58 -0800 (PST)
Subject: Re: [PATCH] block: rsxx: select CONFIG_CRC32
To:     Arnd Bergmann <arnd@kernel.org>,
        Philip J Kelleher <pjk1939@linux.vnet.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210103214254.1996764-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <27333956-47ad-4f5b-56de-6b2214b75d0b@kernel.dk>
Date:   Sun, 3 Jan 2021 14:54:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210103214254.1996764-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 2:42 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without crc32, the driver fails to link:
> 
> arm-linux-gnueabi-ld: drivers/block/rsxx/config.o: in function `rsxx_load_config':
> config.c:(.text+0x124): undefined reference to `crc32_le'

Applied, thanks.

-- 
Jens Axboe


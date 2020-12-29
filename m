Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327962E7540
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 00:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgL2XsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 18:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL2XsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 18:48:12 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAABC06179B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 15:47:32 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n7so10163720pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+3b8AdRBIqhWAbHJd9MKSPNeTg0fP65SdBmoyfUBMYg=;
        b=LOWL6Dv/YDfwgO3gm7k/Ha/1/B99cixiWTPNt5zmPqOtGudX3B84OkiYJ2eqpazjW+
         IUk8J5y74d/F2jrb6kaSCg62aNDYqZTCE5yYeAxG8Cch5dSa1uY3N/Vm0KYNAx8KqDu0
         sD13n89GAed7RR/Bf+OSJ8NozA6xCZ0PHh2JESitG9MV7P7JaXslHGMA1KRNOWPnxTFy
         XSoHOvK5yO5G9s+Xi0dC19N69lwHpf5M/kbSkDT/WGbqwiwYcsjIQYaMs4n0VFUb7EA2
         35/aRBLbPNFMBN9OnvEpbxXrUOFQ4MUFfzxVEzOeMzGc+XZ2IbDhpvO8hI3iGB9Dw+kj
         bk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3b8AdRBIqhWAbHJd9MKSPNeTg0fP65SdBmoyfUBMYg=;
        b=oU3SxnQQ99yyNJ63e9GN28m9Ju6m0OI+8Hu+UedSGaiKA1pY6x1AehB3sFwBVv3VqI
         KXCMok8xWebamyJsK0BVJpCsHbxafHkMT99b4km4aoCx3P98AUU6W5RDKm8GGDCwyqIp
         lhyJa7YkdJ4wo3sWf0DacOMnKj86S+YNUX7b1FaMPXIsdLcGiiEansWHLxgNSoX3U5a4
         HbHs3ziHfS5QECrd2G/lyPsJYlwTOGM8vrHiE8M5nc3OcQJSl0kY8PiJRfJtPF8Yv0OP
         WqrZWljbMkEyUdijdcM47tbSsnqzwcbgroxEiP3t3OdaIaF1k6K8brd0AG+WWFSluV9n
         K9UA==
X-Gm-Message-State: AOAM531aDtrWTHo0eB6poB24r5SC5l8/fWqJjtgxTsaQhNpJj0FhiKac
        JlkSW2Snd7ED7l9ineXxzGxITw==
X-Google-Smtp-Source: ABdhPJw5d9F0tV2Vowzh8aEgRK+TarMawaqPnaU+0pRVws/TCofMSmohcSXCPeG0Gyls3rJKg70taw==
X-Received: by 2002:a62:19ca:0:b029:19d:cd0d:af83 with SMTP id 193-20020a6219ca0000b029019dcd0daf83mr47506004pfz.51.1609285651753;
        Tue, 29 Dec 2020 15:47:31 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:8f91:de2a:ac8a:800e? (2603-8001-2900-d1ce-8f91-de2a-ac8a-800e.res6.spectrum.com. [2603:8001:2900:d1ce:8f91:de2a:ac8a:800e])
        by smtp.gmail.com with ESMTPSA id gz5sm4485940pjb.15.2020.12.29.15.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 15:47:31 -0800 (PST)
Subject: Re: [PATCH] fs: block_dev.c: fix kernel-doc warnings from struct
 block_device changes
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20201229034706.30399-1-rdunlap@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75e962dc-a95f-7ca7-c145-6a83f11d6271@kernel.dk>
Date:   Tue, 29 Dec 2020 16:47:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229034706.30399-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/20 8:47 PM, Randy Dunlap wrote:
> Fix new kernel-doc warnings in fs/block_dev.c:
> 
> ../fs/block_dev.c:1066: warning: Excess function parameter 'whole' description in 'bd_abort_claiming'
> ../fs/block_dev.c:1837: warning: Function parameter or member 'dev' not described in 'lookup_bdev'

Applied, thanks.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DCD1FA3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 00:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgFOWwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 18:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:52:10 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80395C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:52:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h185so8522717pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RwrdlsWehKZKBVZQSVbm4FZ+bZkOFL8rSZ1Dubk+3s8=;
        b=HwsPMF4pWt1ws4mKNcP2Ya9FrKgdDvltSNqUltzclLf1OG3MvSSLnw4ZQCBfOKNYnN
         KmMIITLprB3TvVG/kcoSQ33WWH8p7wNK3O2389ax6ZVOqgzok6nRzUgvKaX8Gnwz18Rb
         u6CKCGXkOYThg/3ZKrk61Qhq/Ofj0xgqHiO/s612k2akDYlerc+gRB3Mim0IopO8an+x
         x8935Rn1HctWYYtZlmir8+LKvUh+JwJrAiFz+PIJxidVWgbzGduwzoXzHXYHQcr+Y09S
         FTYQopH43e+3weONi0vnGiMtrc0rIjVOvNAJq2OWsGLLQRGOuiruuszBR0n70eBKnoPU
         f0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RwrdlsWehKZKBVZQSVbm4FZ+bZkOFL8rSZ1Dubk+3s8=;
        b=NcsAcAO8B21GEEyOjv/TQqzbpEHVzmlpO4yk3nTz4rCP44JECr3tj64yOfS+9rV3To
         ghqhL7aYNKq6Dp6z4H9TViVvxRcS1xh97ttf4P6Y/majMGduvi50j5IzKtH0bxkSo463
         RRfwvvLx32hv4GIsBCqhBlWTZUWl8HkSgrM0jOB6oMV7Zu/PKcHAemLfkH6iEHa4eo+B
         yorlNSB/ygtCOFChYeXG8dPtFYwTwWm8/fBzKxbTDV7QHCAvrU0v7N693SWBgWmvtL52
         URNGwcnmPQBU2Xu5N3CFVHtMuqel6G3QlTC5mA4dIwwrjrC8x60t17Zu3YqcFG7iu5Iz
         lJmA==
X-Gm-Message-State: AOAM533yyj4arUwXVlkzRcbXuqd3Yp4kHNjJjOWjrmFVmRvCJyGutaES
        S3WAby2MA9Zw5ne4Gg4xYFj7rpYcFGZW0A==
X-Google-Smtp-Source: ABdhPJx0yc3wWLKwncX5fZpU4ROUljh6Czx52DiKh1T5kEl0Ddnty5eyDjZFWlRxaTDPUCkvX6/EpQ==
X-Received: by 2002:a63:d951:: with SMTP id e17mr17827703pgj.318.1592261528999;
        Mon, 15 Jun 2020 15:52:08 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j13sm464942pje.25.2020.06.15.15.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 15:52:08 -0700 (PDT)
Subject: Re: [PATCH] trace/events/block.h: drop kernel-doc for dropped
 function parameter
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
References: <d572a150-192a-bbce-4449-8de45bce1a9b@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <baaf65e6-dd38-473e-e00b-98a19cd9bfbe@kernel.dk>
Date:   Mon, 15 Jun 2020 16:52:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d572a150-192a-bbce-4449-8de45bce1a9b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 1:22 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning: the parameter was removed, so also remove
> the kernel-doc notation for it.
> 
> ../include/trace/events/block.h:278: warning: Excess function parameter 'error' description in 'trace_block_bio_complete'

Applied, thanks.

-- 
Jens Axboe


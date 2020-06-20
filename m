Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377392026CA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 23:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgFTVW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 17:22:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34202 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgFTVWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:22:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id z63so6308691pfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aNmYYThIQrwKb/CnYFR3qPzspsMeW9XF/8FmP59B/pA=;
        b=w2xwOc2AnM6BiXKYV8JoFnLRvFbrjOAYOTkIDHcfZAeGuhn7z8U1ubraIOTXuYYCQo
         STExqObm7UQKdamVnkf9bqs5IjG7eDSuPKYhFtH49/nFmVeKqQAIq4hW7+0eXS+/6L+m
         hiXyDzXfhgj2Th6+mZD81o1sqcpKbtbKkfg/FixGzeJAUcExUXphOe6ERIwkXtISfhJT
         tWL6RatMMMeWDspEjDzXJVGohrjuJRLexyu4ATa/LRwxsAmdYLuh1dJkHxzo6iyW5Jtj
         rFOAJKm5sx9K6R0sl5v+zFgKT1uG+g/tLkCTjkEf0xrP8yMJS3F0MFpZwE7meC+3xzZz
         tjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aNmYYThIQrwKb/CnYFR3qPzspsMeW9XF/8FmP59B/pA=;
        b=pSpXTwetGk/ULprhCHxcJ7gI6lBpR2/+Mbv0g0ZMqz4QZmUQtDIiayrTBWHRanpecz
         lGN3yqLyyZRRX479KFUjFm3y94YOkQ8lpNBpgmsOCue73xgUfK7ySqhuqIq/d0VoWSeQ
         ji1ZXum5Xmsg6TxHhdwgzkLaNZpgVX5EyJFEo5g5Mlm7AudtuIOAw5rV/uS1plUNrZ9g
         LZGLS2kEaVoJcIMjLgeQGILhQAUi9OOIqIlPDEDs543SlnXmWg+p+WlwNbuRGUsMO70r
         FVUHoExO5QVHgQ7hSIOU3E6fTXSU/EvHFcK9gO9Vu7chtvXWOxrvEiZXQs2KN9ThfWsW
         +0gA==
X-Gm-Message-State: AOAM530+qFr1WshV1N5vOUDt7T1knWApQTrYAtNezPIHgBbqJEttc8Uj
        UMJVdON7e/C9PRwLQ8wRDe/Gqg9Gd94=
X-Google-Smtp-Source: ABdhPJwIOpcEUxLA+Tx2u4Sym8EmChXJqY90sCTB5kAjBGyWszcpwUeEvhpKhj3+IN7vie2zB9rm8g==
X-Received: by 2002:a62:5e85:: with SMTP id s127mr253010pfb.236.1592688113516;
        Sat, 20 Jun 2020 14:21:53 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q6sm9305202pff.79.2020.06.20.14.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 14:21:52 -0700 (PDT)
Subject: Re: [PATCH][next] block: bio: Use struct_size() in kmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200620004949.GA30923@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ecbc8a9-42ec-c117-42f7-32572b750036@kernel.dk>
Date:   Sat, 20 Jun 2020 15:21:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620004949.GA30923@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/20 6:49 PM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.

Applied, thanks.

-- 
Jens Axboe


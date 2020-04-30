Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D71C0518
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 20:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgD3SrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 14:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3SrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:47:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A80C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:47:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so256729pfx.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ABdRQgBI25yIrNvDESTtqmXMNbdBPdhiiSh6GEOf12k=;
        b=CS7iZoWGBiAeaHIhT3vGdnnpVYg3KGf4JUbPH7vg1jP7Wyh+f14SEPpo8mHgtDYzYS
         SK+Ou1SVqV8PrNAL1wKoKB/zIHibqlrG9vCmbenfxeQGs80iOXx0WUPMZxCAyvuL7pKy
         0WxCAVumF9a+kz7dxFn4dhJM0FsFTmbHE8WV4r+2upnZVkwdAq+r6iEJ71izlXReGZKv
         7bw3pkXgwQUseVNIH2JCQohcFdJnyPm4Y6aTAUY/mZPtSY/ZLuxt4epw+TSBrrUTnEkc
         2atVBpwYmaW6IbsQGugx0yso0lsOSZlxWi5UsMZCKRbfJQYkaA9EfcGxJNm8gdRgjOJz
         durA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ABdRQgBI25yIrNvDESTtqmXMNbdBPdhiiSh6GEOf12k=;
        b=tRcl9/K3qWn2qjGc/KS7u/JTQc7pim5oQewxZjtiCjrRpi4rsnPzLgJO6bFUoozI8/
         ldxMPaNp0Y40oEPjqPRWyY4P8oixW3abiCojCzpwPplFbSQPnGNlI3dQKo9nx7+ERhak
         iU5+UAAKbgPKVmWroLTcnroG6Jxr3Ie+4AdMHv9ctH61cvHFE6lW14Pt5X6TfWoVIU8d
         hKmbBAPFTyrbvejAUXZvsCALwX8xmBrBvYU055EDNj62mgi56QlB9P5/07rl2zgWaRo+
         uV3OEyuio26QCCtUWb7D5dFE8ZnCLnHaxEcjmlRYt2/ZWhvayv6zivOpm7JDRitI+idw
         honw==
X-Gm-Message-State: AGi0PubpNbpi6yp0T8USEAYrBag/4enpNfg+mMFDDDN2f39BlklOPJ6o
        p1nErPJGursoVL141gK3v5BIW/TGfGWfDg==
X-Google-Smtp-Source: APiQypK50Mb5vUZOYLMzB7jL/Aw7RXfUYPGr8cTLOc5I+VuurshaMp5y0AtUjuRe4ZiNEEcvfpCTcw==
X-Received: by 2002:a62:6246:: with SMTP id w67mr119360pfb.326.1588272425985;
        Thu, 30 Apr 2020 11:47:05 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y26sm413214pfn.185.2020.04.30.11.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 11:47:05 -0700 (PDT)
Subject: Re: [PATCH] pipe: read/write_iter() handler should check for
 IOCB_NOWAIT
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
 <20200430175856.GX29705@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d00f0ead-2782-06b3-6e21-559d8c86c461@kernel.dk>
Date:   Thu, 30 Apr 2020 12:47:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430175856.GX29705@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 11:58 AM, Matthew Wilcox wrote:
> On Thu, Apr 30, 2020 at 10:24:46AM -0600, Jens Axboe wrote:
>> Pipe read/write only checks for the file O_NONBLOCK flag, but we should
>> also check for IOCB_NOWAIT for whether or not we should handle this read
>> or write in a non-blocking fashion. If we don't, then we will block on
>> data or space for iocbs that explicitly asked for non-blocking
>> operation. This messes up callers that explicitly ask for non-blocking
>> operations.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Wouldn't this be better?

Yeah, that's probably a better idea. Care to send a "proper" patch?

-- 
Jens Axboe


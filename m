Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889B91EF891
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgFENFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 09:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgFENFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:05:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5DAC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:05:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x11so3613705plv.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qMmRPUhgtpuS6TTG/GuqLkNjYHA8c+3dVy8v0SMwjMk=;
        b=bkqNLpnPAhUUJPYxLvISfFtr4FvME2B0TRGC5RqPoNt2xKQMu5TPyH7bQDFNomaW2y
         cdr68bxUbRNBYT56MpvLzMeWjqQKNeF6hCrfo/lQoE1/Op2UPzMm4h+6k3GRrK+xoyhJ
         jDJ79wGBXsMM6klm3WxyJ3PrEmmtbfPDKp/odfEuUPRyo2qdgY5Pwu2UggruUrqkZVLd
         V1/7DbEG/cyRRKhiiR4HVe0XetnFxxfYwe30V9ywHzffwSLPzwQY9QyB5LQxjExieX/Q
         d7ANk0zYFIrS0TD4DN9WEE5hJGkIeF348d8XPrtZsFZjaG7jaCjZPQJNKfsvsF0L/y78
         4+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qMmRPUhgtpuS6TTG/GuqLkNjYHA8c+3dVy8v0SMwjMk=;
        b=ayme8/HQNZEfS1OFMCbypOn48C2yz3Uo6bOnJUTupXbY6IQTVFYwk4egafZYiUqcrr
         XIjO+FI9KL9bTLO0GkNCxYz1sxamOlir9e1NfQna6mH3CtUL3BbbwK09UMpnCFAkx9BB
         gcFlRPVvgFDHzCrq6cQ3AlanzT2QvkhCFG/xR5ov2CrkPfT9DewlNEOFCD6IuSEcI8Kq
         KWcZe72p+K5gN4h4Y8dPedX6q6yI61vNiA5Bljto4AGnlXPNTbm831cCWEhJQo7ZPidc
         21ojrFn4UlLp8frRYRDB59b/X12+D+6R7Yk9AnDSdC7YMKtDXPgqf/17a/2Tma5ZXnTU
         bavg==
X-Gm-Message-State: AOAM532ZnuFLknPjYjbepCUXzd9Y6aLeW6gOhSws8oT98OpzjSSwDLZ2
        AP8Rd9OrCCkb5j8izVXwPCwY2A==
X-Google-Smtp-Source: ABdhPJztl3sgTYmes9QTZ50W/VL5LHmidIjsSGXV5BWpaw3tcv1f91aOZKJu3/pXlLzzR6iDp493gQ==
X-Received: by 2002:a17:902:41:: with SMTP id 59mr9814427pla.104.1591362299795;
        Fri, 05 Jun 2020 06:04:59 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 136sm7448369pfa.152.2020.06.05.06.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 06:04:58 -0700 (PDT)
Subject: Re: block: Fix use-after-free in blkdev_get()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Yan <yanaijie@huawei.com>, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam> <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111049.GA19604@bombadil.infradead.org>
 <b6c8ebd7-ccd3-2a94-05b2-7b92a30ec8a9@web.de>
 <20200605115158.GD19604@bombadil.infradead.org>
 <453060f2-80af-86a4-7e33-78d4cc87503f@web.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1d95e2f6-7cf8-f0d3-bf8a-54d0a99c9ba1@kernel.dk>
Date:   Fri, 5 Jun 2020 07:04:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <453060f2-80af-86a4-7e33-78d4cc87503f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 7:01 AM, Markus Elfring wrote:
>>> The details can vary also for my suggestions.
>>> Would you point any more disagreements out on concrete items?
>>
>> That's exactly the problem with many of your comments.
>> They're vague to the point of unintelligibility.
> 
> Was is so vague about possibilities which I point out for patch reviews
> (for example)?
> * Spelling corrections
> * Additional wording alternatives

I'll make this very simple - don't reply making suggestions to commit
messages, ever. The "improvements" aren't usually improvements, and it
causes more confusion for the submitter.

Maintainers generally do change commit messages to improve them, if
needed.

No reply is needed to this e-mail.

-- 
Jens Axboe


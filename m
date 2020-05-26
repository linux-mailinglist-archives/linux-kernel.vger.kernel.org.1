Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696D41C3BAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgEDNsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 09:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDNr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:47:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794BC061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 06:47:59 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z6so6779281plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Rg9UJJZ2W+/6S6MT1yhRF1ts3Ydv5puORxZkSnYHZRI=;
        b=H+GI6QH7GVmDJt9eR5e3WijVO2f2YgUQwIhVzCHRTk48F9Zye6P94vp8XXB6uvbUFZ
         qb7kz6M0lu8AjoQ0nx42BHznddNfwoCWOvaurhJJ6WbIZTX6RUZaBpeuKaFv6+Qvwqpd
         6BPL4gJqV6q3lrNiUJY1c6ccc46SW8R8FERPrNPiyfQyedEj9QSpDi7VxAxjB9FSTkDF
         H0sx8Qbo8EkV/QZM9xhttl8qeCYARH2Tr5pibQ3Y6MGB9Ew590BRnWO/zzIcAOb2ZS4n
         T/SNCgDp4ZxIszIldbtusRlvPZNOlCqBmsQWwTlLuFYiN04oLaOv+tWLQpHwAuMx4IVF
         k0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rg9UJJZ2W+/6S6MT1yhRF1ts3Ydv5puORxZkSnYHZRI=;
        b=LGQsDNr4aFdsyHXu2T+HbBRxNu+5MWbFq2Rq5rJfSSmiXqFPfq7sZNAcr6fvGENneU
         aGh95F+TO+/fMv2XPPJ2dUILKsLmIvlJClK/WybVYdFimtdFHSHcVulgC1TCuYVZrQsK
         09axzaxkY6aK4BGcZDyCgjIGOlehSJ1kw3aFew42UfndoKg+9l2M8+dngKuFTrcKmyg1
         HEVlTW9eCiRYr8L4erkg/OEav5irn9wYJNFUT+uGH01UVcx81Zvdu9k4x/Z7ULO7h9Bj
         W1HGXaQuJSsQMnQG+iwoeGMPowDPRMO/3CkOLJIGOe3JjkyN2Y5La32ITx+0IhLLZwQo
         Thnw==
X-Gm-Message-State: AGi0PuYtRyL7FHvZWyzP1Y7U5+Uj+nb+OFQiLMY+SAApcnMG2QQrYpbs
        3etAf5MWwGxy9G9vojSIHxZrfazNpmOSiQ==
X-Google-Smtp-Source: APiQypLp6xInEdHrkCM7w6jc80BQxPrij8GCaCtwruE5LFklNlcGU79ZnBD6dQ7m0iXCPMxhm3LB8A==
X-Received: by 2002:a17:90a:8d01:: with SMTP id c1mr17221288pjo.170.1588600078528;
        Mon, 04 May 2020 06:47:58 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r78sm8909979pfr.10.2020.05.04.06.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 06:47:58 -0700 (PDT)
Subject: Re: linux-5.7-rc4/fs/io_uring.c:2786: bad if test ?
To:     David Binderman <dcb314@hotmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <DB7PR08MB3801F4B9DD818545A8DA6CC99CA60@DB7PR08MB3801.eurprd08.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <529ea928-88a6-2cbe-ba8c-72b4c68cc7e8@kernel.dk>
Date:   Mon, 4 May 2020 07:47:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DB7PR08MB3801F4B9DD818545A8DA6CC99CA60@DB7PR08MB3801.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 2:12 AM, David Binderman wrote:
> Hello there,
> 
> linux-5.7-rc4/fs/io_uring.c:2786:6: warning: Identical condition 'force_nonblock', second condition is always false [identicalConditionAfterEarlyExit]
> 
> Source code is
> 
>     if (force_nonblock)
>         return -EAGAIN;
> 
>     poff_in = (sp->off_in == -1) ? NULL : &sp->off_in;
>     poff_out = (sp->off_out == -1) ? NULL : &sp->off_out;
>     ret = do_splice(in, poff_in, out, poff_out, sp->len, flags);
>     if (force_nonblock && ret == -EAGAIN)
>         return -EAGAIN;
> 
> So the second return can never execute. Suggest code rework.

Looks like that's a leftover of the "only punt sometimes" code. That
second one is indeed dead now, Pavel is re-working the async punt
for 5.8 anyway so I don't think it's worth touching at this point.

-- 
Jens Axboe


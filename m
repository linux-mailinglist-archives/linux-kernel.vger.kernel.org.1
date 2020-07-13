Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F7521B773
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 16:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGJOAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJOAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:00:17 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512CC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:00:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q8so6098112iow.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PvFFjq5d2hTh/8bud3isCUm9zau1JSIuUDHz07eccEY=;
        b=pGdMddqxUAmlcCo7ogE0OCAZvDGeFPItZ1LDAQmz8UIaq7nRQ2ktMWmXfsjfMQQCvi
         eh4tmKgY3KMq4jKHpglluCnjKQO0+g34gmBYfOt1LrZCt3xVszxoSx1Il/aPI2ix57Oa
         Vj32TJnOLGYkQyVePcQluxBs5jl+0cFj4KKeXG2N40NxDI3oMrAb/1Djm7F9CN8Oj6i4
         B4yyWVA8Vwpc6MuGuodL4plOShU8gmPNyqvFo/7wYRoyywlPdXaPWKNvEkn8oGFpB52R
         +izO7i1tBYFgAAe5OCDArRCD35lIvi8XDmP/4p2N1WSubo3rgy3+Wj9K+8oTMSgQmPBz
         2Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PvFFjq5d2hTh/8bud3isCUm9zau1JSIuUDHz07eccEY=;
        b=UYcyXZxRYBUCl5f+vZLDelemCjaq6cXaURDee60jGOdsDTLm9ct5CWBb3++pb2lTpw
         n5merV75w1bBaoHzIoJPDE2so64RURYkPhFs++ofvvk4iqDPKGG6LtII0PghjuVTIj5B
         mMNJlO5gyo+zSZ4mcC7vmAN52F405qPXFcAvmCP9lCz9ekWRKx93LQeCz77goyHPrdHj
         x3tJVdfFzdR+8J1U63f+HeWHa1E5lk0BT50qkbE2lrnI2A4qtpxDKraJBaWJcKlEpt3u
         DsOm8HchhSdO/a+YjsBqqU6S0IZmD5/bbQ2hV9Vnm1T0Oxr5itftws2cl19zzYgpPTeM
         EDUw==
X-Gm-Message-State: AOAM532X25v5hF5pKeC2uqYqkLgknrxEMAHg9HGM8cqq5kKLN3PDwxYV
        QTvHQgsJViAprjsJ+xCOJCnDcY42yQ8/Eg==
X-Google-Smtp-Source: ABdhPJw2NckfkJzMQc16hE0YTUMLHE0WQtJPPNmrEX8HPgeJ6vFTo3Z869Z78VJq7eAbTVrxys316w==
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr47749067ios.42.1594389616361;
        Fri, 10 Jul 2020 07:00:16 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w15sm3650008ila.65.2020.07.10.07.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:00:15 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Remove unnecessary validation before calling
 blk_mq_sched_completed_request()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <969d0e9f637b2a0dbfb3d284abfbed6fc7665ea4.1593846855.git.baolin.wang7@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eddd681b-6a80-486d-3655-e8810ba7b118@kernel.dk>
Date:   Fri, 10 Jul 2020 08:00:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <969d0e9f637b2a0dbfb3d284abfbed6fc7665ea4.1593846855.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/20 1:28 AM, Baolin Wang wrote:
> We've already validated the 'q->elevator' before calling ->ops.completed_request()
> in blk_mq_sched_completed_request(), thus no need to validate rq->internal_tag again,
> and remove it.

Applied, but I reformatted and edited your commit message.

-- 
Jens Axboe


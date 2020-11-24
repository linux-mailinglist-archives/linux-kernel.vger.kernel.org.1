Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD862C24E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgKXLpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732792AbgKXLpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:45:06 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48936C0613D6;
        Tue, 24 Nov 2020 03:45:04 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y10so6169148ljc.7;
        Tue, 24 Nov 2020 03:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lEZOg2+Pg+PWUdy2vuWhDST9DUP8pdhSxb8BJWFY9tE=;
        b=vOYyA/g9dkI4GqaR/Nzl5Toy2WtgFbuZt895POW6raPpyIeuezBIf0CpzqpKxvRtV6
         lK0UKkjbhwFrq1k/4oUdllgdW0Jt531xFbcbWPFR551BhP/1O8BpumRwUbf6K1z5AoRm
         PHAK1Gi28g7ms6y+8kLCuevenERfhEVx6HlXGWoH8t56EMgbSiPhx6B8QZAXciYn5LXT
         OQ/RrX2/DI4xdLDSy7d9N1ZpFQrc82o6Ho0uUIFW+zEDFVq1jt1QlQy/emYO2DY+UurR
         xbyXqbNUzUSRXKbUgzTCax+iQIURzo7j68eSZWnMpzZe+pD0Pami+RmIq41wCi+03ZYy
         g8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lEZOg2+Pg+PWUdy2vuWhDST9DUP8pdhSxb8BJWFY9tE=;
        b=bCB80pmY3s8WGba3HFuGO3wo2T+kUFo8dDmcX1tGuVeQQBhjiQxnuEmYB734CTQNJI
         DpMmnrAnfSP/L4D9a2qwy+Kmqe+lGc5txGXS35R1rhNYNfavaSfQTpNCjiGo7rMOukXF
         X2obcSXGddlLdRtXCAihZbW68BxtWafieX5Q3kIBFZ5DKbgJXtGFb9ZZ8Impd59ZbGuA
         ey12Pz9r+hH6lyk94/xLmvDAEiYoNWPev1OcAWd+PCoCUWGeeStmu9amZhy6xzTRAAOP
         x3Xnw9ily8crVeh/2Wjk6tnzc2jmIwwl+VWgvLX3YqW8YEQD8k00RmOeQMKZVz4xcN7q
         ZKLA==
X-Gm-Message-State: AOAM533+EjZ0XVrAs8ShBruFKrFDCW2lvhFmU//t5A0vpi/OFY0MMRyQ
        e2A6mLcUhbLwYHC9Cc7sjMw=
X-Google-Smtp-Source: ABdhPJyt2qxVoOO+tTtlJp1TOkO9FcEk2yiuWPPlEX8dqIesxpSd7BbAyc596g4eq07ogrDnKa6onQ==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr1769040lja.294.1606218302727;
        Tue, 24 Nov 2020 03:45:02 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:44aa:1e8:bf33:c8db:a3e2:c358? ([2a00:1fa0:44aa:1e8:bf33:c8db:a3e2:c358])
        by smtp.gmail.com with ESMTPSA id k28sm983027lfj.48.2020.11.24.03.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 03:45:02 -0800 (PST)
Subject: Re: [PATCH v3] usb: musb: remove unused variable 'devctl'
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
To:     min.guo@mediatek.com, Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201124084955.30270-1-min.guo@mediatek.com>
 <c2f3f643-8514-5c4a-dd52-7abc8a6dc501@gmail.com>
Message-ID: <df11df93-f2ab-157c-22ea-cb8b8a0d9969@gmail.com>
Date:   Tue, 24 Nov 2020 14:45:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <c2f3f643-8514-5c4a-dd52-7abc8a6dc501@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 12:13 PM, Sergei Shtylyov wrote:

[...]
>> From: Min Guo <min.guo@mediatek.com>
>>
>> Remove unused 'devctl' variable to fix compile warnings:
>>
>>      drivers/usb/musb/musbhsdma.c: In function 'dma_controller_irq':
>>      drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set
>>      but not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: Min Guo <min.guo@mediatek.com>
>> ---
>> changes in v3
>> suggested by Greg Kroah-Hartman:
>> Add a comment.
>>
>> changes in v2
>> suggested by Alan Stern:
>> Add void before musb_read to indicate that the register MUSB_DEVCTL
>> was intended to be read and discarded.
>> ---
>>   drivers/usb/musb/musbhsdma.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
>> index 0aacfc8be5a1..2a345b4ad015 100644
>> --- a/drivers/usb/musb/musbhsdma.c
>> +++ b/drivers/usb/musb/musbhsdma.c
> [...]
>> @@ -336,7 +334,11 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
>>                           < musb_channel->len) ?
>>                       "=> reconfig 0" : "=> complete");
>>   -                devctl = musb_readb(mbase, MUSB_DEVCTL);
>> +                /*
>> +                 * Some hardware may need to read the
>> +                 * MUSB_DEVCTL register once to take effect.
>> +                 */
>> +                (void)musb_readb(mbase, MUSB_DEVCTL);
> 
>    Hm, forcibly reading DevCtl in the DMA driver... sounds quite nonsensically. Lemme take a look...

   Indeed, prior to commit c418fd6c01fbc5516a2cd1eaf1df1ec86869028a ("usb: gadget: musb: fix short
isoc packets with inventra dma") the DevCtl read was done in order to check the DevCtl.HostMode bit --
this test was removed but the DevCtl read was left intact... so my vote goes for deleting both the
read and the variable...

> [...]

MBR, Sergei

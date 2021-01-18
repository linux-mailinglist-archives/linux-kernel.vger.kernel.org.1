Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E272FA60E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406612AbhARQZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:25:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406606AbhARQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610986963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PuP4GmU689heinkRuXzHyTbQ9W6oqYfuZZclfdleiIA=;
        b=EBBoMphhHafEM8OHezIGf7numldm4sCY8zaBIuUIXQgWcA78cl3lua3qCduQM2zUYoVmTC
        UVIt37ra5N4UqJRV9XVbR/R2T0iqXx+eG3WG/ra6m48fv5PDKSbbJSwhl7sKqjXgnJcZJs
        jUPWcOQv0DMVxM8/PPHaRZLzmfTL9Gc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-jCrJR_z2M2ibS5Nfdgbb2A-1; Mon, 18 Jan 2021 11:22:41 -0500
X-MC-Unique: jCrJR_z2M2ibS5Nfdgbb2A-1
Received: by mail-qk1-f200.google.com with SMTP id a17so17467193qko.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 08:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PuP4GmU689heinkRuXzHyTbQ9W6oqYfuZZclfdleiIA=;
        b=Qqr34+G/+vGoNG6xaHGfjg4uLhUEiDxJjZT8zU2lU1SnS63GCvGQymAwiNr07TtVCk
         Nev0mP+WM1Mi1dwz1vs3Wvo1f2rr7D5wUDz6sfu2dqEYNaAwkyJQO9wXqevskItil49h
         wJgxEn6c8ADDDK9No1UBo1mpX4CrTyA2pPzt74fHct6MkAexRYHChQDDuHc2tNvpm9tU
         QNWJm/lcV0HLqv5u24GOuMkJIs8IfsV3GmDoB1/kSNQBPpjvXEXbYf8wfAt7CeZ1hm8Y
         awSEYs3EYw31VcRwFAT4jSOanogxdqXsQ8BvOqNsltilZgUYIVGbvZl2efLL9bPXDH5r
         sBRQ==
X-Gm-Message-State: AOAM530eDV2Q+nwccK6r87JqpCRCKsRZzlbPjlvh6dt1ArrEYr3K5wqu
        ihtI+vuZOYd2+mAYEgDEB3fdcP902hWrCHAIV7Y18qTD7kBT+L+1BH7tKWJjpm6u5GEw6btWYI4
        yAJpXilCZ60U0NnFEW5T3puIs
X-Received: by 2002:ac8:5a0d:: with SMTP id n13mr371873qta.172.1610986960951;
        Mon, 18 Jan 2021 08:22:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAqerGsIGV/3/+5J5Qt/R2pGfGPrhlXqFBmwz0tQ1ty8YBxhzJ0iJFbF0jYJXguMv5Xg+Ffw==
X-Received: by 2002:ac8:5a0d:: with SMTP id n13mr371855qta.172.1610986960739;
        Mon, 18 Jan 2021 08:22:40 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r190sm11211164qka.54.2021.01.18.08.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 08:22:40 -0800 (PST)
Subject: Re: [PATCH] clocksource: mxs_timer: add missing semicolon when DEBUG
 is defined
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210118134926.613931-1-trix@redhat.com>
 <830aea92-5ae4-6b04-80c5-349a45feabf9@linaro.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <42e74960-374a-5ae3-bf15-b68a9d1aab10@redhat.com>
Date:   Mon, 18 Jan 2021 08:22:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <830aea92-5ae4-6b04-80c5-349a45feabf9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/18/21 7:15 AM, Daniel Lezcano wrote:
> On 18/01/2021 14:49, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> When DEBUG is defined this error occurs
>>
>> drivers/clocksource/mxs_timer.c:138:1: error:
>>   expected ‘;’ before ‘}’ token
>>
>> The preceding statement needs a semicolon.
>>
>> Fixes: eb8703e2ef7c ("clockevents/drivers/mxs: Migrate to new 'set-state' interface")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/clocksource/mxs_timer.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
>> index bc96a4cbf26c..55aa6b72d075 100644
>> --- a/drivers/clocksource/mxs_timer.c
>> +++ b/drivers/clocksource/mxs_timer.c
>> @@ -133,7 +133,7 @@ static void mxs_irq_clear(char *state)
>>  	timrot_irq_acknowledge();
>>  
>>  #ifdef DEBUG
>> -	pr_info("%s: changing mode to %s\n", __func__, state)
>> +	pr_info("%s: changing mode to %s\n", __func__, state);
>>  #endif /* DEBUG */
> Mind to replace by pr_debug and remove the #ifdef ?
ok.
>
>>  }
>>  
>>
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97F82C7A41
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 18:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgK2RaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 12:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727902AbgK2RaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 12:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606670916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqPnwUYra61gpzARl2AFw49uis8H9NnqHQTo1GLvGnE=;
        b=hc1HlVWt2q/Djqcw3400ri7YFcTaGIA6R1DMBNCNmpiyXKZbI/2VRv/CtFKbecFKRq3K09
        pSoqT7acVCbOQoPbsJihrTbx2VDzm7DcN5hFFaLNYfbnHO16obG5ZvhoshexdV+DC7881H
        h0woSR8u3okvGJb0u4bzFlnVCxxGRV0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-GC09ZmsOPNCeXcllLIRu2A-1; Sun, 29 Nov 2020 12:28:34 -0500
X-MC-Unique: GC09ZmsOPNCeXcllLIRu2A-1
Received: by mail-qk1-f198.google.com with SMTP id 141so7815874qkh.18
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 09:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tqPnwUYra61gpzARl2AFw49uis8H9NnqHQTo1GLvGnE=;
        b=ZhlVVgysS5Lh6dFzKRpdD8gJgJ6rijNJyzqE5H66+znktcf1k/EWylWJ65lW2M8vw5
         ouhlh/il+AoTecND3pyWjQN931ecZLugSWt8LlDWQTo0bvDTN0dQdRnpwwnAHkw2PCOT
         pjFq8YD87czzG8Q8mZRgPoVJeEynwSofaH9pw4aKZz5BKTnEt7KCnSxN9I5KTpKB1IBZ
         QAFa2SKdz2CJvsDmiTz+2Z7ilO9MZiTIEWypG0MDQl2RzMB5L+jzd6eX36DvnBoV607d
         pEJ/pekKHzT8kGm9HDFOhr+Lpqu3JH7aGQLnPXzJaAD2/9DzspwHh1qO7t3Dd1U9Vaam
         gfvg==
X-Gm-Message-State: AOAM533DnGPUtoN6MDjE4BDWgORB+7fRaBBHDxMIo5+wGukGwS2+hGuL
        u2ZjL08NUG9sQRPZvXtz8Ify4tW9z3U7dHYXmlGxLmXCGbwWgnVyYFxODNySXtY/+CZDJXH0ixb
        WRZEBijAjlwMVtEOfHU5ijlrXaXAHxrL7mF1q1RFo8qKXO0FxoWSCptLZxCzogBHuVsZYhNg=
X-Received: by 2002:ac8:4a81:: with SMTP id l1mr18160341qtq.339.1606670913590;
        Sun, 29 Nov 2020 09:28:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyv2HIz1VpM7CgtfJ/AZEnwrRYUL312dmdvF3YmM3OaFSePNWuey5uRslbqcmJM1eaMIBRayg==
X-Received: by 2002:ac8:4a81:: with SMTP id l1mr18160310qtq.339.1606670913289;
        Sun, 29 Nov 2020 09:28:33 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y24sm11993386qtv.76.2020.11.29.09.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 09:28:32 -0800 (PST)
Subject: Re: [PATCH] bpf: remove trailing semicolon in macro definition
To:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201127192734.2865832-1-trix@redhat.com>
 <d7168ec4-040c-851d-f294-709315d13a2f@iogearbox.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4e9c057d-6aa9-e8d1-f84c-1112c509bb52@redhat.com>
Date:   Sun, 29 Nov 2020 09:28:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d7168ec4-040c-851d-f294-709315d13a2f@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/20 4:54 PM, Daniel Borkmann wrote:
> On 11/27/20 8:27 PM, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> The macro use will already have a semicolon.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   include/trace/events/xdp.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
>> index cd24e8a59529..65ffedf8386f 100644
>> --- a/include/trace/events/xdp.h
>> +++ b/include/trace/events/xdp.h
>> @@ -146,13 +146,13 @@ DEFINE_EVENT(xdp_redirect_template, xdp_redirect_err,
>>   );
>>     #define _trace_xdp_redirect(dev, xdp, to)        \
>> -     trace_xdp_redirect(dev, xdp, NULL, 0, NULL, to);
>> +     trace_xdp_redirect(dev, xdp, NULL, 0, NULL, to)
>>     #define _trace_xdp_redirect_err(dev, xdp, to, err)    \
>>        trace_xdp_redirect_err(dev, xdp, NULL, err, NULL, to);
>>     #define _trace_xdp_redirect_map(dev, xdp, to, map, index)        \
>> -     trace_xdp_redirect(dev, xdp, to, 0, map, index);
>> +     trace_xdp_redirect(dev, xdp, to, 0, map, index)
>>     #define _trace_xdp_redirect_map_err(dev, xdp, to, map, index, err)    \
>>        trace_xdp_redirect_err(dev, xdp, to, err, map, index);
>>
>
> This looks random, why those but not other locations ?

Those other macros were never used.

Tom

>
> Thanks,
> Daniel
>


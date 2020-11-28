Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC11D2C7100
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbgK1VvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730237AbgK1Sih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606588630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHNQGQwYTjMfSeue4qgVHv6eIO5mWnflrkHSXDK1TeI=;
        b=jI5xOwsjIf5vbTyC/QvkRc2Lx07qEmymLlupeATfZc3xKF23QK/+vGS8wBaQ9M1c9nb6rW
        Hjc88ev0aPvO+Ho42NTyMNdTMqwPcl4CSRUzEKEDlMy5wSop3zPlDaZTWKHuwH7Vvd1JCv
        cP2vcC3GKy9+lWbAwjERJSfjL31iycE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-PVPalPGnOqOCfFvEZnnwVA-1; Sat, 28 Nov 2020 10:36:21 -0500
X-MC-Unique: PVPalPGnOqOCfFvEZnnwVA-1
Received: by mail-qv1-f69.google.com with SMTP id i11so4889299qvo.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 07:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tHNQGQwYTjMfSeue4qgVHv6eIO5mWnflrkHSXDK1TeI=;
        b=bX+s+sSbSg5LEEC4I2Q1tcoidBK9oF6+zTJixNlSr5yDT1y2YXlTRy5F4oG1AjVcw5
         64qYo6oB4pBliBmJRRfHi3LWTImeHgKifW5E6H11kz4C95MvIZBv1S+bf4HNCmQjYYmS
         lSAHDpX7wjqiBZo4pxcBanXeOg5ILhJFz75/zdo8tp6IGrOqMH56w2hjT3jcRq45QpVi
         NvkQfWY7iuahh+TyNGHqGA+hhkp9Ewxq/7iVR3R0M60vqH2mnxyflRNDwYOaV7epNcFF
         0A8eXzoiS2CCPWjZrGebsPxl0K6onIQ0/XIfRhTfF3toPCDPY3xR1Fe0mOLRT4jmZ5Hu
         jpSw==
X-Gm-Message-State: AOAM5314j4Z1yvixunIDrBKBCJVEhyt3sgbHiLZKg2eD//cnY+IvdXhO
        QLqj2Qg+CUD/D1pGSD1SRxEDjmeLQw9cSHMPBFG04eVcv1akClK2OVwYqLyg3Aadrx5VHWF1h8h
        r8VW4ZygubzpmPIp8EvMD/D8IfMPywF9GeqpG7LQ8Uz0GPpVqRl3LgcHJJm9GmqeR+k/8DIo=
X-Received: by 2002:ac8:5653:: with SMTP id 19mr13889254qtt.136.1606577780234;
        Sat, 28 Nov 2020 07:36:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeLj+ft0hyIu5tY+9IGU8mX5chSiE3HfiAHFqd3zePgTYRdxtLobWfv1YhFFOq9Ab/bUpgGA==
X-Received: by 2002:ac8:5653:: with SMTP id 19mr13889230qtt.136.1606577779926;
        Sat, 28 Nov 2020 07:36:19 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l28sm8681546qkl.7.2020.11.28.07.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 07:36:19 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS add D: tag for subsystem commit prefix
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20201127214316.3045640-1-trix@redhat.com>
 <a4e796f8c0bfdb2c0a2816fa706d13cc0ae06d40.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f96ff56c-7c39-2fed-dd8b-11971f8965bf@redhat.com>
Date:   Sat, 28 Nov 2020 07:36:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a4e796f8c0bfdb2c0a2816fa706d13cc0ae06d40.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/20 2:10 PM, Joe Perches wrote:
> On Fri, 2020-11-27 at 13:43 -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> From
>> RFC MAINTAINERS tag for cleanup robot
>> https://lkml.org/lkml/2020/11/21/190
> I think this should be RFC.
> It looks as as if it's only for subsystems through A

Yes only A, i wanted to show the direction in a subset.

>
>> The prefix used by subsystems in their commit log is arbitrary.
>> To elimitate the time and effort to manually find a reasonable
>> prefix, store the preferred prefix in the MAINTAINERS file.
>>
>> Populate with reasonable prefixes using this algorithm.
>> What did the maintainers use in their commits?
>> If there were no maintainers commits then what did everyone
>> else use in their commits.
> The algorithm used to produce these prefixes should also be published.
Ok.
>> The results were manually reviewed and about 25% were rejected.
> Because this isn't necessarily the best option.
>
> I think an exception mechanism would be better than a specific
> mechanism added to various entries.
Can you give an example of what you mean ?
>>  # check MAINTAINERS entries for the right ordering too
>> -			my $preferred_order = 'MRLSWQBCPTFXNK';
>> +			my $preferred_order = 'MRLSWQBCPTFXNKD';
>>  			if ($rawline =~ /^\+[A-Z]:/ &&
>>  			    $prevrawline =~ /^[\+ ][A-Z]:/) {
>>  				$rawline =~ /^\+([A-Z]):\s*(.*)/;
> I'd prefer to keep the file and keyword list last.
>
So change to

my $preferred_order = 'MRLSWQBCPTDFXNK'; 

?

>
>


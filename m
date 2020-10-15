Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97FE28F7E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbgJOR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731485AbgJOR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:56:15 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6CC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:56:15 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d28so29311ote.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WhXHtRQLiNvlxA4Ve4EGkL4Yj2RyR9bAfejYfV8NKoY=;
        b=LkXC4WB06ByVlUKUgEg92KmVPC9c/Lr6VceWMRdBnVynCIMxm/QJN29fJtLeyA/8JM
         V71tbZYSR6gKPlYBmn96I5oGiLRE498NemTt/nGrhS2UvwC4DS6/oYde3SmHYGtWCpLA
         I2nlg/XJzRzSEZoydxkttpkCLyNWZNPnp2l18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WhXHtRQLiNvlxA4Ve4EGkL4Yj2RyR9bAfejYfV8NKoY=;
        b=k9fT1GWS5FijSm1MRLe7TPZMCbNo986pqLf8QRC5KnkPlIgtxiv1cBb3wH8u/VsoQe
         nvY2+pn8sxbOR+uwg9fCrsJ2+wwKZ/+DzlSpo5Wq2hNWiZICQA04kYtVV7zNbkf02IXE
         QXKGg3uWXCqtbqN46iTZ+P9LXtr9MTGNRQpoKnHfWcsJJ19LwD9U0QlLeurbgDm9J0Dh
         tHPmagvtnrBsQdbvSUdGVKBOT8dIWa9XblICwTJZMuVCDix1scg7+Haba/9gfGx2UlSt
         5Gb+UOnV1wxKdZ5s2SN6SqX1Cq3dKG7sJ2e9gwQAqeuciPSa1U7IEbGAkdaz2ZKKvm4+
         JMmg==
X-Gm-Message-State: AOAM530l7kEcyJmqWz50pLjwj9cUBiEJ2/PoxI/Nbu3MZVjtYdlQp5BY
        Ys9S2iDW4iuQwKGkRgNskdG//A==
X-Google-Smtp-Source: ABdhPJyWCGNwF/h+GQeALThlCZpGDJ2foEce5mnVm3bpnpgPTrjTgZU3WdDaCcvNyLQuFvVtVHFKlg==
X-Received: by 2002:a9d:7308:: with SMTP id e8mr3653483otk.238.1602784574333;
        Thu, 15 Oct 2020 10:56:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n1sm1394096otr.16.2020.10.15.10.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 10:56:13 -0700 (PDT)
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 kunit-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Patricia Alfonso <trishalfonso@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201012195649.2047671f@canb.auug.org.au>
 <20201015163806.1c5696bb@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <05a34f8f-075f-87b0-e13f-898399f480ac@linuxfoundation.org>
Date:   Thu, 15 Oct 2020 11:56:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015163806.1c5696bb@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 11:38 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 12 Oct 2020 19:56:49 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the akpm-current tree got a conflict in:
>>
>>    lib/kunit/test.c
>>
>> between commit:
>>
>>    45dcbb6f5ef7 ("kunit: test: add test plan to KUnit TAP format")
>>
>> from the kunit-next tree and commit:
>>
>>    e685acc91080 ("KUnit: KASAN Integration")
>>
>> from the akpm-current tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> diff --cc lib/kunit/test.c
>> index de07876b6601,dcc35fd30d95..000000000000
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@@ -15,11 -16,16 +16,6 @@@
>>    #include "string-stream.h"
>>    #include "try-catch-impl.h"
>>    
>> - static void kunit_set_failure(struct kunit *test)
>>   -static void kunit_print_tap_version(void)
>> --{
>> - 	WRITE_ONCE(test->success, false);
>>   -	static bool kunit_has_printed_tap_version;
>>   -
>>   -	if (!kunit_has_printed_tap_version) {
>>   -		pr_info("TAP version 14\n");
>>   -		kunit_has_printed_tap_version = true;
>>   -	}
>> --}
>> --
>>    /*
>>     * Append formatted message to log, size of which is limited to
>>     * KUNIT_LOG_SIZE bytes (including null terminating byte).
> 
> This is now a conflict between the kunit-next tree and Linus' tree.
> 

Thanks Stephen. I will mention this conflict in my pull request to
Linus.

Thanks,
-- Shuah

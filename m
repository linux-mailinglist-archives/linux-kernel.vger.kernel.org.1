Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D072996DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793125AbgJZTb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:31:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43361 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784783AbgJZTb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:31:57 -0400
Received: by mail-io1-f66.google.com with SMTP id h21so11419453iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mOk5XUEuchPEMU5r7mFZgJBEBGvQ35xr1MEWrB7Ojk0=;
        b=gypib57D2xJe9o/RDSKiXXI9ePiUvyB58fIXstW8rnCPwj0szv731X5HsVxnkuhr9y
         V37Yk+blnOJesZethVFog9u+FsxMKOZld1Va0u2xNxvbLL99ng5+DnsphHYt78WAPBd7
         MqK0h9kT0rWMJ+6Bdg8/yM45VyfcKHyOiY7+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOk5XUEuchPEMU5r7mFZgJBEBGvQ35xr1MEWrB7Ojk0=;
        b=BOgQmEqlQdzztPLh+FeOVLqR3EF1hYmX57OnLGUyl6yhJ3cJEd8/K5NLzN3xcYwURX
         yQ8YSIReGIoiZMyOEf54hYnH4Nqwf/TLfHxTJ3UT7QDQeh3FjnxwZ0ioJDSLjoTZ2sul
         M4WkRGB9eFkiHhs3NwcRNhZmW9seTLGaAUqyNwNWSFuEi0TXu1faVJU+T+omrp03usGq
         adNu8LHeoRLDuyPq2RWxjXZnUY0Gl3FMw68lao/HimYaq6/+zjrgUqjtxIBJJicjyXNE
         Fjdp8pVAro3ge83f59KkSZ7Xf4azepBNkjP4GAFY2zjcK61k9WKFfEfeBIimCm2gqr6E
         h6YQ==
X-Gm-Message-State: AOAM532AsIPuRiy0AD43mSDW5f6UXaH3k06EJgxvkRJNzBqaSbu+ei5J
        KBLi3FQnePhoE5dQB5ZGnFhxtQ==
X-Google-Smtp-Source: ABdhPJyBDNdSHXxIVJ7vNq1XMkOY66Fk5QesPkw0wWus2ohanYGpi8QEDsuZu83kFo7iymAK4awFPw==
X-Received: by 2002:a6b:f610:: with SMTP id n16mr11780704ioh.103.1603740716696;
        Mon, 26 Oct 2020 12:31:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w11sm5933501iop.14.2020.10.26.12.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 12:31:56 -0700 (PDT)
Subject: Re: [PATCH] kunit: Fix kunit.py --raw_output option
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201022030455.1871987-1-davidgow@google.com>
 <CAFd5g46D69b1GgGhL4jvCLUCDG3NDja2ZDXYxx2a1Rv=DQtEmA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c6a0f45d-1416-6953-b4eb-26c2a0cfed7c@linuxfoundation.org>
Date:   Mon, 26 Oct 2020 13:31:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46D69b1GgGhL4jvCLUCDG3NDja2ZDXYxx2a1Rv=DQtEmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/20 10:11 PM, Brendan Higgins wrote:
> On Wed, Oct 21, 2020 at 8:05 PM David Gow <davidgow@google.com> wrote:
>>
>> Due to the raw_output() function on kunit_parser.py actually being a
>> generator, it only runs if something reads the lines it returns. Since
>> we no-longer do that (parsing doesn't actually happen if raw_output is
>> enabled), it was not printing anything.
>>
>> Fixes:  45ba7a893ad89114e773b3dc32f6431354c465d6 ("kunit: kunit_tool: Separate out config/build/exec/parse")

You need just the SHA1 45ba7a893ad8

Fixed this up and applied to linux-kselftest kunit-fixes branch


>> Signed-off-by: David Gow <davidgow@google.com>
> 
> Thanks for fixing this!
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> 

thanks,
-- Shuah

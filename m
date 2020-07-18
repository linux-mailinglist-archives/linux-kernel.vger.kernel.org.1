Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68A224B47
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGRNFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 09:05:45 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:40590 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgGRNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:05:45 -0400
Received: by mail-ej1-f44.google.com with SMTP id o18so13658317eje.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 06:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RQQRaX3pXuawLT/zNRNMYLJFYUSdiLn+MtY3ctdSgCU=;
        b=iFam5tTwb7aipf769OYBOlC5FeLnGA62p7uDkSngUrTPklEffKoo2TZfoYZgU2YjE/
         a7RFMR9ePUvMii2deL43Lf3+Vzd4ZOxEYkbVLRouFMmZALE6uq+S1SvFkVwROCeRBW47
         sSO/1rPWijkgQoRihIOMCTNZehyqeQb87Pc/0l6E2+4EVMDUDi6V3gcHyRTbytzFf6AK
         EpOMZ7FnFyFp+2WTR/QGT+wbybD3vT36iAmjIeYCCu/7gZFnILOJeX78OVT35K9/iPgi
         G0Z8EPe3mkqk2TcJRctVyAGUiYx7cL9gvN0KxzJRmWK0qKIYxnc+EpCncgLIpSmZUrW+
         5sug==
X-Gm-Message-State: AOAM531rxM2BWwZLwF4c427KGCf/j9ufDNEZ/NzVXGg6yYwuvb2cPgff
        enwdFcaayLyWV71oj+5XlaiUkPe5
X-Google-Smtp-Source: ABdhPJxTy3+cb3JhadCFh36x5rXKTol8/nmnp1fvc0kg+N1AFhbxAm79I/UAdlps5R2M//F/e7JObw==
X-Received: by 2002:a17:906:33ca:: with SMTP id w10mr13432397eja.171.1595077542689;
        Sat, 18 Jul 2020 06:05:42 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id u19sm11326872edd.62.2020.07.18.06.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 06:05:41 -0700 (PDT)
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, christian@brauner.io,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717111203.f32s7r5vdvdn535u@wittgenstein>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <b923c34f-5765-756b-fdeb-f756a278b6a6@kernel.org>
Date:   Sat, 18 Jul 2020 15:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717111203.f32s7r5vdvdn535u@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 07. 20, 13:12, Christian Brauner wrote:
> On Fri, Jul 17, 2020 at 01:04:38PM +0200, Jiri Slaby wrote:
>> On 17. 07. 20, 12:45, Jiri Slaby wrote:
>>> Hi,
>>>
>>> the strace testsuite triggers this on 5.8-rc4 and -rc5 both on x86_64
>>> and i586:
>>
>> make check needs -jsomething, running is sequentially (-j1) doesn't
>> trigger it. After the error, I cannot run anything. Like ps to find out
>> what test caused the crash...
>>
>> 5.7 was fine.
> 
> Can you try and reproduce with
> 
> commit e91b48162332480f5840902268108bb7fb7a44c7
> Author: Oleg Nesterov <oleg@redhat.com>
> Date:   Tue Jun 30 17:32:54 2020 +0200
> 
>     task_work: teach task_work_add() to do signal_wake_up()
> 
> reverted, please?

I reverted these 3:
+This reverts commit b7db41c9e03b5189bc94993bd50e4506ac9e34c1.
+This reverts commit ce593a6c480a22acba08795be313c0c6d49dd35d.
+This reverts commit e91b48162332480f5840902268108bb7fb7a44c7.

But it still crashes.

thanks,
-- 
js

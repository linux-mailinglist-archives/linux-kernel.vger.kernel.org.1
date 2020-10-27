Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F345429C8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829850AbgJ0TWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:22:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34783 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829833AbgJ0TWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:22:12 -0400
Received: by mail-io1-f66.google.com with SMTP id z5so2810052iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SDggL/5DGppgpieLJVWQafcXCbils7Ckn7/0JVsVkp8=;
        b=hq73Yj7bsWrlpqS4zs3IDf58m4nMCTD6doLz0JGlSfgxyF7Puc+zM1d1wMWu8HQHTx
         mmImVhjtvzGvy37q/sWI2LKm29gnqscERtLZwDS3P9SJ5etZhzs99yrZzd/dalvTen//
         asOUMGi5Ya6HQN/yVqdF6MnBbbK1mNGhYiFpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDggL/5DGppgpieLJVWQafcXCbils7Ckn7/0JVsVkp8=;
        b=idkORwrpfkTA9YOcaBHNGoQBCo/w491VKRlX+3lNwb5u3ZqA5rn466dO1hibnTB5BU
         q7W7Az+cTkJ8Y7i51VzHzp/1ddttfHySQVWavtROuqc2jIBe8Zf0tQ1CFLlVl4PxmC5f
         A08gmk/P9GoFaQ1oNZw5xcppmPPXT56kBsd1i+Yhw/Vb0CuGyYysJv1ArICSOVeiazeV
         qfr8QAG2idq7lMkpgs9SIJxI29D0VGfS2TGCtW1Jidh3qLD+HWU5XdaBj/fx4hi4vUbh
         NQDSLB5F73bo5F3DWZUjDGtmmta6EzvZxcvI/KZ2QtTofWf7PX9hRjuTuLJEVwD+AF5t
         2eSg==
X-Gm-Message-State: AOAM532iKc1S/us0xH3qZQ/cfDDn9k1GlxmbFMZiovRGsQq84O2aXusl
        C0z6dWL4YbrQ9i/jl7yDYf1Uvg==
X-Google-Smtp-Source: ABdhPJy3Se8JR1mhvlIQqlPkinjv5GVdR5/x5K8dVxtchLUsqjjVVLeH7afe4vJvCHX58nwDXoAxDg==
X-Received: by 2002:a02:a518:: with SMTP id e24mr3984656jam.131.1603826529853;
        Tue, 27 Oct 2020 12:22:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z87sm1510362ilf.9.2020.10.27.12.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:22:08 -0700 (PDT)
Subject: Re: [PATCH][V2] selftests/ftrace: check for do_sys_openat2 in
 user-memory test
To:     Steven Rostedt <rostedt@goodmis.org>,
        Colin King <colin.king@canonical.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201002132501.88992-1-colin.king@canonical.com>
 <20201008164807.62582e8c@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ec3bf828-f5f3-85cb-061c-348fb66ddee8@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 13:22:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008164807.62582e8c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 2:48 PM, Steven Rostedt wrote:
> On Fri,  2 Oct 2020 14:25:01 +0100
> Colin King <colin.king@canonical.com> wrote:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> More recent libc implementations are now using openat/openat2 system
>> calls so also add do_sys_openat2 to the tracing so that the test
>> passes on these systems because do_sys_open may not be called.
>>
>> Thanks to Masami Hiramatsu for the help on getting this fix to work
>> correctly.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Care to take this through your tree?
> 

Yes - Will include in my next fixes pull request.

thanks,
-- Shuah

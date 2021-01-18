Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C32F9812
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 04:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbhARDKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 22:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbhARDKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:10:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 19:09:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w1so8388640pjc.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 19:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y7fVUHJpnbiVdDH0WkhU1b1wymkei/DPXiWGa0ITBTE=;
        b=r6JyUrIQNeHV5o/KTBM5N19gF1uNyoUaCfIspIYK2RDXngjTk+vi7iUtpEWUFyfPmo
         vZeB4j6NxZsS36VTFjwM1teAazyaEfL60a22OHxZ9BSrzizOJWk8nxQN10qJ8DyZjpz/
         kkfeCzlu+zv8yCnNdVf9Z5ADMUTtd70+Jh3+mjeefqcJXZUdb5KItrp47Ym8/UpWxEdi
         +Pon+K6K5XRgi3qixt9RDUzzVD40BJeep9mtzKa+owlCD0bRm8YUAskEe2GVdXKCk8fJ
         +owi7Q4203+OaOcGTcqMwR0Jve2csxv90KXIRIuF595nQLoJSAi6OURWw3Kdcz8Glsho
         G2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y7fVUHJpnbiVdDH0WkhU1b1wymkei/DPXiWGa0ITBTE=;
        b=EFvPmy3jljP7qFnSn53H1zhtAgfkBmx9X7x2Fbd2g4+C9Gqoqn7T8y50688SCXtlKF
         dFIkpm2Tu0kKHd33VBRHi9rIog+XfpU/PMVqUwbyTm1nJ+X6qpAtNPgQh3V26bxlPIWr
         CDRu8dqYGyq1YHFyWvY+SQ94o1Xgw6fTyYuZD0V+/hOMOHrlTv8di2XrPhnLrVAQaBll
         IDHHlvnZ9/REGbZ2z/YjjpWdt1dTziPYMi9+0dNidH7sPkhXrQFWdfUlAdWNGesEnsNB
         /MsYEmLksiSBRACpjKjiNbjAJTJJMfTSkhfU+8FVJHF3Q/ZfCiU04TY1dzrKdpZ6tOdM
         OmFQ==
X-Gm-Message-State: AOAM533oi3jOMNvyMkQ45ZVcTQV7NeAJF07emXpIInEnk3gteW+ErQvO
        9jjTo1yMuYEm5J2nE6IFZEQ=
X-Google-Smtp-Source: ABdhPJyn+h+lOgNKwYk+RTChRWeEBeEGyyiRCdutVdXDyaX6GRNyFRLwab0gU7p6KyCTnSY7nUNDUg==
X-Received: by 2002:a17:902:e551:b029:de:8dba:84a3 with SMTP id n17-20020a170902e551b02900de8dba84a3mr8430343plf.8.1610939375725;
        Sun, 17 Jan 2021 19:09:35 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm14594805pjt.16.2021.01.17.19.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 19:09:34 -0800 (PST)
Subject: Re: [PATCH] initramfs: Panic with memory information
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, opendmb@gmail.com,
        Barret Rhoden <brho@google.com>, Arnd Bergmann <arnd@arndb.de>
References: <20210114231517.1854379-1-f.fainelli@gmail.com>
 <20210117133355.10fe86c628279161bb3435d4@linux-foundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <36c6065f-0680-4ac0-c480-1382aa13fcb0@gmail.com>
Date:   Sun, 17 Jan 2021 19:09:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210117133355.10fe86c628279161bb3435d4@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2021 1:33 PM, Andrew Morton wrote:
> On Thu, 14 Jan 2021 15:15:16 -0800 Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> On systems with large amounts of reserved memory we may fail to
>> successfully complete unpack_to_rootfs() and be left with:
>>
>>  Kernel panic - not syncing: write error
>>
>> this is not too helpful to understand what happened, so let's wrap the
>> panic() calls with a surrounding show_mem() such that we have a chance
>> of understanding the memory conditions leading to these allocation
>> failures.
> 
> Seems sensible.
> 
>> @@ -45,6 +46,11 @@ static void __init error(char *x)
>>  		message = x;
>>  }
>>  
>> +#define panic_show_mem(...) {	\
>> +	show_mem(0, NULL);	\
>> +	panic(__VA_ARGS__);	\
>> +}
>> +
> 
> But can we replace nasty macro with pleasing C code?

That works for me, would you like to squash this into my patch before
sending this to Linus?
-- 
Florian

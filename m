Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3442D8020
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392040AbgLKUm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388009AbgLKUl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:41:57 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD28C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:41:16 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id 2so10013221ilg.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bJD8TQXY9Iw0B4aOZnAz/J6NLF+5HmQSrMearbDOB3o=;
        b=XlevVis0OmZcsGnbpxHrh2lxwMquktZ7RxjnYXtkV0o44N4mJXhJIwfNfe48f+0Don
         V5Z+N23XBRKTWkKEe9pG3jd/qFm7yI2jnI+s7YBm01qEwnp6UzZuNJd1z0plDSUlErTK
         XpQsi6GlECmIuGLEoofK6L1Se52JqC0q4sfNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bJD8TQXY9Iw0B4aOZnAz/J6NLF+5HmQSrMearbDOB3o=;
        b=JHa4zYEZHqFeM+h9VcgL51ycR/sogA2H1JyoDKSym7QkmX2Jcv6N1YH6jIJeQzmHwL
         BpqnLu+UXt9FRtz6D+n9tIuqcUGNbtZFY+J6FCCx1OAgf6dZp7Q1wtVVBY4h2Q3nZYar
         XKjSQ7BvA8pNQmjg7exjPYwpSkpgvjMpzZHWYBdQM0vDAh2CgNZk6b4+LrsYKrbU7OB9
         OrqEuOSgzKO1H/DTfR9a3fc8ObVlHeSHI1WBszzfPVXzpXR0jNUAbZB8NF7wqo80FRCI
         53avH28X4wcjM1+1Tt9SPBV9wARz9JzH08hvJT2ife1PflH5lnFjwkFCXd/aiuLBpC1D
         AooQ==
X-Gm-Message-State: AOAM5328rXOBYAp/tSGCZz80rKUReMrPmTZqGKz3QntU+aXP1l7eMuNg
        NIMNUYcDed9V5ng14ahLIGC/CS/TjVAXAA==
X-Google-Smtp-Source: ABdhPJzJCBvlvLUFiXmhYME3cg+v8p7NOO0WyaJihB8LW/qazex2lfZa9+bS5D5jGcT935fuX/OjvQ==
X-Received: by 2002:a92:155b:: with SMTP id v88mr17506371ilk.303.1607719276099;
        Fri, 11 Dec 2020 12:41:16 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f6sm4807940ioh.2.2020.12.11.12.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 12:41:14 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: common_interrupt: No irq handler for vector
Message-ID: <9741d93c-3cd1-c4ef-74bb-7f635231c778@linuxfoundation.org>
Date:   Fri, 11 Dec 2020 13:41:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am debugging __common_interrupt: 1.55 No irq handler for vector
messages and noticed comments and code don't agree:

arch/x86/kernel/apic/msi.c: msi_set_affinity() says:


  * If the vector is in use then the installed device handler will
  * denote it as spurious which is no harm as this is a rare event
  * and interrupt handlers have to cope with spurious interrupts
  * anyway. If the vector is unused, then it is marked so it won't
  * trigger the 'No irq handler for vector' warning in
  * common_interrupt().

common_interrupt() prints message if vector is unused: VECTOR_UNUSED

ack_APIC_irq();

if (desc == VECTOR_UNUSED) {
     pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
                           __func__, smp_processor_id(), vector);
}

Something wrong here?

thanks,
-- Shuah



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12AA2C5D87
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbgKZVdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:33:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56390 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgKZVdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:33:18 -0500
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1kiOt9-0001ox-TC
        for linux-kernel@vger.kernel.org; Thu, 26 Nov 2020 21:33:16 +0000
Received: by mail-qv1-f70.google.com with SMTP id s8so1846054qvr.20
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=LkGnUEWLOTsXw7OTNCwX6L+iv752ZbpNWi5kPbxoFVk=;
        b=kKWit2XaJ62V59VW6N9sfc/mLz4yZ0DflXmsHo/H93qNhYBr76jcwFxh5xkl2jtucD
         YXibZgEF9bfL7CvwafVxC1Vy808I/TfQdbKSLeF49NSMbzZJGENqOO+DrjKEb7OcwEOK
         8nq7xlI+tdtLftvG8iUbtesvHILm9teCec8wozWT+LFGkEHkxLmKF3q7FCD2dP1vsR+V
         BNsSGqoDbIYfKlbH9Gg/H4xvV8DlY5W9sSDYOM0rQx6cDPOgt0bhw885Ej+mZjhie4ZZ
         uxU3gRuaP+b0jHRpxEynkC3HmyofHMzzCvDBqASbAt3j7XJSuc3DfQpTI2ZWDxLbWzwZ
         pdRw==
X-Gm-Message-State: AOAM530Lm2RBjU9fbJtGprTxAtteD4dZhLIrx9zrU8WYPmFfsLdFoHBJ
        n3DuhWylEB+xYsO28DITckglNQAl25Obibr9QbQcbBLmqXAat//1tRpbz8KnA7dCrWQkSTX7/Xu
        CbR9BfoCTUgvK/8GsUxOBOVrtIQOjYdDAK3aD4LQpXQ==
X-Received: by 2002:a37:cd1:: with SMTP id 200mr5074412qkm.55.1606426394880;
        Thu, 26 Nov 2020 13:33:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+YYZi8TYoMEuLLcCNrIvVAL5nSvOGWc7H6vTxbBtfx3bslLpNRfeJZq+Rj4h/rUWZFJL/jg==
X-Received: by 2002:a37:cd1:: with SMTP id 200mr5074386qkm.55.1606426394567;
        Thu, 26 Nov 2020 13:33:14 -0800 (PST)
Received: from [192.168.1.75] (200-160-92-130.static-user.ajato.com.br. [200.160.92.130])
        by smtp.gmail.com with ESMTPSA id t63sm3518947qka.128.2020.11.26.13.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 13:33:14 -0800 (PST)
Cc:     Kees Cook <keescook@chromium.org>, ccross@android.com,
        tony.luck@intel.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        u.kleine-koenig@pengutronix.de
To:     anton@enomsg.org, joel@joelfernandes.org
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: About ftrace+pstore+ramoops
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <72df55ca-20f3-c3ee-861b-c50c1a55495e@canonical.com>
Date:   Thu, 26 Nov 2020 18:33:09 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton / Joel (and all CCed), sorry for annoyance but I'm not being
able to make pstore ftrace capture to work - I'm not sure if I might be
missing something, or if there's a known limitation.

So, first, my use case: I'd like to be able to collect *ftrace* trace
buffer in a specific point in time, when some issue I'm facing happens;
for that, I enable ftrace through tracing_on() in the correct point in
the code. After this issue, machine is not responsive, so I need to
reboot (hence I'd like to persist the trace buffer in my ramoops
reserved area).

For the basic test purpose though, I'm doing just what is suggested in
the ramoops documentation, which is to write 1 on
<debugfs>/pstore/record_ftrace and reboot - but no ftrace file is
present in the pstore folder after the reboot. I've tested the same
system/config by inducing a kernel oops and the corresponding
dmesg-ramoops file is there after the reboot...

Just for clarification: this ftrace feature in pstore is meant to do
what I want right? It should *always* collect the same information as
seen in the trace buffer, but on the persistent memory region configured
by ramoops, correct?
Any guidance you can provide me is much appreciated.
Thanks in advance,


Guilherme

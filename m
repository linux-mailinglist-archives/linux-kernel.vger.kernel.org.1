Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB14A2B87F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgKRW4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:56:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46195 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKRW4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:56:30 -0500
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1kfWNa-0004Ca-Dw
        for linux-kernel@vger.kernel.org; Wed, 18 Nov 2020 22:56:46 +0000
Received: by mail-qt1-f198.google.com with SMTP id z14so2798898qto.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:in-reply-to:from:subject:autocrypt
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=9hM3BhOixpgWWUwPs0/nSKrVu8zTVptQYczuRAn528E=;
        b=SHPt6D0b97BCabBshZFfpmnFvtrVrUlNmkPNT7HMmvQ5WTuQ4xp5uMVGuYvugzV3iP
         xf8ehmJNhADv+w/+NoHyxa97u1bVLfTAEgmIp1XuBAS4M+OgRY3ash7PfEZadg2sgP0r
         h9Vy4nZRdnNU40qcGjpanIHKGPk+Arp7S2rUZhYVHDOY6vuSrftlIW2bn6rhQoWs50aX
         yW1VSYqpfzT1cimSpQacJ1V50ewP3RH+U+gQmHCNMl9/1UfJJaoo07caXPJUFS9fQyj/
         ZT+f5Het47+zg3Qor0woGcQY9YnQJeJLq9P9eWSsfbqRXKSJD1iXCx3RH0uAtQIGsHKq
         a14g==
X-Gm-Message-State: AOAM533JQskP4BUAqrxDGWRhD1+DYTBKOVUUKiWuQlK4+XalydyGfhQk
        gSERhCRIgH+K3Z13UP2TLto5cByifTStkQmhLt2q7aUAAT0Dz2Axw4oGK/QPdc8+Behd2ojkeGS
        gWWXRveFjeC5/E9EGVaGmmYiw5uCDfcsgIkT9B0d0kQ==
X-Received: by 2002:aed:2141:: with SMTP id 59mr7386720qtc.117.1605740205490;
        Wed, 18 Nov 2020 14:56:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynz+uuAUd+R0wXJKjUR5CRGS5h1/6Vbvp0ykTmN3/BRYV6zXtTZqaZV7SA+LZzKwvZROxZxg==
X-Received: by 2002:aed:2141:: with SMTP id 59mr7386701qtc.117.1605740205239;
        Wed, 18 Nov 2020 14:56:45 -0800 (PST)
Received: from [192.168.1.75] ([177.215.76.189])
        by smtp.gmail.com with ESMTPSA id k31sm16519305qtd.40.2020.11.18.14.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 14:56:44 -0800 (PST)
To:     vincent.guittot@linaro.org
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, zohooouoto@zoho.com.cn, mgorman@suse.de,
        mingo@redhat.com, ouwen210@hotmail.com, pauld@redhat.com,
        peterz@infradead.org, pkondeti@codeaurora.org, rostedt@goodmis.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Gavin Guo <gavin.guo@canonical.com>, halves@canonical.com,
        nivedita.singhvi@canonical.com, linux-kernel@vger.kernel.org,
        gpiccoli@canonical.com
In-Reply-To: 
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: [PATCH v3] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
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
Message-ID: <17fc60a3-cc50-7cff-eb46-904c2f0c416e@canonical.com>
Date:   Wed, 18 Nov 2020 19:56:38 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent (and all CCed), I'm sorry to ping about such "old" patch, but
we experienced a similar condition to what this patch addresses; it's an
older kernel (4.15.x) but when suggesting the users to move to an
updated 5.4.x kernel, we noticed that this patch is not there, although
similar ones are (like [0] and [1]).

So, I'd like to ask if there's any particular reason to not backport
this fix to stable kernels, specially the longterm 5.4. The main reason
behind the question is that the code is very complex for non-experienced
scheduler developers, and I'm afraid in suggesting such backport to 5.4
and introduce complex-to-debug issues.

Let me know your thoughts Vincent (and all CCed), thanks in advance.
Cheers,


Guilherme


P.S. For those that deleted this thread from the email client, here's a
link:
https://lore.kernel.org/lkml/20200513135528.4742-1-vincent.guittot@linaro.org/


[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe61468b2cb

[1]
https://lore.kernel.org/lkml/20200506141821.GA9773@lorien.usersys.redhat.com/
<- great thread BTW!

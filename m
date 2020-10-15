Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7F28F4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbgJOOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387589AbgJOOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:35:33 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB02C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:35:31 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so4342041ilo.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3L1/9TBjpLndWthwoBtB4TeBTtQ0A63hi99kT0nsw3A=;
        b=BzJiNkYItJ0a0K19sc+CJzVjK04s7IdG6sUwtX8FggqZPkZ1Y08i29g2RXglnEgykN
         Bn8vUti72MSkl86BawXLiX2P8z/DTa4Rz3woD5N0hyOexA1KlTbFXwdS0fuXprwyjKSf
         Hst+oIURzeY9GdxLuaRyt8fqSOJMyouKdzgKlNHc8x+j9+NcP+05IkJCU3EhtDOTRsds
         2Eni0M3FHrANKoKcL0VVZ3QAtYFHsDf+HrnVH0rkwaHK+PM5R4iZQoD/1jmhXrRZfIMy
         NzfiUz7mc1xv8UIcHfR56hYNV08bN0ClnyQuRAoCpqHOhFl4A2cLyfGwmCCZYfZqpxag
         pdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3L1/9TBjpLndWthwoBtB4TeBTtQ0A63hi99kT0nsw3A=;
        b=ln9sb69EBGwbdg4EgvgWQ9q+jvJtnzV3rOyf5lwYLUR1DxkwPmqIz662Eu1cLT6w1j
         drhbn9dXu2v44Nt+IRmV1eavywXZ7outEb9Ll4eMWk1ZJfwzciOYp6OKcPh/fMmp8tXn
         /4cMifiR3mCq/fQe9GBbHlXGtLgWbERH4DF8rVg67AlwFHdDDAiXFLsQtJXzXhHfBWxO
         VblNNj6hlME3A2yM1v/286sxCWBobd8O5wpAaiQrSII2C9Cdd4okq79uZ8rd2L0dE0ZP
         v1dafkBJoO1/lgrM5mO5P8b8p4zFscMNggjkYT5SoDfncW239lSIwor3DDwUVE19rlWg
         vdgA==
X-Gm-Message-State: AOAM531ZOWQ32nRD1dJPTw2YGzOfqUoTyrSpcG8XWUcjV9Bn7XxAE6yz
        3J2YRB6V54arlDpnv6CQ095/Pg==
X-Google-Smtp-Source: ABdhPJyqXcj9QRFyoB1KPc/WOeAGEY2EarWDvhjGXoHzQE6g7WikjXzel8kZLXYRkKSy6gCvpRuIkg==
X-Received: by 2002:a92:c10e:: with SMTP id p14mr2984337ile.160.1602772531133;
        Thu, 15 Oct 2020 07:35:31 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o13sm2778921iop.46.2020.10.15.07.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 07:35:30 -0700 (PDT)
Subject: Re: [PATCH 4/5] x86: wire up TIF_NOTIFY_SIGNAL
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     peterz@infradead.org, oleg@redhat.com
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-5-axboe@kernel.dk>
 <87o8l3a8af.fsf@nanos.tec.linutronix.de>
 <da84a2a7-f94a-d0aa-14e0-3925f758aa0e@kernel.dk>
 <87ft6fa77o.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1a618cba-759f-11f4-df39-bcef64a2e1fa@kernel.dk>
Date:   Thu, 15 Oct 2020 08:35:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87ft6fa77o.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 8:34 AM, Thomas Gleixner wrote:
> On Thu, Oct 15 2020 at 08:31, Jens Axboe wrote:
>> On 10/15/20 8:11 AM, Thomas Gleixner wrote:
>> We could, should probably make it:
>>
>> static void handle_signal_work(ti_work, regs)
>> {
>> 	if (ti_work & _TIF_NOTIFY_SIGNAL)
>>         	tracehook_notify_signal();
>>
>> 	if (ti_work & _TIF_SIGPENDING)
>>         	arch_do_signal(regs);
>> }
>>
>> and then we can skip modifying arch_do_signal() all together, as it'll
>> only be called if _TIF_SIGPENDING is set.
> 
> Then you loose the syscall restart thing which was the whole point of
> this exercise :)

Hah oh yeah, good point... But then we need to touch every arch
do_signal() anyway, so probably not much point in making the change
then.

-- 
Jens Axboe


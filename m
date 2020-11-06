Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1391B2A8C69
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbgKFCDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbgKFCDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:03:00 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A929C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:02:59 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e21so2715980pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=MfUR8zFkzj3kr4PPBmXznA83GIqjmqrQi8dR4mnY5LM=;
        b=OifMrK+xYjA8lLgOUadiWJP+wSmcvuyLPJy8oZM5a4NU04wONUPxxyyTv0muleVrpf
         pKcbl7OS+5OBXTUQ5QZuvqqwhB/dix35NP+i273CjetfCHbFbdiq5r7cx47LwHz75s4M
         3sxaBTtvg0MYq/ttNf3mI9L6qr+lst9TdEAJ1rChG5EmJSI89BoqB0XyvQ8/N5KfYrJe
         r4feXgllxVNASUUFjmRMjgT8j6IZKT9eSEesWG/x9A8z3F2FdVj9PvwaBR33Vh1YVeFN
         0CDTmgTxUZpq5+dmcr69uz2gR3O5V1UDu39p3T9twUe7FUxW3DlZ1evqVwSvx15ZAws4
         ShMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=MfUR8zFkzj3kr4PPBmXznA83GIqjmqrQi8dR4mnY5LM=;
        b=YiAESvsDpTgO0qlYj1KrB2NtsfFM/fD0UxrhMFyoi2V0f/5YUI1c4uQi4+UcGHzisA
         c9yEbkrofl+5JD1Jldq4YqYNd4Hajupl4wsS8CTanUPXlVGYhyJqyIddxTjB5zP8duWn
         LZmqQpDfe0feWldLnw9lhYKpRmXDBYrhxW1bygli2s3w7uwVJRzJpUDP/fJV5ECyH+Kr
         hZGOfj4FItRQJ8lL7iUHcXsjjPdupa688UHuCvZqmZ6fYi53gI0sfORJz78JGOS6I0kR
         NmJq6SWAGar0JsAsXcDOpQ5KOb2Bqd/kuTEBF9Y7C7ipC+0XccwAk+n3ZflB2E3OaYe3
         UGvQ==
X-Gm-Message-State: AOAM531oH09nkGGyR0gwWC5LV6VWz+lXsvhm9aCWCWrT5Pb/JuGYf9Ie
        2KB0CfGok5HHMIXk7gvdio+pPQ==
X-Google-Smtp-Source: ABdhPJxYtyDZKGpxHAIXw60/WyXXonc+jGAUmrNQl1hZQ7jn6G63WSJpYGmmn54EdIUI/L3TW85EsA==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr5261081pju.194.1604628178688;
        Thu, 05 Nov 2020 18:02:58 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i10sm3467604pjz.44.2020.11.05.18.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:02:58 -0800 (PST)
Date:   Thu, 05 Nov 2020 18:02:58 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 18:02:56 PST (-0800)
Subject:     Re: [RFC PATCH] irqchip/sifive-plic: Fix getting wrong chip_data when interrupt is hierarchy
In-Reply-To: <87y2jl81ft.fsf@nanos.tec.linutronix.de>
CC:     Marc Zyngier <maz@kernel.org>, jason@lakedaemon.net,
        geert+renesas@glider.be, greentime.hu@sifive.com,
        linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        uli+renesas@fpond.eu, linux-renesas-soc@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tglx@linutronix.de
Message-ID: <mhng-8b35a163-6996-484c-a9e9-09662614f1b1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Nov 2020 08:52:06 PST (-0800), tglx@linutronix.de wrote:
> On Sun, Nov 01 2020 at 12:10, Marc Zyngier wrote:
>
>> On Thu, 29 Oct 2020 10:37:38 +0800, Greentime Hu wrote:
>>> This oops is caused by a wrong chip_data and it is because plic_irq_unmask
>>> uses irq_get_chip_data(irq_data->irq) to get the chip_data. However it may
>>> get another irq_data with the same irq_data->irq if it is hierarchy.
>>>
>>> In this case, it will get irq_data of sifive_gpio_irqchip instead of
>>> plic_chip so that it will get a wrong chip_data and then the wrong lmask
>>> of it to cause this oops.
>>>
>>> [...]
>>
>> Applied to irq/irqchip-next, thanks!
>
> That should go into urgent, the offending commit is in Linus tree already

I agree.  I'm assuming that's for Marc, but LMK if you guys want me to take it.

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!

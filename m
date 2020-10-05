Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2C2835D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgJEMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEMbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:31:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BB9C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:31:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u8so11661122ejg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=fiCrvDEC+N91sV5tSYfiRUfHF9WZ4cEQDOciG9CIIEo=;
        b=jeCAFGdVVyZTTJVSAYgmCTbMhs2z/jLPfL6bbH5ezEq64dztUXuA3/Nq27U3WKMgFG
         Lemw0JeuJdSf2TIvfuTw4vbryHp7U8pI38jM8Po5eehY/qRSRsqpc19Ku6NhF+OM10yN
         TCzAII1A1p4ibrR/zRIWRgrMSDTX2P+9vmLeh+RRNjGxwaxJj/vu/smwC7lHIcE8F2Ao
         eoQxO7MHjUY4RO644XNJcFYAOgMEQMt+UBJlJGUJKdCUOPgXlSEQNN0FFImFlQb2Udi6
         ZJS5GICnohvXBu0nqUY13Nnz0jYxaLe7FNc5h8MMm6QKbFIDewptfKzRElGQ119pgj8Q
         1VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=fiCrvDEC+N91sV5tSYfiRUfHF9WZ4cEQDOciG9CIIEo=;
        b=ZjecGxp7nSJksIHTFuxYCIz/fDV06A3k5vmMa6UYtqu5P1wQwCKB9O60X6XGplOigI
         Nt7XRIMX5FIaTE21sjf5r/6aqWHbaqtGXORSHG8UvOwWy2753L0FH81SHV6R1c3HxoXY
         JsXYIA8/d543+rRDzPBWodqxTJyxzdJm6sWSaK0FJMINKfF00jtJ+LjJtYNqJ/Q8QPVx
         uyK/pZwMP3z00Cttql6XU9eM2EMAMOPbAiE0uXvzrfYwqUgYrucFaR6STjH96TrpRYb6
         RZwokivGjEXr8Jva30QSG2KQkaMf91VwCGBeCD3ilAAUAaX7kOwBRZDqaLmbnnWrhn3t
         mGeg==
X-Gm-Message-State: AOAM531gTHJ1+8803y3gTkUGn07Rnvpq7shF5h3bvYnT7Dm7ukm0zKzc
        i/KN75YdV2T1qed0jh5yxHJKmQ==
X-Google-Smtp-Source: ABdhPJy02NnD+4aHKxW6Hc8US3lVSSNA3BxcKCnClvJhFQf261x5iusEFWzdEVvbeZjYWA02noZaqA==
X-Received: by 2002:a17:906:2dd:: with SMTP id 29mr15898934ejk.31.1601901068443;
        Mon, 05 Oct 2020 05:31:08 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id i14sm8004849ejp.2.2020.10.05.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:31:07 -0700 (PDT)
References: <20201002164915.938217-1-jbrunet@baylibre.com> <CAPDyKFo6T_P+TQQZSzFgHwLeE08f146KxKBpAutv209MXq0mjA@mail.gmail.com> <87wo052grp.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Brad Harper <bjharper@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
In-reply-to: <87wo052grp.fsf@nanos.tec.linutronix.de>
Date:   Mon, 05 Oct 2020 14:31:06 +0200
Message-ID: <1jlfgkrh11.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 05 Oct 2020 at 10:55, Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, Oct 05 2020 at 10:22, Ulf Hansson wrote:
>> On Fri, 2 Oct 2020 at 18:49, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>
>>> IRQF_ONESHOT was added to this driver to make sure the irq was not enabled
>>> again until the thread part of the irq had finished doing its job.
>>>
>>> Doing so upsets RT because, under RT, the hardirq part of the irq handler
>>> is not migrated to a thread if the irq is claimed with IRQF_ONESHOT.
>>> In this case, it has been reported to eventually trigger a deadlock with
>>> the led subsystem.
>>>
>>> Preventing RT from doing this migration was certainly not the intent, the
>>> description of IRQF_ONESHOT does not really reflect this constraint:
>>>
>>>  > IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
>>>  >              Used by threaded interrupts which need to keep the
>>>  >              irq line disabled until the threaded handler has been run.
>>>
>>> This is exactly what this driver was trying to acheive so I'm still a bit
>>> confused whether this is a driver or an RT issue.
>>>
>>> Anyway, this can be solved driver side by manually disabling the IRQs
>>> instead of the relying on the IRQF_ONESHOT. IRQF_ONESHOT may then be removed
>>> while still making sure the irq won't trigger until the threaded part of
>>> the handler is done.
>>
>> Thomas, may I have your opinion on this one.
>>
>> I have no problem to apply $subject patch, but as Jerome also
>> highlights above - this kind of makes me wonder if this is an RT
>> issue, that perhaps deserves to be solved in a generic way.
>>
>> What do you think?
>
> Let me stare at the core code. Something smells fishy.

FYI: initial discussion can be found here
https://lore.kernel.org/linux-amlogic/24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com/

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6B278AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgIYOOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgIYOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:14:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCC1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:14:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ay8so2630981edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=wM9M9SzefD5gqh6rUe+GGK3P8rbYWiC3a0TiUA4Suek=;
        b=jJuocI/bplwYAWFLuhGNb/1qgyrDnRkMLJAlZdkhGDJJsUt4ok2/cyUbysJMmCGDKA
         KXH9ftBquli+ARnXX4BDOeYilgqtVQ7ln8kOH1qXr48cU4hrWRFBhEuWYUrLzLgpp2PB
         gdPfZa3GoCJ0u2CVL/zGIo1yn3QawYh7274Sgw53RbqpDTyn45QUqUixesApHD9H7wY6
         BQaVd+GhKSE+N6ed7ZcaylKPV1wNGLOhJurEGTLlHszLFU1245uSjl0dJvrxnWiPPUXC
         sLzmP+bB360gkGoyR6jEcWZw2nlmWDuw+ZuNC1pfQxRBpzatPZkbcAmcIW5ixv9QfZmo
         wdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=wM9M9SzefD5gqh6rUe+GGK3P8rbYWiC3a0TiUA4Suek=;
        b=muBWKqUasgovuSB17HQWQrrAqT25CsuHKDiGAuFVgSvp+cM/aWYH+07+NpIXc9I8OT
         7SzY4qJk2c2PDjgMXATm59Z39Apx/kXAmn+JRJgxQfmfEVaOL0M9wd1gNcRJ9QOve5uu
         pi+XdBQ17/aO2mKsxMXqZOQJf7IBZ8OjbvyRu8DedBenJjQXqNmbf5KzR9irfblBkFMY
         f7eyoaGNw4rR8EiPwg9JJicojDdo0wzoxhWbtFzWBE1GaVtqmNpM+svPs38EO9l/prs/
         hmzlMrpm003tUpV2JZ+N8mu8tmx5WOKEqjWhfXJiVwgxZ2vwDYZKqC3+c0pLLfJB7n7c
         EPtw==
X-Gm-Message-State: AOAM533e9oqucdVIHYPlh21wRpI8llnvxrvDy8dc70AIoRMvkrK80FPP
        It1Qc6+dRUlQibUegxFlxWanZQ==
X-Google-Smtp-Source: ABdhPJzwIPCGQ+75gzlRe/ufSmeKulNDnlPMmGvgzb28BYKfC4imiU3i9M+FUIyU2tCF/soD6aW5iQ==
X-Received: by 2002:a50:bb62:: with SMTP id y89mr1551879ede.261.1601043252055;
        Fri, 25 Sep 2020 07:14:12 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id k6sm1934617ejr.104.2020.09.25.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:14:11 -0700 (PDT)
References: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com> <7hk0wj9ki2.fsf@baylibre.com> <1jzh5e8bld.fsf@starbuckisacylon.baylibre.com> <20200925134445.rk366jip5ne4x7em@linutronix.de>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Brad Harper <bjharper@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: meson-gx-mmc: fix possible deadlock condition for preempt_rt
In-reply-to: <20200925134445.rk366jip5ne4x7em@linutronix.de>
Date:   Fri, 25 Sep 2020 16:14:09 +0200
Message-ID: <1jh7rmj64u.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 25 Sep 2020 at 15:44, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-09-25 11:11:42 [+0200], Jerome Brunet wrote:
>> I'm not sure about this.
>> As you have explained on IRC, I understand that IRQF_ONESHOT is causing
>> trouble with RT as the hard IRQ part of the thread will not be migrated
>> to a thread. That was certainly not the intent when putting this flag.
>
> That is my understanding as well.
>
>> This seems pretty unsafe to me. Maybe we could improve the driver so it
>> copes with this case gracefully. ATM, I don't think it would.
>
> Running the primary handler in hardirq context is bad, because it
> invokes meson_mmc_request_done() at the very end. And here:
> - mmc_complete_cmd() -> complete_all()
>   There is a lockdep_assert_RT_in_threaded_ctx() which should trigger.
>
> - led_trigger_event() -> led_trigger_event()
>   This should trigger a might_sleep() warning somewhere.
>
> So removing IRQF_ONESHOT is okay but it should additionally disable the
> IRQ source in meson_mmc_irq() and re-enable back in
> meson_mmc_irq_thread(). Otherwise the IRQ remains asserted and may fire
> multiple times before the thread has a chance to run.

Looks like we need to do manually what IRQF_ONESHOT was doing for us :(
This brings a few questions:

* The consideration you described is not mentioned near the description
  of IRQF_ONESHOT. Maybe it should so other drivers with same intent
  don't end up in the same pitfall ?

* Why doesn't RT move the IRQ with this flag ? Seems completly unrelated
  to RT (maybe it is the same documentation problem) 

* Can't we have flag doing the irq disable in the same way while still
  allowing to RT to do its magic ? seems better than open coding it in
  the driver ?

>
> Sebastian


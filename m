Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75352F6599
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbhANQRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbhANQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:17:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24028C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:17:09 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:17:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610641027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqtQbeVMLh79dOF34C4Z4RZ/eHRYm7fDBoO+wUdjOFQ=;
        b=H8UGuXTZY8e5lYl9xfmE2yteNTRFFfth5mjlr/Ufxfetg1nZS8slBsgHiY2EyxBa9ZpxQ3
        NQ1R3i4GgYwl6aK7WydMzkJOdRUmKELLwLbOJCVznBuNI+Tq0juiIH06Xi7Y6tEHiucenh
        eGpec0HqahCXrdd3avVF/xfQTymqJEyMU+681H4QVZimiZXSpfJ1basSmL0kyQ6Y0QWO0y
        6ukJEfjJKgz3OxQ6LVb2kNfcXCulKvBPxnWEmT7mXJ8c0XSMQR2ijW2s3WZnTNwp4d0kNO
        Lr7vs0l6BlfqmWj2e7vxIOR5JFqPserGl7RrRoQ4k1KgWxkEAmjM8GasS1Q0CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610641027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqtQbeVMLh79dOF34C4Z4RZ/eHRYm7fDBoO+wUdjOFQ=;
        b=0zWEAw9zSfSoVi7BljSvsSx8knAavkNmAiL37X3TW1M99P9EFCXdWmPc/xAyZRKMuSm/x1
        OLSGwSFG9DY3XiBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
Message-ID: <20210114161707.wfgbxi2rppoobfo7@linutronix.de>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com>
 <20201220011835.GU15600@casper.infradead.org>
 <CAM4kBBJCONeSBUwnH0rb3-cAn5THDFapQ8p8xt6+-VaobS_cWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM4kBBJCONeSBUwnH0rb3-cAn5THDFapQ8p8xt6+-VaobS_cWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-20 08:21:37 [+0100], Vitaly Wool wrote:
> Not really because bit spinlock leaves preemption disabled.

It leaves it disabled for a reason. Now you just spin until the original
context gets back on the CPU. On UP with preemption, if the "lock owner"
gets preempted, the next lock attempt will lock-up the system.

Sebastian

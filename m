Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A747C281559
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgJBOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:36:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446B7C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:36:18 -0700 (PDT)
Date:   Fri, 2 Oct 2020 16:36:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601649376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrUOIAqsssB4FumTljj+LZWMjFcAq3+jZ2AYz8xyr74=;
        b=uukbz9JOyKFxRkvFoV8RYwRksTtV9IuJLdXDfO2IcRSWBgpWlKwQTGMi2s2me9NGCbz10+
        bDIbqwyeItpARP0XkzJE0sLP4V/61AQF/e+ktA59P5XWVAtEkbX8wn/pNGtBxi96FgiQ6n
        IJCkUJ7j0LdjWQyY5njpjqpUkWzZnmtNKx0qOCmfUdawlJ02SmeXGQNf3gA+akL0F39gyj
        OeLviF1qp07E3ZtywJr61nEDQs/jrBPduPSGVlkQ99J5I/UJjEKUecaQIXtgVESCY+MjIl
        cZtawNKWMzx3SEBjMeL5X/Q3KheoEiCgkE51X3UkyLDj4UbyJtYq5Ph0t4G9aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601649376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrUOIAqsssB4FumTljj+LZWMjFcAq3+jZ2AYz8xyr74=;
        b=kTmyPDfP7CmIBp+GTLtDBCtsBSlWVOZiKw3rsv8RMtkaf66ajKj2D/TV1prC5uDa8OiDwK
        geHRqJn2Y9tsGvCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
Message-ID: <20201002143615.h42coicoyytahq2u@linutronix.de>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.769861942@infradead.org>
 <20200925165047.iey2dlcdn4im2vv4@linutronix.de>
 <20201002142149.GZ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201002142149.GZ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-02 16:21:49 [+0200], Peter Zijlstra wrote:
> Yeah, I didn't want it in a header where world can access it and attempt
> creative use :/

tell me about it. Currently cleaning up other creative abuse of things=E2=
=80=A6

Sebastian

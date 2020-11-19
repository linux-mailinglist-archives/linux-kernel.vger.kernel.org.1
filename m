Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE12B9935
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgKSRYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgKSRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:24:08 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E233C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:24:08 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y16so7121742ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roKed23LgH2ixqxBEBzRYh8QoZ0Y+ahXxWrHQPjuH7U=;
        b=R25wBXI23xncSP774w9yY17VRXi5gWwtiFn5B5y0aCu8Ej56oJnYXT4a52YWJrErvL
         aHstvk6tzU7PKlrfe0Rtveex72l4tsEaaTYslKzHXiF/HffAijHs1WhL7CZRm8rT4vzh
         ddMAdfw98+K4N6JgZ99dj+rjCTxhZvk+DkSy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roKed23LgH2ixqxBEBzRYh8QoZ0Y+ahXxWrHQPjuH7U=;
        b=qib7V3cKRpFxOSY8+KWprcZ+cDUbkSn3psdUih7h08hZ7y1WvmAjW8XS+80avjoky5
         9tPjOyX71xkq4u+fkYl5As+hYPlvHshRS3cv46GO5bHFTVSmWih+nS0sVXYI2AgL9fM2
         tEZdWSyUxBu8X5gMVpbg4/VixOOMosdtFtO5P/+UwTBmp0powL7XBMi+wMqIRWO/1gIs
         JURigGtMFkWsWEZUCm3eaJHVndtBzqntIxwOD3POSEOL7USI4dvUlYPW5UqolbkR+j1N
         Lp6zxrRfQ4jElz95AH+KpfyYl1X4b4l6NSnsSmOwQ4iumLTOa4DYxyYqj4YG16Q7eP5u
         N/Gw==
X-Gm-Message-State: AOAM533+WlkfT8769ZRmeELmERtfAH7ayvtUHlHWR+nrKpiGX3NmUaUl
        h76arCPKJgFitpy8SRR1P55zE1g3EDf9Uw==
X-Google-Smtp-Source: ABdhPJxOzeVIix0ZlmDJ4MGJxOdnPJ98A/BaPmBTPay3AGK4Ncm9eyBxXBREJXWGmEIH6k5askp3FQ==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr6580695ljl.20.1605806645467;
        Thu, 19 Nov 2020 09:24:05 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id w6sm28137lfn.64.2020.11.19.09.24.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 09:24:03 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id i17so7111849ljd.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:24:03 -0800 (PST)
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr5946254ljk.102.1605806643076;
 Thu, 19 Nov 2020 09:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20201118194838.753436396@linutronix.de> <20201118204007.269943012@linutronix.de>
 <20201119093834.GH3306@suse.de> <20201119111411.GL3121378@hirez.programming.kicks-ass.net>
In-Reply-To: <20201119111411.GL3121378@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Nov 2020 09:23:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wire3dzhHx=KiL_f5Rj0=1u9ustsa33QoR-F9-v-NU9Ng@mail.gmail.com>
Message-ID: <CAHk-=wire3dzhHx=KiL_f5Rj0=1u9ustsa33QoR-F9-v-NU9Ng@mail.gmail.com>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent
 of RT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 3:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I still hate all of this, and I really fear that with migrate_disable()
> available, people will be lazy and usage will increase :/
>
> Case at hand is this series, the only reason we need it here is because
> per-cpu page-tables are expensive...

No, I think you as a scheduler person just need to accept it.

Because this is certainly not the only time migration limiting has
come up, and no, it has absolutely nothing to do with per-cpu page
tables being completely unacceptable.

The scheduler people need to get used to this. Really. Because ASMP is
just going to be a fact.

There are few things more futile than railing against reality, Peter.

Honestly, the only argument I've ever heard against limiting migration
is the whole "our scheduling theory doesn't cover it".

So either throw the broken theory away, or live with it. Theory that
doesn't match reality isn't theory, it's religion.

          Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B7277E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 04:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgIYCsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 22:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIYCsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 22:48:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB7DC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 19:48:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so1746975pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 19:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gM7SDWqbXlUnie8/K9aQ5b7aV4uURtNM0hRz/7vAlag=;
        b=I6bd+Oi99bFVpGwqyLI8hQMFdhxbN9BxBmK3HJtN4w0ZNfSQ5zh3Dmr8gOWNGQMMSZ
         RQsH+V5qOLht27O3Pt42n28dU1XSP1GwHeJH4ZW8I5HbsnuZDwwB/mpsNf/4u2zIxICc
         uiwQJOTl9O0yR+LF3zwp9IjL+gSIdcaGoJKod9Z1yLmfNYe4Gkyg5DAbAJNaQIdtmCIW
         e9jO/c5EUKsQX71oltWVkbjHT9y/8r0ZR74zgDbHh24IzDF++IABUnyyigz/qsJpsQfv
         Y6KjZhn+nSY1Z2CmoFRKhhXrug4LxEpuWncki7wgIA+AgFaKB5x7ZSnrLHClsx4H8/qZ
         vP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gM7SDWqbXlUnie8/K9aQ5b7aV4uURtNM0hRz/7vAlag=;
        b=qapmgd4hbWJGYNrr6XpxsdwtOOa4dxxRqnPqj85BmVVhM5+ELvpdK2/5XIKRyRZkR4
         qLd3Bxo15+Cce5zuI35dhFHydyVs+X9Y1arvicamKtrgeAKGfHbyCID17Kdzd3bvJiDw
         7p+uNqPHvjErUOWoTWfmP8/SL5pBm1EydpQXML2QIKFqRqufIJA7wTvoCG6naJN1lNru
         mVScxhjJU4EJUsHjB0Cp06wLOU4YIIiW6+V+dO6iGckwaqPa0DwG8/M+BjJ62J6r0/e1
         s3KM9/U475F9B3YjbLEVOqmoPYgyMHS6Cof91x5T9qHXYj/SmLgWSX6vsuuXO8RF6llU
         +XXg==
X-Gm-Message-State: AOAM533xKRBLB6WoXZ7EdzOtm0JIaVODYfit1Vdg1b4u2S2wgsLWj6nQ
        zo86U0X8+NWzaLI5Td+LCj17bmp3GmVwuZInh2FFCw==
X-Google-Smtp-Source: ABdhPJx7AfnIo+0I6MR0bqZRub+CI3ngVdVaJMd/n00pAqpwwMqRxFp5uT4ADccRuQyzKSlBoAq5/Hv+qdR5BSTd6Gg=
X-Received: by 2002:a63:3047:: with SMTP id w68mr1661974pgw.341.1601002109717;
 Thu, 24 Sep 2020 19:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200905060412.88560-1-songmuchun@bytedance.com> <873637838m.fsf@nanos.tec.linutronix.de>
In-Reply-To: <873637838m.fsf@nanos.tec.linutronix.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 25 Sep 2020 10:47:43 +0800
Message-ID: <CAMZfGtXG8Bn2SosdVKNxw2t0JW_ej-Oc4Lg-bGV59tDN7kNrfg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] tasklet: Introduce tasklet tracepoints
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, romain.perier@gmail.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 1:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, Sep 05 2020 at 14:04, Muchun Song wrote:
>
> > Introduce tracepoints for tasklets just like softirq does.
>
> What does softirq?

I mean that the softirq has tracepoints and the tasklet may
also be needed.

>
> > In this case, we can calculate tasklet latency and know what tasklet
> > run.
>
> I rather see people working on removal of tasklets.

I do not know about this, why do we remove the tasklet?

>
> Thanks,
>
>         tglx

Thanks.

-- 
Yours,
Muchun

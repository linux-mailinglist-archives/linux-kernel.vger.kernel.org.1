Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502AB2626E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 07:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIIFvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 01:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbgIIFvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599630673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=il5f2exuzL5JakB/RTDDV/wE8hpRfPQoB+xkGYphses=;
        b=IA4ct3z94wXWOSdUGB/5Ob1Fdp3Lrw7xPoNy/KvQ8k2rQ1slqZdHiYgC2zOp7489z6LCaE
        mDVZ0zasa39uJIHLS2UmaeL1WOjLJXrE6Mwlo5QGy+eAS4YjyDPMUvnCzhJh1QiCXla79P
        TEH3V0eHpJwKRfVyh0MJM+tQMuNOZ34=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-e3FzrWjcNlWx7TgN_fydOQ-1; Wed, 09 Sep 2020 01:51:08 -0400
X-MC-Unique: e3FzrWjcNlWx7TgN_fydOQ-1
Received: by mail-wr1-f72.google.com with SMTP id 33so536629wre.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 22:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=il5f2exuzL5JakB/RTDDV/wE8hpRfPQoB+xkGYphses=;
        b=VTLDDY7iKemjydi7ZIftcBWnOgKO/Hq8YzFH1fAGVivCcg8xS/ffQbmjbnNoNq2px0
         6ax2V/XUT7Z1YImz2WwepPWdWA18C6JJzGPB6hHJ0KAB0EL6GqXVyBoeR4idt1RVbh3n
         o7byYdIVIIV9Yilb5iF0Ee1gIqrjVCBhppWUPfN1c1JKWwyvguCygZ3DbPd7n/aRTzRQ
         BG7NUzHSVNGSxZMDdTJlze1cFkFeAffLrM/nBunVBFO+CMHCDRzI3CfeCPXSybeesQot
         C+uQ/MbdrL7aJurjqtBpmME3x76Hl+cIPJBDCEjrhjuQEHwiQUG/L2JfjrNRTygKZ+8p
         mo6A==
X-Gm-Message-State: AOAM532QJDM20uWCM/R/qd3SxtEmKtyQ3NWa3cB0PODa3QL60ZQACMHa
        OrWBNGJjzUgoUrTH5ttDKSS5YI4emnU6tGfMoi2uu+pbR5aDfXBNW2BRZZ02lNJyYlEtGqPxlbE
        b8HfC7gGbU9uvFTed+pDYLUMX
X-Received: by 2002:a7b:c768:: with SMTP id x8mr1885693wmk.189.1599630667670;
        Tue, 08 Sep 2020 22:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMkW1TqwP4Ye4ockimpubn1IIW7MJimFAD5OWipotdjICi8VTmGvrUnlcAK5spXy824A0ytw==
X-Received: by 2002:a7b:c768:: with SMTP id x8mr1885676wmk.189.1599630667450;
        Tue, 08 Sep 2020 22:51:07 -0700 (PDT)
Received: from localhost.localdomain (ca-18-214-147.service.infuturo.it. [151.18.214.147])
        by smtp.gmail.com with ESMTPSA id f6sm2630914wme.32.2020.09.08.22.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 22:51:06 -0700 (PDT)
Date:   Wed, 9 Sep 2020 07:51:03 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Message-ID: <20200909055103.GA18215@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200908222252.GC1005@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908222252.GC1005@bug>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 09/09/20 00:22, Pavel Machek wrote:
> Hi!
> 
> > This is RFC v2 of Peter's SCHED_DEADLINE server infrastructure
> > implementation [1].
> > 
> > SCHED_DEADLINE servers can help fixing starvation issues of low priority tasks (e.g., 
> > SCHED_OTHER) when higher priority tasks monopolize CPU cycles. Today we have RT 
> > Throttling; DEADLINE servers should be able to replace and improve that.
> 
> It would be worth noting what "server" is in this context.

It comes from Constant Bandwidth Server (CBS), that SCHED_DEADLINE is
implementing [1].

> 
> It is not white box with CPU inside, it is not even an userland process, afaict.
> 
> Subject is quite confusing.

Best,
Juri

1 - https://elixir.bootlin.com/linux/latest/source/Documentation/scheduler/sched-deadline.rst#L42


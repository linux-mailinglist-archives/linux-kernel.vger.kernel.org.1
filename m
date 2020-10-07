Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7362F28581E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 07:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgJGF3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 01:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgJGF3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 01:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602048584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fCH6QAGrKIileKVZT+ymuJeBoAmGogkMo1GbnjIqrGQ=;
        b=X5MtQ5ftKT0xSpWmeHb8Ja87LoK9saLO9ugF9LktOr4LgON9S/Pe/owuqI9mvoAVLY+lEt
        EL4ZrSnYoyfWkaT0GFc0e68hac5k4Y0fh1FIYj4tjd0EClutwJdBol6KQ2c0nz4fsG8FJV
        cgjATjINvxKwKqmW58ZaW/6Fy9jDL8I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-1a4g_C9EOw2zKPK9ReqXMg-1; Wed, 07 Oct 2020 01:29:40 -0400
X-MC-Unique: 1a4g_C9EOw2zKPK9ReqXMg-1
Received: by mail-wm1-f69.google.com with SMTP id d197so117834wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 22:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fCH6QAGrKIileKVZT+ymuJeBoAmGogkMo1GbnjIqrGQ=;
        b=DpTUzQ6aG0rbQOplomWxkpfLFXLdMKu3dLbQE+MgBh/zmAx9koBD2X8ILhOz1zMCHC
         8hpKqSZh1lTTHN1tupCDp5O/ps29AfOQVzJTICRJCaSbTyVKu1osHkLIWKxCN0jsvUvi
         5lgeLsjibM+DrSdJtou6Kj5+SzS3Dh8tftBUlLnehOJM+4o+feTS0y3/hui0urtVNo5L
         xSkTnnKxW4uL959W/emxx7FL3M7eeg1uj/IPL8z7NcgYfT36CWrHuIF4uJETZgfheGZP
         2lJ8sU8aT2qr9XNFHdujtNyNkRq2kFc7BnURnLTcGMepwmEbAgmZhB8dxnNI7z0vTWAk
         +Irw==
X-Gm-Message-State: AOAM532J8LGRzX/0imn99nBzA5TiWblCnSRV2u3aE2fIA17SI3yKcRG8
        6yhK3y09xZNGGBl8WHmNF3gRZxIkYy6CFgW+mVo20Q1uGSn0YlAZtwvJbpAYVJJeJKO+kqtoUYW
        bQ5VGPwN5hwRcEYbz5/1gzKx6
X-Received: by 2002:a1c:f208:: with SMTP id s8mr1295302wmc.85.1602048579149;
        Tue, 06 Oct 2020 22:29:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5Lqt0n8qv24fIigws1+lcuONxUtAMtWxWKezQd7nimlfj+FsVvcBuSMyXZSfS7cLn7/0OCw==
X-Received: by 2002:a1c:f208:: with SMTP id s8mr1295279wmc.85.1602048578831;
        Tue, 06 Oct 2020 22:29:38 -0700 (PDT)
Received: from localhost.localdomain ([151.29.91.67])
        by smtp.gmail.com with ESMTPSA id f189sm1040036wmf.16.2020.10.06.22.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 22:29:37 -0700 (PDT)
Date:   Wed, 7 Oct 2020 07:29:35 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201007052935.GK4352@localhost.localdomain>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
 <jhjv9fnmwhg.mognet@arm.com>
 <20201006134850.GV2628@hirez.programming.kicks-ass.net>
 <20201006143704.GJ4352@localhost.localdomain>
 <20201006144816.GZ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006144816.GZ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/20 16:48, Peter Zijlstra wrote:
> On Tue, Oct 06, 2020 at 04:37:04PM +0200, Juri Lelli wrote:
> > On 06/10/20 15:48, Peter Zijlstra wrote:
> > > On Tue, Oct 06, 2020 at 12:20:43PM +0100, Valentin Schneider wrote:
> > > > 
> > > > On 05/10/20 15:57, Peter Zijlstra wrote:
> > > > > In order to minimize the interference of migrate_disable() on lower
> > > > > priority tasks, which can be deprived of runtime due to being stuck
> > > > > below a higher priority task. Teach the RT/DL balancers to push away
> > > > > these higher priority tasks when a lower priority task gets selected
> > > > > to run on a freshly demoted CPU (pull).
> > 
> > Still digesting the whole lot, but can't we "simply" force push the
> > higest prio (that we preempt to make space for the migrate_disabled
> > lower prio) directly to the cpu that would accept the lower prio that
> > cannot move?
> > 
> > Asking because AFAIU we are calling find_lock_rq from push_cpu_stop and
> > that selects the best cpu for the high prio. I'm basically wondering if
> > we could avoid moving, potentially multiple, high prio tasks around to
> > make space for a lower prio task.
> 
> The intention was to do as you describe in the first paragraph, and
> isn't pull also using find_lock_rq() to select the 'lowest' priority
> runqueue to move the task to?
> 
> That is, both actions should end up at the same 'lowest' prio CPU.
> 

OK, right. Think there might still be differences, since successive calls
to find_lock_rq() could select different candidates (after the
introduction of cpumask_..._distribute), but that shouldn't really
matter much (also things might have changed in the meanwhile and we
really have to call find_lock_rq again I guess).


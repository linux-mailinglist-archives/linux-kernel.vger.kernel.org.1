Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7805127B524
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgI1TSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbgI1TSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:18:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601320691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yuwDiCuS53qLPlHL7d2G9agEv5mUWSqvLsfJ5r+guPA=;
        b=fU5mF7dRoA3JCOrZYNVJFn+tYWzwkfjd8qgUyscJr9vtbsw3rWzW5C2Vdu2yGAtx3pi9M2
        jaC6dRFloD7897Ycxak/EPaQKImTbflmwCe/HioHsBDS+8C2hnyKvjzVZzN7f4TdgXauS9
        Q8TiUDRqcJEy3ga9h9gXpBHACJFnZnU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-gGTeC-IOOfiRMF1t_nOl7A-1; Mon, 28 Sep 2020 15:18:08 -0400
X-MC-Unique: gGTeC-IOOfiRMF1t_nOl7A-1
Received: by mail-qt1-f200.google.com with SMTP id w92so1362260qte.19
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yuwDiCuS53qLPlHL7d2G9agEv5mUWSqvLsfJ5r+guPA=;
        b=TEHw95JxbLdjyk9QBA1pkA7MuKmLstyOtIC9MMxBaNEO0Hiw1HSbNdq8JoAHEkB/Ms
         0Sjo3Q8DLup4zDnSjNEyIi2vgxoSVBENLv2k5oiAL23yReKkID23pw7sH8iRE1TXcWdu
         sEeJqpn1FPhaxgV29KvgOhKaq8Veq8HVpUJbUG0a+mMx2AsMkoW872wwRjFlsKooL92Y
         3XWx8rhL4enaqzzz3pKMdFjknfrtbgqIs4dEFYaSC0Hkpw9tDOgFDY1wfg3QXgRmxEDD
         9eBke2gI7pDqRJtdsGw/5ApF7hBODg/BEoHKVp/v0gXnAR4mEDV+f7Bu5HdNkb3BT6xE
         Svbg==
X-Gm-Message-State: AOAM531HHt7Kq28uQqxEHePkAYtaP9yjX0WsUy+ncfva5ZwZCws8ohc1
        ZqpsFVNQsxJ/AI+QU6ySRk4oTlraErMtDDOALC6/oMhETm9RCFj+yydQjprqNB55z0Chluom3eq
        +DRi29bitMKOlIPBbCYjnlDSy
X-Received: by 2002:a37:38c:: with SMTP id 134mr933254qkd.193.1601320687780;
        Mon, 28 Sep 2020 12:18:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjEJgcS5MYE1cGRutSutJfI8/sAs4in3fDfO9mslXU+kE2gys8H66EYcbjkFd4WmCFaKRnKw==
X-Received: by 2002:a37:38c:: with SMTP id 134mr933213qkd.193.1601320687461;
        Mon, 28 Sep 2020 12:18:07 -0700 (PDT)
Received: from x1.bristot.me (host-87-17-196-109.retail.telecomitalia.it. [87.17.196.109])
        by smtp.gmail.com with ESMTPSA id k20sm2272528qtm.44.2020.09.28.12.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 12:18:06 -0700 (PDT)
Subject: Re: [ANNOUNCE][CFP] Real-Time Linux Mini-Summit 2020 - Virtual
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        bastian.germann@linutronix.de,
        Anna-Maria <anna-maria@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Mark Brown <broonie@sirena.org.uk>,
        Daniel Wagner <wagi@monom.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Julia Cartwright <julia@ni.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Tom Rix <trix@redhat.com>, Scott Wood <swood@redhat.com>,
        =?UTF-8?Q?Luis_Claudio_R=2e_Gon=c3=a7alves?= <lclaudio@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dario Faggioli <raistlin@linux.it>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Drew Fustini <drew@beagleboard.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <2a4608f6-f2b1-efaf-3370-ffd7e62cdbbc@redhat.com>
Message-ID: <112d41ff-e3ea-fa03-ef23-783728a1ab92@redhat.com>
Date:   Mon, 28 Sep 2020 21:17:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2a4608f6-f2b1-efaf-3370-ffd7e62cdbbc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

This is a gentle reminder about the CFP deadline for the Real-time Linux
Mini-Summit 2020.

The CFP will be open until September 30th, 2020, at 23:59 PST.

IOW: this Wednesday (in the previous mail I said that Sept 30th was on Saturday,
which is not the case (at last, not this year :-)) my bad)

Thanks!

On 9/18/20 5:17 PM, Daniel Bristot de Oliveira wrote:
> The Real-Time Mini-Summit is organized by the Linux Foundation Real-Time Linux
> (RTL) collaborative project. The event is intended to gather developers and
> users of Linux as a Real-Time Operating System. The main intent is to provide
> room for discussion between developers, tooling experts, and users.
> 
> The mini-summit will take place alongside the Open Source Summit + Embedded
> Linux Conference Europe 2020, virtually. The summit is planned last day of the
> main conference, Friday, October 30th, 2020.
> 
> If you are interested to present, please submit a proposal [1] before September
> 30th, 2020, at 23:59 EST. Please provide a title, an abstract describing the
> proposed talk, a short biography, and describe the targeted audience. Please
> indicate the slot length you are aiming for: The format is a single track with
> presentation slots of 15, 30 minutes long. Considering that the presentation
> should leave a space for discussion.
> 
> We are welcoming presentations from both end-users and developers, on topics
> covering, but not limited to:
> 
>  - Real-time Linux development
>  - Real-time Linux evaluation
>  - Real-time Linux use cases (Success and failures)
>  - Real-time Linux tooling (tracing, configuration, …)
> 
> Those can cover recently available technologies, ongoing work, and new ideas.
> 
> Important Notes for Speakers:
> 
> All speakers are required to adhere to the Linux Foundation events’ Code of
> Conduct. We also highly recommend that speakers take the Linux Foundation online
> Inclusive Speaker Orientation Course. Avoid sales or marketing pitches and
> discussing unlicensed or potentially closed-source technologies when preparing
> your proposal; these talks are almost always rejected due to the fact that they
> take away from the integrity of our events, and are rarely well-received by
> conference attendees.
> 
> All accepted speakers are required to submit their slides prior to the event.
> 
> [1] Submission page: https://forms.gle/yQeqyrtJYezM5VRJA
> 
> Important Dates:
> 
> CFP Close: Wednesday, September 30th, 2020, at 23:59 PST
> Speaker notification: October 10th, 2020
> Conference: Friday, October 30th, 2020
> 
> Questions on submitting a proposal?
> Email Daniel Bristot de Oliveira <bristot@redhat.com>
> 


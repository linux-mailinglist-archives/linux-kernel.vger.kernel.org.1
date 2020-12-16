Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC32DB7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLPAf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgLPAfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:35:52 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572D6C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:35:12 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id w18so8472317iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=yU9Nd85ZijlLkYOsc1l3qZ7RJHr92aND+i+7Yi2A0nU=;
        b=nk2iSdN+Z0GEkCUAECJpzd/3yG54Q61/+lnFNDEexZGnSWrthOzGGV6L6qQcVMlWcm
         3a1o4/H6ipESZ3+LnEbTe8xqqyVh7mlZ1z2P2oZ3zGGqpXqUM8KuwyeI3ZmGAwlwKJXx
         u4vcjpm4gY7UpAgDkqPfEFA4k33FPwNvrqQMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=yU9Nd85ZijlLkYOsc1l3qZ7RJHr92aND+i+7Yi2A0nU=;
        b=QBmEyssCBjAhUYwr7sO9uls1P+YvWkt0HtF3Jdz/bs9I7RgyTbqyANpwWF85v+5wVA
         jqeErMxQtliJkHPyk7G8I3mBhc7LFFL5xZYqwYo8qba7hexzpjC1lGZ4hPMAz4CBvTJS
         Yu8tSuKNe796pDqOypjd+g7blB2a+vQ210/L5kmaqUfpNX7Di2y1ShmNBe+lJaAcWjZU
         Bi6LCNSrJJEzTl0NTuMTmHr0QUsTTK/vTkwK6EmUrrAjZgsJh0hiI5b6Escq66Urj39E
         iEVjRrOh+PH3untHArP+lHvUflz9ZQkyZY2CgJmN4EziZ+jX2+zMJcr1OgkAtZI2xZ+i
         1dRg==
X-Gm-Message-State: AOAM531LJboB+Q3Tt5arxfsD7GVL/30pUUjGtQB2gmBo7x3d5BT3qIao
        zg5NkSQP1HChHXAEUngMkcRxxZMA112myXX7gh+G0A==
X-Received: by 2002:a02:c4d5:: with SMTP id h21mt42666900jaj.23.1608078911663;
 Tue, 15 Dec 2020 16:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org> <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <20201206173418.GC201514@google.com> <20201209185203.GC6876@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <X9e9dcLMrMJThZs+@google.com> <16a390e4-b44d-b0eb-1df6-6e56d78d009f@oracle.com>
 <20201214232541.GF201514@google.com> <796ec1e5-15ef-34da-5716-0ec19432deba@oracle.com>
In-Reply-To: <796ec1e5-15ef-34da-5716-0ec19432deba@oracle.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 15 Dec 2020 19:35:00 -0500
Message-ID: <CAEXW_YSSWFvre17RMb0twtAygFnYiOtW7EeYxMKBDTSQ+UZhrQ@mail.gmail.com>
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling interface
Cc:     chris hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        Alexander Graf <graf@amazon.com>, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        OWeisse@umich.edu, Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dhaval,

On Tue, Dec 15, 2020 at 1:14 PM Dhaval Giani <dhaval.giani@oracle.com> wrote:
>
> On 12/14/20 3:25 PM, Joel Fernandes wrote:
>
> >> No problem. That was there primarily for debugging.
> > Ok. I squashed Josh's changes into this patch and several of my fixups. So
> > there'll be 3 patches:
> > 1. CGroup + prctl  (single patch as it is hell to split it)
>
> Please don't do that.
> I am not sure we have thought the cgroup interface through
> (looking at all the discussions).

Unfortunately, this comment does not provides any information on the
issues you are concerned about.  If there are specific issues you are
concerned about, please don't keep it a secret! What requirement of
yours is not being met with the CGroup interface the way it is in v8
series?

thanks,

 - Joel

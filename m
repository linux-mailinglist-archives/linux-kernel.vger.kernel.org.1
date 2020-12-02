Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FD92CC7A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgLBUVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgLBUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:21:34 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62F1C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:20:53 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id g19so1365295qvy.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=aj7zikfociwcKr6VGphiYIZ8rc665LBf4u7f617m8kE=;
        b=n/zZJtm7n5sa6dwUDkqyAEHqr/PViZlkWneUEVRRE9J7qlT6SEGJmJvmqUdDW+JR+T
         s+cD1eXzNCyKAoElzdabttMfDbV7qG8GcwMTm12kwHRGuTHsWtZ+mia3KD1Tg534QKyT
         OopetEiPDs0dU8/pSCwxnWUxa5s3RmsH6gP97z/3GeGmfwq0RM8i7l4NuzKcVVNuRxMM
         +z3ovi+Ukh56I3ih9IYGzuMW6byxrQbgKjfjg1GfPeAG/xmpWIPQzuZldmWuCqOjXrZ9
         /fxLSzgdoIgG1XKR9V6TpIocayT5u6dLnhhixywPtHfOLAzOQqxKrEURZQ6/zQqHN5eB
         Ezrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:in-reply-to;
        bh=aj7zikfociwcKr6VGphiYIZ8rc665LBf4u7f617m8kE=;
        b=WWJWPbb75JqZJsBpEcDBQeULoOsFa3awCDju7bt2IL6hz4ywQvEruJ71Cgqn3CeOaW
         5Cprrj+8Rap+PSx5tVHA/R/WA3r+E9qx8Z+ez4VynBc/j90AhvKKuvmvVnksSVmXysKK
         gZ3lB9Eozbv7K02OqTqVAKooWPsjnlG2Q5Iac+EmcqHr6CdrFtCSQIs8xRqBu6tJlyUW
         UEtj7+7AUTcvfvR5NT2GVK5kspGFxuXVZMTTQeqdeND1Vw8tdpZy+flk6EKv5PqLSRvA
         RABK6E+UdlxIBgji/I9vuUSfMdl6Ui0/oXAdJ7PPxiJwQuCjshnNNmvyBCtr2dS0iPlH
         J50w==
X-Gm-Message-State: AOAM531TVkzeV2r3d9nqeVbVTPKa0rjrWEgqyC0Gy8Smd8nDKTWR0gfa
        CqcmPQAnRFGJvPXKgQnXQVA=
X-Google-Smtp-Source: ABdhPJz7smZ4bg9M3d7RHvZOaE7BxC09JYYiK8er2jAUeG9o73jqv6IzmdWlxeHZ+hZk9lrN8zPRGA==
X-Received: by 2002:a0c:a992:: with SMTP id a18mr4320506qvb.21.1606940452966;
        Wed, 02 Dec 2020 12:20:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id v15sm2739138qti.92.2020.12.02.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:20:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 15:20:24 -0500
From:   "tj@kernel.org" <tj@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Message-ID: <X8f3CBeHAJwl8Dx4@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ima1ndwz.fsf@notabene.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Neil.

(cc'ing Lai)

On Fri, Nov 20, 2020 at 10:07:56AM +1100, NeilBrown wrote:
> If the workqueue maintainers are unmovable in the position that a
> CM-workitem must not use excessive CPU ever, and so must not call
> cond_resched(), then I can take that back to the NFS maintainers and

Oh, that's not my position at all. I'm completely movable and am pretty sure
Lai would be too.

> negotiate different workqueue settings.  But as I've said, I think this
> is requiring the decision to be made in a place that is not well
> positioned to make it.

Very true. A lot of the current workqueue code is a result of gradual
evolution and has a lot of historical cruft. Things like CPU_INTENSIVE or
long_wq were introduced partly to facilitate existing users to CM workqueue
and definitely are silly interfaces as you mentioned in another reply.

I can see two directions:

1. Keeping things mostly as-is - leave the selection of the specific
   workqueue type to users. We can improve things by adding debug / sanity
   checks to surfaces issues more proactively, adding more documentation and
   cleaning up old cruft.

2. Make things properly dynamic. By default, let workqueue core decide what
   type of execution constraints are gonna be applied and dynamically adjust
   according to the behavior of specific workqueues or work items. e.g. it
   can start most work items CM per-cpu by default and then release them as
   unbound when its cpu consumption exceeds certain threshold.

#1 is easier. #2 is definitely more attractive long term but would need a
lot of careful work. I was suggesting towards #1 mostly because it's a safer
/ easier direction but if you wanna explore #2, please be my guest.

Thank you.

-- 
tejun

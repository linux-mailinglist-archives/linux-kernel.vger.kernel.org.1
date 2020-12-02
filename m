Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C492CCA90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgLBXbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgLBXbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:31:40 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67564C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 15:31:00 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id k4so93898qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 15:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZKIHGtuA3gRLQDXNr6MTzyQShpkGxfy4iPg0ZnOpJc=;
        b=HVZIZtD7by3oSo0VHfJUYl2rMpEQ2VLQwynmJg1HQ4JT/6WJb0AdIwABIY4nzMXNin
         8BZmRdybGi9r3NTYAfthPpt932sR7oaxa8IVdtKyx705UfvayJezzRBF5zgBJ6ZpBSjq
         kfPTVEelC1MIWLsXZnCJGPQyyI7SOICJ+JZk+Yt55j1zEBvugHMUXpddK3A/4WaA8X27
         egtzSVL00FZ5ujVnrK8wcHoqA8DiyIhjuOUipA8PPPEfrZJjoWn1Kk4eWqBvUNw7Qjmj
         MW4mO3omJ6+4PCJBBZPqnGIqeo649OBjAqVC9VIyupGFNLADyVxe5oFzGt6v5O9ITyz2
         XSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MZKIHGtuA3gRLQDXNr6MTzyQShpkGxfy4iPg0ZnOpJc=;
        b=Qa5iP5zPeqMVtUewubZq2RJ4bEhZtnUgxvU+Yz4ICw7vtfb20liCP636Ix73RLsHpL
         baRwZnl1jUmWXH0YoPJsHWq/IbTcHDhoDFOnpzkNfrYu5kFqlMCtCflxLIVXcSb6LeGf
         vlRbRWS1ODDho2RKrvctO1+yvkrzmUOhZ7TeftnLjN2ZjQyG9FqKm66AtLUUvlQ5FXXY
         R48rT2ynQqx8I1lKU5bDwcmR1JROJompVw6p/juB7wJWemCUxdND+DWd2RAsKlrbNeq+
         YyXlglbSAKB3KyhvAKFFx6lDnpVQ4K7DRL8heVwlLSnP/EWZ124f3F2jbcsO0U0rTVTH
         IYHQ==
X-Gm-Message-State: AOAM531ws4MWc6zmQsw5OibdJHOm6aH5jkzRmfRvJ97/mvdoQnAEvZKq
        t9pbmitwuGivhj6qm+sXPL8=
X-Google-Smtp-Source: ABdhPJzAKfrCry46Ge063OA0b5tvAqqwcRbzSeuc423xyKkyYGnaSvDDQkHJLsA80KnF3SrK+WwiCw==
X-Received: by 2002:ac8:75da:: with SMTP id z26mr650437qtq.36.1606951859531;
        Wed, 02 Dec 2020 15:30:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:ec0f])
        by smtp.gmail.com with ESMTPSA id o16sm219958qkg.27.2020.12.02.15.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:30:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 18:30:30 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yafang Shao <laoar.shao@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, dsahern@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, liuhangbin@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
Message-ID: <X8gjliMAsPYZFrU1@mtj.duckdns.org>
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
 <xr93lfehl8al.fsf@gthelen.svl.corp.google.com>
 <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
 <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com>
 <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com>
 <X8fkVcfztQtX2dRT@mtj.duckdns.org>
 <CALvZod4ZroEOwbiZ5aKTd28d1tva0YLWfLZTF-N-xXd_40rUsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4ZroEOwbiZ5aKTd28d1tva0YLWfLZTF-N-xXd_40rUsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 02, 2020 at 03:23:57PM -0800, Shakeel Butt wrote:
> > There've been some changes to cgroup ids recently and now cgroup id, ino and
> > its file_handle are all compatible. On 64bit ino machines, they're all the
> > same and won't be reused. On 32bit ino machines, the lower 32bit of full id
> > is used as ino. ino may be reused but not the full 64bit id.
> 
> __kernfs_new_node() is using idr_alloc_cyclic() which will return
> 32bit ID. If I am understanding this correctly the full ID is
> generated similarly for 32bit and 64bit machines but for 64bit
> machines the whole ID is inode number while on 32bit machines the
> lower 32bits contains the inode number. Is that correct?

Yes, that's correct.

Thanks.

-- 
tejun

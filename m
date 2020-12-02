Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39EB2CCA7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgLBXYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgLBXYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:24:51 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06549C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 15:24:11 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id r24so7403563lfm.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 15:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krM5ZtArJDh4CBdMqAGvzuDAxuZaaWPVN3dbTakwoQA=;
        b=rW70B6hJvfsQzem9DjSh5wXLcOFYSU1woEDzJDe+sxe/DK7kyOs4BekSpMmQdoqloC
         jII3L3g/91M0Il5/MoHlo5S1zYd1n0wjyH20YW2AQgoZERWxzDAIUjM2zu0cUwwT+a1w
         viw4Aq0NPxeNj4A/P0AQ6mKnU59maVXiyq/Tg8WiOnxWpJ6h2GxjUkv53DcRPMqy40au
         KVuTreXa3FHXocfjD9aI2HkDh7bkptBrrD/MQaKzGjktMHr3/gdoRjhw8eVZdfKB5lR0
         6R8Hy2YixzwGYH9GIRFDetJa8BTgN0xLRWFJWkdRp7tUhR7hxOYqcDCmSAm3MlvYmM/P
         nPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krM5ZtArJDh4CBdMqAGvzuDAxuZaaWPVN3dbTakwoQA=;
        b=oCqGADGO6i0s04j1kWgPPzXH+cTrUc3o+JBc9nEUfMQs9xongoazLo0iklLEAzo7mM
         R/1l7qxzS4Vdw83R6u9IMtmuWteMDhn7RzyDZ48/xSS0+uaPfC+uRqjrid2lHBvfo4Pb
         qWBXxlcSHYnn23X/76KKXHatCI2VvReMHm8reNZYP3VDURXBZW/B8pSOPebGf9+V+d81
         QFVNatSZsBgMk353RjE7CeJV/Wu4J+KQxnu6pn/KX2IEV7GD3A2pV8668C7skW0HiIeW
         6wjYqUP3R9MM2UhLha7O2qPRyEzb656ya1fZUZOI6/W3Z+tderRJVksUDPmTxiPQNdrG
         mjaA==
X-Gm-Message-State: AOAM533+ZEwmymDs7a7m6+qE0v+9Xq6ZEm3wp1QEmmAlePavJv/ujpMH
        SE3YkuwoPrzJ/BKX6MKG1nA/20Rgqv/87P1dp1FNrw==
X-Google-Smtp-Source: ABdhPJxEYAINYZmZJ8fCk9T3f9H7hIO21axcvhlNaEHyk4FC9gVxHTTZh/IgVa5ILT91KDY0+vhFH1bSsRswiwCQl3I=
X-Received: by 2002:a19:be4a:: with SMTP id o71mr167981lff.494.1606951449214;
 Wed, 02 Dec 2020 15:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
 <xr93lfehl8al.fsf@gthelen.svl.corp.google.com> <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
 <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com>
 <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com> <X8fkVcfztQtX2dRT@mtj.duckdns.org>
In-Reply-To: <X8fkVcfztQtX2dRT@mtj.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 2 Dec 2020 15:23:57 -0800
Message-ID: <CALvZod4ZroEOwbiZ5aKTd28d1tva0YLWfLZTF-N-xXd_40rUsA@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
To:     Tejun Heo <tj@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 11:01 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Dec 01, 2020 at 12:53:46PM -0800, Shakeel Butt wrote:
> > The writeback tracepoint in include/trace/events/writeback.h is
> > already using the cgroup IDs. Actually it used to use cgroup_path but
> > converted to cgroup_ino.
> >
> > Tejun, how do you use these tracepoints?
>

Thanks Tejun, I really appreciate the example you provided. I do have one query.

> There've been some changes to cgroup ids recently and now cgroup id, ino and
> its file_handle are all compatible. On 64bit ino machines, they're all the
> same and won't be reused. On 32bit ino machines, the lower 32bit of full id
> is used as ino. ino may be reused but not the full 64bit id.

__kernfs_new_node() is using idr_alloc_cyclic() which will return
32bit ID. If I am understanding this correctly the full ID is
generated similarly for 32bit and 64bit machines but for 64bit
machines the whole ID is inode number while on 32bit machines the
lower 32bits contains the inode number. Is that correct?

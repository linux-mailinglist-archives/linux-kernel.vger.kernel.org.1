Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1112AF1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgKKNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKKNWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:22:35 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BAFC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:22:35 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 11so1570115qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=x/Q60pfLuPWLPv6hX/jkwh8drVlnoc+vlgtJVcchKak=;
        b=eXy4ZUKMnn4GrduIy6g6TSW2Xs+a4O2883ah6wgIaSYjEhOmReuVImp9s0P0SgtUxD
         m+ytNjE4hh/UVGkTtBTD0B9pHywto+zQV2oOqf77xGesQyClFNgNyHEMM3I8JOoQi1Sb
         3xk5VPBwZ1uNq77etytCuo8hGN8If7nbcBXMNaB4ZwRy+xqQhbBPnFfGOFuk5kHsJj0H
         rQCQ03QEWVSGxNG6TmxhJp7PB7vtEpU6nvtDDZwouqCpemhpbXqecQK+XJpzFdkiezln
         iL9RzUMxFIdbcuZcYlf4HXGgXJkpxHe6IZ3tOjHJq6ZvMpHLqMiBBUo5YRL0OnYQHwBO
         12dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=x/Q60pfLuPWLPv6hX/jkwh8drVlnoc+vlgtJVcchKak=;
        b=I/+U+F+HVkpf1JK/wOPGvwFRrCF2zex5wCr7WaCRc/PrUKqPCPLbxjAqpI1ajSG6u3
         lXm6Xs8cvttA0+cqlLA8LPNEUF581eWCPdr543+2KEHjWo4l1nWeG14epFqEwUbMWQTq
         I/xV/7qE8kIijzeFufFapruiecuK0PxkRV2gEsi+lS6Du4Dk47hiJyRuqOdOIqHC6uOe
         RQs9AournomMAGMivujPHFmr3U8eTJ2F5ypldPoseKugjCkUf8aNIvt+z1bupo8m9yiJ
         VSMPztQwSb9H9cAJB9F8kR69wHmUYXl5Y1+LS9x5YiTJyi1gCSQdA/j/SfitvlD4YBOE
         8yDQ==
X-Gm-Message-State: AOAM532OB9bJQo0M8KAlTP4vwyjQ+vdMnWR3ViUpNsmDyXz091O0DOs1
        +6GzTpuzCc1ofy4Qabjql1IW/o2No3v1UucP4ZF5Tw==
X-Google-Smtp-Source: ABdhPJytp8qk0/tBKQNwejB7g7hac4aTbtfWdQLmjza31MLnM8KNfxoRLAP7csVzsyLasBOZ/Gdx7HgXnyD5DyKpt0s=
X-Received: by 2002:a37:49d6:: with SMTP id w205mr24951520qka.501.1605100954534;
 Wed, 11 Nov 2020 05:22:34 -0800 (PST)
MIME-Version: 1.0
References: <00000000000054c0d105a0328487@google.com> <00000000000074076405b0f9632a@google.com>
In-Reply-To: <00000000000074076405b0f9632a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 14:22:23 +0100
Message-ID: <CACT4Y+a4VWAe4ED7v5+czPc39TATu_ARw6erMikKM8AwpFWYsg@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in uhid_dev_destroy
To:     syzbot <syzbot+0c601d7fbb8122d39093@syzkaller.appspotmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 6:54 AM syzbot
<syzbot+0c601d7fbb8122d39093@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit bce1305c0ece3dc549663605e567655dd701752c
> Author: Marc Zyngier <maz@kernel.org>
> Date:   Sat Aug 29 11:26:01 2020 +0000
>
>     HID: core: Correctly handle ReportSize being zero
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b82f50500000
> start commit:   152036d1 Merge tag 'nfsd-5.7-rc-2' of git://git.linux-nfs...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=efdde85c3af536b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=0c601d7fbb8122d39093
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ebad0c100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d6c21c100000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: HID: core: Correctly handle ReportSize being zero
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: HID: core: Correctly handle ReportSize being zero

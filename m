Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C846C26BD68
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgIPGmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgIPGmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:42:18 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FF7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:42:18 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j3so3006533qvi.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XhbFoRt7RLTn++aQK8Wkv7CgYgyz3yvURMx4NGMT3sk=;
        b=NntKN76bELN/x0Lk2AGwESb0KC+WOEDgdTNTEkisRL9NwFbarbnNORLddmx63oxN+F
         Vxa6XphwvrcrY9Mz7bddtpQrnnEkhzAAYpHrD0TgaWtG5eiUQoRtU+5y1JAHMXWHcoIv
         MnyULK6TeWEEnRqgNCi1roF3LqFz6T2lxjwEMrJKoqmWf6UpP7S0HyOWnmY5e5O+AEbI
         OczBIEfQsLk4XdpRDrBBPcRTG96dZyU/t8dck5IknpFNrf8bCLRHfS6XKPSj3YfkKOwT
         kSwWbaK5ppi9jXW9lpF3/H7AhXUNyHbgfl960PoRMNuhrFbGQtbX3HDvfOjie6MbR8RE
         BDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XhbFoRt7RLTn++aQK8Wkv7CgYgyz3yvURMx4NGMT3sk=;
        b=cc8nmcAlyYiOoTQlx7aQnBORDeHPpcd2TiXlyVEKmmUKVjGiGzNopa2YnCb70UkYwH
         xvr8UklpFiDJvtuZkar0+LnajLSpWLIfiC+jMcXKKAING7b9uEvttTHEPm2zFtBFX4Ip
         6u4zRFAitShLJneNcWYktcwgpGBNITwygCe5FAAcbC0cLrlbouhER4Sv/MqzRS2NBM3t
         IAqIWFKroSrD6Q/gcPZLdSgtJtiRhM8gIfkxSFpMrGCgl3MjBKKuGZtJlLgN3dHIR/3e
         ScY0XB7L/kcRMln4K0Wa++y9o117nBDHEuNBnWKqJf66pKdZRUTj4dRvUCmx4aZxGhbN
         Pu2g==
X-Gm-Message-State: AOAM532f4RuaVU90FOUeB5qlcXgUUCk6RODnx66mFLrBac1urq3NYZsr
        sCdZcN+XOEHg/zCiJgt7vND8nvaXPbLRgEHYomD/0DuVRANfeg==
X-Google-Smtp-Source: ABdhPJwSHSRWeVSZ3VmvdckqoWENJo1rARcPnkehPZzTz93KkSDzguyDEVt04VpXVe/ApRn5fI+UzzGRa4odjqgXbng=
X-Received: by 2002:a0c:a4c5:: with SMTP id x63mr5477660qvx.58.1600238536928;
 Tue, 15 Sep 2020 23:42:16 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Sep 2020 08:42:05 +0200
Message-ID: <CACT4Y+bYGnyqBH4a29wR_02Skw3LW8GNGJNz94_WupK8fy6ObA@mail.gmail.com>
Subject: Providing machine info for reported bugs
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     syzkaller <syzkaller@googlegroups.com>, kernelci@groups.io,
        KVM list <kvm@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We've recently added a feature to collect some machine info on syzbot
and provide it with crashes, in the case it is useful for
debugging/understanding what happened.

Here are 2 example crashes, check out "VM info" column for crashes:
https://syzkaller.appspot.com/bug?id=7f42f0f8b84628785150a192bafc24fca25e817d
https://syzkaller.appspot.com/bug?id=7c451a21f5159f1993ed44bcbacd5018e4428219

And here is a direct link with a sample of machine info:
https://syzkaller.appspot.com/text?tag=MachineInfo&x=873d2426f38045aa

Currently it includes only /proc/cpuinfo and some info from /sys/module/kvm*

This was a long-standing user feature request, in particular for
debugging KVM bugs (may be highly dependent on HW):
https://github.com/google/syzkaller/issues/466

So please be aware of this new feature. Currently it's only shown on
the dashboard, we decided to not pollute emails with it yet.

What other info may be useful for debugging of bugs in your subsystem?
We don't want to dump just every bit of info in all sysfs/debugfs/dev
(can be gigs of text). But if there is some critical bit that you
really need to know for debugging of bugs, we will try to include it.
Basically: if you are receiving an external bug report, what info are
you generally asking for?
As far as I remember +Takashi asked for something in the past, like a
list of sound devices present, but I don't remember exactly what it
was.

I've added kernelci@ because such a list may be useful for other
testing systems as well. Is there a prior art on this? LKML is not
read directly by lots of people, so if you know who may answer this
question for a particular subsystem, please CC.

Thank you

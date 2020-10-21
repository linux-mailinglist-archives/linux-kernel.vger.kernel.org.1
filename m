Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E123294710
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 05:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411843AbgJUDuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 23:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732257AbgJUDuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 23:50:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760E5C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 20:50:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i2so916510ljg.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 20:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/mlH7Rkpa560PVMbUdTwC6pWnOxYOo+/fb/Tvvof+c=;
        b=VDLrprWiZQP1zgfYnCdWehDecFvFE8lLk2598g65QwFqRqjJuAbNrrsyUbHO3TBBiA
         RNeEvd75eXYxluuk+Cu/HNJrmvtIQzlDNm7VEbC7jTnP5bVTXKpvnrRvr7/bAVwBS91N
         /NvldJ79ishaAK9RU5azOKXGhwt5Kq6uWfg+atxycc3yqJ3RTZKrRPuRNVkeGtOBakA2
         a//YGod/Ht5R29AqDJTt/yE1D0np2h2h2RA5SjOEMuepkEeG5Lqp45fOTjSrv6lxtp9Y
         NWdkX7ClsfOqlN0kQmn7kX5jxGTJu8V3XEiTl7WEHSvgM493TBWo9XOqJZDXH5SIh4Wo
         RT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/mlH7Rkpa560PVMbUdTwC6pWnOxYOo+/fb/Tvvof+c=;
        b=gtcg2c6Jox4ujqS2xgP3MPWyA4q4Q6Y/A5FXDvib2xQjKXjYybPzee/h0hQ6Liv5RA
         S201+wuMQ14N02fLlKqLRSBDoTC2fdkJRcvbmdayObNVgUqxQndq+cJ9GXOoDIzFbu3c
         +SBWpSucyCAi6485eZ77vP4utgBhLsVDVSmKZSzZ0XS5t8V5i9kUrQe0rAqI4WDg1ayZ
         uQPUOeE54MQB0Rbxc65IV3JpCSwc5GdbRmXQdIW5A7tNIApjNgU/RitfEhQMHpc/aq6g
         7SkaGrzDDlrmZlYZ300wnPxajZXOqp8jARIhHzgeVekskAl5ZWjNEYtOeHxh2vVrnkkp
         GURA==
X-Gm-Message-State: AOAM531WkLsUNuv26tL6MOLVzWYVhrYFX/+A0O88Fv6mZ8UrvkR2wbe8
        ZwKxjdECo10Foc2Nok0+NBRujs0wVOAHBvqMOp5feA==
X-Google-Smtp-Source: ABdhPJwp/7M/XgPSYhhApxLoSbfNbAEmtcui4MpeS5LXnKrtmlOBsQfsmhZEIWsjp4lufL41ROXzGdDWeIK5Oyx0wtU=
X-Received: by 2002:a2e:7c0f:: with SMTP id x15mr412496ljc.401.1603252213693;
 Tue, 20 Oct 2020 20:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201020055856.1270482-1-davidgow@google.com> <87d01die4o.fsf@mail.parknet.co.jp>
In-Reply-To: <87d01die4o.fsf@mail.parknet.co.jp>
From:   David Gow <davidgow@google.com>
Date:   Wed, 21 Oct 2020 11:50:02 +0800
Message-ID: <CABVgOSkQRvRSr-c1FKG+GDr5ewV+FJ-unZbtNvQLayoT6FmBtQ@mail.gmail.com>
Subject: Re: [PATCH v2] fat: Add KUnit tests for checksums and timestamps
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 2:51 PM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> David Gow <davidgow@google.com> writes:
>
> > diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> > index f1b2a1fc2a6a..445ad3542e74 100644
> > --- a/fs/fat/misc.c
> > +++ b/fs/fat/misc.c
> > @@ -229,6 +229,7 @@ void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
> >               ts->tv_nsec = 0;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(fat_time_fat2unix);
>
> Hm, can this export only if FAT_KUNIT_TEST is builtin or module (maybe
> #if IS_ENABLED(...))? And #if will also be worked as the comment too.
>

That's possible, but I'd prefer to export it unconditionally for two reasons:
1. It'd make it possible to build the fat_test module without having
to rebuild the whole kernel/fat.
2. It'd be consistent with fat_time_unix2fat(), which is exported for
use in vfat/msdos anyway.

Neither of those are dealbreakers, though, so if you'd still prefer
this to be behind an ifdef, I'll change it.

-- David

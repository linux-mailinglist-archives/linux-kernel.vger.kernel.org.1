Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CC92D347E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgLHUqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLHUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:46:16 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66CBC061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:45:35 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a12so10819912wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRNFKtChjq2P9zZPFMG3JUrl4JmCeOXYmonD/57lU9k=;
        b=hiDQD5cLQpdIKh3uMG64fowgcYfUc6YbH6tg/zLJZLM+/tbhqmnB1Q4u2MqqgIh5Hk
         LI6VUKmcpRJh3STxgUirRcWG9Uzs00BQrSCbr2tbGrZhJKCRbyhCpZbDG9YeHc4lFdpg
         +YuPwd/DRZyUfofAUmY/lhI20/mBDzy04eyWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRNFKtChjq2P9zZPFMG3JUrl4JmCeOXYmonD/57lU9k=;
        b=GDmHboAY7sIc8tfWz/Kl39p8zcCpD251rCDTBe8vOfGk3LF/eTiOxos//0voJok3Tv
         wO1yiTV4QyDvpRkk42V3myNY+1/vGuJRcPq1yY/bgFt8mcnKXFKAXkjPVZH+1K/9+K75
         G6moleUWPt8l0/I119M75pH6F8Ch0KprDkhTSzC20cp4lMpIIu/VMYeiMQ3W9P/35HSk
         NIESzT0VGZzYZVtjMKv5/kZm6u0eC6ufGRugutpuZqjaS5i6T4DU6IKyNJZLRtkeCV3n
         K+ARlkVHNY03yw3Ij+eC/AVOp0BBTrMd4osPbe1md0tTGUhXTo/uTDF9I+CLjOqZM3MD
         kt6w==
X-Gm-Message-State: AOAM532AQkuW9VLdlHzN+GcglgPWXb8U/Ian4lYwzN5s7A9bVLVSUJ1e
        eGD0ncONiMlnkOh1vja0kgF39gFjPISZTw==
X-Google-Smtp-Source: ABdhPJyWP9lK6BpRNG4xZRdMgB/pdHOnFvl/Cp+wbF5UDn+T65RTWzQTmBvsFS56E+FjJFFXgtSFgg==
X-Received: by 2002:a17:907:1004:: with SMTP id ox4mr24065069ejb.240.1607453088371;
        Tue, 08 Dec 2020 10:44:48 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id ak17sm2631285ejc.103.2020.12.08.10.44.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 10:44:47 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id r3so17316320wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:44:47 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr3217172lji.251.1607452656546;
 Tue, 08 Dec 2020 10:37:36 -0800 (PST)
MIME-Version: 1.0
References: <87tut2bqik.fsf@x220.int.ebiederm.org> <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
 <875z5h4b7a.fsf@x220.int.ebiederm.org> <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
 <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
 <20201207090953.GF3040@hirez.programming.kicks-ass.net> <CAHk-=wjgG=_-zONkBkKnkOv3uoVRy45hTxx8e-6Ks3j-3TVHKQ@mail.gmail.com>
 <20201208083412.GR2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201208083412.GR2414@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 10:37:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsvzafKL-_1V5NXMkS5CzYDnTP8Aev5SuZ=SA6e_m61A@mail.gmail.com>
Message-ID: <CAHk-=wgsvzafKL-_1V5NXMkS5CzYDnTP8Aev5SuZ=SA6e_m61A@mail.gmail.com>
Subject: Re: [PATCH] perf: Break deadlock involving exec_update_mutex
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 12:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I suppose I'll queue the below into tip/perf/core for next merge window,
> unless you want it in a hurry?

LGTM, and there's no hurry. This is not a new thing, and I don't think
it has been a problem in practice.

            Linus

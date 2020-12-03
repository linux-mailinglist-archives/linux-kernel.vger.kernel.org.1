Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5932CD204
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbgLCJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387589AbgLCJEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:04:35 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD45C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 01:03:54 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id a1so355672ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 01:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhzuWzYqx4wOucxDbIvfmv+m/R4IcPiign7gbm/9qCU=;
        b=P3l5kbkLjCiESw63nk6Vp1bx6Hj4JKjDgJKynkHy24GRDPRkiv9JmR4sOZJPDAiwLc
         PhcV4gvjkG5TjLEAc2PzuFIdTKJlRhUTKhL24bw8dygHBAA4L17VlB+kayFUZ45dM/MV
         3DqdVND8lFahHbq2Q9oz5tMP0/aezVlVq444bLAs9SG3t9mbtwuoyboT/1KTww8tLs/s
         xJu0PVW/aXDDXMuD38Du786KILPldIc3BZv+hYeHagXsGHzm+i8cLtsGZR9f8pu8+HYm
         dIkQ+0oNLnOx5jPKE+Hyj7ym/BqqIbnyKp9+no5wuG1wPkFnP0s4E7WpEqk0+q2iYdsW
         RYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhzuWzYqx4wOucxDbIvfmv+m/R4IcPiign7gbm/9qCU=;
        b=VdUMpj/a0QA34zb9fsyx9cOKZzGxMqsx4bYNaYiamOmevKzxE71pLEp6EUye/OTClR
         1iWQGk8TxjGEYNB3c+RzDgdUEXr0aaHQnHMMlNQATOysJGcrrxopz6oUx3WDOQaEA2C/
         gxx69Dr8/yg4It4i+Yh/kCKCfh6huipDwTuLxClWNFXVxqiDEpdSG0t3D6bqz83JxbJG
         PIT/D+mAnDMkTgfEYi+3g9r/BHNe/EFsjOLcVgJ0uP/K7ZOQ8xPMPk25U8DGKgfz3vsa
         q20cACZJSgJmyIjSlmlxfavng0o28RRmBWZpGDYaJQWZwvLpQOfa2ZDn9/lYCvrll8SU
         WTag==
X-Gm-Message-State: AOAM531F3ecKFF+zTifKpIL1yAhBw8J64sjOHTLHaFLvCLUTkPmZC3/J
        YbQNJmQ0vSvLB0KzvM1fXHWm7LHwYCH70mhi6nm+dQ==
X-Google-Smtp-Source: ABdhPJzoYEfnqMDRgKUHfbMqAmXCpsqAIGlbh1OszWZfI2PwPDDG4UjOylPpMG89HfXtXeiVb0z5eOqRtHR/i3KGkG4=
X-Received: by 2002:a2e:918a:: with SMTP id f10mr813470ljg.156.1606986232761;
 Thu, 03 Dec 2020 01:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com> <CAKfTPtAppZFdku6k3cA=kNYKjU5e7w4A+E3R5_m11z+jy_WCBw@mail.gmail.com>
 <f9d9c6e959e441ec94264891ae90c11d@hisilicon.com> <CAKfTPtDqpQBcjq03cJEKN99XOZdNuV560ja9S-oZzkq7BToR8w@mail.gmail.com>
 <414fbd167b214452b925ac674575f0d6@hisilicon.com>
In-Reply-To: <414fbd167b214452b925ac674575f0d6@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Dec 2020 10:03:41 +0100
Message-ID: <CAKfTPtALPjSvOZ2xf9cka9R-1uqi3AHQ+GYy7asT3wfvmLqaXw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Cc: Len Brown" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 at 21:58, Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
> >
> > Sorry. Please ignore this. I added some printk here while testing
> > one numa. Will update you the data in another email.
>
> Re-tested in one NUMA node(cpu0-cpu23):
>
> g=1
> Running in threaded mode with 1 groups using 40 file descriptors
> Each sender will pass 100000 messages of 100 bytes
> w/o: 7.689 7.485 7.485 7.458 7.524 7.539 7.738 7.693 7.568 7.674=7.5853
> w/ : 7.516 7.941 7.374 7.963 7.881 7.910 7.420 7.556 7.695 7.441=7.6697
> w/ but dropped select_idle_cluster:
>      7.752 7.739 7.739 7.571 7.545 7.685 7.407 7.580 7.605 7.487=7.611
>
> g=2
> Running in threaded mode with 2 groups using 40 file descriptors
> Each sender will pass 100000 messages of 100 bytes
> w/o: 10.127 10.119 10.070 10.196 10.057 10.111 10.045 10.164 10.162
> 9.955=10.1006
> w/ : 9.694 9.654 9.612 9.649 9.686 9.734 9.607 9.842 9.690 9.710=9.6878
> w/ but dropped select_idle_cluster:
>      9.877 10.069 9.951 9.918 9.947 9.790 9.906 9.820 9.863 9.906=9.9047
>
> g=3
> Running in threaded mode with 3 groups using 40 file descriptors
> Each sender will pass 100000 messages of 100 bytes
> w/o: 15.885 15.254 15.932 15.647 16.120 15.878 15.857 15.759 15.674
> 15.721=15.7727
> w/ : 14.974 14.657 13.969 14.985 14.728 15.665 15.191 14.995 14.946
> 14.895=14.9005
> w/ but dropped select_idle_cluster:
>      15.405 15.177 15.373 15.187 15.450 15.540 15.278 15.628 15.228 15.325=15.3591
>
> g=4
> Running in threaded mode with 4 groups using 40 file descriptors
> Each sender will pass 100000 messages of 100 bytes
> w/o: 20.014 21.025 21.119 21.235 19.767 20.971 20.962 20.914 21.090 21.090=20.8187
> w/ : 20.331 20.608 20.338 20.445 20.456 20.146 20.693 20.797 21.381 20.452=20.5647
> w/ but dropped select_idle_cluster:
>      19.814 20.126 20.229 20.350 20.750 20.404 19.957 19.888 20.226 20.562=20.2306
>

I assume that you have run this on v5.9 as previous tests.
The results don't show any real benefit of select_idle_cluster()
inside a node whereas this is where we could expect most of the
benefit. We have to understand why we have such an impact on numa
tests only.

> Thanks
> Barry
>

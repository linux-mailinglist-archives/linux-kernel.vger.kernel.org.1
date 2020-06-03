Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBD81EC821
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 05:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgFCD5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 23:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgFCD5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:57:19 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8418C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 20:57:18 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z47so105034uad.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 20:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+wo3dW8m0c+iQXJh08GxVTguCzxCF09qjrI8A5/q9So=;
        b=nD38w/MkQ1T5AjnPSo+Ast0pHABbPUSa+yH9Hbot28j7vRweO+uYQ061v6DyZL/MJr
         1A4CDvaPNxyznhRSX0DAqVBiZc9prX4x38bHATeYB5uCqxKQbT6Hm2m40T/Z4a2FgVN4
         mMYDCBYcqcNk6x72is7mCkhGOckKPpEhthuUmASEHtrJmrAZ0XuxN86AfDiKwrB8BXoI
         AaHMc4AO5OD2NkQc3uy1n7IDWmBB8SdbmMYKn0JCzlEU9c6vR777WFYB/BV5LM0dnfaH
         dbs85ftDFaJ/ge18rRfDdf3uY8z8XoiVSoud0w69M8T9SyH4Br3iUkv92TXSEG34rUch
         sqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wo3dW8m0c+iQXJh08GxVTguCzxCF09qjrI8A5/q9So=;
        b=eR8qtN19WhbDdeVRE8znY8fJW8zSVjSx7q0W6/JhzEIvVIcg4vScc4SQKTUREq8Lml
         dbRGSW2Ie2/a0ck1cKE4rUCIlhNuQFNiriT5UjS6+E0j8uURSI7ztWlaFujaCOssNg54
         4Phb0dojmg/JCMYFpYrc887i/+Gv4ihePmruCpAa4NAughC2p+w3Yqo+ag6qZ6xUcOqm
         CvQXggpStDtvRiodQH0RSNsWdFThBz1xz5WgIw8KI4fF2TGEuUY7d/rNNGucCyzQo8bU
         NN3Ul429LSuvWWBLOhNIEoUzdviw2kMpBh+9mCR1zBS2lIIrvKJKpZhCDZ7pXlFof1NG
         W6UQ==
X-Gm-Message-State: AOAM532Q2R21nrtelCCBFIyiubITOfVQ++yVY+lWghVjuJs9zBZdYyjq
        X+xxeyHksDDs3oYxVuG9Dxh9zsdRxfVozjUPUbHQgg==
X-Google-Smtp-Source: ABdhPJxnfZ9JWwfJzRclYZg4/BtDEjBVKi9MMY28iCIFFCs5HFMTdnTtpDHDKW0lF7K0VvWQ4CbRLf9V7VsB/OLV7+k=
X-Received: by 2002:ab0:2eb5:: with SMTP id y21mr5055545uay.92.1591156637571;
 Tue, 02 Jun 2020 20:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
 <f8b9b387-df30-d960-4833-ce6e7974a633@suse.cz> <CAAmzW4OsxZV-xRtPqXUVAoP+dM6SQSaw1E1EE+0Fw2fS1Z9K9A@mail.gmail.com>
In-Reply-To: <CAAmzW4OsxZV-xRtPqXUVAoP+dM6SQSaw1E1EE+0Fw2fS1Z9K9A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 Jun 2020 20:57:06 -0700
Message-ID: <CAJuCfpEgLkQUhwC4cpDjSr8a5vnX1ePzHa9Dz2Cy920vFjVRig@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] workingset protection/detection on the anonymous
 LRU list
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 5:50 PM Joonsoo Kim <js1304@gmail.com> wrote:
>
> 2020=EB=85=84 4=EC=9B=94 9=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 1:55, =
Vlastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On 4/3/20 7:40 AM, js1304@gmail.com wrote:
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >
> > > Hello,
> > >
> > > This patchset implements workingset protection and detection on
> > > the anonymous LRU list.
> >
> > Hi!
>
> Hi!
>
> > > I did another test to show the performance effect of this patchset.
> > >
> > > - ebizzy (with modified random function)
> > > ebizzy is the test program that main thread allocates lots of memory =
and
> > > child threads access them randomly during the given times. Swap-in/ou=
t
> > > will happen if allocated memory is larger than the system memory.
> > >
> > > The random function that represents the zipf distribution is used to
> > > make hot/cold memory. Hot/cold ratio is controlled by the parameter. =
If
> > > the parameter is high, hot memory is accessed much larger than cold o=
ne.
> > > If the parameter is low, the number of access on each memory would be
> > > similar. I uses various parameters in order to show the effect of
> > > patchset on various hot/cold ratio workload.
> > >
> > > My test setup is a virtual machine with 8 cpus and 1024MB memory.
> > >
> > > Result format is as following.
> > >
> > > Parameter 0.1 ... 1.3
> > > Allocated memory size
> > > Throughput for base (larger is better)
> > > Throughput for patchset (larger is better)
> > > Improvement (larger is better)
> > >
> > >
> > > * single thread
> > >
> > >      0.1      0.3      0.5      0.7      0.9      1.1      1.3
> > > <512M>
> > >   7009.0   7372.0   7774.0   8523.0   9569.0  10724.0  11936.0
> > >   6973.0   7342.0   7745.0   8576.0   9441.0  10730.0  12033.0
> > >    -0.01     -0.0     -0.0     0.01    -0.01      0.0     0.01
> > > <768M>
> > >    915.0   1039.0   1275.0   1687.0   2328.0   3486.0   5445.0
> > >    920.0   1037.0   1238.0   1689.0   2384.0   3638.0   5381.0
> > >     0.01     -0.0    -0.03      0.0     0.02     0.04    -0.01
> > > <1024M>
> > >    425.0    471.0    539.0    753.0   1183.0   2130.0   3839.0
> > >    414.0    468.0    553.0    770.0   1242.0   2187.0   3932.0
> > >    -0.03    -0.01     0.03     0.02     0.05     0.03     0.02
> > > <1280M>
> > >    320.0    346.0    410.0    556.0    871.0   1654.0   3298.0
> > >    316.0    346.0    411.0    550.0    892.0   1652.0   3293.0
> > >    -0.01      0.0      0.0    -0.01     0.02     -0.0     -0.0
> > > <1536M>
> > >    273.0    290.0    341.0    458.0    733.0   1381.0   2925.0
> > >    271.0    293.0    344.0    462.0    740.0   1398.0   2969.0
> > >    -0.01     0.01     0.01     0.01     0.01     0.01     0.02
> > > <2048M>
> > >     77.0     79.0     95.0    147.0    276.0    690.0   1816.0
> > >     91.0     94.0    115.0    170.0    321.0    770.0   2018.0
> > >     0.18     0.19     0.21     0.16     0.16     0.12     0.11
> > >
> > >
> > > * multi thread (8)
> > >
> > >      0.1      0.3      0.5      0.7      0.9      1.1      1.3
> > > <512M>
> > >  29083.0  29648.0  30145.0  31668.0  33964.0  38414.0  43707.0
> > >  29238.0  29701.0  30301.0  31328.0  33809.0  37991.0  43667.0
> > >     0.01      0.0     0.01    -0.01     -0.0    -0.01     -0.0
> > > <768M>
> > >   3332.0   3699.0   4673.0   5830.0   8307.0  12969.0  17665.0
> > >   3579.0   3992.0   4432.0   6111.0   8699.0  12604.0  18061.0
> > >     0.07     0.08    -0.05     0.05     0.05    -0.03     0.02
> > > <1024M>
> > >   1921.0   2141.0   2484.0   3296.0   5391.0   8227.0  14574.0
> > >   1989.0   2155.0   2609.0   3565.0   5463.0   8170.0  15642.0
> > >     0.04     0.01     0.05     0.08     0.01    -0.01     0.07
> > > <1280M>
> > >   1524.0   1625.0   1931.0   2581.0   4155.0   6959.0  12443.0
> > >   1560.0   1707.0   2016.0   2714.0   4262.0   7518.0  13910.0
> > >     0.02     0.05     0.04     0.05     0.03     0.08     0.12
> > > <1536M>
> > >   1303.0   1399.0   1550.0   2137.0   3469.0   6712.0  12944.0
> > >   1356.0   1465.0   1701.0   2237.0   3583.0   6830.0  13580.0
> > >     0.04     0.05      0.1     0.05     0.03     0.02     0.05
> > > <2048M>
> > >    172.0    184.0    215.0    289.0    514.0   1318.0   4153.0
> > >    175.0    190.0    225.0    329.0    606.0   1585.0   5170.0
> > >     0.02     0.03     0.05     0.14     0.18      0.2     0.24
> > >
> > > As we can see, as allocated memory grows, patched kernel get the bett=
er
> > > result. Maximum improvement is 21% for the single thread test and
> > > 24% for the multi thread test.
> >
> > So, these results seem to be identical since v1. After the various chan=
ges up to
> > v5, should  the benchmark be redone? And was that with a full patchset =
or
> > patches 1+2?
>
> It was done with a full patchset. I think that these results would not
> be changed
> even on v5 since it is improvement from the concept of this patchset and
> implementation detail doesn't much matter. However, I will redo.
>
> > > * EXPERIMENT
> > > I made a test program to imitates above scenario and confirmed that
> > > problem exists. Then, I checked that this patchset fixes it.
> > >
> > > My test setup is a virtual machine with 8 cpus and 6100MB memory. But=
,
> > > the amount of the memory that the test program can use is about 280 M=
B.
> > > This is because the system uses large ram-backed swap and large ramdi=
sk
> > > to capture the trace.
> > >
> > > Test scenario is like as below.
> > >
> > > 1. allocate cold memory (512MB)
> > > 2. allocate hot-1 memory (96MB)
> > > 3. activate hot-1 memory (96MB)
> > > 4. allocate another hot-2 memory (96MB)
> > > 5. access cold memory (128MB)
> > > 6. access hot-2 memory (96MB)
> > > 7. repeat 5, 6
> > >
> > > Since hot-1 memory (96MB) is on the active list, the inactive list ca=
n
> > > contains roughly 190MB pages. hot-2 memory's re-access interval
> > > (96+128 MB) is more 190MB, so it cannot be promoted without workingse=
t
> > > detection and swap-in/out happens repeatedly. With this patchset,
> > > workingset detection works and promotion happens. Therefore, swap-in/=
out
> > > occurs less.
> > >
> > > Here is the result. (average of 5 runs)
> > >
> > > type swap-in swap-out
> > > base 863240 989945
> > > patch 681565 809273
> > >
> > > As we can see, patched kernel do less swap-in/out.
> >
> > Same comment, also v1 has this note:
>
> I had tested this scenario on every version of the patchset and found the=
 same
> trend.
>
> > > Note that, this result is gotten from v5.1. Although workingset detec=
tion
> > > works on v5.1, it doesn't work well on v5.5. It looks like that recen=
t
> > > code change on workingset.c is the reason of this problem. I will
> > > track it soon.
> > What was the problem then, assuming it's fixed? Maybe I just missed it
> > mentioned. Can results now be gathered on 5.6?
>
> It was fixed on v2. Change log on v2 "fix a critical bug that uses out of=
 index
> lru list in workingset_refault()" is for this problem. I should note
> that clearly.
>
> > In general, this patchset seems to be doing the right thing. I haven't =
reviewed
> > the code yet, but hope to do so soon. But inevitably, with any changes =
in this
> > area there will be workloads that will suffer instead of benefit. That =
can be
> > because we are actually doing a wrong thing, or there's a bug in the co=
de, or
> > the workloads happen to benefit from the current behavior even if it's =
not the
> > generally optimal one. And I'm afraid only testing on a variety of work=
loads can
> > show that. You mentioned somewhere that your production workloads benef=
it? Can
> > it be quantified more? Could e.g. Johannes test this a bit at Facebook,=
 or
>
> I cannot share the detail of the test for my production (smart TV)
> workload. Roughly,
> it is repeat of various action and app (channel change, volume change,
> youtube, etc.)
> on smart TV and it is memory stress test. Result after the workload is:
>
> base
> pswpin 328211
> pswpout 304015
>
> patched
> pswpin 261884
> pswpout 276062
>
> So, improvement on pswpin and pswpout is roughly 20% and 9%, respectively=
.
>
> > it be quantified more? Could e.g. Johannes test this a bit at Facebook,=
 or
> > somebody at Google?
>
> It's really helpful if someone else could test this on their workload.

Please let me know when the new version (after Johannes' memcg
charging changes) is available for testing. I'll try them on Android
workload.
Thanks.

>
> Thanks.
>

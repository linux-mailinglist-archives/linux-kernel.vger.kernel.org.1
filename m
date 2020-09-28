Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378E027AC7E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgI1LQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1LQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:16:02 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D01C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:16:02 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id n193so1453781vkf.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aTg89kQFoPFyRernf7PS1jGsama59atD6k9bwAWjpAg=;
        b=MiBGoys98PDSrsPqkEjYTebINCZC/OCsP2P/n3pNkxhv7fqB7g26/SFOU14RuEuSAt
         9OQZPTba+C4p2ZHYyi8PKu1JKxOCue4a4ExjV1ZroKA6JRDd/cGseOvp5yoh2OQs5QCH
         yrPWHkjG0nj6oyh9rmLGHKZWMQ7w99a6K/GnRSPA9r85j2gUqVNac0sAKqAFHygeb3Lh
         w39ULubsP+AHTSDOInsc38BPCCn9+RqzwVRKFERZX5thhJ6P2621iJdn7590doKGEd6F
         wIG+k8A90CJ76d29GRlp0CYw4W73yRYc+8FopFmN0WHurnEK1455MtWuLJYfasOye2c+
         8+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aTg89kQFoPFyRernf7PS1jGsama59atD6k9bwAWjpAg=;
        b=ad/fIrI12kJ0qAnrQ49UvTCWJggS49M73ZGWGiuZwWTqv9SUaVm3FVg0gTfMIsy3N0
         LwMygSyawxCH+XS8459U5LvibQX4ppF+fKx4es2UQoFZNxvbKMz14aVUiWvcsHdxZGv0
         igBB7M1Mk6AP9fc9Xz6Rr0jLjFwUYzQXjLvDODbqpq3801KTlUT9lnzEDOEaTsdp1nUk
         dzDCrZ7gynuWbmnm1HH9zpo6nh0z4sh26d7TZVJ+Me9414JpYUNhzlOZj3uAiScaFirv
         AU/zP3aL4kZmzUEAFWsLCVsb7t9cKrP9nLuRXdB1KyiBc627XDN6pIhSm2UUNn9NbGdD
         5ONg==
X-Gm-Message-State: AOAM531p/kSaQetBezt2NgHb85JUsvEIydQsQTgybizQoVI5ZkfSsitz
        WdT+aNFUHjeAlgSMqvayXBZIdLPOjI1hY8cNf0Y=
X-Google-Smtp-Source: ABdhPJzVEobMEIZfcXTAraMdTx7qgV5GkDiQmwXNpX8WPDHdxeIYqiLaY3VCwfv3e+FOCq+7hE/RDyr1D+h3tQCSXsc=
X-Received: by 2002:a1f:a905:: with SMTP id s5mr4591464vke.9.1601291762051;
 Mon, 28 Sep 2020 04:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com> <20200928092039.GB2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20200928092039.GB2628@hirez.programming.kicks-ass.net>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Mon, 28 Sep 2020 19:15:50 +0800
Message-ID: <CAKc596KNqQg+EOu=dkbXnZYHw3011dvkWx6Y-PXnK_wDehfeZg@mail.gmail.com>
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing loop
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>, qais.yousef@arm.com,
        Uladzislau Rezki <urezki@gmail.com>, frederic@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 15, 2020 at 07:56:09PM +0800, qianjun.kernel@gmail.com wrote:
> > From: jun qian <qianjun.kernel@gmail.com>
> >
> > Allow terminating the softirq processing loop without finishing the vec=
tors.
> >
> > Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> > ---
> >  kernel/softirq.c | 113 ++++++++++++++++++++++++++++++++++++++++++++---=
--------
> >  1 file changed, 91 insertions(+), 22 deletions(-)
>
> This is still a ginormous patch for something that should be simple.
>

Yes, i think so. Because of the left pending bits need to be processed,
the code is going to be not simple.I will try my best to simplify this proc=
ess.

> I've put my patches (and a bunch on top) in:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git core/sof=
tirq
>
> but got a fairly significant regression report from 0day on that, and
> haven't had time/motivation to look at that.
>

OK, I am trying to slove the significant regression problem, maybe it
needs some time.

thanks

>

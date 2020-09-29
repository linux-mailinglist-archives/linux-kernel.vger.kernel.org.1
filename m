Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F08027DA53
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgI2Vmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgI2Vmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:42:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55792C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:42:33 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 95so5936498ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMTnP36m1E+SZKGnieI0HqsItuKWPP95HDOa71tExHY=;
        b=sqTAEiApfwK6y3dBXrTBGDsRMlig/5xp1blX9IQ1P9kPMe9P4XPvEmmiuFpI904VBK
         EepRFdv1GLma0uBXS2VxsusDvYSf3+zz5PorEPpzKL62RY9uNsUSgeEXBGhHy7BqB1JS
         rfJp+5szSw+GbzHbv9r/GHUtkSU346hnvdClgtCWjibRoqxArZg7yrb1mbw9Wh4s96vO
         rPxCeWVoowsc1/baJQK4cdWayZC64thgRiD434vEglVOgAKZRDUc/4r3WBPrAxZTBXjP
         aqtD8bnCHDfNMYGomCAJh3XibWqjMrRRNKGgKUbvCuRX5yQtr5fGqdeZM4I+yJGhSAtB
         wh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMTnP36m1E+SZKGnieI0HqsItuKWPP95HDOa71tExHY=;
        b=X8BaJcGV/MnZXkoHk1vdtidBe7A0ZQI7ZClb1d9z4B8fMIeBlp0oEWj8PCA2hnjjWV
         a6zyjGm8IJwslfyb+08fTumYYnYv35018rgYJulkW09tFzrGBkPb2OfeA9nkwXkTolAR
         8dEiwuq0bfhmFJIMnzEgCQUVVae4IkKrvcWZpW2lNkU2cnBagePggf1ZcRFmMj93m0wN
         wBnYFpY6khGubAhqxnsfzgwyzNaY3QHwnKqO0FCfFHp8ikug+n4acszQNMG8f172PPqr
         Oo1hAJkoSik9Er3jltEKVLDublQ9HwViW+48FavZVsfpUZhkCT1V095YUOBVKyELsIvA
         c0mA==
X-Gm-Message-State: AOAM530FSZZImrjbnClzV9ItxnZcIPm+ZLadXbHGknqw3woaf6bZ20UE
        FwnwImqWhLKHFZ9+nKWUQpTncPX0bNOnc015Drf1Tw==
X-Google-Smtp-Source: ABdhPJx8g4PsvrZ04THmOIZA5Pfv4k842ratMKMN/KX4T+3kFTxK7lR0xZLye4gsjw3mMz0xteoREAsuMU6FHRnds38=
X-Received: by 2002:a05:6830:164e:: with SMTP id h14mr4048466otr.56.1601415752426;
 Tue, 29 Sep 2020 14:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <1599731444-3525-1-git-send-email-wanpengli@tencent.com> <1599731444-3525-5-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1599731444-3525-5-git-send-email-wanpengli@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 29 Sep 2020 14:42:21 -0700
Message-ID: <CALMp9eRpo0pJ3sO-xGoEZf7ktWb07BvNoDJyaH0pQkE5EY_Yaw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] KVM: VMX: Don't freeze guest when event delivery
 causes an APIC-access exit
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 2:51 AM Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> According to SDM 27.2.4, Event delivery causes an APIC-access VM exit.
> Don't report internal error and freeze guest when event delivery causes
> an APIC-access exit, it is handleable and the event will be re-injected
> during the next vmentry.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

I'm curious if you have a test case for this.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D956F30463F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393630AbhAZRzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390489AbhAZIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:53:01 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7290C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:52:19 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id a7so8345376qkb.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version:date
         :message-id;
        bh=c/iSyicI1jKjDgDx3G8byoMSAaMzoSi+rlsTspd9Dwc=;
        b=Bu9kNcCuHzubvNWknI62kBBrIi8XHRfgrv7QE7xyLVK5IpXsQITQXr6hVuQH57dWHZ
         8Z+5bQFKf3h9pOOwpSZ9jKOi1PEA9dQsrUpGn3rDIO9xPE1joMgC1y40yU+NuvYI+Yv5
         rJQ6hlGzFPGlQfxj0GvySAzgtqJvA/uPUmXDsddcoo92ecY+RWnHITFWJTi5l8sAo+eN
         GA/WYAevepcKwDcL71QOLj7rh41jqKYR3pQEkUYa9vQzs6fMTytNYcwIL5ZuIl50sdGF
         O5I4if5t/+MgElgjV+ydmgj6BZ6MQ2MdiV9SbVcLeKdxugVWjk1m7ctkGZZvXmo4Wlew
         j8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=c/iSyicI1jKjDgDx3G8byoMSAaMzoSi+rlsTspd9Dwc=;
        b=riok9mkRB6Grc2INig6SQHPxKtntO6JTNOTnYHkag8/aoC0SJetQxesaTswm6yTQCg
         vIra9NtIZhTGCaXWJ91WJ4deTRFzs9GcQh7IiroeoV8tQijtlvfvEM6ncZeiCKjlKR5k
         cOFt6ivIyhDYucDjn/b5/Ww4z0kY4eyPeEVx9hheEWv4H96RENmZkS4b6BFU351iObx9
         SDojtEnj2O7FFSyFLJkHVX8/zmcfdOE13HQKyvsDHudTZLOYkmxJYaEeD21F7kUAOURW
         rLg5CDR28KwQoQKNOJpKs2GpF0JCLkfjlVjULajStO/AlJq0Rru0EAsvWbP348zzT+T1
         v5Pw==
X-Gm-Message-State: AOAM533Jd19rg+ZHEhZs0By3zeZtji2KjWqCYNm5WKRPphPn0CYqlTuv
        NRPB4EGIeL6FDdUijkPfSnNpVg==
X-Google-Smtp-Source: ABdhPJzYwyL1av4NPVYvuhQFfdbyTjcSM84hv0IXQGErXm6qkfipWAUDaEUX/bg+m7v0vYS5UKpX+w==
X-Received: by 2002:a37:66c8:: with SMTP id a191mr4743295qkc.48.1611651139075;
        Tue, 26 Jan 2021 00:52:19 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id o15sm3860016qtp.51.2021.01.26.00.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 00:52:17 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tibor Bana <bana.tibor@gmail.com>
cc:     Mel Gorman <mgorman@techsingularity.net>, Jan Kara <jack@suse.cz>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating 100% of my cpu?
In-reply-to: <20210125195438.c8d0e7980da0c2931d4f3056@gmail.com>
References: <20190126200005.GB27513@amd> <12171.1548557813@turing-police.cc.vt.edu> <20190127141556.GB9565@techsingularity.net> <20190127160027.GA9340@amd> <13417.1548624994@turing-police.cc.vt.edu> <20190128091627.GA27972@quack2.suse.cz> <14875.1548810399@turing-police.cc.vt.edu> <9618.1548822577@turing-police.cc.vt.edu> <20190130104020.GE9565@techsingularity.net>
 <20210125195438.c8d0e7980da0c2931d4f3056@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 26 Jan 2021 03:52:16 -0500
Message-ID: <178586.1611651136@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 19:54:38 +0100, Tibor Bana said:

> I don't know if it still actual, but I am strugling with this problem right
> now and searching the internet for solutions. I read the thread and saw that
> you are strugling to reproduce the problem, and I can reproduce it almost every
> day.

I'm pretty sure that you have a real bug on your hands.  Even if your box
is very low on memory, kcompactd should eventually figure out it's not
making any progress and wait for the situation to change before trying again.

However, I'm also pretty sure that it's a different one than the one we were
chasing, because that one never showed up again once all the patches landed in
linux-next, some 18 months before 5.9 was released.


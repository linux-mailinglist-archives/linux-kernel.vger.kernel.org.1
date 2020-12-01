Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDD72CAFD1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgLAWNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLAWNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:13:20 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E1C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 14:12:39 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d20so7749991lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNo0eDx11R5r5Mt473lP4z7j4i15NYf5XYAT5tq3Gc0=;
        b=S1Fq2hOV/kCBqQU8MqqsgrJxYn/JkHGSu3iKGGI7rqsYDk3nXp4Wmv7ymBiaVZjkfx
         x/R8OjysAny2WzYn+051zNfaEQTfvUkUSJlJmD5nwstVM8N11SsWolyE9NGkZjGd2qk+
         XAspcHql8KHCJhg6JN517UT+nt1ue0tzsTvrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNo0eDx11R5r5Mt473lP4z7j4i15NYf5XYAT5tq3Gc0=;
        b=FSpqjaOHIe4OxEN1oCe4Yw9vmtIh+d+lMziXzD7RPl/o1KX6X5SVGklERkpBMruaLl
         IQUedxSFZeLKPdevQsKlakqMD5GRFpeJrR6Oq72u3T8+N6BMUVjTlGsf9JHAMLVxEJAM
         sX4joMIGygWrpYeJzToBwBaGRItQGd1e1DxieQnwAVJD++bVt8V9re1P3qXZGpp8FExm
         qRt93yx48Y37v/26d9deqL5smhXvEK8xdnrp6EttzzwqHK5bFj/hCAJymvAayH/iieAI
         Y3UcsaFqPKGUiZJsb5SpiZVU+XAwSGEDlY4GieUFD0Z2PAs1aA5QSI8D/Sv5evTXDpyw
         Qwig==
X-Gm-Message-State: AOAM53046Hk+dYBRyzTDqudC6A2wvzclXQY6eIw49q2SgzdYtAQaooF1
        iFYuMLKJcoTsQVqqk/iekibHL7/U5c8iSw==
X-Google-Smtp-Source: ABdhPJxFClBcMBFP0PpomNDHovozGwlFbRvyfkS7p1pj+xCqVRHSu6wSaIRJeHLCFLTNs7g3BEkxQw==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr2069271lfa.541.1606860757561;
        Tue, 01 Dec 2020 14:12:37 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q26sm122859lfd.260.2020.12.01.14.12.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 14:12:36 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id d8so7857237lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 14:12:35 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr2023760lff.105.1606860755499;
 Tue, 01 Dec 2020 14:12:35 -0800 (PST)
MIME-Version: 1.0
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com> <20201201173905.GI143045@magnolia>
 <20201201205243.GK2842436@dread.disaster.area> <9ab51770-1917-fc05-ff57-7677f17b6e44@sandeen.net>
In-Reply-To: <9ab51770-1917-fc05-ff57-7677f17b6e44@sandeen.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Dec 2020 14:12:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjymrd42E6XfiXwR3NF5Fs4EhTzhUukCojEWpz0Vagvtw@mail.gmail.com>
Message-ID: <CAHk-=wjymrd42E6XfiXwR3NF5Fs4EhTzhUukCojEWpz0Vagvtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to filesystems
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 2:03 PM Eric Sandeen <sandeen@sandeen.net> wrote:
>
> That's why I was keen to just add DAX unconditionally at this point, and if we want
> to invent/refine meanings for the mask, we can still try to do that?

Oh Gods.  Let's *not* make this some "random filesystem choice" where
now semantics depends on what some filesystem decided to do, and
different filesystems have very subtly different semantics.

This all screams "please keep this in the VFS layer" so that we at
least have _one_ place where these kinds of decisions are made.

I suspect very very few people actually end up caring about any of the
STATX flags at all, of course. The fact that the DAX one was
apparently entirely the wrong bit argues that this isn't all that
important.

               Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F182DC8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgLPWWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgLPWWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:22:54 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AEEC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:22:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x20so32862764lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/v0hHuTQJANmvCHJQOT6cv+aYzklwaQBsw7a+SjqaAo=;
        b=Py++p8U61BKV5jezbYzGa5rfeT+dQm2cIzUuGb4r0JMdVqX1ojA8O+pRU+mKYywEyV
         a+CE1mT/C+ZVnAxn7nwMjoPp58+uu7IK+jXDueismZ2GvuLdTUn7IrhpsKsyOZWRLCKl
         o/rr8hG2wI46saGDp9+rsapwJDsoz8nogfugo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/v0hHuTQJANmvCHJQOT6cv+aYzklwaQBsw7a+SjqaAo=;
        b=JkVFTYOt662cvRY0fP9oW2LUc2acxg3uFEq+DNvbgnZRswL/DGeJ4Xe1prYZ7a/dDY
         i0Cs8cVKCwW6gVQjTmwpv9U65cL6VK40+nscQdYwk/KSNxj73IPIf7T6qsobprJkw1OC
         +/eMwNyd2frhwvanxin0GcyIl+GsWzGvcl1uijyiFxhajrkDlYOoRXe401WYbdbe0BAG
         ousCrgz7mHTBqPLR9mw9WeHJgzwpLazt1vQr6Bq9+DcSyzJlQvK5Q+8w/odcbc8uRbq9
         tQ8ILN1/cXuwo9zoP8oTPuXJoqIkXUe6Ix8Mq6v+mKr8Sc/g5k+rmSQhj79968XvyOGM
         hsKA==
X-Gm-Message-State: AOAM5317wnWglT4it0/3l8rpPVVcVnzydyuZCcE0fP5a099+wh3LaCJ9
        VN2FHgFezyXHZW8Pxn8SsxSK/wo24n4ElA==
X-Google-Smtp-Source: ABdhPJzpU1lTJoUb4uUgEsFJwaWFZeMw1+mnjYbmvQjP5byWZkFJkLGLzCkNV/59upzuXKlTYlkT+w==
X-Received: by 2002:a2e:8416:: with SMTP id z22mr15988346ljg.347.1608157331862;
        Wed, 16 Dec 2020 14:22:11 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d12sm428504ljl.111.2020.12.16.14.22.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 14:22:10 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id o19so26772244lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:22:10 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr12893163lfd.201.1608157330146;
 Wed, 16 Dec 2020 14:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20201214234518.GA14575@willie-the-truck> <20201216185352.GA16598@willie-the-truck>
 <CAHk-=wijH15u2KfpON3VCECQODAVNJ6DtgQajDaKo+PB_c-L3g@mail.gmail.com> <20201216221035.GA16915@willie-the-truck>
In-Reply-To: <20201216221035.GA16915@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Dec 2020 14:21:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg33UY7U_bDpMDjQh7HrHEZrjiiug0R==iH_Gh6ZAySTg@mail.gmail.com>
Message-ID: <CAHk-=wg33UY7U_bDpMDjQh7HrHEZrjiiug0R==iH_Gh6ZAySTg@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU updates for 5.11
To:     Will Deacon <will@kernel.org>
Cc:     iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 2:10 PM Will Deacon <will@kernel.org> wrote:
>
> Brill, cheers. I didn't realise you were going by subsystem, so that's
> why I was getting worried.

My "by subsystem" is a bit fuzzy, and it only really happens when I
have a _lot_ of pending pull requests. Which this merge window has had
more than most, since usually they come in a bit more spread out.

But when I have tens of pull requests in my mailbox, I tend to do them
by a very rough "similarity" metric, ie I'll generally bunch up
filesystem pulls together, but also pulls from the same person
together.

So it's not necessarily by any really strict subsystem thing, but you
can kind of see some patterns.

For example, today I started out with a group of audit and security
layer ones (and printk, which doesn't really group with much anything
else), then moved through virtualization platforms to some arch
updates, and then on to io_uring and block. Which got me to scsi and
rdma, and then iommu.

Not really much of a logical ordering really, more just me trying to
not be _entirely_ random.

But the grouping is definitely also about when things come in - I had
a different group of security layer and architecture updates on
Monday. The ones today hadn't come in yet at that point.

By tomorrow, my pending pile has hopefully shrunk so much that I do
things mainly by when they come in, rather than have a big pile and
trying to do them by some rough grouping.

           Linus

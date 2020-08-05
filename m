Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B955E23C723
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 09:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHEHqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHEHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:46:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB2C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 00:46:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c16so24944553ejx.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcRNpeqICVUMdW+eQV6cNmoTKrDCq48jfX1KaVHDvwQ=;
        b=Feg85hqy7+vcolCIrLFilOaGgrOtXj8thXykBp3Bp0XpYsuPfElOh4nm8I3SnyS62b
         64JD9H/zVxxGypHdTvYO2f1EJ0uPlTosWe53MpIC26xzA7XHbleGbFMLSSofhpx5X7gL
         6fThps3gz64rNFTjpg3m0BIu77PqTCGcRQciM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcRNpeqICVUMdW+eQV6cNmoTKrDCq48jfX1KaVHDvwQ=;
        b=IwdvWrD/h7UnKXBCliOJ8/bdV1m/8iKGvkhlll16gdKhm9iOKjSE2ygwAAD40xVOCD
         rsFUPkQfcGkTZe+FV79y1BjMUe+NsNZbi4cy3QC8WCY6DYRbjZPqkjnPFJ2H88eJmM8J
         VtM6UXRgXry5Dh9NCIGmkvZV/2BjSRmwdgItrVPAu6k00b1zIPnmTtLRwhqqPZgjrN/n
         woxs5hBSUlGgFj+QtPCQ6EK0hQB8HjR4+6ipIvLczKQbjPnaTFy7Mi32K2Zbp5rsW7An
         +BkeszBtK7X4JgZ+cKkJ/tPMxAcDB1w73z8nNlSAGQsHLP3nuH2LjAk7yYew0/w0tizU
         61Fg==
X-Gm-Message-State: AOAM5318u0gULML/sCdKRbmPR+DqB6TBKdOE7MIyRWeZ7vMDo3RXXmUY
        IMeyCZ53m0fIVuSs7WTj/v+qDziiXDqSXAYpdw43vg==
X-Google-Smtp-Source: ABdhPJwSzf7ZyfM06Ap8zJ46vCH2qMZs0q/mJf/FF/mKV8B2cn3vTn5+kSxcusIr/7oVCz9jGqzaVrb7ONfCeuEjpiI=
X-Received: by 2002:a17:907:405f:: with SMTP id ns23mr1832194ejb.511.1596613563524;
 Wed, 05 Aug 2020 00:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
 <20200804135641.GE32719@miu.piliscsaba.redhat.com> <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
 <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
In-Reply-To: <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 09:45:52 +0200
Message-ID: <CAJfpegs1NLaamFA12f=EJRN4B3_iC+Uzi2NQKTV-fBSypcufLQ@mail.gmail.com>
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:46 AM Ian Kent <raven@themaw.net> wrote:
>

> Coming back to an actual use case.
>
> What I said above is one aspect but, since I'm looking at this right
> now with systemd, and I do have the legacy code to fall back to, the
> "just reset everything" suggestion does make sense.
>
> But I'm struggling to see how I can identify notification buffer
> overrun in libmount, and overrun is just one possibility for lost
> notifications, so I like the idea that, as a library user, I can
> work out that I need to take action based on what I have in the
> notifications themselves.

Hmm, what's the other possibility for lost notifications?

Thanks,
Miklos

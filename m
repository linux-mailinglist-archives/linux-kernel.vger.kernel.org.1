Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B62304326
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391997AbhAZPzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:55:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389758AbhAZPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611675278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+sg4yNwZrAUtqGjsjAIZF/lC9W6Hi56SguvTv3qRusA=;
        b=AvAimHzoNnyt6HHce6CcX+chG4tX7GRBMoCQqfIxXhqI8JNTZLdVRQ5eCsiWDp3LoQW+Ll
        BeRU+iGXcpfeyr40dWf/CDbUTRRooyC2d0rayKu4vV7JNCkHFFE87e7d5qPvPql+tPM8IL
        LMZSLZtAFSNufeHw3Gm8odSA9k8MABg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187--fUI9n9MMnaSq1rXqoClfQ-1; Tue, 26 Jan 2021 10:34:36 -0500
X-MC-Unique: -fUI9n9MMnaSq1rXqoClfQ-1
Received: by mail-ed1-f72.google.com with SMTP id n8so9547222edo.19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sg4yNwZrAUtqGjsjAIZF/lC9W6Hi56SguvTv3qRusA=;
        b=fBzkrpO/Cj5U8xL/XBTegzWrt+XSs3DDYtYB6bwzQnXHOAYEJcXKhFhHDhYUDsbW0G
         LxlwciPxcOWxG0du7eL7nfK6hSkcrPxLuesvH38Sjski+sRMSS/1YS5hgSkLb/Lcbdrm
         dTGMf6AXgQj2hgTnZO1d3HqY1fGNma3gtDogKLOXDa9Nw3CDi2DcU0v6pd5oFJ1x4Y8F
         GjOSyms4EYfjkY45hKW1BH4uQECHNwdgFn81mvNJMhz/GyV1g0euUbw+pLln0wmUCi3t
         GVdPhVHceCHB3qZHa/IxVvjDeKyVlycMEppEVIK0S1ZNWeDG7NdJIQPLGUaRb8907GeX
         +cjA==
X-Gm-Message-State: AOAM532DbS/hTZxVTPqHwqPV1tpahwrLptOdYcRZcKI4dUA+5WaINDUn
        LNt4xkhsM00w5jgJJhc2jvheWIDEaNUJlE7I4wtitYQwuG22FApnS2i/NZB1/+uLXg0/y881g6C
        5xp9by8J/5Dj5bhXqjdUdPogNfHAVNLnqzqHZzeLB
X-Received: by 2002:a17:906:4451:: with SMTP id i17mr2289509ejp.436.1611675275260;
        Tue, 26 Jan 2021 07:34:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSasZks4PL3NUJQfxg7We8UW4x28G54NbjOgDuCVAFpi7QKXrub9Pz5L3G6Ovg3Un+JLmrv6pQRbddbpD7RMI=
X-Received: by 2002:a17:906:4451:: with SMTP id i17mr2289493ejp.436.1611675275099;
 Tue, 26 Jan 2021 07:34:35 -0800 (PST)
MIME-Version: 1.0
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
 <161161054970.2537118.5401048451896267742.stgit@warthog.procyon.org.uk> <20210126035928.GJ308988@casper.infradead.org>
In-Reply-To: <20210126035928.GJ308988@casper.infradead.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 26 Jan 2021 10:33:59 -0500
Message-ID: <CALF+zOkNMHjtH+cZrGQFqbH5dD5gUpV+y3k-Bt31E35d4kn1oA@mail.gmail.com>
Subject: Re: [PATCH 25/32] NFS: Clean up nfs_readpage() and nfs_readpages()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:01 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 25, 2021 at 09:35:49PM +0000, David Howells wrote:
> > -int nfs_readpage(struct file *file, struct page *page)
> > +int nfs_readpage(struct file *filp, struct page *page)
>
> I appreciate we're inconsistent between file and filp, but we're actually
> moving more towards file than filp.
>
Got it, easy enough to change.


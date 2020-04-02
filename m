Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0138119C5C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbgDBPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 11:24:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36194 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389279AbgDBPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:24:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id i7so4708683edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4F5ZdY7baHRX9p1mTWpG9zxWusymLcEOqLCXOssAIBU=;
        b=g5rhf8VkZbZjmtrRA9uLq+eA6cn4w30V1Ydtp66keVrraQ5KdoMysqFdqvimk1mNmg
         BBluexcPEK9BqCC/QnMInSRmAeekeaRQk3fsGNB15QPtBRvrJixiWXRDlXjAAx9dX4VF
         hYKeF2UPxxfG/Z8TROG7OTJWLZk7IvAaYBicE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4F5ZdY7baHRX9p1mTWpG9zxWusymLcEOqLCXOssAIBU=;
        b=fIuDy0oxysuz1Ra3RWHnPDNQEzqHSqoZQ4SCkDAVjqjKn2g968HFQTOmXso+EZNzqe
         F+wSOR1DzOhcA+68O8DUVQzALb+Etg2SrTtYzz9U7vbD+kjeve5bvUrXIbLX2zRV7Sc7
         FPMlWLS7Z1oxmWrnFnQiYLLv3tTIRX/HP7Ecb0kMtjiJb3wftqgKfgZNul7SRXZzNure
         HmLYbHTB7TbtM/JTZJvNgRB6OJEBETBshyrrHuYIKnqRP4LN9CYDN6ChdBX7Zt6eD3u/
         e13G1kckjXc6R9w6E9dHU1IBl6PrUovcvamwHRO5q3IEGMq1NxckpaOc69z2IDNtC8gL
         po6Q==
X-Gm-Message-State: AGi0PuYfEzsb08USgS64yqwO03/2rNK95GNfLapj2mTyaZTpMeirpqu6
        8YtW6DkbsGb9hj7n4CVI5NoqWJGyGOGNpPKlzInVZA==
X-Google-Smtp-Source: APiQypKALy3IUYlnKiBfpTwp+9vi6ZR4LdZdo5HC7HfpoPYCDQL8peS420WXQe1UMt0CcEPpeyGkmutc90yHAqvyJdE=
X-Received: by 2002:a50:8326:: with SMTP id 35mr3485075edh.134.1585841083892;
 Thu, 02 Apr 2020 08:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpeguu52VuLAzjFH4rJJ7WYLB5ag8y+r3VMb-0bqH8c-uJUg@mail.gmail.com>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401090445.6t73dt7gz36bv4rh@ws.net.home>
 <2488530.1585749351@warthog.procyon.org.uk> <2488734.1585749502@warthog.procyon.org.uk>
 <CAJfpeguLJcAEgx2JWRNcKMkyFTWB0r4wS6F4fJHK3VHtY=EjXQ@mail.gmail.com>
 <2590276.1585756914@warthog.procyon.org.uk> <CAJfpeguxDiq3BW94AVFhgY75P+jy_+jk3pdyNZ5z-aJPXNvvGA@mail.gmail.com>
 <3070724.1585840971@warthog.procyon.org.uk>
In-Reply-To: <3070724.1585840971@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 Apr 2020 17:24:32 +0200
Message-ID: <CAJfpegv4=wAi+mH32pHM9g8gk+JGESWa25n04BwfnkhVBf=3rA@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     David Howells <dhowells@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 5:23 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > > Not sure what you mean.  I think it shows precisely the information
> > > > Karel asked for.
> > >
> > > It's not atomic.
> >
> > Yes it is.
>
> No, it really isn't - though it could be made so.
>
> ext4_show_mount(), for example, doesn't lock against "mount -o remount", so
> the configuration can be changing whilst it's being rendered to text.

Does s_umount nest inside namespace_sem?  I really don't see the
relation of those locks.

Thanks,
Miklos

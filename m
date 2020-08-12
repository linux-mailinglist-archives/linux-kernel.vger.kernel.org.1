Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978A724298F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHLMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHLMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:43:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126B8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:43:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bo3so2070806ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCWyQNbioriHgzIQZKUiQvV8PcpAPmxSfvNLBzdg+So=;
        b=hNR9GcSpdiiY1n83D6FsfiqR1xB0RtCSJPEMDx9Yk2kx/4RPasQHoFu7V4WsF4oG+p
         3YsZeqYeTZ3COk1dxTDvmZYS0Vnau0kXHGn2OVSJmw3M4NvkzfFlZ9JbhgwFxkSUIr5r
         lb7fy/OpQ96TgSP+Yc7ikbWNzhW5syY6rQows=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCWyQNbioriHgzIQZKUiQvV8PcpAPmxSfvNLBzdg+So=;
        b=Yvxiqidrbm3b4F4RmjtLyFgKduypL9rUzgeZlJDYTol527xUKz9gidGPZ3CrwWFrzm
         eyLX+ctBhCieAdZl/EIk5rHxSPDhbcaLnD60yHgbyEFVqAwcJYIJDumQ0H3furdOnnQ2
         CEZbRqGwsUeuDoJy1wL2inEW8laXI6LK1qNh4+CnajxhEFetqkGgRzv8hOw7+HFiuu/w
         R8hB3wZL5+xTypgzPF3klnH1hPK05Rp/ji6wgG0mG3tWECGoX0E66YSJmFzZ29YRrCd1
         CHM7rAdPzX23pCCkujdG2ApxuS/N2ZkX49bTRMdgcdkZSgygpts1pNt+37RoChqaphyq
         96hQ==
X-Gm-Message-State: AOAM5318uIwDF4njdXBh2tS1bQGHi6eQ1PSFcFdp+wAk9GuaG5CdVNCO
        JClUbKY1Lu4dSJwdP4qzCyRdJCHitzLpWvzgMReeTQ==
X-Google-Smtp-Source: ABdhPJwZNA29O8JrX816txHUgy/+p+EaXvw60jZsZ8AsZIAKu00rfvbAcmmWGY9gxTN/9StYauqZYKkSwHrbPMzggEc=
X-Received: by 2002:a17:906:4c46:: with SMTP id d6mr32652364ejw.14.1597236223300;
 Wed, 12 Aug 2020 05:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
 <98802.1597220949@warthog.procyon.org.uk> <CAJfpegsVJo9e=pHf3YGWkE16fT0QaNGhgkUdq4KUQypXaD=OgQ@mail.gmail.com>
 <d2d179c7-9b60-ca1a-0c9f-d308fc7af5ce@redhat.com> <CAJfpeguMjU+n-JXE6aUQQGeMpCS4bsy4HQ37NHJ8aD8Aeg2qhA@mail.gmail.com>
 <20200812112825.b52tqeuro2lquxlw@ws.net.home>
In-Reply-To: <20200812112825.b52tqeuro2lquxlw@ws.net.home>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 14:43:32 +0200
Message-ID: <CAJfpegv4sC2zm+N5tvEmYaEFvvWJRHfdGqXUoBzbeKj81uNCvQ@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Karel Zak <kzak@redhat.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 1:28 PM Karel Zak <kzak@redhat.com> wrote:

> The proposal is based on paths and open(), how do you plan to deal
> with mount IDs? David's fsinfo() allows to ask for mount info by mount
> ID and it works well with mount notification where you get the ID. The
> collaboration with notification interface is critical for our use-cases.

One would use the notification to keep an up to date set of attributes
for each watched mount, right?

That presumably means the mount ID <-> mount path mapping already
exists, which means it's just possible to use the open(mount_path,
O_PATH) to obtain the base fd.

If that assumption is not true, we could add a new interface for
opening the root of the mount by ID.  Fsinfo uses the dfd as a root
for checking connectivity and the filename as the mount ID + a special
flag indicating that it's not "dfd + path" we are dealing with but
"rootfd + mntid".  That sort of semantic multiplexing is quite ugly
and I wouldn't suggest doing that with openat(2).

A new syscall that returns an fd pointing to the root of the mount
might be the best solution:

   int open_mount(int root_fd, u64 mntid, int flags);

Yeah, yeah this is adding just another syscall interface, but notice how:

 a) it does one simple thing, no multiplexing at all

 b) is general purpose, and could be used for example in conjunction
with open_by_handle_at(2), that also requires an fd pointing to a
mount.

Thanks,
Miklos

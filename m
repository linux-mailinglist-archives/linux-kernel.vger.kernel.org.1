Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F313242AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHLOLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgHLOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:11:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E5CC061385
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:11:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p24so2391736ejf.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAI5XSM3iLSzZtbpzf+lyAZodExx8Fv/UVCtkgNqIpw=;
        b=Ev5v2cO14QrSiyYcOC/Fz6swER260kegAoQqygVAc1l4xp7iWj9y1sNUklptY5fWyh
         UpTrThzpnTLffpSrHOf2H63dAcVssZmBeRiLgorfycUPPCMMTFGXSVEqYOgJikBrkCYO
         UVuT7X9u60ilNRyU6Ttwt5duD6hAUjAYWcjFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAI5XSM3iLSzZtbpzf+lyAZodExx8Fv/UVCtkgNqIpw=;
        b=JMGjZWPOeA8lPQnqsANcGcm+rVpSPX7hELyMm5O0saM7qeSEtkIoltKfjHhj76gJsx
         L1drFhiCcjup1Coclm8//AwAtyL6kbitYqjx5ly4cm2ITaAkt8m7rJxcJSAvvWNslDaz
         1CJUfjYppEbQLXtnfc5Ao9U6mPZIL53dw7bR1+E+U/r3/0uYgOpIfEimvLcvMIXkWOE1
         nUs3wbbQMZioqHqZ2euuS+Rx+7TfXZQKYrttfZ4IAC/e92h8k3az2voaVkGgkFnynvL/
         AULtHzEICnwmPE2iIlh8ue1+nYfCpW8GPdSNhfqF54OU486HHWA/QW/3gcCaOJIl+lb6
         yTlg==
X-Gm-Message-State: AOAM5331yEr5r8cWbCEfgHulgz3/k78CKuHv4Y09pn89yQ9TvHeFk/5n
        58zBpgfpJKTnuuLQIlyxg0voQ48glng5N/cI9AOWbQ==
X-Google-Smtp-Source: ABdhPJx3PJ9aL5obqkNAu7vPQ/SqsQ9TATEfUryRI39r11CbP3IrD6FZDXg7ftvqa1wiyALQ92/dDqI6E8aZplVgzoI=
X-Received: by 2002:a17:906:4e4f:: with SMTP id g15mr16755594ejw.443.1597241467668;
 Wed, 12 Aug 2020 07:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <135551.1597240486@warthog.procyon.org.uk>
In-Reply-To: <135551.1597240486@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 16:10:56 +0200
Message-ID: <CAJfpegvLaoQHZTm1-QKorzsL3ZDnTOcHpcAJn36yF=n-YymCow@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
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

On Wed, Aug 12, 2020 at 3:54 PM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > IOW, if you do something more along the lines of
> >
> >        fd = open(""foo/bar", O_PATH);
> >        metadatafd = openat(fd, "metadataname", O_ALT);
> >
> > it might be workable.
>
> What is it going to walk through?  You need to end up with an inode and dentry
> from somewhere.
>
> It sounds like this would have to open up a procfs-like magic filesystem, and
> walk into it.  But how would that actually work?  Would you create a new
> superblock each time you do this, labelled with the starting object (say the
> dentry for "foo/bar" in this case), and then walk from the root?
>
> An alternative, maybe, could be to make a new dentry type, say, and include it
> in the superblock of the object being queried - and let the filesystems deal
> with it.  That would mean that non-dir dentries would then have virtual
> children.  You could then even use this to implement resource forks...
>
> Another alternative would be to note O_ALT and then skip pathwalk entirely,
> but just use the name as a key to the attribute, creating an anonfd to read
> it.  But then why use openat() at all?  You could instead do:
>
>         metadatafd = openmeta(fd, "metadataname");
>
> and save the page flag.  You could even merge the two opens and do:
>
>         metadatafd = openmeta("foo/bar", "metadataname");
>
> Why not even combine this with Miklos's readfile() idea:
>
>         readmeta(AT_FDCWD, "foo/bar", "metadataname", buf, sizeof(buf));

And writemeta() and createmeta() and readdirmeta() and ...

The point is that generic operations already exist and no need to add
new, specialized ones to access metadata.

Thanks,
Miklos

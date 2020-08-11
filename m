Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87BE241FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHKStt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 14:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgHKSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:49:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32039C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:49:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f24so14234502ejx.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QR5EthpwytHc0ejjeS7AxrlPWVpWopYIIKYLKzP2Eq4=;
        b=qsi/YfmV5n8FbsFLNbmPsP/XkvX4WKPoDYdfXAcHJX7sKPLBuRLurDA3+/2q3dTeSc
         QR8qUCCSWYQi8swtBn5FT3wk2zToUXW4QeK5DefeOUHbAjTA30lN66ie4B4qXy6igVCz
         4BHo6BVZ9hbN3e+PMfS3B/xKbDT6XmlbbOAG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QR5EthpwytHc0ejjeS7AxrlPWVpWopYIIKYLKzP2Eq4=;
        b=DI53jNzdyarr+K92SKhT9DeslQqKaNUSCLIZ+36yvBxs7KHD8Y3aLxbCBNxskPPlvC
         v0kW+16sj1IIOjTyJXRXz+GyX6V6Bt20ufn5pKOPOwroxNFjVhDeE8WOck1zFRM5kzrL
         MZkSaySbZukulk3pkBJXeEXt4DPG/3EJnt1hu6bvGOFtsqlENhb8FXwr9MWzt7osHt0y
         JrIOi53+KyolqlpUJUdBuabMuCXzKO1eTvJdFhTfHNLoPpvOTq19qISvdbiKGiEx4ABw
         6RWSZXhd3erZo6gt7l8dAoF3KCMfUz04s27notnkTk3iuz0ndIMPrS0QfaQXok8s8dH7
         cQYA==
X-Gm-Message-State: AOAM533svUYs/tbFm1T4zFDm4rwLi8cwC99ax3V1aRnpSSRnp1NCGoME
        KcNWBDvcCriLEXnvqyRGdEUDwI9aMig1wVmYPztpRw==
X-Google-Smtp-Source: ABdhPJwnvaq93oJFCq5dS1yTahe560sCcekZabn8tDE66ijpKnt1L+Oo8yrivZ6IVjeel10rJKNsayxlhVFf1TUW2Xc=
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr27509087ejc.110.1597171786328;
 Tue, 11 Aug 2020 11:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com> <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
In-Reply-To: <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 20:49:35 +0200
Message-ID: <CAJfpeguo5nAWcmduX4frknQGiRJeaj9Rdj018xUBrwqOJhVufw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Aug 11, 2020 at 6:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> and then people do "$(srctree)/". If you haven't seen that kind of
> pattern where the pathname has two (or sometimes more!) slashes in the
> middle, you've led a very sheltered life.

Oh, I have.   That's why I opted for triple slashes, since that should
work most of the time even in those concatenated cases.  And yes, I
know, most is not always, and this might just be hiding bugs, etc...
I think the pragmatic approach would be to try this and see how many
triple slash hits a normal workload gets and if it's reasonably low,
then hopefully that together with warnings for O_ALT would be enough.

>  (b) even if the new user space were to think about that, and remove
> those (hah! when have you ever seen user space do that?), as Al
> mentioned, the user *filesystem* might have pathnames with double
> slashes as part of symlinks.
>
> So now we'd have to make sure that when we traverse symlinks, that
> O_ALT gets cleared.

That's exactly what I implemented in the proof of concept patch.

> Which means that it's not a unified namespace
> after all, because you can't make symlinks point to metadata.

I don't think that's a great deal.  Also I think other limitations
would make sense:

 - no mounts allowed under ///
 - no ./.. resolution after ///
 - no hardlinks
 - no special files, just regular and directory
 - no seeking (regular or dir)

>     cat my-file.tar/inside/the/archive.c
>
> or similar.
>
> Al has convinced me it's a horrible idea (and there you have a
> non-ambiguous marker: the slash at the end of a pathname that
> otherwise looks and acts as a non-directory)

Umm, can you remind me what's so horrible about that?  Yeah, hard
linked directories are a no-no.  But it doesn't have to be implemented
in a way to actually be a problem with hard links.

Thanks,
Miklos

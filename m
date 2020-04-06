Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6843519FA30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgDFQec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 12:34:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41436 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgDFQec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:34:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id n17so336305lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMHiT/Wub3WobBASn8jTrpUwrDr3u4OoR64hK8bb9Ks=;
        b=AfWDLI+z1soflaJhqnVIBl+g08ryFIMdzJqIJa45tvPYBFyKn+PmZgyAKpbs5cJwZl
         9gtU1jadiJkYAbncJSZUPSb1X2kcckqoo15hGsCWmJf/qxcwWTHrb5wLDAA7sDdZ3t6B
         sFkeB7u4W8ywdCcWyLji2espSviyDN/+Gi3rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMHiT/Wub3WobBASn8jTrpUwrDr3u4OoR64hK8bb9Ks=;
        b=k7LXqXdE3qpmlfmYfNlUxViXkCYxhm2tmlFPjoZJpX+qF7SjxHF6OEe4tP/gkVSC9g
         HUHk4+HATYUGXSJS09GoyoE9fNsSjJGhWA2Td4nWljbP49svEm/E4N2R3vs02IsJWiUY
         5Q3QV7H/48Al+rSsYRP66aHTa0t5xwm9b1B9IN3Td6mdI8r51S04VxIPg/Ey6qRLlues
         W6KnI46Jbsa12NvckUDC0R/T/+DZI7J3sorIxZYdiZIFcpI7f1XVhVOtivMJ+ARDCbwT
         6yuzwrdFVmtFWk8RC8qt7ZTj8f1NT8nkGelHrNe4mXXXkAlxoMwwVaaEZbGt7r2Bd6A3
         w0GA==
X-Gm-Message-State: AGi0PuZWc+zmszRJGL2EBonFIDYzWQP4mZmFOczV2ojLbP0EwD+OO/kg
        pT1/2BL6rU5k0y/1Xci5KfDyHM4vkDo=
X-Google-Smtp-Source: APiQypJS9xDo+v4peMcy5XQO/ifHqSnYmhyjxBayDeCelmvC1lZ4PAbV+3bco79azHmk1t4LcxgaZw==
X-Received: by 2002:a2e:b52f:: with SMTP id z15mr80980ljm.38.1586190867919;
        Mon, 06 Apr 2020 09:34:27 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m8sm10264897lji.12.2020.04.06.09.34.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 09:34:26 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id w145so9649lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:34:25 -0700 (PDT)
X-Received: by 2002:a19:7706:: with SMTP id s6mr10019987lfc.31.1586190864915;
 Mon, 06 Apr 2020 09:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login> <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login> <20200403203024.GB27105@fieldses.org> <20200406091701.q7ctdek2grzryiu3@ws.net.home>
In-Reply-To: <20200406091701.q7ctdek2grzryiu3@ws.net.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 09:34:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjW735UE+byK1xsM9UvpF2ubh7bCMaAOwz575U7hRCKyA@mail.gmail.com>
Message-ID: <CAHk-=wjW735UE+byK1xsM9UvpF2ubh7bCMaAOwz575U7hRCKyA@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Karel Zak <kzak@redhat.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 2:17 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Fri, Apr 03, 2020 at 04:30:24PM -0400, J. Bruce Fields wrote:
> >
> > nfs-utils/support/misc/mountpoint.c:check_is_mountpoint() stats the file
> > and ".." and returns true if they have different st_dev or the same
> > st_ino.  Comparing mount ids sounds better.
>
> BTW, this traditional st_dev+st_ino way is not reliable for bind mounts.
> For mountpoint(1) we search the directory in /proc/self/mountinfo.

These days you should probably use openat2() with RESOLVE_NO_XDEV.

No need for any mountinfo or anything like that. Just look up the
pathname and say "don't cross mount-points", and you'll get an error
if it's a mount crossing lookup.

So this kind of thing is _not_ an argument for another kernel querying
interface.  We got a new (and better) model for a lot of this.

              Linus

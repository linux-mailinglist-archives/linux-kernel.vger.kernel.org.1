Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C52030366C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbhAZGVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728822AbhAYN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611581153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKBAIHjLBv1uPqHgRWoGEuszBqIj+l3P9UDHtFckEn4=;
        b=LKaNWm1sI+LWt7z9lnCSfTd/bj4Qw0Z//IRwfImml33CKbSFOphOLOeTpqyrfdqjUGunav
        66yvJHfBWJTkwz7cf3VVpbH/WWpm4JAp9aGe5GELrzrQXffI3LUct0NR8+bgDpfEFY5EcV
        8/CYEq9Nd5u0ROrfA7ZoMnIreBqeaEk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-uHrjmWgqNYqPUouv4Ebhkw-1; Mon, 25 Jan 2021 08:25:49 -0500
X-MC-Unique: uHrjmWgqNYqPUouv4Ebhkw-1
Received: by mail-qk1-f197.google.com with SMTP id s66so9843456qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKBAIHjLBv1uPqHgRWoGEuszBqIj+l3P9UDHtFckEn4=;
        b=oUNU5M94Hyt2NEtRYqfiYb9lywSN2DSCsmCpF+43I4EZjBgVl23FiIiaysTzQUCRHb
         HSgCEqzAH+EJFx8Sb1fJJWOQ6Z89rr512E6NatWWfQ4Q1tjoFTaG+Jn0jTce+7sWz5H2
         3J2nLpfm2KwcPN8byaOCseZqyOV/koIRWWZ45ZF9snLr3xVjWRzG4+x4WQkJd/1buWOR
         HzWvDWs0MuiYIg4wYjv7yrnW1ywWZJEQfdPSAclSgnjlsf8ensy0qT6kEwwz79EXsxhJ
         ciS1pQ5vV/W5cVxj6czeEHHtZJ1O74D0jt5FYjhn7sQ8ILwIaZbBSRY4uF/H3VmBzVGj
         pduA==
X-Gm-Message-State: AOAM533JxMIXoqHlxqzvmqIR1aLChzamkaesYfEvhPun+7UeFfOwxqWG
        tB5VJV1MkWs+FUyq4Eb4zjJLj2ap+5eFGGYlW893/z8iqliR+ftrz8aZqcSAV7NCVJ8vY+6ec4o
        SvG9VF5mgOEFX/YkKyiDwe8S3WITlCxeLPsPuknlU
X-Received: by 2002:a37:788:: with SMTP id 130mr656851qkh.390.1611581149429;
        Mon, 25 Jan 2021 05:25:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9uwqNss2gL2K4WjIoL7LYE/brUIbRAkeSgNTSwbgH4tU/Oz6Gn7u/P9cD2BigrYSceF14qFL5icT3pOjziLA=
X-Received: by 2002:a37:788:: with SMTP id 130mr656827qkh.390.1611581149237;
 Mon, 25 Jan 2021 05:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-2-mszeredi@redhat.com>
 <20210122183141.GB81247@sequoia>
In-Reply-To: <20210122183141.GB81247@sequoia>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 25 Jan 2021 14:25:38 +0100
Message-ID: <CAOssrKd-P=4n-nzhjnvnChbCkcrAaLC=NjmCTDRHtzRtzJaU-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on security.capability
To:     Tyler Hicks <code@tyhicks.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 7:31 PM Tyler Hicks <code@tyhicks.com> wrote:
>
> On 2021-01-19 17:22:03, Miklos Szeredi wrote:
> > Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> > vfs_setxattr()") the translation of nscap->rootid did not take stacked
> > filesystems (overlayfs and ecryptfs) into account.
> >
> > That patch fixed the overlay case, but made the ecryptfs case worse.
>
> Thanks for sending a fix!
>
> I know that you don't have an eCryptfs setup to test with but I'm at a
> loss about how to test this from the userns/fscaps side of things. Do
> you have a sequence of unshare/setcap/getcap commands that I can run on
> a file inside of an eCryptfs mount to verify that the bug exists after
> 7c03e2cda4a5 and then again to verify that this patch fixes the bug?

You need two terminals:
$ = <USER>
# = root

$ unshare -Um
$ echo $$
<PID>
# echo "0 1000 1" > uid_map
# cp uid_map gid_map
# echo 1000 2000 1 >> uid_map
# echo 2000 3000 1 >> uid_map
# cat uid_map > /proc/<PID>/uid_map
# cat gid_map > /proc/<PID>/gid_map
$ mkdir ~/tmp ~/mnt
$ mount -t tmpfs tmpfs ~/tmp
$ pwd
/home/<USER>
# nsenter -t <PID> -m
# [setup ecryptfs on /home/<USER>/mnt using /home/<USER>/tmp]
$ cd ~/mnt
$ touch test
$ /sbin/setcap -n 1000 cap_dac_override+eip test
$ /sbin/getcap -n test
test = cap_dac_override+eip [rootid=1000]

Without the patch, I'm thinking that it will do a double translate and
end up with rootid=2000 in the user namespace, but I might well have
messed it up...

Let me know how this goes.

Thanks,
Miklos


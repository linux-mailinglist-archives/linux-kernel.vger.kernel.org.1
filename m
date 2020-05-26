Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A181A271F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgDHQYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 12:24:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36460 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730280AbgDHQYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:24:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id b1so8316122ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5aiANvhgix2N64LwK7RWDgOwJhQeHsVBzrYi29ys94=;
        b=DsqtBI6qRFjNpPkePJmA4uX3kNk0ar1H6f+mDa9WCWCogbW1T44w59UgWS3voTEzVK
         genV1UO4Or0H2X/qb8IDbOA88OBquO3BkpRlNYz06H9TiREZObOBBJUBZTq+Ufv9WsE4
         +7C0iZS1MYYzD1pJn+M2c6GEdXyXvNHvkqSWB4XXDBcfiYWq+U6RNTMgvedFjt69dE17
         14nDpSBj3rkurQYjwNYAGpRsn6UJpZ2eN0cavWpSULcVrBGXx1iDEO77FjTZcDVdSRvX
         QkJmuqfyrMbk+hWYW2pBub6BYirXJ+pM+Mp0JbV/YyhrzUF5+jieHm0nw0AYVfNnXrxV
         gdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5aiANvhgix2N64LwK7RWDgOwJhQeHsVBzrYi29ys94=;
        b=q83desGcIvx4+uNA/wHlv27D5nWT3lSMlmeEm1LhGHitvdYEMdgpCjteLz0hAdhBWK
         oPl+5eMoIHpK23S/UUu3s5ydYvks7CmrRqVKE0f4IJRseJpvzEmO6kaL3rKSgRsbtW/R
         F3T/84iOnK0G6IhA/b98viZuU2hv5GjVSBExj2VnwFpBpgUNegaM1UuAT7c/tawizzzE
         Y4XA+O8WKIFH6vDguVjgq1yqn/pxEAWg9wzV0SUOFAEcpsKcgjD8O200omlI1LAJxjEN
         MQT/7o5bGR7AtVDDlwAQ9bMbXeb1IdKP+uyX4yC0tPdu5lN9Ne6sDrHclAT5c5WgI/5b
         0jUQ==
X-Gm-Message-State: AGi0PuY/bnKQhBkNcXLCT+IRrk+ssR3xrxCf/0DorQz4u53d0pc1dfrO
        cU1RxlQxrZGsUi4g8OGbymPTMFkqpt3133UUMhLaXg==
X-Google-Smtp-Source: APiQypJwZtEyXK5GJK6816AgkQZ1Cx5TsDhHg1RPi2SPIJaChvEwYWQCWwAp1ip6qeVHQ0/Dbzy1kvzvsVWhJz83qlI=
X-Received: by 2002:a05:651c:287:: with SMTP id b7mr400146ljo.73.1586363083460;
 Wed, 08 Apr 2020 09:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200408152151.5780-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200408152151.5780-1-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 8 Apr 2020 18:24:16 +0200
Message-ID: <CAG48ez0KWgLMOp1d3X1AcRNc4-eF1YiCw=PgWiGjtM6PqQqawg@mail.gmail.com>
Subject: Re: [PATCH 0/8] loopfs
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Serge Hallyn <serge@hallyn.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>,
        Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Tom Gundersen <teg@jklm.no>,
        Christian Kellner <ckellner@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        linux-doc@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 5:23 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> One of the use-cases for loopfs is to allow to dynamically allocate loop
> devices in sandboxed workloads without exposing /dev or
> /dev/loop-control to the workload in question and without having to
> implement a complex and also racy protocol to send around file
> descriptors for loop devices. With loopfs each mount is a new instance,
> i.e. loop devices created in one loopfs instance are independent of any
> loop devices created in another loopfs instance. This allows
> sufficiently privileged tools to have their own private stash of loop
> device instances. Dmitry has expressed his desire to use this for
> syzkaller in a private discussion. And various parties that want to use
> it are Cced here too.
>
> In addition, the loopfs filesystem can be mounted by user namespace root
> and is thus suitable for use in containers. Combined with syscall
> interception this makes it possible to securely delegate mounting of
> images on loop devices, i.e. when a user calls mount -o loop <image>
> <mountpoint> it will be possible to completely setup the loop device.
> The final mount syscall to actually perform the mount will be handled
> through syscall interception and be performed by a sufficiently
> privileged process. Syscall interception is already supported through a
> new seccomp feature we implemented in [1] and extended in [2] and is
> actively used in production workloads. The additional loopfs work will
> be used there and in various other workloads too. You'll find a short
> illustration how this works with syscall interception below in [4].

Would that privileged process then allow you to mount your filesystem
images with things like ext4? As far as I know, the filesystem
maintainers don't generally consider "untrusted filesystem image" to
be a strongly enforced security boundary; and worse, if an attacker
has access to a loop device from which something like ext4 is mounted,
things like "struct ext4_dir_entry_2" will effectively be in shared
memory, and an attacker can trivially bypass e.g.
ext4_check_dir_entry(). At the moment, that's not a huge problem (for
anything other than kernel lockdown) because only root normally has
access to loop devices.

Ubuntu carries an out-of-tree patch that afaik blocks the shared
memory thing: <https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/eoan/commit?id=4bc428fdf5500b7366313f166b7c9c50ee43f2c4>

But even with that patch, I'm not super excited about exposing
filesystem image parsing attack surface to containers unless you run
the filesystem in a sandboxed environment (at which point you don't
need a loop device anymore either).

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A342C1B486A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDVPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 11:21:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49499 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:21:04 -0400
Received: by mail-il1-f197.google.com with SMTP id z18so2211200ilp.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pz5CUTnf5j/KbXtN31blRs8hszDPf+GoywqGxmL0NSU=;
        b=jUcTq3r5+FrBxTRJK6v+QsfZVeu+jK8EXPby9NZQpUd1sy0i918Sm/kfm6kU3o6n5a
         B8braiAB/iyyonYkHsmKGZbfNQiUx4BEw/fa0tRNSSpe5PEh9xEWxj2D17AqzzakQb1p
         zlrvwWRO5FALxnlREF5cL93cr44PPUeH3iShS5FmYjB4NEc6SUCSj6IzPyvsc8fmDItr
         LufVKRQipqrW0o6+LNH6I1eMcB0GvpdHuWAa7FqZ7iMxBQB5eBN6KdKpHAmiF9B4CGJB
         sMpzrPqnvbqlwJnO3AmnQJNIIKpMebIQLUWHEW+7TW7tfkZB8LYJ575UaY1H5piQVU62
         eOiw==
X-Gm-Message-State: AGi0PuZoUzy5IUZ3UvkN+q+NzILzhyMWhDVT9VD2te+3HKM+VLqr6XaG
        QHal24rPFeKDx15CoqYJCBQMeT1vpVsHuqd9JU7oWWqC48Fo
X-Google-Smtp-Source: APiQypLGfxG+wShvFp6rdfNRJ1n5KuK6e6eGMdujQtoUfdCunfXWlEVxafiQDoC6rEC+Ti0UWFJk3U/4qIqvqPZ78ZYBhiQaXDeB
MIME-Version: 1.0
X-Received: by 2002:a92:d149:: with SMTP id t9mr17233217ilg.213.1587568863606;
 Wed, 22 Apr 2020 08:21:03 -0700 (PDT)
Date:   Wed, 22 Apr 2020 08:21:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004221058240.20574-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bfce805a3e2aec4@google.com>
Subject: Re: KASAN: use-after-free Read in usbhid_close (3)
From:   syzbot <syzbot+7bf5a7b0f0a1f9446f4c@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, ingrassia@epigenesys.com, jikos@kernel.org,
        julian@cipht.net, killertofu@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pingc@wacom.com, pinglinux@gmail.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+7bf5a7b0f0a1f9446f4c@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf5a7b0f0a1f9446f4c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f40acfe00000

Note: testing is done by a robot and is best-effort only.

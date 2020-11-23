Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB32C1310
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgKWS3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgKWS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:29:21 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEACFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:29:21 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t21so15046891pgl.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLL5VK65mropUj8eVChZS1FbZOADJKAQxn0fusexOMQ=;
        b=E8EPKJbkoUBbzxmoxgjFiQDVuHPS66jo9mhAmbeF+pFORPGIjOhZhSTc47rfpx0BOb
         lFz5rG5hVDN/0HlSEYnEwl0E8my4zcJNGdnReE02YgE7F44rSSK1IA8TnVbwioo4jhpR
         /gwz4/9uQmYPEU1bYf3lUQ9myfmne+0c3HhsySPc1EQTdtxeFIW37MaXWfBm2MX6xmCR
         rPqDrazVGn7dfJ/i1MU1LHesntCd5ldm9jGNQAbiPAFUdndrB0v8sxPlSA+9K9j56fy5
         Nuhm6YBhVFtOyjj9xtuba7WgDOJjaSdW/+C20+47qQ8vEXov5GtQ5lnqzuJo0lSIZiIm
         o3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLL5VK65mropUj8eVChZS1FbZOADJKAQxn0fusexOMQ=;
        b=eMy4alG2Zdr4BcAWMIwM+zTEsFOrusWWAFdHeGyg729ml1NSSLgJrLUC0b9wSNHskW
         R4RnKLTlsMYo3vCySOGTXBd7IeMWKSsd4v+A52q2thIocThSYZVlUaAm7wZuyM5OEiXK
         h0yU0u+gM5UWjvbxsToj7/W0Qw1I9JI5SDZInQOQ3Cwv8mTKkcZ8oSjcQe2Q8orNa3AE
         5e9ZSO8LlCJOI/LcV7N9fKHwQXMP9suU4XvjNJRkpWdVgIatXwZow1KOTnmwFT3qXPUp
         IGEsgd6QrxXASanIwXExG+WoYP1W12/Ix5ndbWQSkCeY/mjg8qihAl2mpfcAhzU2zqyW
         +1pg==
X-Gm-Message-State: AOAM533Mi9o/Wb6kg+/cq1wl5x/w67jmzciHzsI+slndWuKgS7Bo48Ao
        QXxXf81JH9CmqdQLWd09T0B9tmgbsckurRByuzt0AA==
X-Google-Smtp-Source: ABdhPJy6gYzD7W2pmsK/fMkiWlS3Yn8XMBEuepH9rHqFD2NmMngxbrkwdDFj//KzCjmXr3fUAFfoPZbyWFaJ8QWOT5U=
X-Received: by 2002:a62:864a:0:b029:197:ad58:4184 with SMTP id
 x71-20020a62864a0000b0290197ad584184mr565914pfd.55.1606156161130; Mon, 23 Nov
 2020 10:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20201120165609.GE619708@rowland.harvard.edu> <000000000000c49c8b05b48cb833@google.com>
 <20201120170055.GF619708@rowland.harvard.edu>
In-Reply-To: <20201120170055.GF619708@rowland.harvard.edu>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 23 Nov 2020 19:29:10 +0100
Message-ID: <CAAeHK+z0Lb_5zw-fQF6AXLzL=+P6kizOJ7yu=t4SP_5UPK66kg@mail.gmail.com>
Subject: Re: Re: memory leak in hub_event
To:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+44e64397bd81d5e84cba@syzkaller.appspotmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="00000000000071161905b4ca5f5a"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000071161905b4ca5f5a
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 20, 2020 at 6:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Nov 20, 2020 at 08:56:11AM -0800, syzbot wrote:
> > > On Fri, Nov 20, 2020 at 07:15:20AM -0800, syzbot wrote:
> > >> Hello,
> > >>
> > >> syzbot found the following issue on:
> > >>
> > >> HEAD commit:    4d02da97 Merge tag 'net-5.10-rc5' of git://git.kernel.org/..
> > >> git tree:       upstream
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=13a7d2b6500000
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=c5353ac514ca5a43
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=44e64397bd81d5e84cba
> > >> compiler:       gcc (GCC) 10.1.0-syz 20200507
> > >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14925089500000
> > >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16810051500000
>
> > > #syz test: upstream 4d02da97
> >
> > "upstream" does not look like a valid git repo address.
>
> Okay, Andrey.  If "upstream" is not accepted as a valid git repo
> address, why does syzkaller list it on the "git tree:" line?  It seems
> to me that syzkaller should be willing to accept as input anything it
> produces as output.
>
> And what repo should I put here?

Hi Alan,

Yeah, this is confusing, sorry. I've filed
https://github.com/google/syzkaller/issues/2265 for this.

Here "upstream" stands for the mainline tree, so something like this
should work:

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
4d02da97

Thanks!

--00000000000071161905b4ca5f5a
Content-Type: application/octet-stream; name="gspca.patch"
Content-Disposition: attachment; filename="gspca.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_khuvvg0l0>
X-Attachment-Id: f_khuvvg0l0

SW5kZXg6IHVzYi1kZXZlbC9kcml2ZXJzL21lZGlhL3VzYi9nc3BjYS9nc3BjYS5jCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIHVzYi1kZXZlbC5vcmlnL2RyaXZlcnMvbWVkaWEvdXNiL2dzcGNhL2dzcGNhLmMKKysr
IHVzYi1kZXZlbC9kcml2ZXJzL21lZGlhL3VzYi9nc3BjYS9nc3BjYS5jCkBAIC0xNDg5LDYgKzE0
ODksOCBAQCBpbnQgZ3NwY2FfZGV2X3Byb2JlMihzdHJ1Y3QgdXNiX2ludGVyZmFjCiAJfQogCiAJ
Z3NwY2FfZGV2LT52NGwyX2Rldi5yZWxlYXNlID0gZ3NwY2FfcmVsZWFzZTsKKwlyZXQgPSAtRUlP
OworCWdvdG8gb3V0OwogCXJldCA9IHY0bDJfZGV2aWNlX3JlZ2lzdGVyKCZpbnRmLT5kZXYsICZn
c3BjYV9kZXYtPnY0bDJfZGV2KTsKIAlpZiAocmV0KQogCQlnb3RvIG91dDsKCg==
--00000000000071161905b4ca5f5a--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB4286D35
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgJHDiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:38:11 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:47604 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgJHDiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:38:11 -0400
Received: by mail-il1-f206.google.com with SMTP id z14so3120244ilb.14
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 20:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4IhbBH7ECghcPFerwikAMQpqWj6YlBpaCR+/1lLbfIE=;
        b=SzNXD6w46RmLgPJLlHAeegXZ1zaFztq0IO7Qh7PkI58ODZ6NLUY5XFInWEhk50frry
         +v6mdlBOCo/OzfOij+8WtNyu8dB/ippxC21Z6G3SkWmDD9n9EjjaBSuIAboAywnWNwPU
         IobLpuiZduJcNjLyIdzNhw0MAebrwUycPl/aSsYnRX/6IGqlRwqnK08kXw2NVoq8Sxo7
         zBZ35BKxvBZB2X90VxdGH2REMMl8OsZKxyXswdg7W0BzczpqYQw0gf12eaqHUoPvj5KF
         ensFLIs+EqmUnIZBxqh1aLc6vg2pNxXgpp7N/VClL+ibJEFKOBcFOqOlx3drrOCz2rcf
         tP0w==
X-Gm-Message-State: AOAM531gZhv+UVTyPLlANaiSJguvXLg3YNBZXjJGfoZScc4/Qk+cUYuj
        ufWqRFYsq8lHf+4Bt56n87gU/FQB/wUA2fSKchQzGXhnFgbb
X-Google-Smtp-Source: ABdhPJynKSURyz8krzVv92HNweDLHB/5PqX1t0MirYXocBnDSftoIzE01f7AZnfI+TcgJdlhKPHkNqcCx/gg/MZ7dJ+aWSiS2SjA
MIME-Version: 1.0
X-Received: by 2002:a6b:f30a:: with SMTP id m10mr2888088ioh.164.1602128289047;
 Wed, 07 Oct 2020 20:38:09 -0700 (PDT)
Date:   Wed, 07 Oct 2020 20:38:09 -0700
In-Reply-To: <0000000000009323e705ae870d48@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dab1205b1208fe6@google.com>
Subject: Re: KASAN: use-after-free Read in delete_partition
From:   syzbot <syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com>
To:     anant.thazhemadam@gmail.com, axboe@kernel.dk,
        bgolaszewski@baylibre.com, dan.j.williams@intel.com,
        dragonjetli@gmail.com, gregkh@linuxfoundation.org, hch@lst.de,
        hl1998@protonmail.com, jack@suse.cz, jean-philippe@linaro.org,
        johannes.thumshirn@wdc.com, jroedel@suse.de,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        saravanak@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 08fc1ab6d748ab1a690fd483f41e2938984ce353
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Sep 1 09:59:41 2020 +0000

    block: fix locking in bdev_del_partition

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1259b1e7900000
start commit:   f75aef39 Linux 5.9-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=b8639c8dcb5ec4483d4f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c43c79900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173dfa1e900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: fix locking in bdev_del_partition

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

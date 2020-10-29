Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E129EDED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgJ2OKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:10:11 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:57190 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2OKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:10:11 -0400
Received: by mail-il1-f198.google.com with SMTP id y15so2028537ilq.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/Lhss/Vh0kVkE5y7FS4pI9/ATyOMwIe6l8v1CVu9F2s=;
        b=qpeHTqxEhkxAbjVRw3mx4YRDG+K3dFzb651PpXAY0qAqHpn1RIXOpV1ziTT+f4cRRe
         9LPMIqw5CL0SOKsy9LH57XlrAuiEJ+aCLu2ytYIWHM4COXkQ8Dg0A2HFWE2x8zoYRolC
         +t8yXTF4i66u+40msnoj2SFgeP2vFgJGjc6T5yA3y7HUWxokzsc//4LCRXDI/zUo+/74
         GwaZC233pXtiEL5WCo6KJWJzKJpSDOyT/vyAYvT98fK/3p8hPQbZGFiUGdHeijM9bks/
         7a8EJg0PnGIdjPNGCr6mbTgqw0C+YQopEA4Ebu2KM/QcsbtkW2jEJa6bO6SKAEdsNTdD
         NE8w==
X-Gm-Message-State: AOAM533H2PKrRwTfMeGZmW5fHk4evz/K41xTKL9OtgJjctgrpdL6HAPn
        OkCklEKM+LXjUJ+Hh3i87DmChKfmqzU60+rXUe6iODBASSLK
X-Google-Smtp-Source: ABdhPJzabo1orFnRTGkB9TdGZI3LZZm/Y+0CJcYx63o3mlm+JAQvAjhhnluZZ+iNQ7CzBZxZ0jVD2ar5nWwcwYHPLfunUIm4Q9s+
MIME-Version: 1.0
X-Received: by 2002:a92:28d:: with SMTP id 135mr3487539ilc.238.1603980608707;
 Thu, 29 Oct 2020 07:10:08 -0700 (PDT)
Date:   Thu, 29 Oct 2020 07:10:08 -0700
In-Reply-To: <000000000000a4b3c205b0c24743@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068a67705b2cfd6e9@google.com>
Subject: Re: KASAN: out-of-bounds Read in __switch_to (2)
From:   syzbot <syzbot+2667188e965125ab6e7a@syzkaller.appspotmail.com>
To:     0x7f454c46@gmail.com, anant.thazhemadam@gmail.com,
        b.zolnierkie@samsung.com, bp@alien8.de, chang.seok.bae@intel.com,
        dan.carpenter@oracle.com, george.kennedy@oracle.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        sashal@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a49145acfb975d921464b84fe00279f99827d816
Author: George Kennedy <george.kennedy@oracle.com>
Date:   Tue Jul 7 19:26:03 2020 +0000

    fbmem: add margin check to fb_check_caps()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174684b8500000
start commit:   fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=41b736b7ce1b3ea4
dashboard link: https://syzkaller.appspot.com/bug?extid=2667188e965125ab6e7a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11743a37900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbmem: add margin check to fb_check_caps()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

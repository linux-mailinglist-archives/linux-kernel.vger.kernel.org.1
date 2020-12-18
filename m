Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A182DE67F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgLRP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:26:45 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:50523 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgLRP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:26:44 -0500
Received: by mail-il1-f199.google.com with SMTP id t8so2320199ils.17
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 07:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sk5wsene1nN0m/ZwzAMFtPnzrH/E8P/WHO8ceDjivzI=;
        b=WfzZg8mLZKiJ8/W3geozLapk4K69sggG5J3yxXBBktkDgcoVVGcSLND4pfjOoOqvwH
         K+tK+w5yI8eq2HshStjCQauCN4tuxep4lFIHVp6e8/aLjItYNNmBHW2iaAmgjrCnHaON
         hRckXhrqhTztNpgKuOgILEGbrJ6WZ7QRaFhn61LRout4NG0z0vHymRLBxd9Or0Sz+yLu
         pVEQcmb8kHTeRfdb1jWUhohrRe6cvCRQb825FqYlQg0JK3DqdE+05pqzNeVoB/p0ivoq
         r8uhXNYV8KphFT38rfVP7nqRToyzw4j9UUTMYIHex1KKt2WU8+zAvOi3T/pP47xidnTf
         czOA==
X-Gm-Message-State: AOAM533tUz2xMtyikOkJd2vVD40OC+AcrylzKYPX2EYmwLbkkQCNZpk0
        UEp6olGgGGr4ftRf3z9Mef5asrI6CcSi1N/L99hq77oGnXOd
X-Google-Smtp-Source: ABdhPJzuvrPtRbQYMrW7TokBn0kIwTaf/V843TfLKQjba/B7jwxt5ruzQvW2+psjnlXsskbIbwR8PyAsQ+KrYXz+osh7v24vwsOS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr4326230ilu.104.1608305163890;
 Fri, 18 Dec 2020 07:26:03 -0800 (PST)
Date:   Fri, 18 Dec 2020 07:26:03 -0800
In-Reply-To: <000000000000b30cad05b0fc3d74@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbf57305b6beb939@google.com>
Subject: Re: BUG: unable to handle kernel paging request in cfb_imageblit
From:   syzbot <syzbot+dfd0b1c6705301cc4847@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dan.carpenter@oracle.com,
        dri-devel@lists.freedesktop.org, george.kennedy@oracle.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a49145acfb975d921464b84fe00279f99827d816
Author: George Kennedy <george.kennedy@oracle.com>
Date:   Tue Jul 7 19:26:03 2020 +0000

    fbmem: add margin check to fb_check_caps()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1149f30f500000
start commit:   22fbc037 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e672827d2ffab1f
dashboard link: https://syzkaller.appspot.com/bug?extid=dfd0b1c6705301cc4847
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ba9a5d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cfd4af900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbmem: add margin check to fb_check_caps()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

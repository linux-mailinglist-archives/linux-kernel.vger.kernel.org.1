Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2311AB49E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 02:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391441AbgDPALW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 20:11:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36083 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391270AbgDPALG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:11:06 -0400
Received: by mail-io1-f69.google.com with SMTP id p9so6759964ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fpoqVPhszf0NVg05C+Ce87uumBc0cG0RasYX5KRrK/A=;
        b=twUFJ+s0ioh5PHTp5bpU/F2FTI59EUrki8X0PSEK7C8T8DrHiMXXwzCUXq8nkW2VWf
         9tvelCVjlIEj/Om3F9C/qBg4H7uNWAlYJ52XJfxkMUgiB33YAXcjkArr3epQ8hs3KXuh
         cyN9NqQGALT/hIFAT8MckdKseCMT0PoCrXGTtaq2Ee9q5nR6RZq2mwVLszd2Ynd5gkts
         /enjHm0QGO9tx5ftZlnD76Kgw5qAKgLzD3Z9BcJbKropXEPsNhLkOVETJj8ngLwQZDIa
         TswYdRgoNkmnojowvsRo3CK8tnWttAIrKx8c+7lFZzukGLoxuBRqmysit3/YJImZds0U
         tQzg==
X-Gm-Message-State: AGi0PubGQFlvj/BTwBqjrQWviV1GS1r1/USuNs8htP8+frb98pO8azNM
        3rAJksbc8uvYW3h51+fFGLj5v0NGVtomZXhjc9V3hoccRr9b
X-Google-Smtp-Source: APiQypKcCgI3/2owP+Ax+avsl/BzFIkiA31xvFAOZDOMymkWaDm+4dJSPNPqeM8Ut+RNphNBCe4mDPpNDLKfGAmGhhXHK5QOcm+K
MIME-Version: 1.0
X-Received: by 2002:a02:7b05:: with SMTP id q5mr28919026jac.105.1586995863913;
 Wed, 15 Apr 2020 17:11:03 -0700 (PDT)
Date:   Wed, 15 Apr 2020 17:11:03 -0700
In-Reply-To: <0000000000003ec128058c7624ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba8e5605a35d4465@google.com>
Subject: Re: WARNING in kernfs_create_dir_ns
From:   syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, gregkh@linuxfoundation.org, hdanton@sina.com,
        hongjiefang@asrmicro.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, longman@redhat.com,
        mareklindner@neomailbox.ch, mingo@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 810507fe6fd5ff3de429121adff49523fabb643a
Author: Waiman Long <longman@redhat.com>
Date:   Thu Feb 6 15:24:08 2020 +0000

    locking/lockdep: Reuse freed chain_hlocks entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1008138be00000
start commit:   72825454 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=38f5d5cf7ae88c46b11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6c439a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353c323a00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: locking/lockdep: Reuse freed chain_hlocks entries

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C034028D631
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 23:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgJMVZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 17:25:22 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:49276 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgJMVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:25:22 -0400
Received: by mail-il1-f198.google.com with SMTP id h13so896563ils.16
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 14:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=60+Mxk64iVZf267Dg3ol8mIlWkb77pqGXvVvfjK/8nw=;
        b=En0WfIhFviOpLV0G1Ayfz4qw/eWYvmvjj1LPqBxyEQZy3eQIm3vmhCqChDvZuaqEs7
         KDr2JLolfqx3u5mRM46r6OCXYprlMa/QCnOhGSyzjtO3ZC919hFjQLo3+TyBy0uAwmN+
         6fCRInmAF5HuliXzTG/LW6VJ8Vy62y0EhMK64kEH7jyl5n5PKYMM0+Hv6gOg7QLPx7LL
         6cXHUw7+v8MTAEtUW2n9w4zOyoAJLYwKtCFCTuue3v1li2Huo0nh7mPPWbuLFffhG1Ph
         JOEn75DfJdZi9gM062L6KwdMO6hWVrXjGPzbz2qAOEy73urrWizRGl2UPGTDHXU8dPDL
         z1nQ==
X-Gm-Message-State: AOAM531+IZHUPU1ffKXrhlKxYcklB0yaKZOTswi0uEn3RjgMXteK+dNJ
        9FwyQPrrpY4QK87q5NnM/3UiZ2ICaDaiRGsno4Q89G6BUvFs
X-Google-Smtp-Source: ABdhPJwVhtVDseEa8IeraqGregoatXB0F17k95IZ5AfbScIuet/lSzLcYkP/8yRPqJa5oVjbN8dBctmR1jNS5xjocfQvr1FCD3R/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca3:: with SMTP id 3mr1517139ilg.95.1602624321356;
 Tue, 13 Oct 2020 14:25:21 -0700 (PDT)
Date:   Tue, 13 Oct 2020 14:25:21 -0700
In-Reply-To: <000000000000a03f8d05ae7c9371@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000620d5805b1940d15@google.com>
Subject: Re: WARNING: can't access registers at asm_sysvec_reschedule_ipi
From:   syzbot <syzbot+853f7009c5c271473926@syzkaller.appspotmail.com>
To:     alexandre.chartre@oracle.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    64a632da net: fec: Fix phy_device lookup for phy_reset_aft..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11580c80500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c06bcf3cc963d91c
dashboard link: https://syzkaller.appspot.com/bug?extid=853f7009c5c271473926
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c1bc6f900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+853f7009c5c271473926@syzkaller.appspotmail.com

WARNING: can't access registers at asm_sysvec_reschedule_ipi+0x12/0x20 arch/x86/include/asm/idtentry.h:586


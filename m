Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEEB61A0E13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgDGNDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 09:03:21 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:37260 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgDGNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:03:20 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id BC50A12F211;
        Tue,  7 Apr 2020 22:03:19 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-18) with ESMTPS id 037D3I3Z154581
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 7 Apr 2020 22:03:19 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-18) with ESMTPS id 037D3H6D892892
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 7 Apr 2020 22:03:17 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 037D3Gpb892808;
        Tue, 7 Apr 2020 22:03:16 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: KCSAN: data-race in __fat_write_inode / fat12_ent_get
References: <0000000000000cfff005a26226ce@google.com>
        <874ku0sncc.fsf@mail.parknet.co.jp>
        <CACT4Y+YaM9Qj9V9G7G+aQrmfxfdtyBX4WXXsBamUjyMMpEeEdg@mail.gmail.com>
        <877dyveq1h.fsf@mail.parknet.co.jp>
        <CACT4Y+ZQ4Uw7uP36ULiAQ_MSB8KkXhBSZhWTXZaMybn2acK1Sg@mail.gmail.com>
Date:   Tue, 07 Apr 2020 22:03:16 +0900
In-Reply-To: <CACT4Y+ZQ4Uw7uP36ULiAQ_MSB8KkXhBSZhWTXZaMybn2acK1Sg@mail.gmail.com>
        (Dmitry Vyukov's message of "Tue, 7 Apr 2020 12:39:28 +0200")
Message-ID: <874ktva1nv.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

>> You meant I can regenerate a disk image from that log (if so, how)?
>>
>> If not, for next time, it would be helpful if syzkaller provides the log
>> to regenerate the corrupted image (or saving a corrupted image) to
>> reproduce this, then I can try to detect the corruption pattern early.
>
>
> I've converted the program to C using syz-prog2c:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#syzkaller-reproducers
> then slightly changed the generated program to dump the file to disk
> rather than mounting.
>
> The resulting image is attached (archived because it's mostly zeros).

Thank you! I think I can see now why the generated image became the
cause of this.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

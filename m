Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D8023FCD9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 07:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHIFPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 01:15:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34923 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgHIFPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 01:15:10 -0400
Received: by mail-io1-f70.google.com with SMTP id s5so4752562iow.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 22:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+7GquL5yQSGcFGMZlACJ2Y2BFlEpHb0ViyNa4GHMUYI=;
        b=XQMFj4T0pmEB45Iw0B1kSnJLdfZ7no2L1WFqI/JkgAF34zgpnq/8nkK9LrClR4g9zk
         fcpad+5LBHuyVizfeZ6EDNDrsOg7jm9AevsoFpiqgj17w0lYzoTQvTNo+IIya3aRtHtC
         XEXuFabWPKmRSUmTHEHACz1fa7wyo5Obw9o804VtH3iDHGRnuBmsBlU9199msinfN8fa
         BTxVgIF6JKJmm3M7ks2iBrOpiw0M1Tp355OHuCMpvC0Ek1WDgNdTwYE62vXxF/6FttJj
         gkIBsYGQ66LtMH0rlB+cX6AzLsjmR0C+xNge00WgBYy0w9IlASegcOJKmeCDHVqdTXMe
         eTWA==
X-Gm-Message-State: AOAM530kA307SLevkhtoX4RFZUJREB+aoKsNg1QUK2N7iGI2/s5n1aFA
        2seafIHY9LhNtlzY1SB6cfDQU/V1/DFkvAc+hrSJ+ZiZtkKc
X-Google-Smtp-Source: ABdhPJwnoROO8orXk27MbZoY6LmPmQEmrUZnYlYAjH2J4bAGvlMJDDzVwIZ0hH60TV5qaTtB7u2wVG/qNSiGwWh/MNVTaKiDIsBk
MIME-Version: 1.0
X-Received: by 2002:a92:918b:: with SMTP id e11mr12138160ill.201.1596950109419;
 Sat, 08 Aug 2020 22:15:09 -0700 (PDT)
Date:   Sat, 08 Aug 2020 22:15:09 -0700
In-Reply-To: <000000000000cde53e05ac446157@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fefd5e05ac6aeb99@google.com>
Subject: Re: WARNING: ODEBUG bug in put_device
From:   syzbot <syzbot+a9290936c6e87b3dc3c2@syzkaller.appspotmail.com>
To:     bgolaszewski@baylibre.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, jdelvare@suse.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, marcel@holtmann.org, netdev@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 6f8c8f3c31015808100ee54fc471ff5dffdf1734
Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu Aug 8 08:01:44 2019 +0000

    hwmon: pmbus: ucd9000: remove unneeded include

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1550298a900000
start commit:   47ec5303 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1750298a900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1350298a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bb894f55faf8242
dashboard link: https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b69a52900000

Reported-by: syzbot+a9290936c6e87b3dc3c2@syzkaller.appspotmail.com
Fixes: 6f8c8f3c3101 ("hwmon: pmbus: ucd9000: remove unneeded include")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

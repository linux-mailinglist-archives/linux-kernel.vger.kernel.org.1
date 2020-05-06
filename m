Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE751C6C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 10:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgEFIyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 04:54:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:52892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgEFIyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:54:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 362F8AB8F;
        Wed,  6 May 2020 08:54:20 +0000 (UTC)
Message-ID: <1588755226.13662.17.camel@suse.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hfa384x_usbin_callback
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com>,
        andreyknvl@google.com, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, nishkadg.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Date:   Wed, 06 May 2020 10:53:46 +0200
In-Reply-To: <00000000000039420505a14e4951@google.com>
References: <00000000000039420505a14e4951@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 20.03.2020, 12:28 -0700 schrieb syzbot:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d74573e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d42d68643a35f71ac8a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fa561de00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d74573e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
> 

Hi,

is this bug still active and can a test be run on it? I requested one
yesterday. If my analysis is correct this bug has security
implications, so it is kind of important.

	Regards
		Oliver


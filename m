Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267582659D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 09:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgIKHCD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Sep 2020 03:02:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42917 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgIKHCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:02:01 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 530AECED19;
        Fri, 11 Sep 2020 09:08:55 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Linux-kernel-mentees] [PATCH v2] Bluetooth: Fix memory leak in
 read_adv_mon_features()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200909072551.1101031-1-yepeilin.cs@gmail.com>
Date:   Fri, 11 Sep 2020 09:01:59 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: 8BIT
Message-Id: <15999FE1-5227-4D55-8E3C-39142725FDA5@holtmann.org>
References: <20200908200635.1099360-1-yepeilin.cs@gmail.com>
 <20200909072551.1101031-1-yepeilin.cs@gmail.com>
To:     Peilin Ye <yepeilin.cs@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peilin,

> read_adv_mon_features() is leaking memory. Free `rp` before returning.
> 
> Fixes: e5e1e7fd470c ("Bluetooth: Add handler of MGMT_OP_READ_ADV_MONITOR_FEATURES")
> Reported-and-tested-by: syzbot+f7f6e564f4202d8601c6@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=f7f6e564f4202d8601c6
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> I forgot the "Link:" tag yesterday. Sorry about that.
> 
> Change in v2:
>    - add a proper "Link:" tag.
> 
> net/bluetooth/mgmt.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


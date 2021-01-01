Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D50F2E8358
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 10:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhAAJFN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Jan 2021 04:05:13 -0500
Received: from smtp.h3c.com ([60.191.123.50]:18464 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbhAAJFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 04:05:12 -0500
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam02-ex.h3c.com with ESMTP id 101939aW099159;
        Fri, 1 Jan 2021 17:03:09 +0800 (GMT-8)
        (envelope-from gao.yanB@h3c.com)
Received: from DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 1 Jan 2021 17:03:12 +0800
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([fe80::81d1:43f5:5563:4c58])
 by DAG2EX08-IDC.srv.huawei-3com.com ([fe80::81d1:43f5:5563:4c58%10]) with
 mapi id 15.01.2106.002; Fri, 1 Jan 2021 17:03:11 +0800
From:   Gaoyan <gao.yanB@h3c.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2]net:ppp: remove disc_data_lock in ppp line discipline
Thread-Topic: [PATCH] [v2]net:ppp: remove disc_data_lock in ppp line
 discipline
Thread-Index: AdbgF4nu3oTHId93RmKcCrU29a4qZw==
Date:   Fri, 1 Jan 2021 09:03:11 +0000
Message-ID: <edd8f7978f674449bca8c436207c34f5@h3c.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.161.27]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 101939aW099159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg KH:

We have a potential race on dereferencing tty->disc_data, so we should use some locks to avoid the competition.
In the current version, it defines disc_data_lock to protect the race of ppp_asynctty_receive and ppp_asynctty_close.
However, I think when cpu A is running ppp_asynctty_receive, another cpu B will not run ppp_asynctty_close at the same time.
The reasons are as follows:

Cpu A will hold tty->ldisc_sem before running ppp_asynctty_receive. If cpu B wants to run ppp_asynctty_close, it must 
wait until cpu A release tty->ldisc_sem after ppp_asynctty_receive.

So I think tty->ldisc_sem already can protect the tty->disc_data.

About your question:
What changed from v1?
==>just change some description.
And how did you test this?  Why remove this lock, is it causing problems somewhere for it to be here?
==>Somedays ago, There is a problem in n_tty line discipline. Specific description is here:
https://lkml.org/lkml/2020/12/9/339
At the beginning I tried to add a lock in the layer of n_tty, until I find the patch 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.9-rc4&id=83d817f41070c48bc3eb7ec18e43000a548fca5c
About the patch, Specific description is here:
https://lkml.org/lkml/2018/8/29/555


Thanks
Gao Yan




----- Original mail -----

On Fri, Jan 01, 2021 at 11:37:18AM +0800, Gao Yan wrote:
> In tty layer, it provides tty->ldisc_sem to protect all tty_ldisc_ops 
> including ppp_sync_ldisc. So I think tty->ldisc_sem can also protect 
> tty->disc_data, and the disc_data_lock is not necessary.
> 
> Signed-off-by: Gao Yan <gao.yanB@h3c.com>
> ---
>  drivers/net/ppp/ppp_async.c   | 11 ++---------
>  drivers/net/ppp/ppp_synctty.c | 12 ++----------
>  2 files changed, 4 insertions(+), 19 deletions(-)

What changed from v1?

And how did you test this?  Why remove this lock, is it causing problems somewhere for it to be here?

thanks,

greg k-h

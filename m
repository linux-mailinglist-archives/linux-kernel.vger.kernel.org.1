Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40452DC157
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgLPNdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:33:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:43871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgLPNdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608125487;
        bh=wJvxKbVu5Goj6d/CvAE61j8JoBUlkpdze0dLBH96NwA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=M3ACKEvUTaZSDm+u6HiWH7yrlXZXg9eBEY6dESxXbQAxID94p8nuWWxra6Trs9YxT
         qdfPNE8ovPr6WPwtm2SQ0SmTR8E/ozkqOUBi/Yu7zAGLA+BO9orr2KmkrUOkG1iN/R
         2h0d1gRhcwDyreLXEbmRyIqSwFSqIlLYXKgOInws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1kUAIb0v5y-00NjXQ; Wed, 16
 Dec 2020 14:31:27 +0100
Message-ID: <fe612bbbeedd0ee0d03d04c7341ea62406b957c7.camel@gmx.de>
Subject: regression:  nouveau fifo: fault 01 ==> channel 1: killed ==> dead
 desktop
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>
Date:   Wed, 16 Dec 2020 14:31:25 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:X0H3gZFoNt/xPoiBLfk2/uoLGovPlEDqAr+C2ALRfdQnY8AaUJ1
 Z6N7NS2BvxLJMFP8yF2v+9Ik1GOqmzxI9jfSRNDbAHGJnZBuDCWb8WgrE2TFcfr2gtr1gfC
 LEabSMvDAAe6Df7J9/XrP3mIbxkcU7wFXZxablZn+ZakbJ/+4gXaFPuJRGuJn0RskpSB25j
 bAP8uRjPMIpNKnLYUPhyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VLfXP1FbdO0=:C67pQawelYx6Xjn149Az7A
 CBYq3OpRzY/g+fWy1tBGb9g8h69dRXYwB/LUDYz71kkkvXNb5vYZktM0WlU4rX2yQoJnswREq
 zAXKNTP52Pus6E/m/V0hSmgUln3DhVQng4Na1mzSLr1ZNvUEHMVyESB+naY0/Ci4pRmVZS+/Q
 qOFH+pxkmczPqJ76NbS4ZJNQ9GIyKcEInlsXdmXc+0s8+97mNpC7VobU2OynpWPVBgmhmIAZ6
 OsYADenVrp9WCL7C/JEnHQJmfwy06t6qWTVMeP/J9KVm6OLnCW62GMjz/XIcLce4C38n17oFE
 6K+rsdsHODqle5+udtDXo5hwMExM8VLbeoCKNaMuhjWG0xcH+kZCwRzsA73m6GEDZab7GOvCz
 M1v11jKAAnDO07YPEwN6qxRo56m3/WvAdvaICNhbSlO5IwEifWpd14d5DDLc6Axn5mckTvWB3
 K49DeKgIAAItyOzcQqzpbwcJ4z2ICY58nwsRwzTzP2mivHQW1hm+H0S40doMELjnYoD1PI8fn
 a51OgnNlfyEiYrIgP6NZK8L5vmxzZgU2P2m/eh+pj6eCjQ+RQ/c2TiNp+bspjHJfPn8Po5QKz
 2qatRwmCdg2ZwGrr+X0CKKhuZp9BVB13Q257PwLjKu3lKp6TiXXmO+a5T54JjIJ1YAfVUs24w
 epjbv+eoLlCPmM/KDzKPrKJ5npcdng82ykjD0I53B8czFgNYRaaq7L/s+m/QtkCrI23H9jGjL
 3GJY7KqJ5z/D+iD+1m9mQvtrEf7shAQaEzHES5B/Taj/XMAD6d57P6FTyk+4jl3fBuhkm5I3I
 l8pDAqVyuq8IciN9XBfDei0q9drrDyGWorGJ7dO9zmTh+Q9ieVVaVAn65m/8hHXeiAK65Y4NK
 3SuJN0CvSA52jKN8tJkA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the below new to 5.11 cycle badness happens, it's time to reboot.

...
[   27.467260] NFSD: Using UMH upcall client tracking operations.
[   27.467273] NFSD: starting 90-second grace period (net f00000a0)
[   27.965138] Bridge firewalling registered
[   39.096604] fuse: init (API version 7.32)
[  961.579832] nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 000000000069f000 engine 15 [CE0] client 01 [HUB/CE0] reason 02 [PTE] on channel 1 [00ff73d000 DRM]
[  961.579840] nouveau 0000:01:00.0: fifo: channel 1: killed
[  961.579844] nouveau 0000:01:00.0: fifo: runlist 0: scheduled for recovery
[  961.579850] nouveau 0000:01:00.0: fifo: runlist 4: scheduled for recovery
[  961.579853] nouveau 0000:01:00.0: fifo: engine 4: scheduled for recovery

Box is aging generic i4790 desktop box with...
01:00.0 VGA compatible controller: NVIDIA Corporation GM204 [GeForce GTX 980] (rev a1)

	-Mike


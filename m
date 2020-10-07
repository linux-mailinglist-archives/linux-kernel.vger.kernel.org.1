Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F57285A94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgJGIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:36:12 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16702 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:36:11 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201007083608epoutp0182b3028a621b17f71243811b6592252b~7qN8XKCt22356723567epoutp01R
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:36:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201007083608epoutp0182b3028a621b17f71243811b6592252b~7qN8XKCt22356723567epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602059768;
        bh=2ojU3QIaxUJNnLtZAJiFzrOCtmVXkzt15QRidstxv7s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jb1mC7JkVLh6u198BM1aDkXzal/jmMwfquC473XAQVlpAD0QXMhitswYsZOHAu6kr
         bX1AcHMNPpsftiJ/w1smSzbAWUMqpZfMx9y3RH/aXJiYPyug8sY2cljzPTG7yBfyxf
         R0Ev2yDlx/y83L3E/qswV5UUmhRrEL7lcQHCgHVo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201007083608epcas1p114999cdcc1a220be6fa215b7da7acfb0~7qN8Kkz3A1512115121epcas1p1-;
        Wed,  7 Oct 2020 08:36:08 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4C5njg2J9MzMqYlp; Wed,  7 Oct
        2020 08:36:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.DD.09582.3FD7D7F5; Wed,  7 Oct 2020 17:36:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201007083603epcas1p22050f982bbf149ad060b723d763de1b3~7qN3NZm-V0430304303epcas1p2q;
        Wed,  7 Oct 2020 08:36:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201007083603epsmtrp24a0ac6758b88021e3b6d52ad397b2614~7qN3M4Npw2968029680epsmtrp2I;
        Wed,  7 Oct 2020 08:36:03 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-9c-5f7d7df363aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.E4.08745.2FD7D7F5; Wed,  7 Oct 2020 17:36:02 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201007083602epsmtip16865f5f1a5ec8066a5ca8e15ef1373e2~7qN3CmGCT0077900779epsmtip1w;
        Wed,  7 Oct 2020 08:36:02 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] exfat fixes for 5.9-rc9
Date:   Wed, 7 Oct 2020 17:36:03 +0900
Message-ID: <009901d69c84$e422f280$ac68d780$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdacbtQcD3zlSbyxQIanys0bdsKSfg==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmru7n2tp4gyevxS0u75rDZvGo7y27
        A5PHiRm/WTw+b5ILYIrKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21
        VXLxCdB1y8wBGq+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L
        10vOz7UyNDAwMgWqTMjJ+Lu+nangEWfFtv09TA2Mf9i7GDk5JARMJJ6ub2PqYuTiEBLYwShx
        8MwJZgjnE6PE4ecNjBDOZ0aJD4ebGGFa7t2bAlW1i1Fi4tEXUM5LRonVW6eygVSxCehK/Puz
        H8jm4BARMJP4tsQRxGQWUJK4ekoOxBQW0JZYdToLpJhFQEVi1rPprCA2r4ClxLPNLcwQtqDE
        yZlPWEBsZgF5ie1v5zBDnKAg8fPpMrB6EQE9iVubv7FD1IhIzO5sA7tGQmAfu8SNfROgbnaR
        eLr/LAuELSzx6vgWqPelJD6/2wt2pYRAtcTH/VDzOxglXny3hbCNJW6u38AKcb2mxPpd+hBh
        RYmdv+cyQqzlk3j3tYcVYgqvREebEESJqkTfpcNMELa0RFf7B6ilHhJz/y5inMCoOAvJk7OQ
        PDkLyTOzEBYvYGRZxSiWWlCcm55abFhgjBzTmxjB6U7LfAfjtLcf9A4xMnEwHmKU4GBWEuFN
        966JF+JNSaysSi3Kjy8qzUktPsRoCgz2icxSosn5wISbVxJvaGpkbGxsYWJmbmZqrCTO+/CW
        QryQQHpiSWp2ampBahFMHxMHp1QDU42i5KKo2aL6OfVbljL+Xdi4sUVg5tP/3nPVXyxnDex+
        EXWJR25awb/Toqn9M1RuzJTdym98dMqBokJD97Y7MixGu/+K+lvFHuvIvH84p1TSkUUl6/ZC
        p1nnWF+4bl9R4Sic/2RPYY3Qr7CEHumLRVeWlh9Z2K9WNqukyP9HXZ/pArO6d/8+Ns+2O7Vu
        ltlS8SwrvlMyS0XOyvsnPVQL8JB6tva3rbPtQQPFlqfhX8uN/nwTjzm+Snqd313mNM6+1tV7
        d/udNL5heUhZMDj+XlD1765g3Rm+l1pYny0zO6OS9WQ61/SPqiGmy78KGOfeCLroycU4I0ZH
        QjZxg1qU3c/EAy45szacWh7eyxWtxFKckWioxVxUnAgA7kS7DQAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSnO6n2tp4g20nLC0u75rDZvGo7y27
        A5PHiRm/WTw+b5ILYIrisklJzcksSy3St0vgyvi7vp2p4BFnxbb9PUwNjH/Yuxg5OSQETCTu
        3ZvC3MXIxSEksINR4t3sHawQCWmJYyfOACU4gGxhicOHiyFqnjNKtE9+xwJSwyagK/Hvz342
        kBoRATOJb0scQUxmASWJq6fkQExhAW2JVaezQIpZBFQkZj2bDjacV8BS4tnmFmYIW1Di5Mwn
        LBCdehJtGxlBwswC8hLb385hhrhFQeLn02VgrSJAJbc2f2OHqBGRmN3ZxjyBUXAWkkmzECbN
        QjJpFpKOBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgkNYS2sH455VH/QOMTJx
        MB5ilOBgVhLhTfeuiRfiTUmsrEotyo8vKs1JLT7EKM3BoiTO+3XWwjghgfTEktTs1NSC1CKY
        LBMHp1QDE/vqKX5cNWyPDi0WdF98rvfQCZYj9/cued3fMjll/8LeMyuOFpb3H7IvqLQo2Pfu
        ocLh2prXDexO1Usu7cndYLxp5R55TpZJe/gPV91wXWQdelz38B21dXd2P98op/2Qv1F9wvIC
        4bozYQxGQRrs+akv1c+v4lLctyr96DNRaYELzSWrPD8p//pgn/Z8cqi2Fc9DaX2WfU9TXX0e
        yGyKcglUc1oafcDUf6GBkq7msqNT2C5Jn+a9rVHf2xfM83VrFkto9OUUycLOiBfP2lXbWJqd
        55jkKQheC9ieM48rsChgwUqW9m6F50sttKJ+t8U6WJm2b9De4xu8/eyqCzMPmieZiTjua1N8
        WRk2N8RYiaU4I9FQi7moOBEA+jay9NACAAA=
X-CMS-MailID: 20201007083603epcas1p22050f982bbf149ad060b723d763de1b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201007083603epcas1p22050f982bbf149ad060b723d763de1b3
References: <CGME20201007083603epcas1p22050f982bbf149ad060b723d763de1b3@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat fixes pull request for v5.9-rc9. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.9-rc9

for you to fetch changes up to 8ff006e57ad3a25f909c456d053aa498b6673a39:

  exfat: fix use of uninitialized spinlock on error path (2020-10-07 14:27:13 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Fix use of uninitialized spinlock on error path.
  - Fix missing err assignment in exfat_build_inode().

----------------------------------------------------------------
Namjae Jeon (1):
      exfat: fix use of uninitialized spinlock on error path

Tetsuhiro Kohada (1):
      exfat: fix pointer error checking

 fs/exfat/cache.c    | 11 -----------
 fs/exfat/exfat_fs.h |  3 ++-
 fs/exfat/inode.c    |  2 --
 fs/exfat/namei.c    | 13 ++++++-------
 fs/exfat/super.c    |  5 ++++-
 5 files changed, 12 insertions(+), 22 deletions(-)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABD2E0644
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgLVG6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 01:58:52 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:17447 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLVG6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 01:58:51 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201222065808epoutp048389ed9a81beab8192bc0d2c11372aaf~S96EYJ7rF1801718017epoutp04W
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:58:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201222065808epoutp048389ed9a81beab8192bc0d2c11372aaf~S96EYJ7rF1801718017epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1608620288;
        bh=waAzjy9cNePp2peDoapjsqmsDfSFmd3rxP7qpE4lHKI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=f2yrKvdfXWmc/fGz2uEBRFejqdDXnTnof+sFYjzWi3Xf5QhO/IzL35z/IE1n8diEK
         J6h8jALl4TIQg/NXMKdnPdZ8I5HTa5PfxO85uT9V5BDcLA8sxsMiv6Ow7HGKzAf26l
         yoaxCDlHVrQtuwth3kwwaazXhHJLLWTy+uq9Fr74=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201222065807epcas1p3c542296ab097c69484f621e0fbdf8744~S96EGaH6q0346903469epcas1p3I;
        Tue, 22 Dec 2020 06:58:07 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4D0RxV4LyPzMqYkf; Tue, 22 Dec
        2020 06:58:06 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.BA.09577.CF891EF5; Tue, 22 Dec 2020 15:58:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201222065804epcas1p4968e405d34b6c0ef755c55d3dae624c6~S96Alha1v0964109641epcas1p4k;
        Tue, 22 Dec 2020 06:58:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201222065804epsmtrp159ec724bdb40f4b5c8742c5c4fa76e93~S96Ak_gyX1881818818epsmtrp1Z;
        Tue, 22 Dec 2020 06:58:04 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-72-5fe198fc0539
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.A1.13470.BF891EF5; Tue, 22 Dec 2020 15:58:03 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201222065803epsmtip10cd58475080b24838e1ae0b72115bd8a~S96AYzSNr1602216022epsmtip1w;
        Tue, 22 Dec 2020 06:58:03 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
Subject: [GIT PULL] exfat update for 5.11-rc1
Date:   Tue, 22 Dec 2020 15:58:04 +0900
Message-ID: <00ac01d6d82f$cb740850$625c18f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AdbYGTSCtXbozFWATMGAtDTh84FOKA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmge6fGQ/jDTbMk7O4vGsOm8WWf0dY
        LR71vWV3YPY4MeM3i0ffllWMHp83yQUwR+XYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gAtUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        GBoU6BUn5haX5qXrJefnWhkaGBiZAlUm5GR8fnqWveA2e0XL49VsDYx72LoYOTgkBEwkju0x
        7WLk4hAS2MEosWzeE0YI5xOjxKJ171ghnG+MEu/6VgB1cIJ1fPv0lR0isZdR4vGDWSwQzktG
        if4bF8Gq2AR0Jf792Q+2Q0TATOLbEkeQMLOAv0Tb1cNMILYwUMmbrsusIDaLgKrE2yPzWUDK
        eQUsJbYcrAcJ8woISpyc+YQFolVeYvvbOcwQNyhI/Hy6jBUiLiIxu7MNLC4ioCexa/VGsKMl
        BM6xSyya+IcVosFFYtPfc1C2sMSr41vYIWwpiZf9beyQoKiW+Lgfan4Ho8SL77YQtrHEzfUb
        WEFKmAU0Jdbv0ocIK0rs/D2XEeIEPol3X3tYIabwSnS0CUGUqEr0XYJ4VkJAWqKr/QPUIg+J
        x0tsJzAqzkLy4ywkP85C8tcshL0LGFlWMYqlFhTnpqcWGxaYIkf0JkZwAtSy3ME4/e0HvUOM
        TByMhxglOJiVRHjNpO7HC/GmJFZWpRblxxeV5qQWH2I0BQb6RGYp0eR8YArOK4k3NDUyNja2
        MDEzNzM1VhLnTTJ4EC8kkJ5YkpqdmlqQWgTTx8TBKdXAtNy/5YZC7y0pBdE/lZ3hjqeDwj5N
        2Kz+r2VD1laFfeLxF52vJ3BLMfyqvFbczvvdjFFtsZtZDsNf1a0KG88Wzl1272xSnuFEfrlK
        l7ql30ovl72+J2QZs/XiygOxiZ9YyjYsqYi/mp30t8ic059bfmP3ix+XH286sumDkccx29tF
        vq9m/PZjf8WQkKcWlxplsoCx/obH78xHExNTXv6Y3ety3vuDxTyN/g0LJ6y+KTvn4oG5qt83
        WB9MnPeg63BPQtA2U4YDWpcmR9+Z+NI4btn3r0Ft4vHzz0fPeu62cNGGLVfmd//U3S/+8qL+
        vg+8JbLv3Xl7Ra8xB7rtvJyz6HkAmzH37579Ha+uXGY9zq/EUpyRaKjFXFScCABnb5uXCQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnO7vGQ/jDdYftbG4vGsOm8WWf0dY
        LR71vWV3YPY4MeM3i0ffllWMHp83yQUwR3HZpKTmZJalFunbJXBlfH56lr3gNntFy+PVbA2M
        e9i6GDk5JARMJL59+srexcjFISSwm1Fic9dXqIS0xLETZ5i7GDmAbGGJw4eLIWqeM0pMWL0a
        rIZNQFfi35/9bCA1IgJmEt+WOIKYzAL+Evcvu4NUCANVvOm6zApiswioSrw9Mp8FpIRXwFJi
        y8F6kDCvgKDEyZlPWCA69STaNjKChJkF5CW2v53DDHGLgsTPp8tYIeIiErM728DiIkDlu1Zv
        ZJ3AKDgLyaRZCJNmIZk0C0n3AkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwWGt
        pbmDcfuqD3qHGJk4GA8xSnAwK4nwmkndjxfiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
        QHpiSWp2ampBahFMlomDU6qBKX77P+OFarUqbh/Z3Cd6vlB2eSG67sAHJsWKd4dvZDr2h85K
        uJmyufCEzLL1Z1IP/RH4k65qJMF6QPvvOnnFUyf2layemit4Qvb4pAupa3mXnIuNmTg54e1+
        B3Nftj5xlkmGbtEXUxgvlXz7VeM1V/Zy89nwMj2Rrv8C5vM43sue1V0/57rTu7KVSvq/d7Bc
        dNxuo6pU6Ny4spenbM2z6WH7uNKjLTeodtTJt1xNYjn7Y4bwV36mBcHzVPe/fyhgbaMb6vd/
        XpnWijrXyJPft4T/sRHQr8mrencqh/PnkuZDSx+3XVavvTB7kw3LAUfe3736+9wS+hfL8GZs
        Zjr8tTLQU2iyvhiTNOuduF4LJZbijERDLeai4kQAWALDHtoCAAA=
X-CMS-MailID: 20201222065804epcas1p4968e405d34b6c0ef755c55d3dae624c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201222065804epcas1p4968e405d34b6c0ef755c55d3dae624c6
References: <CGME20201222065804epcas1p4968e405d34b6c0ef755c55d3dae624c6@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.11-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 2c85ebc57b3e1817b6ce1a6b703928e113a90442:

  Linux 5.10 (2020-12-13 14:41:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.11-rc1

for you to fetch changes up to 9eb78c25327548b905598975aa3ded4ef244b94a:

  exfat: Avoid allocating upcase table using kcalloc() (2020-12-22 12:31:17 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Avoid page allocation failure from upcase table allocation.

----------------------------------------------------------------
Artem Labazov (1):
      exfat: Avoid allocating upcase table using kcalloc()

 fs/exfat/nls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248AC286F19
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgJHHSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:18:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:38493 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgJHHR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:17:59 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201008071758epoutp047cb250986a10bbc91eadbdc41478cadc~78y_OGGRW3247032470epoutp04I
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:17:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201008071758epoutp047cb250986a10bbc91eadbdc41478cadc~78y_OGGRW3247032470epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602141478;
        bh=D7TrO2gtlsUp4TeZi+CZcJBHHLsLnIlsDOu+joF8goE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IAnqBBhIoA3T8Rm+dqgDeb/mVGZLkS/cdXKxbtbjytmd0VosdKmsQD51CPEvj5HjE
         10Clp30ni/4l6HoT1il94gOTeSJPqePNElaYs1kQ8ymQDIM2S/N4qMDNWDgJNDjbG8
         y4U/yhu4ZKVs/SsOWgPTXt4FZttsOrh1zdM9dvmI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20201008071757epcas5p41cb9c5ec51216fe2423d936d2cb140c0~78y9vTvBF2056220562epcas5p4T;
        Thu,  8 Oct 2020 07:17:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.AF.09922.52DBE7F5; Thu,  8 Oct 2020 16:17:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811~78xqfKEWj2308523085epcas5p2p;
        Thu,  8 Oct 2020 07:16:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201008071628epsmtrp16515fb01720e97a643864021481c35b7~78xqeVIIs1688916889epsmtrp1a;
        Thu,  8 Oct 2020 07:16:28 +0000 (GMT)
X-AuditID: b6c32a4a-337ff700000026c2-4a-5f7ebd2576a2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.9A.08745.BCCBE7F5; Thu,  8 Oct 2020 16:16:27 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201008071624epsmtip1725f392a040f519009dbe42f9f635132~78xndnNkB1815718157epsmtip13;
        Thu,  8 Oct 2020 07:16:24 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     linux@armlinux.org.uk, ndesaulniers@google.com, caij2003@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de, maz@kernel.org,
        valentin.schneider@arm.com, vincent.whitchurch@axis.com,
        nhuck@google.com, akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        will@kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 0/3] IRQ stack support for ARM
Date:   Thu,  8 Oct 2020 12:45:30 +0530
Message-Id: <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7bCmhq7q3rp4g8dvpSwmTHvBYnFxd6rF
        nPVr2CymXZzEbLFy3k5Gi02Pr7FaXN41h83i0NS9jBaH57exWOycc5LV4sOE/0wWmw9/YrHY
        vGkqs8Whk3MZLbbP/8lscX6bv0XLHVMHQY8189Ywely+dpHZ4/q6AI+ds+6yeyzYVOqxaVUn
        m8e7c+fYPU7M+M3isXlJvUffllWMHp83yQVwR3HZpKTmZJalFunbJXBlrJm1kKVgB3fF9ucP
        2BoYH3N0MXJySAiYSJyZsYKpi5GLQ0hgN6NEZ/9zVgjnE6PE2fa7jBDOZ0aJxVMOMsO0fLlw
        lg0isYtR4sm611D9XxklPl5dyQpSxSagJ7Fq1x4WkISIwBQmiXlfl4M5zAKLGCXmXOxnBKkS
        Bqo6f+sgWAeLgKrEsac/WUBsXgF3iRuzn0Ltk5O4ea6TGaRZQmAuh8SGLdfYuxg5gBwXiW+P
        nCBqhCVeHd/CDmFLSbzsb2OHqG9mlPi0by0jhDOFUWLpxY+sEFX2Eq+bG5hABjELaEqs36UP
        EZaVmHpqHROIzSzAJ9H7+wkTRJxXYsc8GFtVouXmBqgx0hKfP35kgbA9JFb8/Ql2hJBArMSW
        i2uZJzDKzkLYsICRcRWjZGpBcW56arFpgVFearlecWJucWleul5yfu4mRnBS0vLawfjwwQe9
        Q4xMHIyHGCU4mJVEeNO9a+KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yr9OBMnJJCeWJKanZpa
        kFoEk2Xi4JQCevCOkrDihYrr+15Vpc1vj/WvW79K+Oxv89Ji9VP3GYt91G/Ebb4wW0x73eM7
        iX6NWrsv5aRubNKK9o6t7uHfdtVqrXOa+dr/GaemBGRNnvUkVkv68ePylwwr5rqJrQlIDzyd
        tD5cMu7G+6YT28vfWJfuN/F0N1R+tsKJY0KWhMKfI84rk7nMVj4+sY5N8lVpySPvVxm6LxVm
        eK6f83HL60sXpHlEeC5MN/xV5/Pk21Ulble/jO5uM/XVPuwdTq0FrKYVLQozfOSbbd/9NJzU
        djNVNva/wJ/QWf5shbIC0SYy633erTqb+dL80dQrk19eM2i4nT7TnunKQ7GHTbLBtW2vvc8v
        TXLQcXb6GaegxFKckWioxVxUnAgAEimZSbkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnO7pPXXxBnvXWVlMmPaCxeLi7lSL
        OevXsFlMuziJ2WLlvJ2MFpseX2O1uLxrDpvFoal7GS0Oz29jsdg55ySrxYcJ/5ksNh/+xGKx
        edNUZotDJ+cyWmyf/5PZ4vw2f4uWO6YOgh5r5q1h9Lh87SKzx/V1AR47Z91l91iwqdRj06pO
        No93586xe5yY8ZvFY/OSeo++LasYPT5vkgvgjuKySUnNySxLLdK3S+DKWDNrIUvBDu6K7c8f
        sDUwPuboYuTkkBAwkfhy4SxbFyMXh5DADkaJVdt2MkEkpCV+/nvPAmELS6z895wdougzo8SO
        uT/AitgE9CRW7drDApIQEVjCJHH00mRWEIdZYBmjRPvftawgVcJAVedvHQSzWQRUJY49/Qk2
        llfAXeLG7KfMECvkJG6e62SewMizgJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
        cHhrae1g3LPqg94hRiYOxkOMEhzMSiK86d418UK8KYmVValF+fFFpTmpxYcYpTlYlMR5v85a
        GCckkJ5YkpqdmlqQWgSTZeLglGpgkj166bXQ37ksxWlBTsvWlvud+v45oqBcuk0qPKrx+exr
        ITN7uRatb098a/27KVfP/60Qh4e3+fTTO/7w/Yw8tLE85yP3x3L1JvuTm+SkAh5YpQf84++I
        K9pdtXHmrRyH3MaNthGfNzZ+ObHkOvc//v2fHLa1m3k/to6OlpV7oM1w5umKjH0Ljzw+Fzkl
        w09iQ/xzJQveNTlur5rmxXzwulAu+llpyjodi9nHm1f8mc5SyXot2dTsd4eMT1Lh/w/9Fey8
        Io7B2ml7jk14H+K4ayHz9xW8Jf/8rytvfnv5juguztwnPuvbJezyNq0V1T1tWqvt/lbqOU+E
        qZpfpNianTsVT3Ff6Nz3VLXm+3EeJZbijERDLeai4kQAnXyV194CAAA=
X-CMS-MailID: 20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811
References: <CGME20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Observed Stack Overflow on 8KB kernel stack on ARM specially 
incase on network interrupts, which results in undeterministic behaviour. 
So there is need for per cpu dedicated IRQ stack for ARM.

As ARm does not have extra co-processor register
to save thread info pointer, IRQ stack will be at some
performance cost, so code is under CONFIG_IRQ_STACK.

and we don't have much knowledge and set up for CLANG
and ARM_UNWIND, so dependency added for both cases.

Tested patch set with QEMU for latest kernel
and 4.1 kernel for ARM target with same patch set.

Maninder Singh, Vaneet Narang (3):
  arm: introduce self pointer in thread info
  arm: introduce IRQ stacks
  arm: Modify stack trace and dump for use with irq stack

 arch/arm/Kconfig                   | 10 ++++++++
 arch/arm/include/asm/assembler.h   | 11 +++++++++
 arch/arm/include/asm/irq.h         | 13 +++++++++++
 arch/arm/include/asm/thread_info.h | 27 ++++++++++++++++++++++
 arch/arm/kernel/entry-armv.S       | 41 ++++++++++++++++++++++++++++++++-
 arch/arm/kernel/irq.c              | 24 +++++++++++++++++++
 arch/arm/kernel/stacktrace.c       | 21 +++++++++++++++++
 arch/arm/kernel/traps.c            | 47 +++++++++++++++++++++++++++++++++++---
 arch/arm/lib/backtrace.S           | 18 +++++++++++++++
 include/linux/thread_info.h        |  4 ++++
 kernel/fork.c                      |  1 +
 11 files changed, 213 insertions(+), 4 deletions(-)

-- 
1.9.1


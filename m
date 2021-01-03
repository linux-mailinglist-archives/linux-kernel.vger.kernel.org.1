Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2632E8E68
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 22:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbhACVWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 16:22:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:33321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbhACVWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609708839;
        bh=tyVCmIkoSkb6PtUj+JJ7qDitC2PSZFcvd9lmlSEV0is=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Z1Sk60CAPcnahBDZaxju+NP0wx7ogablHOH1s0JgFl0aQ4cdIkdZaEaQsLWZvPlBe
         Z58eBve6SYP1temTD7lrojEE5gv8KKvrYAZQsDfj2VcqH4dAVnStmAScTeofoJunGR
         1PFTV+s229jrLDUT60p+x1zifZAiIyW/12CGS8Wo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from chef ([212.114.250.16]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1kPb0Y1hrF-00bp1x; Sun, 03
 Jan 2021 22:20:39 +0100
From:   Julian Sax <jsbc@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Julian Sax <jsbc@gmx.de>
Subject: Bisected regression: /proc/stat reports 0 steal time after commit
 x86/kvm: Move context tracking where it belongs
Date:   Sun, 03 Jan 2021 22:20:25 +0100
Message-ID: <87a6tp3eg6.fsf@chef>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:C7vWOWsmN4/4NbRjZl1+nH+GMFxBhdSMSP7tIJOWXJ4ulfL3bLy
 mVgcWMU0VvrGCDnyHdiJpt+FX0CdKYs+Kt5NtMWEXtfeh4koAg3efDQboDVtwP8FyZXkVIr
 MlLjH37256WpXxFPBr1EPwFaywOwVuLGsUmiJHECQQpy7wwmHiZg9QY2L+s2q+mv2E7Sb+3
 8VQDlqmFT4TyobsAwE3tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eY/VC6+7ZaA=:Az4rvUmu7ncw4XQIseVZtB
 utC8mB2elgSP5Xn6I62Bw1LoPfyRxXKmYDHQH7pZetIUD/5P+d2811sghHvsRHz92CwBQ3ag7
 1RICmWjFG+wwbAROSn1lh6aFqyFUs4GxjNzXuor1QJjQ389T2mr3BJmLYvd+UjinNQzKT6z2f
 fiYP7tazfj+fJGzpNaRxzaG+8YeQgGImRTSVVe605ovnuBmnz9UlO47l9FF/X3OBddVKMz34B
 q0GMJaxrS3CJBj3w4Mx47ex1h/xZTFek8Oz3fg+N24rcXILspUqEWBE+cDko426QPkovDCRCB
 46h5SD5BwixKX/5mRwDCeEqh38naBNZpFS8lKYQOJUnJGd2G/h7v39MQxN7bHDiS+sIv7JnKo
 Tbf4j23Pts/OEW+kZaicGd7EeCa+jjr+VmO2qZzcEsa+Uyq6pd50uP5l8t77TQh9QP5/rXs1A
 lTWr3qkue7P2rNUsMoXBIq8bcjGfX1iio9OjcG/pmLQmdZtNVRFVPYRCvEoX599ps5k3zWCys
 yWlZThJF6NlDpKe9en+I1qgook0HbsNcE1qmG6mggi+D8frTKOp90JpTC4OY7lUs1VDggAO9p
 xkgUN8YLYD5l9anMMs3B5N56kdz1tXbY8TSpshx2YqzZVsX6JXDT9OoxLz0YIWM75wZPc/nb7
 IiHaHOb07DiIvM3m5hYAoi7kRZxB+HJvghvMyYJdZGvT85+xpD0iFabtl724+HhWL29V9pDdT
 YYQgLV+guBXlakAzSI3x/HWCDFkNGsE1V48ClF4YVrEGN1KyC4yy9MUw/rut/fcF4Hp3Pxi4b
 1+3zyaAuawDgaPwBq/c1nZ4VetLdSeVfdzHwjNz+9sqH0xiQ7WcYFaMNTk+XRgg24xcr6c+lC
 1mqw234NiPb7UcO3c5BQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know I am kind of late with this report, but I recently upgraded
from Kernel 5.8 to 5.10 and noticed that all my steal cpu time in htop
was gone, instead the time seems to be added to the sys counter. The
same thing happened in my own scripts, which source from /proc/stat.

After execution of "qemu-system-x86_64 -enable-kvm -m 1G" right after
bootup with no kvm used before this happens:

5.8, good
julian@chef:~$ cat /proc/stat | grep "cpu "
cpu  11235 3 7928 1309820 1360 0 64 0 508 0
#                                     ^ steal

5.10, bad
julian@chef:~$ cat /proc/stat | grep "cpu "
cpu  420 0 1869 37801 746 0 7 0 0 0
#                               ^ steal

I did bisect the problem and ended up at

commit 87fa7f3e98a1310ef1ac1900e7ee7f9610a038bc
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Jul 8 21:51:54 2020 +0200

    x86/kvm: Move context tracking where it belongs

This however does not revert at all on top of the current HEAD and I am
not familiar enough with the area to possibly guess what side effect
could have caused this.

This functionality was pretty nice, because it enabled me to see how the
guest was scheduling etc. It would be nice if that could be brought
back.

Or am I doing the wrong thing to begin with? But then again, htop
breaks in the same way.

Thanks!

Regards,
Julian

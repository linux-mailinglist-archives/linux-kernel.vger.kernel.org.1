Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4EE2B2E29
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgKNPkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 10:40:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:59003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgKNPkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605368438;
        bh=Yy9l8U0I4AcfUNHl5mNY6+eY2n0gQ9V+P/E7vqhJH1Q=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=guOZhMRF/dHA7sMDMZM1GpiCL2/ZHDlctIZbMUSB6R7fOniYFh7JftOtBqGfryeyt
         Ih9k2eM0yl/gdbsLd6zfpmpUx6VXa5KYb7OZuZXrcciScu2jLIhdn8TCxHValWbv72
         /85IOmiFNPzZOvSpvXSHniO9Pc63Xe8cauwneFGs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.100] ([185.6.148.154]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDnI-1kRGsS1cAo-00Cmed for
 <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 16:40:38 +0100
Message-ID: <17c526d0c5f8ed8584f7bee9afe1b73753d1c70b.camel@gmx.com>
Subject: Suggestion: Lengthen the review period for stable releases from 48
 hours to 7 days.
From:   Hussam Al-Tayeb <ht990332@gmx.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 14 Nov 2020 17:40:36 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FWrWt7CbA/82EYRdcLnQ62O4+aRXP7xtLB1tsfDdarlZGF1TTo6
 2QRtTe2n34Ry7NjyFHvQoM2mE2Y5WDbYBAgZcxlcDiK35QdDIe1crCDLo15EG2UE1lj7PWi
 SWXgQsskhtPTghgUGnwb8qpL7Em4lE5CUSachtx05IERs6E/DAkIo/Bhaat/z0j9W0Wah7V
 KhbhYDGXvw4IuJFprUl+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0r1VrjaY7Q=:xVSJ/Go8SCbmOhUU+3GNg5
 sBVYaa4advGQc7dHBvRr5uDjkmAYR6/oKXP10bMb+CJYi/m/RBhyFGsoho+yFR7AhmsezkC1f
 2RrRfySTarXjumSo0mhex/AvnYzBpz4gW3mqolKB1ud0VYfD5BPxoQhunUhR7pyHNLiKLPo4+
 h7+qibbyedueqwxNN+YgR974SFiOcDL6sLQnh3tDLV2qbAdUUIn2bS+TZnCAnGyKF0ZD7OD2J
 zGJ1DrCzZ4eRHdwNyfr+m6gZZzoW3SEs/C1hhN4eSfYwGiRH2cPsVPlw6rU1ELp0feaNqoa6s
 GPGnQafMHomVUL79Nv4p2tppUvdFH1JMfnJRHJtC+DkEgnRY+GMTEitCqMLSk2OKwlh2tF5Or
 vcBWM6VJ3juDGv5dXtCWtU5VzmQBOScUWQU6euDf5c6EgRmEh9xVVl96gFhMFTyJrl9u10ZgC
 qYTwbCoaJbh2QqJD5JR/1OXv6umtIfKM/iAHw1soJZz5skHraX3G3LZy15B1RyPbUkcMRVqbl
 jtg61C893v/jKv9AOdsfErvkBQn/8b1XEDtpOoBcTtDpP49LNyoVeqtBf6D1oqUk63o1floBC
 bG3jQO7M6SyhEBcmz9QkS36OHEFsU9QuSMgW5UPA1wO0B4j+TFp+9GqQ21hneqQyIYpD2fQFA
 1yRs4zVkm0fk2O9P8WdXQT52jK0eelFeGry34j8Wlf1WjJc3HlWiZxPVSFAJralDSijHNc6SS
 Ze/phsAvxsuIgAfS7TRkjRINYal1DGjlHdvWtLbFA6j17jHwK3ezUq9UoznEoKh4Cz0KHqtlK
 ZgRgaAscqLJvA2J2dCvjO4HoS4L/tjeMGVGk7o1p0PWGv1QNpOMN1Gx0L1+tli/RMTjhQeLqm
 MuFkDs7vDfN1Hmgr7QMsgytbO3MQoOMuu+86pMLfo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I would like to suggest lengthening the review period for stable
releases from 48 hours to 7 days.
The rationale is that 48 hours is not enough for people to test those
stable releases and make sure there are no regressions for particular
workflows.
This is especially important for companies deploying those kernels in
production machines. Often those releases are on weekends as well
further limiting the ability to test.
It is of course possible to skip stable updates that have large numbers
of patches and only update once a month but I feel a longer testing
period will work best for everyone.
It is, of course, always possible to exempt urgent security releases
from the waiting period.

Thank you.
Hussam.


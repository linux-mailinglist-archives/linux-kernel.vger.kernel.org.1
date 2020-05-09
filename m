Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F42121CBF67
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgEIIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 04:52:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbgEIIw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:52:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03E00BF11E02B47FFDF8;
        Sat,  9 May 2020 16:52:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 16:52:18 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <heiko.carstens@de.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.or>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next 0/3] s390: use scnprintf() in show() methods
Date:   Sat, 9 May 2020 16:56:05 +0800
Message-ID: <20200509085608.41061-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snprintf() returns the number of bytes that would be written,
which may be greater than the the actual length to be written.
	    
show() methods should return the number of bytes printed into the
buffer. This is the return value of scnprintf().

Chen Zhou (3):
  s390/crypto: use scnprintf() instead of snprintf()
  s390: use scnprintf() in sys_##_prefix##_##_name##_show
  s390/protvirt: use scnprintf() instead of snprintf()

 arch/s390/crypto/prng.c | 14 +++++++-------
 arch/s390/kernel/ipl.c  |  2 +-
 arch/s390/kernel/uv.c   |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.20.1


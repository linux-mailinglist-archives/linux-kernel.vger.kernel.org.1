Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6026326DEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgIQOru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:47:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727612AbgIQOlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:41:06 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2C464D8CA3BB2F2434A0;
        Thu, 17 Sep 2020 21:52:26 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 21:52:15 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>
CC:     <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <rcu@vger.kernel.org>
Subject: [PATCH 0/2] two tiny fixes for locktorture
Date:   Thu, 17 Sep 2020 21:59:08 +0800
Message-ID: <20200917135910.137389-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hou Tao (2):
  locktorture: doesn't check nreaders_stress when no readlock support
  locktorture: call percpu_free_rwsem() to do percpu-rwsem cleanup

 kernel/locking/locktorture.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.25.0.4.g0ad7144999


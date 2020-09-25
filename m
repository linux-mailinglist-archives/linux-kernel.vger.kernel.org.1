Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E9278024
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgIYGB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:01:56 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:52571 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727189AbgIYGBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:01:35 -0400
X-UUID: 377f658f115e496e98f91a99abceb056-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CwJeUOkkh2glyL7K2vCK6Qm2LXqDuXxnbfUDj0hayaM=;
        b=fFI+4xPZog20rTQFttRO1xgWr2D4Sz2ZAkPFwRbIiNA/RmBTpf71J0DECGIXkorMEHpp31epjWaMlQGFEs0EmtRz9hm55VerOKJ6SJNkxsNELnnH0mtLxbPrDD8LHu8KkpwnIK3qbF5R0+LEvoDfSYT2vGSDnqvwRicUR+4gTUA=;
X-UUID: 377f658f115e496e98f91a99abceb056-20200925
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1598022880; Fri, 25 Sep 2020 14:01:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:01:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:01:28 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 11/11] usb: gadget: bdc: fix checkpatch.pl repeated word warning
Date:   Fri, 25 Sep 2020 13:58:19 +0800
Message-ID: <1601013499-28920-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FF505727F65D4B51688AC87D09DF0B30B35687F5F39E17EDB9E5CD4B70EE7B782000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IHRoZSB3YXJuaW5nOg0KV0FSTklORzpSRVBFQVRFRF9XT1JEOiBQb3NzaWJsZSByZXBlYXRl
ZCB3b3JkOiAnYW5kJw0KDQpDaGFuZ2UtSWQ6IEk0OGQ4OWM0YzAwMWUxMWFlMTNkOGZmMjE5MGM1
MTMyOGEzZmFhZjQ2DQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+
DQpBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQotLS0N
CiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyB8IDIgKy0NCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9i
ZGMvYmRjX2VwLmMNCmluZGV4IGQyMjdkMjYuLjhlMmYyMGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2VwLmMNCkBAIC0xNDA1LDcgKzE0MDUsNyBAQCBzdGF0aWMgaW50IGVwMF9zZXRf
c2VsKHN0cnVjdCBiZGMgKmJkYywNCiB9DQogDQogLyoNCi0gKiBRdWV1ZSBhIDAgYnl0ZSBiZCBv
bmx5IGlmIHdMZW5ndGggaXMgbW9yZSB0aGFuIHRoZSBsZW5ndGggYW5kIGFuZCBsZW5ndGggaXMN
CisgKiBRdWV1ZSBhIDAgYnl0ZSBiZCBvbmx5IGlmIHdMZW5ndGggaXMgbW9yZSB0aGFuIHRoZSBs
ZW5ndGggYW5kIGxlbmd0aCBpcw0KICAqIGEgbXVsdGlwbGUgb2YgTWF4UGFja2V0IHRoZW4gcXVl
dWUgMCBieXRlIEJEDQogICovDQogc3RhdGljIGludCBlcDBfcXVldWVfemxwKHN0cnVjdCBiZGMg
KmJkYykNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE61278022
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgIYGBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:01:50 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40504 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727187AbgIYGBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:01:35 -0400
X-UUID: 48db09f403d548a793abfd7e1b4d8813-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=37F4pDO5B60SbyqWx3pAJL5O++RHKPYJ7n5xuJUU/Eo=;
        b=Mj1glP4rEnyOsRDONluzG4x2558NRaeEg6SewQdczLfLnPb8RmJ/JWLwbWkinvfqvp/XvGAocAD3VBXCVekAH3D8ZVQwsYIJ0QeGLT8GKNkz57tcmLhj9w6JvQrcmL51dpuAabOS826r+jyheIhCX7xvPMD/SJ28xz1gmmWTEQQ=;
X-UUID: 48db09f403d548a793abfd7e1b4d8813-20200925
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 926468863; Fri, 25 Sep 2020 14:01:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:01:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:01:26 +0800
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
Subject: [PATCH 10/11] usb: gadget: bdc: fix checkpatch.pl spacing error
Date:   Fri, 25 Sep 2020 13:58:18 +0800
Message-ID: <1601013499-28920-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8AADC226BA6A9EDFF3B6E8692388FFD4A4791DCE6FD50EA80FABFA127FDF51852000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IGNoZWNrcGF0Y2gucGwgZXJyb3I6DQpFUlJPUjpTUEFDSU5HOiBzcGFjZSBwcm9oaWJpdGVk
IGJlZm9yZSB0aGF0ICcsJw0KDQpDaGFuZ2UtSWQ6IElkYzQ5NmRlOTM3ZTQ2YzIyNDI2OWM5NGJm
OTEzMTM4ZjMxOTZiYjEwDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5j
b20+DQpBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQot
LS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfdWRjLmMgfCAyICstDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfdWRjLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2JkYy9iZGNfdWRjLmMNCmluZGV4IDBjMWFiOTUuLjVhYzBlZjggMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfdWRjLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvYmRjL2JkY191ZGMuYw0KQEAgLTUzMCw3ICs1MzAsNyBAQCBpbnQgYmRjX3VkY19p
bml0KHN0cnVjdCBiZGMgKmJkYykNCiANCiAJYmRjLT5nYWRnZXQubmFtZSA9IEJSQ01fQkRDX05B
TUU7DQogCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoYmRjLT5kZXYsIGJkYy0+aXJxLCBiZGNfdWRj
X2ludGVycnVwdCwNCi0JCQkJSVJRRl9TSEFSRUQgLCBCUkNNX0JEQ19OQU1FLCBiZGMpOw0KKwkJ
CQlJUlFGX1NIQVJFRCwgQlJDTV9CRENfTkFNRSwgYmRjKTsNCiAJaWYgKHJldCkgew0KIAkJZGV2
X2VycihiZGMtPmRldiwNCiAJCQkiZmFpbGVkIHRvIHJlcXVlc3QgaXJxICMlZCAlZFxuIiwNCi0t
IA0KMS44LjEuMS5kaXJ0eQ0K


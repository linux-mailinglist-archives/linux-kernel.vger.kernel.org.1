Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D7229290
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgGVHwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 03:52:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:61315 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726870AbgGVHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:52:52 -0400
X-UUID: 8ac798eac069470899699dfdeb82f262-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qwTImn/8K9LJnphZrWhb4BjXDRmrvFi/Lz39VCoRDJc=;
        b=B0xiaxc6mxBUfm3hNd6geXRbRag79XZcTwiKFaxtiBYE2z2AUwGkqVwj2a+Xyy/ngtY0l6of9H9FOcSO3lHDmIqRjDMTEH98ozygU0J1lVIoOmFYiy4kb2xLssz7iNho4q3oizJDnSKe4mjVpE+jZPJFg3Z+oynjx5/K9EXgWG8=;
X-UUID: 8ac798eac069470899699dfdeb82f262-20200722
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1730592382; Wed, 22 Jul 2020 15:52:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:52:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:52:39 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH 6/7] usb: gadget: tegra-xudc: convert to devm_platform_ioremap_resource_byname
Date:   Wed, 22 Jul 2020 15:51:14 +0800
Message-ID: <1595404275-8449-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 40B6B90EE131EFAFFE5849A03C43ADD0B35715D3D998C073E94E47EE4221B35E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSB0byBzaW1wbGlmeSBj
b2RlDQoNCkNjOiBOYWdhcmp1bmEgS3Jpc3RhbSA8bmtyaXN0YW1AbnZpZGlhLmNvbT4NClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvdGVncmEteHVkYy5jIHwgNyArKy0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvdGVncmEteHVkYy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy90ZWdyYS14dWRjLmMNCmluZGV4IGJiZTFhMDQuLjVhN2M1Y2YgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL3RlZ3JhLXh1ZGMuYw0KKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy90ZWdyYS14dWRjLmMNCkBAIC0zNzUwLDE1ICszNzUwLDEyIEBAIHN0YXRpYyBpbnQg
dGVncmFfeHVkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJu
IFBUUl9FUlIoeHVkYy0+YmFzZSk7DQogCXh1ZGMtPnBoeXNfYmFzZSA9IHJlcy0+c3RhcnQ7DQog
DQotCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9N
RU0sICJmcGNpIik7DQotCXh1ZGMtPmZwY2kgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYt
PmRldiwgcmVzKTsNCisJeHVkYy0+ZnBjaSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJj
ZV9ieW5hbWUocGRldiwgImZwY2kiKTsNCiAJaWYgKElTX0VSUih4dWRjLT5mcGNpKSkNCiAJCXJl
dHVybiBQVFJfRVJSKHh1ZGMtPmZwY2kpOw0KIA0KIAlpZiAoeHVkYy0+c29jLT5oYXNfaXBmcykg
ew0KLQkJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNF
X01FTSwNCi0JCQkJCQkgICAiaXBmcyIpOw0KLQkJeHVkYy0+aXBmcyA9IGRldm1faW9yZW1hcF9y
ZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0KKwkJeHVkYy0+aXBmcyA9IGRldm1fcGxhdGZvcm1f
aW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUocGRldiwgImlwZnMiKTsNCiAJCWlmIChJU19FUlIoeHVk
Yy0+aXBmcykpDQogCQkJcmV0dXJuIFBUUl9FUlIoeHVkYy0+aXBmcyk7DQogCX0NCi0tIA0KMS45
LjENCg==


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016F229A9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898330AbgJ0Kcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:32:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34186 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898302AbgJ0KcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:32:17 -0400
X-UUID: 9692bcac71244448b8c31aff43f29a78-20201027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:To:From; bh=/b/gCQSV6Qz2dGVgfETzaXVIvurYItjdyLbamEocLz8=;
        b=li0Ufj2brudnK36zI5WlhbbbQ5AwOFZw9rqwKKm4G+ks9nx6jcob7I95/9YmsNJSxtscev43kJ3bewjcZ/mlYqYyCaHC493HJnJkRTAfZK5iIToDJc+JjryOUse+orTQUbWNnz90aLtgaT0SWusS8gJY51RqHLHv6NlKU343iOM=;
X-UUID: 9692bcac71244448b8c31aff43f29a78-20201027
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1883957800; Tue, 27 Oct 2020 18:27:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Oct 2020 18:26:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Oct 2020 18:26:59 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v5 0/1] Add basic node support for Mediatek MT8192 SoC 
Date:   Tue, 27 Oct 2020 18:26:51 +0800
Message-ID: <20201027102652.12806-1-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpNVDgxOTIgaXMgYSBTb0MgYmFzZWQgb24gNjRiaXQgQVJNdjggYXJjaGl0ZWN0dXJlLg0KSXQg
Y29udGFpbnMgNCBDQTU1IGFuZCA0IENBNzYgY29yZXMuDQpNVDgxOTIgc2hhcmUgbWFueSBIVyBJ
UCB3aXRoIE1UNjV4eCBzZXJpZXMuDQpUaGlzIHBhdGNoc2V0IHdhcyB0ZXN0ZWQgb24gTVQ4MTky
IGV2YWx1YXRpb24gYm9hcmQgdG8gc2hlbGwuDQoNCkJhc2VkIG9uIHY1LjEwLXJjMQ0KDQpDaGFu
Z2UgaW4gdjU6DQoxLiBSZW1vdmUgd2F0Y2hkb2cgYW5kIGFsbCBzeXNjb24gbm9kZXMNCjIuIFVz
ZSBjbGsyNm0gYXMgdWFydCBjbG9jayBzb3VyY2UNCjMuIFJlbW92ZSBhbGwgZGVwZW5kZW5jeSBs
aXN0cw0KDQpDaGFuZ2UgaW4gdjQ6DQoxLiBSZW1vdmUgc2Nwc3lzLCBzcG1pIGFuZCBhcHUgbm9k
ZXMNCjIuIEFkZCBpMmMgbm9kZXMNCjMuIFVwZGF0ZSB3YXRjaGRvZyBiaW5kaW5nDQo0LiBVcGRh
dGUgZGVwZW5kZW5jeSBsaXN0DQoNCkNoYW5nZSBpbiB2MzoNCkZpeCB0eXBvIGluIGJpbmRpbmcg
ZG9jdW1lbnQgb2YgdGltZXINCg0KQ2hhbmdlIGluIHYyOg0KMS4gUmVtb3ZlIG10ODE5Mi1wb3dl
ci5oIGZyb20gbXQ4MTkyLmR0c2kgd2hpY2ggaXMgbm90IHVzZWQgeWV0DQoyLiBBZGQgdGltZXIg
YmluZGluZyBkb2N1bWVudCBhbmQgZGV2aWNlIHRyZWUgbm9kZSBpbiBtdDgxOTIuZHRzaQ0KMy4g
UmVtb3ZlIHdhdGNoZG9nIGRyaXZlciBtb2RpZmljYXRpb24NCg0KU2VpeWEgV2FuZyAoMSk6DQog
IGFybTY0OiBkdHM6IEFkZCBNZWRpYXRlayBTb0MgTVQ4MTkyIGFuZCBldmFsdWF0aW9uIGJvYXJk
IGR0cyBhbmQNCiAgICBNYWtlZmlsZQ0KDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9N
YWtlZmlsZSAgICAgICB8ICAgMSArDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
OTItZXZiLmR0cyB8ICAyOSArKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTky
LmR0c2kgICAgfCA1MTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hh
bmdlZCwgNTQzIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxOTItZXZiLmR0cw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQoNCi0tDQoyLjE0LjENCg==


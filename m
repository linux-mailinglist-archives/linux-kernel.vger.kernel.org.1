Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B828D8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 05:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgJNDJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 23:09:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41007 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbgJNDJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 23:09:48 -0400
X-UUID: 17bc8e16847e4b2bbdf332681d5c0aca-20201014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=593gZkLlpT2AoBcCSxfV41s1+sRbcMRlkgvURXl1NpQ=;
        b=d5Ez8C69xJsQ6Su1yXf6Cfda8O2wJBzbogVWoTzWyO7S+6Bag80p7BokML70sax/gZ7gAvRfBwRQwTqpf9oFW8Y4iMzpLhAk+5ZbI+KT+qOkV2g9he+9cNWApPXNQSh5DgdmelbMMaBT8zzBGRtgOgxoZMGH9lvSKBI6ohj+WCg=;
X-UUID: 17bc8e16847e4b2bbdf332681d5c0aca-20201014
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2113837464; Wed, 14 Oct 2020 11:09:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Oct 2020 11:08:49 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Oct 2020 11:08:49 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH v7 2/4] mmc: dt-bindings: add support for MT8192 SoC
Date:   Wed, 14 Oct 2020 11:08:44 +0800
Message-ID: <20201014030846.12428-3-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201014030846.12428-1-wenbin.mei@mediatek.com>
References: <20201014030846.12428-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVQ4MTkyIG1tYyBob3N0IGlwIGlzIGNvbXBhdGlibGUgd2l0aCBNVDgxODMuDQpBZGQgc3VwcG9y
dCBmb3IgdGhpcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRp
YXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210
ay1zZC55YW1sIHwgMTUgKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbA0KaW5kZXggNzk5MDVkZjc1ZjFkLi4wMzBlM2Zk
Y2U0OTIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1j
L210ay1zZC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1j
L210ay1zZC55YW1sDQpAQCAtMjksMjYgKzI5LDM3IEBAIHByb3BlcnRpZXM6DQogICAgICAgLSBp
dGVtczoNCiAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10NzYyMy1tbWMNCiAgICAgICAgIC0g
Y29uc3Q6IG1lZGlhdGVrLG10MjcwMS1tbWMNCisgICAgICAtIGl0ZW1zOg0KKyAgICAgICAgLSBj
b25zdDogbWVkaWF0ZWssbXQ4MTkyLW1tYw0KKyAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4
MTgzLW1tYw0KIA0KICAgY2xvY2tzOg0KICAgICBkZXNjcmlwdGlvbjoNCiAgICAgICBTaG91bGQg
Y29udGFpbiBwaGFuZGxlIGZvciB0aGUgY2xvY2sgZmVlZGluZyB0aGUgTU1DIGNvbnRyb2xsZXIu
DQogICAgIG1pbkl0ZW1zOiAyDQotICAgIG1heEl0ZW1zOiA0DQorICAgIG1heEl0ZW1zOiA4DQog
ICAgIGl0ZW1zOg0KICAgICAgIC0gZGVzY3JpcHRpb246IHNvdXJjZSBjbG9jayAocmVxdWlyZWQp
Lg0KICAgICAgIC0gZGVzY3JpcHRpb246IEhDTEsgd2hpY2ggdXNlZCBmb3IgaG9zdCAocmVxdWly
ZWQpLg0KICAgICAgIC0gZGVzY3JpcHRpb246IGluZGVwZW5kZW50IHNvdXJjZSBjbG9jayBnYXRl
IChyZXF1aXJlZCBmb3IgTVQyNzEyKS4NCiAgICAgICAtIGRlc2NyaXB0aW9uOiBidXMgY2xvY2sg
dXNlZCBmb3IgaW50ZXJuYWwgcmVnaXN0ZXIgYWNjZXNzIChyZXF1aXJlZCBmb3IgTVQyNzEyIE1T
REMwLzMpLg0KKyAgICAgIC0gZGVzY3JpcHRpb246IG1zZGMgc3Vic3lzIGNsb2NrIGdhdGUgKHJl
cXVpcmVkIGZvciBNVDgxOTIpLg0KKyAgICAgIC0gZGVzY3JpcHRpb246IHBlcmlwaGVyYWwgYnVz
IGNsb2NrIGdhdGUgKHJlcXVpcmVkIGZvciBNVDgxOTIpLg0KKyAgICAgIC0gZGVzY3JpcHRpb246
IEFYSSBidXMgY2xvY2sgZ2F0ZSAocmVxdWlyZWQgZm9yIE1UODE5MikuDQorICAgICAgLSBkZXNj
cmlwdGlvbjogQUhCIGJ1cyBjbG9jayBnYXRlIChyZXF1aXJlZCBmb3IgTVQ4MTkyKS4NCiANCiAg
IGNsb2NrLW5hbWVzOg0KICAgICBtaW5JdGVtczogMg0KLSAgICBtYXhJdGVtczogNA0KKyAgICBt
YXhJdGVtczogOA0KICAgICBpdGVtczoNCiAgICAgICAtIGNvbnN0OiBzb3VyY2UNCiAgICAgICAt
IGNvbnN0OiBoY2xrDQogICAgICAgLSBjb25zdDogc291cmNlX2NnDQogICAgICAgLSBjb25zdDog
YnVzX2Nsaw0KKyAgICAgIC0gY29uc3Q6IHN5c19jZw0KKyAgICAgIC0gY29uc3Q6IHBjbGtfY2cN
CisgICAgICAtIGNvbnN0OiBheGlfY2cNCisgICAgICAtIGNvbnN0OiBhaGJfY2cNCiANCiAgIHBp
bmN0cmwtbmFtZXM6DQogICAgIGl0ZW1zOg0KLS0gDQoyLjE4LjANCg==


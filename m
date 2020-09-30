Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7A27E205
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgI3HIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:08:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39818 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728416AbgI3HH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:07:58 -0400
X-UUID: abd55a5e844b4f9e974476c073abed46-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xbdpvvhbw7U+oQhzcXIeyhQL340+/VTYp2FTyRYou84=;
        b=IBcrfrSkPmWG+M+4SDiJU+j65dZQeL42uuI7RWpij4jF8maGG1bN4I9IMs4NaP2JyMC3LCKSZtBWJdhdkJ05SwRNx/+cyYsnBspxNnpMc4a4iq1OZ+/DqCbGu+3BETVfSrPI/sSMyhlUW2YeBN2ghWoda7zgM9S2d4/Vg1KZz2E=;
X-UUID: abd55a5e844b4f9e974476c073abed46-20200930
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 624761361; Wed, 30 Sep 2020 15:07:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:07:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:07:55 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Subject: [PATCH v3 04/24] dt-bindings: memory: mediatek: Extend LARB_NR_MAX to 32
Date:   Wed, 30 Sep 2020 15:06:27 +0800
Message-ID: <20200930070647.10188-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RXh0ZW5kIHRoZSBtYXggbGFyYiBudW1iZXIgZGVmaW5pdGlvbiBhcyBtdDgxOTIgaGFzIGxhcmJf
bnIgb3ZlciAxNi4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5j
b20+DQpBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KIC4uLi9i
aW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbCAgICAgICAg
fCAyICstDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCAg
ICAgICAgICAgICAgICB8IDQgKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRl
ayxzbWktbGFyYi55YW1sDQppbmRleCA1MDc5M2EwZTY3NTkuLmVhNDE4MTEzYmYyNyAxMDA2NDQN
Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxl
cnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sDQpAQCAt
NjIsNyArNjIsNyBAQCBwcm9wZXJ0aWVzOg0KICAgbWVkaWF0ZWssbGFyYi1pZDoNCiAgICAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQogICAgIG1pbmltdW06
IDANCi0gICAgbWF4aW11bTogMTUNCisgICAgbWF4aW11bTogMzENCiAgICAgZGVzY3JpcHRpb246
IHRoZSBoYXJkd2FyZSBpZCBvZiB0aGlzIGxhcmIuDQogICAgICAgUmVxdWlyZWQgcHJvcGVydHkg
Zm9yIG10MjcwMSwgbXQyNzEyLCBtdDY3NzkgYW5kIG10NzYyMy4NCiANCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5oIGIvaW5jbHVkZS9k
dC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0KaW5kZXggMmVjN2ZlNWNlNGU5
Li5mNGQ4ZTNhZWQwYmMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9t
dGstc21pLWxhcmItcG9ydC5oDQorKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGst
c21pLWxhcmItcG9ydC5oDQpAQCAtNiwxMCArNiwxMCBAQA0KICNpZm5kZWYgX19EVFNfTVRLX0lP
TU1VX1BPUlRfSF8NCiAjZGVmaW5lIF9fRFRTX01US19JT01NVV9QT1JUX0hfDQogDQotI2RlZmlu
ZSBNVEtfTEFSQl9OUl9NQVgJCQkxNg0KKyNkZWZpbmUgTVRLX0xBUkJfTlJfTUFYCQkJMzINCiAN
CiAjZGVmaW5lIE1US19NNFVfSUQobGFyYiwgcG9ydCkJCSgoKGxhcmIpIDw8IDUpIHwgKHBvcnQp
KQ0KLSNkZWZpbmUgTVRLX000VV9UT19MQVJCKGlkKQkJKCgoaWQpID4+IDUpICYgMHhmKQ0KKyNk
ZWZpbmUgTVRLX000VV9UT19MQVJCKGlkKQkJKCgoaWQpID4+IDUpICYgMHgxZikNCiAjZGVmaW5l
IE1US19NNFVfVE9fUE9SVChpZCkJCSgoaWQpICYgMHgxZikNCiANCiAjZW5kaWYNCi0tIA0KMi4x
OC4wDQo=


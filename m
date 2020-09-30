Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7B27E20E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgI3HIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:08:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40062 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728416AbgI3HIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:08:17 -0400
X-UUID: 8f8a059023584fd5871d139da49238f4-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=axtHnh7qKvv1KMMgmnGRSN/KcSTs8AdXhfI9O+e7IvY=;
        b=A4xDjLPje7yMZ29HFTNKHE8JDYvaizpz8Z6OUz2x2RJMdaooy6HM948P3AAaIOlCVV03j+qtWL3LR3TPL9YxY5TysaS0j7kdBzhVlIWEEoydEvO2lLjoILxhCtQlAXxmtM4a8T1VHckrzsOVJMHvFTZNBeDyV6KuDamioL0bwFI=;
X-UUID: 8f8a059023584fd5871d139da49238f4-20200930
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1473144545; Wed, 30 Sep 2020 15:08:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:08:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:08:06 +0800
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
Subject: [PATCH v3 05/24] dt-bindings: memory: mediatek: Add domain definition
Date:   Wed, 30 Sep 2020 15:06:28 +0800
Message-ID: <20200930070647.10188-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E7D6746DA1C6BD03377D3E4B8E29DEB562679DA890B32B4FB83C13859582B8F32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIGxhdGVzdCBTb0MsIHRoZXJlIGFyZSBzZXZlcmFsIEhXIElQIHJlcXVpcmUgYSBzZXBl
Y2lhbCBpb3ZhDQpyYW5nZSwgbWFpbmx5IENDVSBhbmQgVlBVIGhhcyB0aGlzIHJlcXVpcmVtZW50
LiBUYWtlIENDVSBhcyBhIGV4YW1wbGUsDQpDQ1UgcmVxdWlyZSBpdHMgaW92YSBsb2NhdGUgaW4g
dGhlIHJhbmdlKDB4NDAwMF8wMDAwIH4gMHg0M2ZmX2ZmZmYpLg0KDQpJbiB0aGlzIHBhdGNoIHdl
IGFkZCBhIGRvbWFpbiBkZWZpbml0aW9uIGZvciB0aGUgc3BlY2lhbCBwb3J0LiBJbiB0aGUNCmV4
YW1wbGUgb2YgQ0NVLCBJZiB3ZSBwcmVhc3NpZ24gQ0NVIHBvcnQgaW4gZG9tYWluMSwgdGhlbiBp
b21tdSBkcml2ZXINCndpbGwgcHJlcGFyZSBhIGluZGVwZW5kZW50IGlvbW11IGRvbWFpbiBvZiB0
aGUgc3BlY2lhbCBpb3ZhIHJhbmdlIGZvciBpdCwNCnRoZW4gdGhlIGlvdmEgZ290IGZyb20gZG1h
X2FsbG9jX2F0dHJzKGNjdS1kZXYpIHdpbGwgbG9jYXRlIGluIGl0cyBzcGVjaWFsDQpyYW5nZS4N
Cg0KVGhpcyBpcyBhIHByZXBhcmluZyBwYXRjaCBmb3IgbXVsdGktZG9tYWluIHN1cHBvcnQuDQoN
ClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogaW5j
bHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCB8IDkgKysrKysrKyst
DQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCBi
L2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmgNCmluZGV4IGY0
ZDhlM2FlZDBiYy4uZDAwZjVkZTg0MzhiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5n
cy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9t
ZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0KQEAgLTcsOSArNywxNiBAQA0KICNkZWZpbmUgX19E
VFNfTVRLX0lPTU1VX1BPUlRfSF8NCiANCiAjZGVmaW5lIE1US19MQVJCX05SX01BWAkJCTMyDQor
I2RlZmluZSBNVEtfTTRVX0RPTV9OUl9NQVgJCTgNCisNCisjZGVmaW5lIE1US19NNFVfRE9NX0lE
KGRvbWlkLCBsYXJiLCBwb3J0KQlcDQorCSgoKGRvbWlkKSAmIDB4NykgPDwgMTYgfCAoKChsYXJi
KSAmIDB4MWYpIDw8IDUpIHwgKChwb3J0KSAmIDB4MWYpKQ0KKw0KKy8qIFRoZSBkZWZhdWx0IGRv
bSBpZCBpcyAwLiAqLw0KKyNkZWZpbmUgTVRLX000VV9JRChsYXJiLCBwb3J0KQkJTVRLX000VV9E
T01fSUQoMCwgbGFyYiwgcG9ydCkNCiANCi0jZGVmaW5lIE1US19NNFVfSUQobGFyYiwgcG9ydCkJ
CSgoKGxhcmIpIDw8IDUpIHwgKHBvcnQpKQ0KICNkZWZpbmUgTVRLX000VV9UT19MQVJCKGlkKQkJ
KCgoaWQpID4+IDUpICYgMHgxZikNCiAjZGVmaW5lIE1US19NNFVfVE9fUE9SVChpZCkJCSgoaWQp
ICYgMHgxZikNCisjZGVmaW5lIE1US19NNFVfVE9fRE9NKGlkKQkJKCgoaWQpID4+IDE2KSAmIDB4
NykNCiANCiAjZW5kaWYNCi0tIA0KMi4xOC4wDQo=


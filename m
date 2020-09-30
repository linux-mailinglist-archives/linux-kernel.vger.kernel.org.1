Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6920027E218
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgI3HIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:08:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40417 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:08:46 -0400
X-UUID: 0c766645f6554de8b823bae2d930b1ff-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u5tqR9ENhht0ilsy0f2kHtyPEnKLMCniBaBxwf4wdHg=;
        b=pAmuNmpm4zZR3Bdo3+QuDPMQfSnZs57hZyYG6HqfDXKPIrxl8t8HzXKA/w1tvw0PDs/vXxnvPyWpuCyn2VNJG91OSLeTerdWXI6q5Yf17ypAhfW63I3vfzj+X7vHZeaoj0oJGzhAWA810/FMddTc9pVIeRA+qSl0j4Ml6108quc=;
X-UUID: 0c766645f6554de8b823bae2d930b1ff-20200930
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1371739614; Wed, 30 Sep 2020 15:08:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:08:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:08:41 +0800
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
Subject: [PATCH v3 08/24] iommu/io-pgtable-arm-v7s: Use ias to check the valid iova in unmap
Date:   Wed, 30 Sep 2020 15:06:31 +0800
Message-ID: <20200930070647.10188-9-yong.wu@mediatek.com>
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

VXNlIHRoZSBpYXMgZm9yIHRoZSB2YWxpZCBpb3ZhIGNoZWNraW5nIGluIGFybV92N3NfdW5tYXAu
IFRoaXMgaXMgYQ0KcHJlcGFyaW5nIHBhdGNoIGZvciBzdXBwb3J0aW5nIGlvdmEgMzRiaXQgZm9y
IE1lZGlhVGVrLg0KQlRXLCBjaGFuZ2UgdGhlIGlhcy9vYXMgY2hlY2tpbmcgZm9ybWF0IGluIGFy
bV92N3NfbWFwLg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgfCA1ICsrLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgYi9kcml2ZXJzL2lvbW11
L2lvLXBndGFibGUtYXJtLXY3cy5jDQppbmRleCBhNjg4ZjIyY2JlM2IuLjRjOWQ4ZGNjZmM1YSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCisrKyBiL2Ry
aXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCkBAIC01MjYsOCArNTI2LDcgQEAgc3Rh
dGljIGludCBhcm1fdjdzX21hcChzdHJ1Y3QgaW9fcGd0YWJsZV9vcHMgKm9wcywgdW5zaWduZWQg
bG9uZyBpb3ZhLA0KIAlpZiAoIShwcm90ICYgKElPTU1VX1JFQUQgfCBJT01NVV9XUklURSkpKQ0K
IAkJcmV0dXJuIDA7DQogDQotCWlmIChXQVJOX09OKGlvdmEgPj0gKDFVTEwgPDwgZGF0YS0+aW9w
LmNmZy5pYXMpIHx8DQotCQkgICAgcGFkZHIgPj0gKDFVTEwgPDwgZGF0YS0+aW9wLmNmZy5vYXMp
KSkNCisJaWYgKFdBUk5fT04oaW92YSA+PiBkYXRhLT5pb3AuY2ZnLmlhcyB8fCBwYWRkciA+PiBk
YXRhLT5pb3AuY2ZnLm9hcykpDQogCQlyZXR1cm4gLUVSQU5HRTsNCiANCiAJcmV0ID0gX19hcm1f
djdzX21hcChkYXRhLCBpb3ZhLCBwYWRkciwgc2l6ZSwgcHJvdCwgMSwgZGF0YS0+cGdkLCBnZnAp
Ow0KQEAgLTcxNyw3ICs3MTYsNyBAQCBzdGF0aWMgc2l6ZV90IGFybV92N3NfdW5tYXAoc3RydWN0
IGlvX3BndGFibGVfb3BzICpvcHMsIHVuc2lnbmVkIGxvbmcgaW92YSwNCiB7DQogCXN0cnVjdCBh
cm1fdjdzX2lvX3BndGFibGUgKmRhdGEgPSBpb19wZ3RhYmxlX29wc190b19kYXRhKG9wcyk7DQog
DQotCWlmIChXQVJOX09OKHVwcGVyXzMyX2JpdHMoaW92YSkpKQ0KKwlpZiAoV0FSTl9PTihpb3Zh
ID4+IGRhdGEtPmlvcC5jZmcuaWFzKSkNCiAJCXJldHVybiAwOw0KIA0KIAlyZXR1cm4gX19hcm1f
djdzX3VubWFwKGRhdGEsIGdhdGhlciwgaW92YSwgc2l6ZSwgMSwgZGF0YS0+cGdkKTsNCi0tIA0K
Mi4xOC4wDQo=


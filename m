Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0C26D3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIQGnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:43:07 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60042 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbgIQGnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:43:06 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 02:43:05 EDT
X-UUID: 9ce8dc1f769b461ebfc6778803b3d27b-20200917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=q3zAN8zFo1/THiBdhYK4ZALTgtXSBsMJR5IaK/NHfaM=;
        b=WFDVt9Ec2VeCS10jZZxIB+Uw+zlN7CKT2jnblL04VB7CSRJOaWqAU4mJfqkZtQ8sBlwCQDO6jXap7QuRm7hruHGfPReOWRd+2mA9C4KkAWLnUbZZ2kl2gfP7qXUtvuNbQE6pCkp0lYAO5ReHXsUuJt9ujU+/Y55ou/IXL/eia6U=;
X-UUID: 9ce8dc1f769b461ebfc6778803b3d27b-20200917
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <lina.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2100878145; Thu, 17 Sep 2020 14:37:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS32N2.mediatek.inc (172.27.4.72) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Sep 2020 14:37:50 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Sep 2020 14:37:49 +0800
From:   mtk81216 <lina.wang@mediatek.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        mtk81216 <lina.wang@mediatek.com>
Subject: [PATCH] xfrm:ignore big packets when tunnel mode
Date:   Thu, 17 Sep 2020 14:32:49 +0800
Message-ID: <20200917063249.13457-1-lina.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A425E91767A7A18DC5E4A7FBDF28EB4693A4C644D5DD00B9FC8494E7B463B61B2000:8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdHVubmVsIG1vZGUsIHdoZW4gaW5uZXIgaW50ZXJmYWNlIGlzIGlwdjQsb3V0ZXIgaW50ZXJm
YWNlIGlzIGlwdjYsIGZsYWdzDQpvZiB0dW5uZWwgbW9kZSdzIHhmcm0gc3RhdGUgaXMgYWYtdW5z
cGVjLCBpZiBhIGxhcmdlciBwYWNrZXQgd2hvIGlzIGJpZ2dlcg0KdGhhbiBtdHUgZ29lcyB0aHJv
dWdoIHR1bm5lbCBpbnRlcmZhY2UsIGl0IGVudGVycyBpcDZfZnJhZ21lbnQsIGdvZXMgdG8NCmZh
aWxfdG9vYmlnLCBhbmQgSUNNUFY2KElDTVBWNl9QS1RfVE9PQklHKSB3aWxsIGJlIHNlbnQuIEl0
IGlzIHVubmVjZXNzYXJ5DQp0byBkbyBzby4gSXA2X2ZyYWdtZW50IHdpbGwgZnJhZ21lbnQgc3Vj
aCBwYWNrZXQgd2l0aCBvdXRlciBpbnRlcmZhY2UncyBtdHUNCm1pbnVzIHR1bm5lbGxlZCBlc3Ag
aGVhZGVyLGl0IHdvbm90IGJlIHRvbyBiaWcuDQoNClRoZSBzYW1lIHRoaW5ncyBoYXBwZW4sIHdo
ZW4gYSBsYXJnZXIgZnJhZ21lbnRlZCBwYWNrZXQgd2hvc2UgZnJhZ19tYXhfc2l6ZQ0KaXMgbGFy
Z2VyIHRoYW4gbXR1Lg0KDQpXaGVuIGEgbGFyZ2VyIGZyYWdtZW50ZWQgcGFja2V0IGlzIGZvcndh
cmRlZCwgaXQgYWxzbyBtZWV0cyB0aGUgc2FtZSANCnNjZW5hcnkuDQoNClRoaXMgcGF0Y2ggaGFz
IGhhbmRsZWQgdGhyZWUgYWJvdmUgc2NlbmFyaWVzLCBpZiBpdCBpcyB0dW5uZWwgbW9kZSxqdXN0
IA0KaWdub3JlIHNrYl9sZW4gb3IgZnJhZ19tYXhfc2l6ZSwga2VlcCBnb2luZy4NCg0KU2lnbmVk
LW9mZi1ieTogbXRrODEyMTYgPGxpbmEud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBuZXQvaXB2
Ni9pcDZfb3V0cHV0LmMgfCAyMyArKysrKysrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0
L2lwdjYvaXA2X291dHB1dC5jIGIvbmV0L2lwdjYvaXA2X291dHB1dC5jDQppbmRleCBjNzhlNjdk
Nzc0N2YuLjBlMWU2ZmNkN2E1ZCAxMDA2NDQNCi0tLSBhL25ldC9pcHY2L2lwNl9vdXRwdXQuYw0K
KysrIGIvbmV0L2lwdjYvaXA2X291dHB1dC5jDQpAQCAtNDAyLDEyICs0MDIsMTQgQEAgc3RhdGlj
IGlubGluZSBpbnQgaXA2X2ZvcndhcmRfZmluaXNoKHN0cnVjdCBuZXQgKm5ldCwgc3RydWN0IHNv
Y2sgKnNrLA0KIA0KIHN0YXRpYyBib29sIGlwNl9wa3RfdG9vX2JpZyhjb25zdCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCB1bnNpZ25lZCBpbnQgbXR1KQ0KIHsNCisJc3RydWN0IHJ0Nl9pbmZvICpydCA9
IChzdHJ1Y3QgcnQ2X2luZm8gKilza2JfZHN0KHNrYik7DQogCWlmIChza2ItPmxlbiA8PSBtdHUp
DQogCQlyZXR1cm4gZmFsc2U7DQogDQogCS8qIGlwdjYgY29ubnRyYWNrIGRlZnJhZyBzZXRzIG1h
eF9mcmFnX3NpemUgKyBpZ25vcmVfZGYgKi8NCiAJaWYgKElQNkNCKHNrYiktPmZyYWdfbWF4X3Np
emUgJiYgSVA2Q0Ioc2tiKS0+ZnJhZ19tYXhfc2l6ZSA+IG10dSkNCi0JCXJldHVybiB0cnVlOw0K
KwkJaWYgKHJ0ICYmICEocnQtPmRzdC5mbGFncyAmIERTVF9YRlJNX1RVTk5FTCkpDQorCQkJcmV0
dXJuIHRydWU7DQogDQogCWlmIChza2ItPmlnbm9yZV9kZikNCiAJCXJldHVybiBmYWxzZTsNCkBA
IC03ODcsMTYgKzc4OSwxOSBAQCBpbnQgaXA2X2ZyYWdtZW50KHN0cnVjdCBuZXQgKm5ldCwgc3Ry
dWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KIAkgKiBvciBpZiB0aGUgc2tiIGl0
IG5vdCBnZW5lcmF0ZWQgYnkgYSBsb2NhbCBzb2NrZXQuDQogCSAqLw0KIAlpZiAodW5saWtlbHko
IXNrYi0+aWdub3JlX2RmICYmIHNrYi0+bGVuID4gbXR1KSkNCi0JCWdvdG8gZmFpbF90b29iaWc7
DQotDQotCWlmIChJUDZDQihza2IpLT5mcmFnX21heF9zaXplKSB7DQotCQlpZiAoSVA2Q0Ioc2ti
KS0+ZnJhZ19tYXhfc2l6ZSA+IG10dSkNCisJCWlmIChydCAmJiAocnQtPmRzdC5mbGFncyAmIERT
VF9YRlJNX1RVTk5FTCkpDQogCQkJZ290byBmYWlsX3Rvb2JpZzsNCiANCi0JCS8qIGRvbid0IHNl
bmQgZnJhZ21lbnRzIGxhcmdlciB0aGFuIHdoYXQgd2UgcmVjZWl2ZWQgKi8NCi0JCW10dSA9IElQ
NkNCKHNrYiktPmZyYWdfbWF4X3NpemU7DQotCQlpZiAobXR1IDwgSVBWNl9NSU5fTVRVKQ0KLQkJ
CW10dSA9IElQVjZfTUlOX01UVTsNCisJaWYgKElQNkNCKHNrYiktPmZyYWdfbWF4X3NpemUpIHsN
CisJCWlmIChJUDZDQihza2IpLT5mcmFnX21heF9zaXplID4gbXR1KSB7DQorCQkJaWYgKHJ0ICYm
ICEocnQtPmRzdC5mbGFncyAmIERTVF9YRlJNX1RVTk5FTCkpDQorCQkJCWdvdG8gZmFpbF90b29i
aWc7DQorCQl9IGVsc2Ugew0KKwkJCS8qIGRvbid0IHNlbmQgZnJhZ21lbnRzIGxhcmdlciB0aGFu
IHdoYXQgd2UgcmVjZWl2ZWQgKi8NCisJCQltdHUgPSBJUDZDQihza2IpLT5mcmFnX21heF9zaXpl
Ow0KKwkJCWlmIChtdHUgPCBJUFY2X01JTl9NVFUpDQorCQkJCW10dSA9IElQVjZfTUlOX01UVTsN
CisJCX0NCiAJfQ0KIA0KIAlpZiAobnAgJiYgbnAtPmZyYWdfc2l6ZSA8IG10dSkgew0KLS0gDQoy
LjE4LjANCg==


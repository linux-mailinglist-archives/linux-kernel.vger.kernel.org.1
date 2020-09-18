Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6E26F9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIRKFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:05:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:2451 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725874AbgIRKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:05:36 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 06:05:35 EDT
X-UUID: 3d65e3b0b821458c84a42662c187f36e-20200918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5KG7Ielhe3B+dvZYJjzHGPLnsgOSiwr2/zpF1goKrCU=;
        b=iLp3H6t0Mz4fO8j1qhV/AO4qSiJrZVY+QLopvfEyBu0HCH1bHGedVZmPW8r8i2Ip8zsC8Hy2cG0fXnC/qV2f37hdjlDqD4FCddprGElV2yqiXVp4kVM85teh7YlkF3mNMbopEMcEe+oh/jwuIk+JNf7tngr8JzO2gnKnYuwEzvA=;
X-UUID: 3d65e3b0b821458c84a42662c187f36e-20200918
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <shane.chien@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 989043934; Fri, 18 Sep 2020 18:00:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Sep 2020 18:00:26 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Sep 2020 18:00:27 +0800
From:   Shane Chien <shane.chien@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <eason.yen@mediatek.com>, <shane.chien@mediatek.com>
Subject: [PATCH 0/1] Use memset_io to access I/O memory
Date:   Fri, 18 Sep 2020 18:00:18 +0800
Message-ID: <1600423219-29058-1-git-send-email-shane.chien@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIlNoYW5lLkNoaWVuIiA8c2hhbmUuY2hpZW5AbWVkaWF0ZWsuY29tPg0KDQpVc2UgbWVt
c2V0X2lvIHRvIGFjY2VzcyBJL08gbWVtb3J5LCBpbnN0ZWFkIG9mDQptZW1zZXQuDQoNClNoYW5l
LkNoaWVuICgxKToNCiAgQVNvQzogVXNlIG1lbXNldF9pbyB0byBhY2Nlc3MgSS9PIG1lbW9yeQ0K
DQogc291bmQvY29yZS9wY21fbmF0aXZlLmMgfCAgICAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCi0tIA0KMS43LjkuNQ0K


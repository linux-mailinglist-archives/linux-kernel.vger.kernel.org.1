Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF02DCF64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgLQKSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:18:21 -0500
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:33640 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgLQKSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:18:21 -0500
IronPort-SDR: QG24yfAsjfeNtckUD1JP48yVAI/mWh3Ou+653xk2bw473IjP931h9WtQgM9h48tZqIpxXz+aHV
 rJz7vH1MqUwQ==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 17 Dec 2020 18:17:39 +0800
Received: from CSBMAIL1.internal.ite.com.tw (csbmail1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 0BHAHXwi011831;
        Thu, 17 Dec 2020 18:17:33 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from CSBMAIL1.internal.ite.com.tw (192.168.65.58) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 17 Dec 2020 18:17:33 +0800
Received: from CSBMAIL1.internal.ite.com.tw ([fe80::2cba:f37c:ac09:f33f]) by
 CSBMAIL1.internal.ite.com.tw ([fe80::2cba:f37c:ac09:f33f%22]) with mapi id
 15.01.1713.004; Thu, 17 Dec 2020 18:17:33 +0800
From:   <allen.chen@ite.com.tw>
To:     <mathieutournier@gmail.com>
CC:     <Jau-Chih.Tseng@ite.com.tw>, <Kenneth.Hung@ite.com.tw>,
        <Laurent.pinchart@ideasonboard.com>, <a.hajda@samsung.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <Hermes.Wu@ite.com.tw>, <jernej.skrabec@siol.net>,
        <jitao.shi@mediatek.com>, <jonas@kwiboo.se>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <narmstrong@baylibre.com>, <pihsun@chromium.org>,
        <yllin@google.com>
Subject: RE: [PATCH v6] drm/bridge: add it6505 driver
Thread-Topic: [PATCH v6] drm/bridge: add it6505 driver
Thread-Index: AQHW09kDeNVHdtyQH0m9AQl+m0+RXan5ifSAgAF7uVA=
Date:   Thu, 17 Dec 2020 10:17:33 +0000
Message-ID: <d056de706f244ef68121f1ca275f9dfa@ite.com.tw>
References: <3F164009-1941-4980-A704-A35EAE3EDAB1@hxcore.ol>
 <CABWh7Q-j57g_vcTx29Po_L8t_nnOMNjUvYdzbuGsFz-xsmV7AQ@mail.gmail.com>
In-Reply-To: <CABWh7Q-j57g_vcTx29Po_L8t_nnOMNjUvYdzbuGsFz-xsmV7AQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.70.104]
x-tm-snts-smtp: 83C1934D75706A74833661191BBC425129E4A12CD44046931B732A017E5019F22000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 0BHAHXwi011831
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldQ0KDQpGb3IgZ29vZ2xlIHJlZmVyZW5jZSBkZXNpZ24obXQ4MTgzK2l0NjUwNSks
IHRoZSBtYXhpbXVtIDk1MDAwa0h6IGlzIGRlcGVuZHMgb24gbXQ4MTgzIHJlcXVpcmVtZW50Lg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWF0aGlldSBUb3VybmllciBbbWFp
bHRvOm1hdGhpZXV0b3VybmllckBnbWFpbC5jb21dIA0KU2VudDogVGh1cnNkYXksIERlY2VtYmVy
IDE3LCAyMDIwIDI6NDcgQU0NClRvOiBBbGxlbiBDaGVuICjpmbPmn4/lrocpDQpDYzogSmF1LUNo
aWggVHNlbmcgKOabvuaYreaZuik7IEtlbm5ldGggSHVuZyAo5rSq5a625YCrKTsgTGF1cmVudC5w
aW5jaGFydEBpZGVhc29uYm9hcmQuY29tOyBhLmhhamRhQHNhbXN1bmcuY29tOyBhaXJsaWVkQGxp
bnV4LmllOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBIZXJtZXMgV3UgKOWQs+S9
s+Wujyk7IGplcm5lai5za3JhYmVjQHNpb2wubmV0OyBqaXRhby5zaGlAbWVkaWF0ZWsuY29tOyBq
b25hc0Brd2lib28uc2U7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbWF0dGhpYXMuYmdnQGdtYWlsLmNvbTsgbmFybXN0cm9uZ0BiYXlsaWJyZS5jb207IHBp
aHN1bkBjaHJvbWl1bS5vcmc7IHlsbGluQGdvb2dsZS5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0gg
djZdIGRybS9icmlkZ2U6IGFkZCBpdDY1MDUgZHJpdmVyDQoNCkhpIEFsbGVuLg0KDQpBcyBpdDY1
MDUgaXMgY29tcGF0aWJsZSB3aXRoIERpc3BsYXlQb3J0IDEuMWEsDQpTaG91bGQgRFBJX1BJWEVM
X0NMS19NQVggYmUgMTY1IDAwMCBpbnN0ZWFkIG9mIDk1IDAwMCBraHogPw0KVGhpcyB3b3VsZCBw
ZXJtaXQgMTA4MHAgc3VwcG9ydCwgYXMgaXQgbWF5IGJlIHN1cHBvcnRlZC4NCg0KTWF0aGlldQ0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD24F28F610
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbgJOPpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:45:46 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32646 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731115AbgJOPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:45:46 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09FFXNYu030506;
        Thu, 15 Oct 2020 17:45:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=FlUps5l1qHs3UktBsfAqXmT7hDBXF55BDMjiS5k1x7Y=;
 b=NnlY2B+UeYSZo/SFQkGwmcD8r7wIyOUdTGpu3ltoloIfmHj9aJ2KHi4gO1LAbJMlrzCW
 r08UwbkP0LdFAZl5S8155tLHSA1oaIoGlNuQ6KHEy3O55gkdlXC/6t9r1wW9Demx6SSM
 +Pc0B3asM1TnVBD1FCtwwHpP9M9r9Q+5E0mRD/XUAABGPkldPVeL7DEem7Q/xh6BR1gF
 Hk+FwUkMmU6PpCt3chbyfKACed64VSbHFsLkgGqzM/pY0JPycEwFQMZZOLRkqw86vA1g
 r753221eIgs51gOmZ8uSyjoo8X6c/Qe55+/mDuJR0Sb13czfC3dfOEZDfeTpYsM7PToX 2Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34356enyr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 17:45:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA2CA10002A;
        Thu, 15 Oct 2020 17:45:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 641392CA83C;
        Thu, 15 Oct 2020 17:45:25 +0200 (CEST)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 15 Oct
 2020 17:45:24 +0200
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Thu, 15 Oct 2020 17:45:24 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        =?utf-8?B?R3VpZG8gR8O6bnRoZXI=?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Yannick FERTRE <yannick.fertre@st.com>
Subject: Re: [PATCH] dt-bindings: display: Add dsi-controller.yaml in DSI
 controller schemas
Thread-Topic: [PATCH] dt-bindings: display: Add dsi-controller.yaml in DSI
 controller schemas
Thread-Index: AQHWmQ+ulgrOjTAQxEucP5u428qq1amYwL0A
Date:   Thu, 15 Oct 2020 15:45:24 +0000
Message-ID: <96cfe905-6d6b-646f-8b81-c4deb110d13c@st.com>
References: <20201002225924.3513700-1-robh@kernel.org>
In-Reply-To: <20201002225924.3513700-1-robh@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <554B802CDF0F7B47B9FA5FABAD1C4879@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_09:2020-10-14,2020-10-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzMvMjAgMTI6NTkgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBTb21lIERTSSBj
b250cm9sbGVycyBhcmUgbWlzc2luZyBhIHJlZmVyZW5jZSB0byB0aGUgcmVjZW50bHkgYWRkZWQN
Cj4gZHNpLWNvbnRyb2xsZXIueWFtbCBzY2hlbWEuIEFkZCBpdCBhbmQgd2UgY2FuIGRyb3AgdGhl
IGR1cGxpY2F0ZSBwYXJ0cy4NCj4gDQo+IENjOiBNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5l
bC5vcmc+DQo+IENjOiBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+DQo+IENjOiBFcmljIEFu
aG9sdCA8ZXJpY0BhbmhvbHQubmV0Pg0KPiBDYzogTmljb2xhcyBTYWVueiBKdWxpZW5uZSA8bnNh
ZW56anVsaWVubmVAc3VzZS5kZT4NCj4gQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlA
Z21haWwuY29tPg0KPiBDYzogUmF5IEp1aSA8cmp1aUBicm9hZGNvbS5jb20+DQo+IENjOiBTY290
dCBCcmFuZGVuIDxzYnJhbmRlbkBicm9hZGNvbS5jb20+DQo+IENjOiBiY20ta2VybmVsLWZlZWRi
YWNrLWxpc3RAYnJvYWRjb20uY29tDQo+IENjOiBNYXhpbWUgQ29xdWVsaW4gPG1jb3F1ZWxpbi5z
dG0zMkBnbWFpbC5jb20+DQo+IENjOiBBbGV4YW5kcmUgVG9yZ3VlIDxhbGV4YW5kcmUudG9yZ3Vl
QHN0LmNvbT4NCj4gQ2M6ICJHdWlkbyBHw7pudGhlciIgPGFneEBzaWd4Y3B1Lm9yZz4NCj4gQ2M6
IFJvYmVydCBDaGlyYXMgPHJvYmVydC5jaGlyYXNAbnhwLmNvbT4NCj4gQ2M6IFBoaWxpcHBlIENv
cm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQoNCg0KSGkgUm9iLA0KYW5kIG1hbnkgdGhhbmtz
IGZvciB0aGUgcGF0Y2guDQpGb3IgdGhlIHN0bTMyIHBhcnQsDQpSZXZpZXdlZC1ieTogUGhpbGlw
cGUgQ29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOi0p

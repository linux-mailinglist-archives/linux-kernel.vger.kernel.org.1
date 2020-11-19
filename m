Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4992B900A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgKSKYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:24:32 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55472 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgKSKYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:24:31 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJALtiG006723;
        Thu, 19 Nov 2020 11:23:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=p4mzCj+B69TXZeYDuaw092X0YJhGUhi21XMiQofjohg=;
 b=kwNzPUvjckfgFdetteQ7wdwE8Ac4Bh+gzjmRGqyxrzvUSqlktzDZ8eDQiPMayCS+2Yqs
 I1FYspXeWLMNkdL10TpVZu68nQPw98moR2RETKuk/Gh4M1i5RnAzJX7C+x6im2CiE65v
 vSVlkHZUmVvpe7/+v4W2vdUuQjzbOQ/KXRvwTYesLd+9Pe/29al21S+FRg9CJGaCQxi7
 pf242/Y7sXV/WnCMdYuxDUbFuXdUNTgfAggKkhauVhM0X2WXYKL4b4kxcXcDKL0a2ROS
 3Tf7g21I3saOW+Xo4GfYsHxFmPr89H0z70Z/ZVFvrbsg7a4v4bPwy91STE86NjQypTNQ fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t70gyc1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 11:23:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB1FB10002A;
        Thu, 19 Nov 2020 11:23:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BF1AB240134;
        Thu, 19 Nov 2020 11:23:54 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE1.st.com
 (10.75.127.4) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 11:23:54 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Thu, 19 Nov 2020 11:23:54 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Alain Volmat <avolmat@me.com>,
        Russell King <linux@armlinux.org.uk>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Olof Johansson" <olof@lixom.net>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
Thread-Topic: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
Thread-Index: AQHWfwfrE6fqxIT1OkCwFqrVmb6UAKnPh2uAgAAFIgCAABldAIAAB2uA
Date:   Thu, 19 Nov 2020 10:23:54 +0000
Message-ID: <1f55d2f0-c0dd-fc1a-33eb-935812f9de8c@st.com>
References: <20200830195748.30221-1-avolmat@me.com>
 <4597cef9-a9f9-bbde-69ac-dd9f96cb7c30@st.com>
 <CACRpkdbigTHKtfwQQSVf7EiJyG8Lby=ksBdmvBKDt0jqPXjUsA@mail.gmail.com>
 <e1de318e-5bea-ee33-f222-f2c67354e956@st.com>
In-Reply-To: <e1de318e-5bea-ee33-f222-f2c67354e956@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B92FA4AEE9C12F4988949D5D695DC8A9@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_08:2020-11-17,2020-11-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWZ0ZXIgZGlzY3Vzc2lvbiB3aXRoIEFsYWluLCBoZSB3aWxsIHRha2UgY2FyZSB0byBzdWJtaXQg
dGhlbSB0byBSdXNzZWxsJ3MgcGF0Y2ggdHJhY2tlci4NCg0KVGhhbmtzDQoNCk9uIDExLzE5LzIw
IDEwOjU3IEFNLCBQYXRyaWNlIENIT1RBUkQgd3JvdGU6DQo+IEhpIExpbnVzDQo+DQo+IE9uIDEx
LzE5LzIwIDk6MjYgQU0sIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+PiBPbiBUaHUsIE5vdiAxOSwg
MjAyMCBhdCA5OjA4IEFNIFBhdHJpY2UgQ0hPVEFSRCA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4g
d3JvdGU6DQo+Pg0KPj4+IElzIHRoZXJlIGFueSByZWFzb24gZm9yIHRoaXMgc2VyaWVzIG5vdCBi
ZWluZyBtZXJnZWQgPw0KPj4gRGlkIHlvdSBwdXQgdGhlbSBpbnRvIFJ1c3NlbGwncyBwYXRjaCB0
cmFja2VyIGFzIEkgYXNrZWQ/DQo+PiBJIGhhdmVuJ3Qgc2VlbiB0aGVtIHRoZXJlLg0KPj4gaHR0
cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVzLw0KPiBObyBpIGhhdmVu
J3QgcHV0IHRoZW0gaW50byBwYXRjaCB0cmFja2VyLCBteSBiYWQuDQo+DQo+IEkgd2lsbCByZWdp
c3RlciB0byBpdCBhbmQgYWRkIHRoaXMgc2VyaWVzLg0KPg0KPiBUaGFua3MgZm9yIHRoZSB0aXAg
TGludXMuDQo+DQo+IFBhdHJpY2UNCj4NCj4NCj4+IFlvdXJzLA0KPj4gTGludXMgV2FsbGVpag==

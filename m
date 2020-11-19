Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A580D2B8CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgKSIIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:08:43 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:34895 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgKSIIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:08:41 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ84177020085;
        Thu, 19 Nov 2020 09:08:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=mi2RW6UKgtzNmOF3R6Z4E/lynidHRdOUei/ubAEwZ2M=;
 b=xg/5zlP+NjWu/MErlrtfzNFA99jo0snOrCnYL+TZSrye8vbVYO3hF9M9/8bZf2B/cV1V
 QtQBarl3kZdjsriMK+d/iGspSiEDjSYEJP2/HrCuf4QsCfg+Lf8+Q0+903HYPlVj0Yqx
 Hnz7/r7v5GT4zR4hCsVmWtscNmckJg70MzRgnVGiSyACH5yzWLloEzod4TYONdXSMBt5
 rwx2xlTdu3pwxkXUFhqDqbr1IM7+q9n0gVEZqt8oB4cTwCysUTeeBJzAFRfWhmM4VH6O
 APQNdSgi14oudMrz/yz2yt6Y0zLcHl+lXWurAltp97IxSHHhzcgRZXbRBxRJFA8sHiaQ vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5k5dyy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 09:08:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 24E0E10002A;
        Thu, 19 Nov 2020 09:08:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 053E023126E;
        Thu, 19 Nov 2020 09:08:13 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 09:08:12 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Thu, 19 Nov 2020 09:08:12 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Alain Volmat <avolmat@me.com>,
        Russell King <linux@armlinux.org.uk>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Olof Johansson" <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Nathan Huckleberry" <nhuck15@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
Thread-Topic: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
Thread-Index: AQHWfwfrE6fqxIT1OkCwFqrVmb6UAKnPh2uA
Date:   Thu, 19 Nov 2020 08:08:12 +0000
Message-ID: <4597cef9-a9f9-bbde-69ac-dd9f96cb7c30@st.com>
References: <20200830195748.30221-1-avolmat@me.com>
In-Reply-To: <20200830195748.30221-1-avolmat@me.com>
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
Content-ID: <9E1092938500BC4B926889990A97AA44@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_05:2020-11-17,2020-11-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnVzc2VsbA0KDQpJcyB0aGVyZSBhbnkgcmVhc29uIGZvciB0aGlzIHNlcmllcyBub3QgYmVp
bmcgbWVyZ2VkID8NCg0KVGhhbmtzDQoNClBhdHJpY2UNCg0KDQpPbiA4LzMwLzIwIDk6NTcgUE0s
IEFsYWluIFZvbG1hdCB3cm90ZToNCj4gVGhpcyBzZXJpZSB1cGRhdGUgdGhlIFNUaSBQbGF0Zm9y
bSBMTF9VQVJUIGNvZGUgdG8gcmVseSBvbg0KPiBERUJVR19VQVJUX1BIWVMgJiBERUJVR19VQVJU
X1ZJUlQgYW5kIGFkZCB0aGUgU1RpSDQxOCBTb0Mgc3VwcG9ydC4NCj4NCj4gQWxhaW4gVm9sbWF0
ICgyKToNCj4gICBhcm06IHVzZSBERUJVR19VQVJUX1BIWVMgYW5kIERFQlVHX1VBUlRfVklSVCBm
b3Igc3RpIExMX1VBUlQNCj4gICBhcm06IHN0aSBMTF9VQVJUOiBhZGQgU1RpSDQxOCBTQkMgVUFS
VDAgc3VwcG9ydA0KPg0KPiAgYXJjaC9hcm0vS2NvbmZpZy5kZWJ1ZyAgICAgICB8IDM4ICsrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vaW5jbHVkZS9kZWJ1
Zy9zdGkuUyB8IDI2ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAyOSBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4NCj4gdjI6IHJlYmFzZWQgb24g
dG9wIG9mIGxpbnV4IDUuOS1yYzINCj4NCj4=

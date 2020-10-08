Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB965286D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgJHD5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:57:52 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47146 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbgJHD5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:57:51 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0983lbJs025835;
        Wed, 7 Oct 2020 20:57:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=0YEaVG1Hl4iXhyT1e4hPpkfGMIjVP4W3wI6QBiL1OdY=;
 b=IOU0PQjKybqPOVN2+QONY8+TC4KXDyunBnFWHhwtGFn/gjDI0US8dzZbMmzrPhW9h5pa
 IS7cSXHA09i+R4blPcWWMuWESeoVcvbSNEVgy41TG0IuCoTOxr/3f+pn3tQmeiwcq1Fb
 HaMBN6Cd69TCDHYycvuqNDe9OLDja4Yx5lDEokFGVfYDoSaqyZO5NadckQi6Pu16Zdq6
 qxwDJMxcO6m7Tmp2mgAIFG+eWbWGgkU2cQx8k0wrVFDVZ4MRN3NmWP/X79d69fF3MEvu
 G/x5U9GGSCMqRlcnZlDSzHYQ74XDgaBXoZAvyPh586SpSj8knfZNnnjzTmdSXCEWAf3u fA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33xnuxre27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 20:57:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBu2zXSuv8zUcZxHXQzfiavJ9ayCe6ruI7AYAClnHhSRhWElGUA6G44kZdI3WaHWI3uJ1vI1cvgkdhl+sULPGrEzuz1W0kg64is85o1mfHUPBLfu1BJlbYS2OPq++j235lF5RHNrWMCdT6IsqXP3OzaJ6C7S8VdxpxHMsGnI3/yIit++Xdppz1ZOz/krWRYv3pFgLEaP7xOW6KTRAafWQvyyWdP9QNpR4hQfKR2GoRjPNe8hIVumJ8OIJg9ItJS09WiMc0V3u4pUlUo9NUhVa+qJID/1iI/2Hz2ZrmptIje+KDALZkSVdp+gyYOd9uLOr27Vae9FiXDR+BKevCq1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YEaVG1Hl4iXhyT1e4hPpkfGMIjVP4W3wI6QBiL1OdY=;
 b=H5UwrAw5341Nd6H/5hFHLEtomVD4ECVlP8DD0NkY42/xai3ZAFRMeGM6SCQAUJr65J7da/86VP3DcvU9PIy8VzFAkwVP99E/Rg9GOr3HNfcr3RlMsNsMl+UUV0SAIAlHpds9EPuqzzonP1cptomGnhN/xvC6BGIb19KSHVa5gOn3kmXEJnFkvJcXVbLn+uCta4ObaepTPdsIR30piu2N0HNDyqGQLSnvyGq4pXILEcwhQlbystEb9Xtxd1UPeY6RqaxFD7XXqQqpp6pqTCe+AWTjsxdbC3YEfQnaBpNwtWYYlWfJ7Jb3MbrC4XLmcSdmTh9GJpO9XqpHV5cSKnHmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YEaVG1Hl4iXhyT1e4hPpkfGMIjVP4W3wI6QBiL1OdY=;
 b=SHHI0QkgsS882BjQA4XPVXOoP9UJ11zIX4PwIpDelvgmo5i3I8XQe9xcKShD7Sz0WKUvnqXlzcfkxpHzlVWiSPgDMWkZ8cMXCkbQXaJohPLI8i/0zL6EToXJXZXUhoX0bRkkGN9nyGqaGdUjyPSIpDgSJwBLGC8MuNViVhg6pyo=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM5PR07MB4037.namprd07.prod.outlook.com (2603:10b6:4:b2::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.42; Thu, 8 Oct 2020 03:57:39 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 03:57:39 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Roger Quadros <rogerq@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: =?utf-8?B?UkU6IFtQQVRDSCAyLzJdIHVzYjogY2RuczM6IFZhcmlhYmxlIOKAmGxlbmd0?=
 =?utf-8?B?aOKAmSBzZXQgYnV0IG5vdCB1c2Vk?=
Thread-Topic: =?utf-8?B?W1BBVENIIDIvMl0gdXNiOiBjZG5zMzogVmFyaWFibGUg4oCYbGVuZ3Ro4oCZ?=
 =?utf-8?Q?_set_but_not_used?=
Thread-Index: AQHWnFuti3XUYQUWRkOXE/bkBsrAi6mLyzCAgAAlWICAASOvkA==
Date:   Thu, 8 Oct 2020 03:57:38 +0000
Message-ID: <DM6PR07MB552984371C356A6E31D8D116DD0B0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201007033932.23050-1-pawell@cadence.com>
 <8994106d-2cc5-fa2c-bbcc-6526632ff80b@ti.com>
 <18bf46b7-d86a-fbf0-9ce7-c2d0765758f1@gmail.com>
In-Reply-To: <18bf46b7-d86a-fbf0-9ce7-c2d0765758f1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjY2OWEwOWItMDkxYS0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDY2NjlhMDlkLTA5MWEtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNzM4IiB0PSIxMzI0NjYwMzA1NjcwNzk3OTciIGg9Im5WU2JjVit4dDBIMjFpeXl1USs4emErb0lpYz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [34.99.247.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dfe5770-1e7d-42a6-c5c9-08d86b3e4c98
x-ms-traffictypediagnostic: DM5PR07MB4037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB4037CD4E7666DC67C4BFEE28DD0B0@DM5PR07MB4037.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:128;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b7Olp1JuGxqoIwmzF8aYU+GyAN9uz7tTH9wF7J63Wbvjc3sa1dFf4Muemi1PaO95RwihWUgPMh6UioA3qRo7LecxjrJPp1hQf3xmnpolshM+Hn05oAv40IIvfbUwiUNeEuE5NiPMLRKOKDJW9DRrayUrkW0kNH67LjsmLCw/XyCDcawN+44swdM0fJrrzZXdACf9XMxZedh+ZnnJVDbTbQI7+A7eB1mxnlUOjGYTdd7ntIsmSpWOdsWpwHBRj+IAWhv23irpkvmuSUH4zK7AaN9uiMtakrfh8NHaPkPogCZ+dSjfqDcX61ai+Qa68vi5wkd54VPFe14i3Jx7+4CEXB2GXxpKeGQp228R4XklkAcF0MeqNPIfLrMpKC0YIBim
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(36092001)(9686003)(7696005)(76116006)(6506007)(107886003)(55016002)(54906003)(4326008)(4744005)(316002)(33656002)(478600001)(186003)(110136005)(66946007)(26005)(66446008)(66476007)(64756008)(66556008)(5660300002)(8936002)(2906002)(52536014)(83380400001)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NHMfJ/MQyaA3vtanAbivcImKYYG9DJpRS6x8z4H2T8fIvIeSdPhcDs/J/GbIeecBa+OWrVY2XWjbmEDOEYxH6oXqGLsGi1Oqg98LjBwh60aFXUOuo8IveMUFpnHsbjr1dJngVMxG7q9nl1QepC+Hn2HyyZa6kpZdNW7LwD6+pn/dGat0Npa1NEN4hG/tjVrwnLTbRMQ8UILS/K8GnzqhY/Z3RMdCbd/LvpG+5Jqr30z9R2SjMmjMhHXP+4f0iAyCOBKZhGSxBlqmEZu7ZyOsLeRZa/A8PQb6OWKkEgCvwh6PqyGvum6Yfl8ruLK9Y4WjVxOqYL1I5Nym8nIBybAgObRVK6Ewcm8XucTNNpaXizIOGt0Y3Ftc6wAEcasbAKpJ0EeSzUu/PEYHtOh9yrs4wBUUJhZPsFIlpKDbc5NJSYJJaXh+0cIYlULxdNeSbMLi++wx33Vkje9QeSCGYKxwycNIi86JO3AOrcsXOoRwXPNuy09sfdzq3eaxNikf3pDnTm/95rPo9xMk0b7U1J/SdJsQAu3ueQYjsli6+SFUZBtauuO1GkyBR3j7H59k4zl3c0Cl8m8eTzECRdlSjzY6w+kuXcne7dljpcba+c0/3OFde46U9ayscgLle9qzKpYVF0uzqfY7t8esf7xZtpwLwQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfe5770-1e7d-42a6-c5c9-08d86b3e4c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 03:57:38.8331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1a30GeGfzls7TPYkCvrTElx7+q/jCtIk3oGGQRUIXbUBeUSU8BAg8qCHizpBcI79y1BQ0YDczup0ou7n2c2ilPYx71aV7Z5fNIf64VvcSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4037
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_01:2020-10-07,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxscore=0 mlxlogscore=616 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2llcmdlaSwNCg0KPg0KPk9uIDEwLzcvMjAgMTE6MTUgQU0sIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6
DQo+DQo+Wy4uLl0NCj4+PiBQYXRjaCByZW1vdmVzIG5vdCB1c2VkIHZhcmlhYmxlICdsZW5ndGgn
IGZyb20NCj4+PiBjZG5zM193YTJfZGVzY21pc3NfY29weV9kYXRhIGZ1bmN0aW9uLg0KPj4+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4+
DQo+PiBGaXhlczogY29tbWl0IDE0MWU3MGZlZjRlZSAoInVzYjogY2RuczM6IGdhZGdldDogbmVl
ZCB0byBoYW5kbGUgc2cgY2FzZSBmb3Igd29ya2Fyb3VuZCAyIGNhc2UiKQ0KPg0KPiAgIE5vICJj
b21taXQiIGlzIG5lZWRlZCBoZXJlLg0KDQpDYW4geW91IGV4cGxhaW4gd2h5PyANCg0KSSBndWVz
cyBpdCdzIGJlY2F1c2UgY29tbWl0IDE0MWU3MGZlZjRlZSBpcyBxdWl0ZSBuZXcgYW5kIGl0J3Mg
bm90IHlldCBpbmNsdWRlZCBpbiBhbnkgc3RhYmxlIGtlcm5lbCB2ZXJzaW9uLCANCm9yIGJlY2F1
c2UgaXQncyBvbmx5IHdhcm5pbmcgLSBub3QgZXJyb3IuIA0KDQpBbSBJIHJpZ2h0ID8gDQoNCj4N
Cj4+IEFja2VkLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAdGkuY29tPg0KPlsuLi5dDQo+DQoN
ClJlZ2FyZHMsIA0KUGF3ZWwNCg==

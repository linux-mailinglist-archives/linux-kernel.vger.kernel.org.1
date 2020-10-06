Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475412848C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgJFImn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:42:43 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:2676 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgJFImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:42:43 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0968fiQu004125;
        Tue, 6 Oct 2020 04:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=plXhWIhjHa+vUc+1SBJv/T19h/1N8DTp70vAk1yVfQs=;
 b=dLu3pnoBsTYbiS2qGyqVPZm7Ee4Hn4ycrfGre5pgy4AgmniaUCWiGnBufZ9QxRtl8X1M
 5F3M6aa0M4vKBExAzAX6vRrGc/GR4cZ4rWcgPmWWRUanfFXOgQylBjot+U47Cq+7QvWu
 wuxv2HZV9hdxG83G7egSGQVD0CDcypnV32Fai2mKL9lskT2pZg+aOvoGOMUqAOs0eCl3
 lRf1iYD2jb2u4kGDYMVi8VT2jE/BruMp356jWGdstYPl+klCjTP2Q11NGENdzlnl/myd
 bFkX3Y/kiVBOFJfo7ydT41USkKxCnK9yF9HW+PbNtF3mVKTq2Aym2V40Z50wTqHdgezu PQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33y8mcppav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 04:42:41 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0968gX8n080106;
        Tue, 6 Oct 2020 04:42:40 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00154901.pphosted.com with ESMTP id 340mg7gmk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 04:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPtNAaXJn1UBlk+eUq/Q62hiCqB95Jz0JhgLNcU+4VOV9t7bbTcGT1uVV8CpWg49uzWCQ59ZNiehQdWCX0LmyjS/3SePNLcJ4+AXuAGmEfqCSKxsLOOQqcGYFEw1Eg/SHXpHHTysiLcs7uQDC7Zr9l1f3++tLO0O2HSapqWUqye5WwS1tP3xopZm4/hKJkvpvUM0uYFZwHb/1UpYqlzg9x2CJJ0rHjdAZCIrK54vfD9LLgzYfAfyO3lsF4Z2DCDFyk6BAPZ1DqTefWBYmBKg7YfNqK9otc35icTI3xc9eNUZYI6CjbI2jmKokEz3xPGG2FJRfAT2GCv+tk5C5Nsy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plXhWIhjHa+vUc+1SBJv/T19h/1N8DTp70vAk1yVfQs=;
 b=jRaXY8ww246OYi4AxyVfsEJjqTXGAu9Q1a6Bf34RoGOmJcm7QQRVPygz0r6Svz4Z4xHm8/eYRr9rIZvnQBrf8iZwRwhcwUE44RH/PlymvsFMOa44ivieNpyJiHdmWJ7uLVka/TN4nLzerYT7e8GhvyzPToI3QUkS8d9f59ej8EUayTjVdvHX+2Jxl9GeqSoXUG33zSw/c8YxMsd8etMOp6vfyfKMY1ajd+krJx7GObpAN3aLSThlfTZlEZfDbtsk/8Zfx8h3eRZ+U+JkTgG9tnx+/G2trE8D6h3oVSFRlNIDhApRfGPhdxZ+8BlRKTEpsVMG2ll4gDS480MxSzmAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plXhWIhjHa+vUc+1SBJv/T19h/1N8DTp70vAk1yVfQs=;
 b=GMNuWrztFRkp/pRXyOfSjTU1Jyw9CuoFXhEzT4EilBW/0tfvvrpmsgpt5AbjjnO2JnA83U7XAEeQqVtKiCRJbpuUDccViKHkREX8ddCD9Eaj9q0jtLdRCOBDVdR6sM/5RlpmVtfQDeZCGuim424ItkBxPnwr217izT+AhmL3MAQ=
Received: from CY4PR19MB1254.namprd19.prod.outlook.com (2603:10b6:903:109::19)
 by CY4PR19MB1557.namprd19.prod.outlook.com (2603:10b6:903:14d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Tue, 6 Oct
 2020 08:37:51 +0000
Received: from CY4PR19MB1254.namprd19.prod.outlook.com
 ([fe80::28f2:1ae1:8ba:4bfc]) by CY4PR19MB1254.namprd19.prod.outlook.com
 ([fe80::28f2:1ae1:8ba:4bfc%11]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 08:37:51 +0000
From:   "Bharathi, Divya" <Divya.Bharathi@Dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: RE: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Topic: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Index: AQHWlgw8iScoxjhp9kO1Bw1J0X/FTKmDEwiAgAc2tbA=
Date:   Tue, 6 Oct 2020 08:37:51 +0000
Message-ID: <CY4PR19MB1254A852F16CD347C38E742E850D0@CY4PR19MB1254.namprd19.prod.outlook.com>
References: <20200929025521.59573-1-divya.bharathi@dell.com>
 <7015e6d5-3c1e-e07e-572f-d5d47a9b0191@redhat.com>
In-Reply-To: <7015e6d5-3c1e-e07e-572f-d5d47a9b0191@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [223.226.93.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1993261f-a47e-4aff-4bd1-08d869d31caf
x-ms-traffictypediagnostic: CY4PR19MB1557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR19MB155729727DC251D1F95E537D850D0@CY4PR19MB1557.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qftkazHgXkeHAcaP2g0+9oToycnzYxrpH6kG/StJVRLqiEFlOGv7h5vGTpCxv4a0N8MQWR0UuBZ4s4RAh3PeI4xxgyM/M2VQL+uPsOQywM0H5IUOLfCUqKy+0uFoTAjjdhloTeDs4dRbQ6NedmFjHgCZ/w9tyIhrRpcx6MP9srRgij+EDZG78FO2zNtwE1S4AWdqfv65XXvNRk1Fvo0vYYlEh5CfhzDvktY0lpUR/+V0FKm4Gnrz0ooMsaXqbxuNQrS6dinP0S8AJsK9geelAYE21dSqIAHwV9DelZozJQJz4DdbAt2VE0pDg7UEKtjs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR19MB1254.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(7696005)(76116006)(186003)(66556008)(66476007)(478600001)(8676002)(71200400001)(54906003)(2906002)(4744005)(66446008)(83380400001)(110136005)(64756008)(66946007)(52536014)(786003)(5660300002)(4326008)(33656002)(316002)(107886003)(26005)(6506007)(86362001)(9686003)(55236004)(8936002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0AFd4dhp/f5PNLTvPkw3qynviUxBWG/r3lJ6A9G8vRml0GNG+adjoMQmP1Ksrad3IpMQ7fE97+2D113QSpdAOwX2Z1m2HLC0AUugZGYFLUIs4MN0y8UHLF9FwopsNcfbu2s+VSSo7GH9sjCtLyJtnXtZgpHt5HsbWgz8wKca5TBH7LVYMSh4gUlsn1jKKMNg8I4P3LkNC0z9TYxcGom8mNGL86GX1sUVlzugUyrkYjI906IOTe/t6cjZ8RY6U5+c4lN7NvetSQdMmfmZ1n9LdOxqQhOMW2GXlToMT/HhWdX/n7G9a8ex6cDBZulEcRnC1AZLfyznQ6sZxFapTSCstZmwHo/dvvWJr09Kf8TCaJkJziv2/oQXG790IbdgqgBBnMxteUxIL80gNfv/8OWT62WiCurdz4cs7A671++KgPUt/OKvdwtMucw12KGJhtRVrcytgHsTVf6Is3M0X0xt9GwYwds92LRzYeI8Yy7SBjrNUt34RhIE6v/ZpjnVpz0qb/cfOvxFdwREt5Jmq6PTIHWSetT60GDoBDppxAmwtcNgOTSnwG3xBDEbp2G3y5yDDj0lBcgas3F5ebfS6shBQt/UUPaX6nE+HGePpZmpV6CW09h8j2nWEhFWsgUXav9xi+AGDmbjVdPbJObZwaV8lA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR19MB1254.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1993261f-a47e-4aff-4bd1-08d869d31caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 08:37:51.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhNDmZhJmp4eZQJeXAUiE/rxTc20elU6/YouzLRjbDZ5pRdSFFvhDQzobvDDpPbq8EB/w4WWqxQVd/gLJNXVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR19MB1557
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_03:2020-10-06,2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1011 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060054
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHNuaXA+DQoNCj4gDQo+IEhtbSwgY2hlY2twYXRjaCBpcyBzYXlpbmc6DQo+IA0KPiBXQVJOSU5H
OiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUgYnkgbm9taW5hbCBwYXRjaCBhdXRob3IgJ0Rp
dnlhDQo+IEJoYXJhdGhpIDxkaXZ5YTI3MzkyQGdtYWlsLmNvbT4nDQo+IA0KPiBJIGFzc3VtZSB0
aGUgZGVsbCBhZGRyZXNzIGlzIHRoZSBvbmUgeW91IHdhbnQgdG8gdXNlID8NCj4gDQo+IElmIHNv
IHRyeSBzZXR0aW5nIHRoZSBmb2xsb3dpbmcgaW4gfi8uZ2l0Y29uZmlnOg0KPiANCj4gW3VzZXJd
DQo+ICAgICAgICAgIGVtYWlsID0gZGl2eWEuYmhhcmF0aGlAZGVsbC5jb20NCj4gDQo+IEFuZCB0
aGVuIGRvOg0KPiANCj4gZ2l0IGNvbW1pdCAtLWFtZW5kIC0tcmVzZXQtYXV0aG9yDQo+IA0KPiBU
byBjaGFuZ2UgdGhlIGF1dGhvciB3aGljaCBnaXQgaXMgdXNpbmcgZm9yIHRoZSBwYXRjaC4NCj4g
DQo+ID4gLS0tDQo+ID4NCg0KVGhhbmtzLCBJIHVzZWQgLS1yZXNldC1hdXRob3Igd2hpbGUgY3Jl
YXRpbmcgcGF0Y2gtdjYuIA0KDQpBbmQgSSBoYWQgYWRkZWQgbXkgZGVsbCBhZGRyZXNzIGluIGdp
dGNvbmZpZyBmb3IgcHJldmlvdXMgcGF0Y2hlcyANCmFzIHdlbGwuIEFsc28sIGxvY2FsIGNoZWNr
cGF0Y2gucGwgc2NyaXB0IGRpZCBub3QgdGhyb3cgbWUgdGhpcyB3YXJuaW5nLg0KDQpIb3BlLCBu
ZXh0IHBhdGNoIHdpbGwgbm90IGhpdCB0aGlzIHdhcm5pbmcuDQoNClJlZ2FyZHMsDQpEaXZ5YQ0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78C2EF63B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbhAHRHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:07:18 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:23134 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727283AbhAHRHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:07:17 -0500
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108Gv1uX001730;
        Fri, 8 Jan 2021 12:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=4m7aLIsfzt+EHSL7mKQC697gqunPEAr3sND4hZGxXu8=;
 b=iSaKhtALfzlknPzjTi0GqhUzzQ/G+PptCbmL/U+Ee8NE+D0q70JzAMAmlTQGC3lzoUZP
 xnA2rp+n0IjdqP/9wiXYTU5y9uIZXGB3Ufw4Ia/pOORlfeytjnnKARYLQ+7dV2287Frl
 RojUF2PS5Kr52AeLl+NvePt95EbY25fCii7Jp3DGozTMGIeAOqcDmo5pV2uKZC9ZyHEQ
 ifOFs8EGLM5lt3gSFBy6mBsVES4UwMCHV1PnuDXfRs5BDQ9TavCodqNDaRx8Vyqko9L+
 avq2riKtvhFdsKYMsPknSvDayGl1mWe+w3OpjOCCtIl0VBDLMRuFbxiO9Q4EgLLXi03r Tw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 35wsyux85v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 12:06:28 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108GsbWf131731;
        Fri, 8 Jan 2021 12:06:28 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0b-00154901.pphosted.com with ESMTP id 35xtyx0km8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 12:06:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irYIY5EiQTcqMP/7CfDn93Eis0svoYj/+cizcqw8bB7oThLs3/gigsW6oxKBrZHZkJi0yEvxjSA2CqEs1Zz/HJ1quke9dBFIJulZtSWGtfGJLlABZGBZKsfAq31v+8S1oMJFxdPfLQ9eSslTh5/V2+wHeeUPTyAMU6+8tUkGEQmg0ryS0WhUSV7XgZGclmBAtAPRHJTAA1UDE8fvq25WD7YnWc06FgSfaLmBUbLXYxtopMuNk+5b8Xi6Zvm/XkyayiNA19zAtVbgT36JfjQja9udpVOvNRF90Vk9WtCGhQpPnQ53tTfrQdKT9Zk8GSo/xRBUyO6pB131c1mvVXaV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m7aLIsfzt+EHSL7mKQC697gqunPEAr3sND4hZGxXu8=;
 b=Gb+f6VqvhlZEk4kPzTNDXe+wWCsbA8KaUMHuk9OpnvFleuRvyoEjyKz66ElkF1Ew3pcXJLyXSxd5MO2bvmNtL2PZzkg+BeCI/UiaKwsog1QauvNNMRjuCPhtmEoM/z8yuOr7zZC1A161fFTFAoUtPKABGxltIY6JwlW+qM6LG8GlCIKg6xtbaE/RDgdlpEKqkEuDMIE4+XjuVi5hJNdnuKkcI4AWIdG9ojOgNb8Fr7d3qEo3xRKkhCsCz2wKugS1zjNRwPrHNtCzSbJDEiQPtP1/4Thi5+Gw5893r3GYTiTUJeAR/h0usNsiAfBm1F5BMNHkCQCoGHSVnknUskd+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m7aLIsfzt+EHSL7mKQC697gqunPEAr3sND4hZGxXu8=;
 b=BJI+O8DBsm2z3nmtaYGrQykoDl5vmGfOOFtvAP5gOR+i3uobAqlgjog/ekMwZdC+7vHvHWoQbDSuENAGAA2Znoy9ww3E5sipivZPbkmel8w61nQAuBX50xswpgb8mLEIqkbe/BsiNRFz7Ym6OBjz98csg91/5+6zUE4v7Ls2qUc=
Received: from SA1PR19MB4926.namprd19.prod.outlook.com (2603:10b6:806:1a6::18)
 by SN6PR1901MB2141.namprd19.prod.outlook.com (2603:10b6:805:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 17:06:26 +0000
Received: from SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::e14a:eb33:4847:6cba]) by SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::e14a:eb33:4847:6cba%3]) with mapi id 15.20.3742.007; Fri, 8 Jan 2021
 17:06:26 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     "Yuan, Perry" <Perry.Yuan@dell.com>,
        =?utf-8?B?QmFybmFiw6FzIFBvY3pl?= <pobrn@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, David D" <David.D.Wang@dell.com>,
        "Zhang, Zorro" <Zorro.Zhang@dell.com>
Subject: RE: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
Thread-Topic: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
Thread-Index: AQHW3R16WYDyiAWUE02/be1YjUlvG6obUR6AgAESAgCAAaNiAIAAADHQ
Date:   Fri, 8 Jan 2021 17:06:26 +0000
Message-ID: <SA1PR19MB49267EC0228761CBAE0FACBAFAAE0@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com>
 <d1d31281-d5c8-ea09-9e2d-1c5acb35deef@redhat.com>
 <kt8PP3Pj3sI0-gL28bw5rPCvcv3S8STD0pMFoQUrixarFRv_36In5dPDtrOtSSJk2WhEo4FN9duHO_pNG8kDDPng06mDOX9UvmXeaPNI6sE=@protonmail.com>
 <SJ0PR19MB4528F933A2FD758D2EDECB0484AE0@SJ0PR19MB4528.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB4528F933A2FD758D2EDECB0484AE0@SJ0PR19MB4528.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Enabled=True;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Owner=Perry_Yuan@Dell.com;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_SetDate=2021-01-08T16:57:57.9042099Z;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Name=Customer Communication;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_ActionId=572b0802-0f66-4dfc-946d-48bba748db53;
 MSIP_Label_a17f17c0-b23c-493d-99ab-b037779ecd33_Extended_MSFT_Method=Manual
authentication-results: Dell.com; dkim=none (message not signed)
 header.d=none;Dell.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c213e22-0ed1-42c6-09f8-08d8b3f7bbd9
x-ms-traffictypediagnostic: SN6PR1901MB2141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR1901MB2141C1F701656CBEE4A6134EFAAE0@SN6PR1901MB2141.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+xoBVmoMY5IPSaEaAgbdrCfprVD1KhByUqNEfOM4/bOP6Jc7nbfL7S+ncUhMQSXIofPLAmz+MaWNJgjGFCCL4pqzf4uZK8PBq5aka6AldEMFZ7tAi/KCZ1UPBMnsvnwT8VSCMzQF2fkQJ9XEoyOUTcQh1VVVi9Ej5gAxo4K+G5m6zUdbH8fiEQ3MgeeGN+8MAjpyl3Co6M7gNN+6e6UJB818NuK82o9V87tK6HADIerpyTZ9KPO/Ybz+MIvQ2zd1xDrKpnQjj7zz1qk41nSNix/YBCVkydBu7Su5YmRUAOZHuVVvs1PPhHajJXV1Bxjjdkwjd5mix4j1UP1xZkQXpnzf+j8cOktqWX6tRzXOVmVYHuwoxVMk2xlKaQlvdYmoeektdm9aihyGxFuEaQxxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4926.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(86362001)(33656002)(64756008)(110136005)(8676002)(66556008)(76116006)(52536014)(8936002)(66476007)(2906002)(54906003)(66946007)(478600001)(107886003)(5660300002)(4326008)(55016002)(26005)(186003)(66446008)(558084003)(7696005)(9686003)(316002)(786003)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QzlHOTBTeHEyaVFoU2ZSbWdGd0E1dXh3cTZzdWRFM3lRdFh2L0lyYXpzcERG?=
 =?utf-8?B?Q1VFTkFrRzRpcCtiVFY2MW00RHV2UU1ZV1RmdVJEWm9pTXF2eFNFRDBOVlZk?=
 =?utf-8?B?Z3duK29qSUNJRThuZW1qUFMwNlRVWExnL0h0b0dmQ3VrdDZRRnNWUXlkZXZ2?=
 =?utf-8?B?RzFiRmhmd0hqbUo1RS85dWllbFRDeTJYT0kvYlpXQmNLK01yZlZkQmhPeTFI?=
 =?utf-8?B?TnZpUzdYbndlQWYwd0U2MndGV05nM1JtTDFueFRWRTN4b0twTFFnenZYaVZh?=
 =?utf-8?B?bDZJZk9rUGJybFd5dUxEM1R0b2wxTnVWMjdEUDFaU2w1Q0Z6REMraVM4RmZn?=
 =?utf-8?B?Q3VEMVd3UEp5cGVUc0pGRkZzWHMzaW95MThQcFVPK09yR2NJSmFtYWtldUs5?=
 =?utf-8?B?b2N6UUllMmFzbVY2RHJaNnRpYXJCTUFUY29rUUhVU2gzUVFMRnZTNXorRExo?=
 =?utf-8?B?QmFKL0dSL2xTZGgrOVRnQlhaRU1mTDdPNGJSaWFWMCtOVXYzYnlaekcycWRC?=
 =?utf-8?B?Y0hTSThBS2hhQlp3WkJESjJYQ2VJcXVjYWdKYUFvSUlrYzV0WHloM05CM2tO?=
 =?utf-8?B?b2h4T0lmZEJQYlJURCs2enBKTXNpYjVWZW9CRUZQcGREUEhLUmxZc01vSEdL?=
 =?utf-8?B?QXR0NlFnUEYwWFlnWkkzRlk0OGVrYm51bzhFcHpKcnAxK1ArdGpadXZxN3hQ?=
 =?utf-8?B?eXlmd0Y2VDRPRGlRQmlySlVSb0pBVkFmUmdNVjgrSkY3SlVhblVxZlJaWVB1?=
 =?utf-8?B?YTRZTDVRMW81bjhwdmU0bDVuSFgybkI5NGFmVmNTRml4citTMk91T3BBdFFS?=
 =?utf-8?B?WjNQQUFZczV2NkN1cXJ1QWNNYlZmaUdpdjdrak9Rc2E4eGJnTmZHS2FmZ0wv?=
 =?utf-8?B?RUQrQnFyUUkwZlVvWW13Z2orSE5NWjZjTXRaVnp1ZkVuT1BEb1hOWkdkOEFT?=
 =?utf-8?B?bEk1SmdoVXBvREYxVk5nalp1SkhCa2lFakdJTWQwTUxVamRoRnVZN3JVWTJl?=
 =?utf-8?B?Z0Rad1ZYS3diNXd5Wk4xUnlEL1V2NXUyU3hQUmlRZWdjQmZKQXhjc0JCMkcw?=
 =?utf-8?B?cGhqM20vMDkxbFlFUW02OUV5Q2lXSFVrWXJZcTZtLzA3dk5ka0grRUR1d3Rp?=
 =?utf-8?B?a2s4MEJpVzdZaEptRFVDL2dpKzNiNDVVdjFtcjZBYUtkREJZNnJqSktoeFhp?=
 =?utf-8?B?NnJnM01aUDNvTGFSRStKOEw2RmNwdTRZRDlCcU5ZV3NZS0tKejA4TmdQY2dx?=
 =?utf-8?B?eklVT2pwTm5GR0ZUV2pqNWk0MGdvdjR6azFDa2d1YnU4QmZBTTArM1Q5bWky?=
 =?utf-8?Q?9vFTIBg1deBgs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4926.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c213e22-0ed1-42c6-09f8-08d8b3f7bbd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 17:06:26.2145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SFiBz+WI+54nB3+DXMArKU7lGtmKwhvpjoA4FNDD5mnciaDJ4oJuadWXrEQyRFRQnzFDqMYA+DFU+vt619Hd4gQrggK+F9sp3JR5zUrY2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1901MB2141
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_08:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=595 adultscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080095
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=715 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVsbCBDdXN0b21lciBDb21tdW5pY2F0aW9uIC0gQ29uZmlkZW50aWFsDQoNClBlcnJ5LA0KDQpG
b3IgZGlzY3Vzc2lvbiBpbiBwdWJsaWMgbWFpbGluZyBsaXN0cyB5b3UnbGwgaGF2ZSB0byBtYWtl
IHN1cmUgdGhhdCB5b3UgZ2V0DQpEZWxsJ3MgbWFpbCBzZXJ2aWNlIHRvIHR1cm4gb2ZmIHRoaXMg
Y2xhdXNlIGFuZCByZXNlbmQ6DQoNCj4gDQo+IERlbGwgQ3VzdG9tZXIgQ29tbXVuaWNhdGlvbiAt
IENvbmZpZGVudGlhbA0KPiANCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5425EF01
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgIFQJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 12:09:08 -0400
Received: from mail-bn8nam08on2048.outbound.protection.outlook.com ([40.107.100.48]:15521
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbgIFQJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 12:09:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUPD+xFYsV39rI+eUUkHfqsi8ZVz4qTldYQz2pRr2tZVdNOS25jroDDmiiV7MM39Mi2CYRK3pHR7ngqi3P52/x2H+I3P6wbzPQ6G1BXSklfXAyEjjA44ZAxf9TNY6mTirVH3qE86lBoBfngfjlKsB0/IVWmYLi/JFDNSn1rZ5qDs5GyJKJdn1dZyIQ1sD78XvA5yM0BFbp0122ZGWFBXGHxZsxKWUwIGkU6XtQACoZA6q61aaS1fqK06awGQKS9GmYH2qxLH6DFCeX/y4QTPq87OwJkwHYY1g6Efiz1Mbk0SLULi4/89Kb6Tg5gWXvY1vV9ogACpUABz+7cxbC9fdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7zCx4T7mpicWt4iBAcTh0zATijjcrntP4QFMvYBeYk=;
 b=C7fYrvscx73r9XuxoPsKfuknmBWIVJOQqYAKRb9iSvg/rWuN5QPUPzjD77ilBPTYne55atkLE9UX/96Z1430Rqldt8WXRByPnsFXqarzvNhvWxZ2Eite7laujXjpYWSW9TRszi2SaZCzmD4ia0f+ChzWnbOqwr4SRP6qVkt9bV+mVN7rDg+aQVSfyL2r63a7wuCH+swAMh1Q/h0VXW0VJO9WnU5tOB8sBy3TOmS0NeK7gG0PLD+Z82XjVdeGl754elQtFtNEZBmEXu8m8UsQGU8nvAHcmcI/lqWQ/TwPsGSZ33eE31kqbIWo9bJqMUfw7zceaj1VXQS+neXq06c6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7zCx4T7mpicWt4iBAcTh0zATijjcrntP4QFMvYBeYk=;
 b=pFhtvm8RZ8Jj02BEeZr4iRTjQDxetk8VBBK8hlWlnXnePnMeE6YxGOLGS1MD49q9NxWCmMBCsrCs1wt8ioSF+L/1+ypN9ZS1tv8OSqTcC1CHCgoE8CzSxqYXRsWy3GI1YAxAqElGSsHf4t/XQtiqqRJnxk+Fps7k2i3E3+rxhkk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Sun, 6 Sep
 2020 16:08:59 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3348.019; Sun, 6 Sep 2020
 16:08:59 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     "jroedel@suse.de" <jroedel@suse.de>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Topic: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Index: AQHWegTrKFaLvteaIU+zNTDEWFvNM6lKcXK8gAATzoCAAABa0IADCauAgAACVICAABPWsIAABqKAgAAEcBCACqFqAIADfFNw
Date:   Sun, 6 Sep 2020 16:08:58 +0000
Message-ID: <MN2PR12MB448843EC6D3D5B71613BEAAFF72B0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200824105415.21000-1-joro@8bytes.org>
 <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
 <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
 <MN2PR12MB448849D3AD019749DB64A146F7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828152943.GY3354@suse.de>
 <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200904100556.GU6714@8bytes.org>
In-Reply-To: <20200904100556.GU6714@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-06T16:08:58.298Z;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.187.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e8984bc-d580-4fb3-2a27-08d8527f29fc
x-ms-traffictypediagnostic: MN2PR12MB4174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB417474FB31E013B4CA85AEEAF72B0@MN2PR12MB4174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvsY8buXvvtnkZtWrLxU59sF/UPp2GrvErR9l8xXnCyBQrS7TIP0HtAvQs7MEPTzqxZKmAoCkPHeVrpMhuwsZp5im4Ru19sqEWetkeazllU5CV+j6HpXWT1Dduh8/JfLeaJ7GPpLfPMWKS6YQIjYV9qwAyWRXachcGS1DvtaVJl9M9l24y2jBgBVPcqsAWRlpPShFijwtlwuWL8yqiaVpXNXZQdu9Wz8giaZCYCAoLj8COB9JgqclulJ4fW66XMQI9kSoElCbqWz17wqb1DpCe5CI9I3yvQF85E62Svg+hM6fAjcYeHXSXRVeKnvY7O2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(5660300002)(33656002)(8676002)(52536014)(66946007)(71200400001)(66556008)(6916009)(4326008)(8936002)(186003)(478600001)(64756008)(53546011)(99936003)(6506007)(54906003)(26005)(86362001)(66446008)(7696005)(66616009)(83380400001)(4744005)(2906002)(9686003)(316002)(66476007)(55016002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +py1oJjksXVGlGb7yihXMqOcdbbwAGXq5lKJ6AJlkib0RjVVP0MnWzGLvGMyZ22QBjUCDCYStjTjfgjHkmSt/ZkTJbTSGmYAdq0iOZRKVlqxiAXdZROxal0Aocrfh2XcE2NsYpbVfoxU6e0HFxoI1qcEV9yPQQ/LOWssM37XvvuiKahxqY77CxmGq0D0iGWGhDTiPwVtvSbsSstXUs6NgDxKtl6nZXrGcg66dJ0zC5oEHVbOE5f4yWnIwrp4JIWxS6oppmMp20dW2bt5OGNMi1KDoCk13D0CootoJExSTDtczsWxgvJw/znCSmGQgiNNO6Cx47pLGZuzmDI9YKv1fOTmpO1Y5lZCjqMxZLG3c27Ohs8fW8k5lvMBpxs8ux2GbEKf7UiIcl01dbBFUyz/Jjm7cC48M8UQkH7nKUUXyUc4udZCwb+3SaT5NZ/rrvIsi7ANsqTN/+ORrDafN8oZEEacI8e327lyKJb0+PdG8uiYfLvTckZd+3aR7q5Yh86cgtVNdz0iCt2u2w2e8dZXTIG+g1C9wI4dilQxDW63lNbxUeG9wAm4chUJ6sySrljK9hdQuJnAL3eElr6QIZlfQrhuRSc/Gqf2+Qtibw+Qlkonjt3kpTI3lbonHDSs2TR7x934HLF4qoxhepR8ejPN6w==
Content-Type: multipart/mixed;
        boundary="_002_MN2PR12MB448843EC6D3D5B71613BEAAFF72B0MN2PR12MB4488namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8984bc-d580-4fb3-2a27-08d8527f29fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2020 16:08:58.9580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5eiqX+sLC62Mm6UtoR8nUc9Rh/tfThsRNp6LSFAQ47QQQ60SySLImo0ZxvlqPTDdZ3mCAJD7xS6QSBjf2NtxCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_MN2PR12MB448843EC6D3D5B71613BEAAFF72B0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Friday, September 4, 2020 6:06 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: jroedel@suse.de; Kuehling, Felix <Felix.Kuehling@amd.com>;
> iommu@lists.linux-foundation.org; Huang, Ray <Ray.Huang@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is
> active
>
> On Fri, Aug 28, 2020 at 03:47:07PM +0000, Deucher, Alexander wrote:
> > Ah, right,  So CZ and ST are not an issue.  Raven is paired with Zen ba=
sed
> CPUs.
>
> Okay, so for the Raven case, can you add code to the amdgpu driver which
> makes it fail to initialize on Raven when SME is active? There is a globa=
l
> checking function for that, so that shouldn't be hard to do.
>

Sure.  How about the attached patch?

Alex


--_002_MN2PR12MB448843EC6D3D5B71613BEAAFF72B0MN2PR12MB4488namp_
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-Fail-to-load-on-RAVEN-if-SME-is-active.patch"
Content-Description:
 0001-drm-amdgpu-Fail-to-load-on-RAVEN-if-SME-is-active.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Fail-to-load-on-RAVEN-if-SME-is-active.patch";
	size=1438; creation-date="Sun, 06 Sep 2020 16:08:52 GMT";
	modification-date="Sun, 06 Sep 2020 16:08:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmNDc5YjlkYTM1M2MyNTQ3YzI2ZWJhYzg5MzBhNWRjZDlhMTM0ZWI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFN1biwgNiBTZXAgMjAyMCAxMjowNToxMiAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IEZhaWwgdG8gbG9hZCBvbiBSQVZFTiBpZiBTTUUgaXMgYWN0aXZlCgpEdWUg
dG8gaGFyZHdhcmUgYnVncywgc2NhdHRlci9nYXRoZXIgZGlzcGxheSBvbiByYXZlbiByZXF1aXJl
cwphIDE6MSBJT01NVSBtYXBwaW5nLCBob3dldmVyLCBTTUUgKFN5c3RlbSBNZW1vcnkgRW5jcnlw
dGlvbikKcmVxdWlyZXMgYW4gaW5kaXJlY3QgSU9NTVUgbWFwcGluZyBiZWNhdXNlIHRoZSBlbmNy
eXB0aW9uIGJpdAppcyBiZXlvbmQgdGhlIERNQSBtYXNrIG9mIHRoZSBjaGlwLiAgQXMgc3VjaCwg
dGhlIHR3byBhcmUKaW5jb21wYXRpYmxlLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcnYuYyB8IDEwICsrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCmluZGV4IDEyZTE2
NDQ1ZGY3Yy4uZDg3ZDM3YzI1MzI5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZHJ2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jCkBAIC0xMTAyLDYgKzExMDIsMTYgQEAgc3RhdGljIGludCBhbWRncHVfcGNpX3Byb2Jl
KHN0cnVjdCBwY2lfZGV2ICpwZGV2LAogCQlyZXR1cm4gLUVOT0RFVjsKIAl9CiAKKwkvKiBEdWUg
dG8gaGFyZHdhcmUgYnVncywgUy9HIERpc3BsYXkgb24gcmF2ZW4gcmVxdWlyZXMgYSAxOjEgSU9N
TVUgbWFwcGluZywKKwkgKiBob3dldmVyLCBTTUUgcmVxdWlyZXMgYW4gaW5kaXJlY3QgSU9NTVUg
bWFwcGluZyBiZWNhdXNlIHRoZSBlbmNyeXB0aW9uCisJICogYml0IGlzIGJleW9uZCB0aGUgRE1B
IG1hc2sgb2YgdGhlIGNoaXAuCisJICovCisJaWYgKG1lbV9lbmNyeXB0X2FjdGl2ZSgpICYmICgo
ZmxhZ3MgJiBBTURfQVNJQ19NQVNLKSA9PSBDSElQX1JBVkVOKSkgeworCQlkZXZfaW5mbygmcGRl
di0+ZGV2LAorCQkJICJTTUUgaXMgbm90IGNvbXBhdGlibGUgd2l0aCBSQVZFTlxuIik7CisJCXJl
dHVybiAtRU5PVFNVUFA7CisJfQorCiAjaWZkZWYgQ09ORklHX0RSTV9BTURHUFVfU0kKIAlpZiAo
IWFtZGdwdV9zaV9zdXBwb3J0KSB7CiAJCXN3aXRjaCAoZmxhZ3MgJiBBTURfQVNJQ19NQVNLKSB7
Ci0tIAoyLjI1LjQKCg==

--_002_MN2PR12MB448843EC6D3D5B71613BEAAFF72B0MN2PR12MB4488namp_--

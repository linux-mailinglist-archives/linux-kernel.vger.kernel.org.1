Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B285275248
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWH0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:26:50 -0400
Received: from mail-eopbgr1410043.outbound.protection.outlook.com ([40.107.141.43]:47677
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbgIWH0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jr8f0/xQHJB2GIWAfxRQ0Lmu4BPiPHJ6QUKZ5Gz4PtN/zq1XnP8T/3cH2KY73F057TnBwhPwdfedgGH7W/iunQX89Jll4lsOTOMIrcyrgAZFPL9In50YvGckwH5pNSWCLLnwbPfAH3bPHg6Ie2817DDl1YjOs0Sieu8GI8WQ1BQTbyklkFItJJ1vLddqqNC7g8Y1RxmJMtq70VsnH2M/dNAP3B1yYSKbFSXTX+wQtSl+0vrgalMOi16j4WYmAbe2k+0uQ+JUjiHu8hIojcXQgDu/t4ndTzuS7EFZ8LdsGzmyVMQCBCnZXeFByoW8t6aW3Z+e9BDjUUW4RjZUn2VUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb0aeT7eRqyBxLS5tTfdb+a/9Aby2fkDVyGNry0Yccs=;
 b=QoAlhETQ0Tmr1bLcpHAHlkuxM1H8DA4bk3I326B57izQRZktqFIFiu8Aehe1gGdWNNShl1+rwGXigtyQfcDHJDSeEdkbR90kAiMnfSl5rob1Plxyzx5xaiZKGWqpPyAv2N0xLCO+oP3r96P2ISQdhrOkBBfia5A1HFme+s6ifToMGoqLatG7v1QazyNWX1FHYSsTlQU8+iLOi3Y/q8QiCZ3tLVHVuqN9DtK7KtTooRPsKsojvVYm+AJwesi32Ef4iiOC2/Yqi7KqMeiZ5oaNKT8r1Ao7xpWUoPN9BqTkQllpifPYbV7Y/26BqvIwyKE3AQpeY/6xHC1ZmPVLuMNW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb0aeT7eRqyBxLS5tTfdb+a/9Aby2fkDVyGNry0Yccs=;
 b=mdZi+xaGJuqlrxszMPmP3M/VZtLwl2VDfmc1NaNof8JNLT69g2gaxRl3QKI20NnVEPIWB8m4oZhEv8U7fn5sqI7cKpZIZYEc+6rOphs1X1wqYCtIbik0QOy0LlER5cJGGZb5AlM5TQ/3Enno2orP+4lKMcD5snuYKpEDBvQ93tc=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYBPR01MB5357.jpnprd01.prod.outlook.com (2603:1096:404:801f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 07:26:48 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:26:48 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "aris@ruivo.org" <aris@ruivo.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v7 07/14] mm,hwpoison: unify THP handling for hard and
 soft offline
Thread-Topic: [PATCH v7 07/14] mm,hwpoison: unify THP handling for hard and
 soft offline
Thread-Index: AQHWkOhLmC0WeoJf90Kq3kCU/3n09al10/mA
Date:   Wed, 23 Sep 2020 07:26:48 +0000
Message-ID: <20200923072647.GA15126@hori.linux.bs1.fc.nec.co.jp>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922135650.1634-8-osalvador@suse.de>
In-Reply-To: <20200922135650.1634-8-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e244d19-e215-420e-4f67-08d85f920841
x-ms-traffictypediagnostic: TYBPR01MB5357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB535760A999CFA913D3C5CD43E7380@TYBPR01MB5357.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzwON2KOxmqQATHovorSfCDuJvtmgRrQlcPP+7+N51GdMVtsJbXmmLpA+HIRQ4PFMcAD15FBnYn58n0KjEhBXqyTQItOle+Q9s3DDVovQiTxHk9PsMmRDPfNM3gUv4Gng+53Av74MxesWJH8Ie7/jD8xjUMdBQ7AZoVjRvuCqq4XahAhpGNRyBlGVNEiFoo/y7c5IZk+SCosDEufMMmUMhaNkio4JGxprSijPj3oqweiKHKNYKrgsRQ2XVLQ7myj4cNoRviNfTnX5ZMF4ANZWhmbSeZLkibV1vsAO9hiOTE6rv4cWjmkHXMjOpIDknHzH5+o1JZ6guaAcRaIt8dm43rICYcOjEvzOpf0zgl3X1BWosojBQwovYtp7JhmdfI1dkNcTjoCTqvY7hjA4V8kyn930Iwz2c8qwxSj4B9JrBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(66556008)(316002)(6486002)(1076003)(54906003)(55236004)(478600001)(26005)(33656002)(66446008)(6506007)(86362001)(2906002)(76116006)(4326008)(66946007)(64756008)(71200400001)(6916009)(8936002)(6512007)(85182001)(8676002)(5660300002)(558084003)(9686003)(66476007)(186003)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZbY+VM5XCe6W6bym8ZSuGKDpi8jInIleO+k8yhstycLwa/2BF0n8+VuEIg08sIPF4FSeSmTESaSUa20B+ubPXr4N3zzfDWe/agat78ukx0qHoPpqseZ9gYc9dlEzg7W+qQVFa6Zqs25SLZNWguzx6xXLFSIdIcC7QCAeB+tD41LLnSZ78cIsmeYI9/PpsVRw84T1p12ELCQwTuhRNJgijqS+d/oOBMW4UkUPS1agOXfX+bmxqcj4QHK0EdN9GAlEm3hHc3M3qP37PIgJZFRMBYd9yk9FCoPUK/SPSOt/pfY8JC67XOIcaRKctWVEfp00Q4eOLl/Q5E9lPcFyKth8TaLJ0rmOav0dP0vitPXYmwX/5wmCvjTEWbenbf3dS9hP67N2fR+hzEVvJAcixZZRdTaO9cu8S/bPof6D1oFii7oe91b8o43Ik8CCrNQbqfzkSyO1UK4l0PZQwqNM4gqTR2JG7WSQXEnCVVoLvLbzXm5cXrZg+ILQqRHfD33ILv1NtJnKZx2Ky4F5lUjImvNoQ3P9oW/mw2G90yYZOEW4qsvviL5vVEHHNjlNOULhDph+Tu9bF5a25j2CAEvQANSQISmEA0r5BwCv9ZBO2s4VWtfOp6uEbitCIeD4cw9HWea7m7KLZ3lbKqUE5prF+ALyCg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <21E9689F2FE3884CA5E6F6FEDC40B121@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e244d19-e215-420e-4f67-08d85f920841
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:26:48.0367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPCeBVCtPquRjFAzCXa3jRK4sbR2yYy90jnLy29hNfIK7MlVo6s2PWNzQc2osofXCLK4a614g9AiXqsWAcfkvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5357
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:43PM +0200, Oscar Salvador wrote:
> Place the THP's page handling in a helper and use it from both hard and
> soft-offline machinery, so we get rid of some duplicated code.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=

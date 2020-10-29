Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2729ED06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgJ2Nfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:35:38 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:33676 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgJ2Nfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:35:37 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TDW97M018927;
        Thu, 29 Oct 2020 09:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=QDh8Qm89exH9mh8deZsTCrC4lpPwSIr/9wW7eGoqbQM=;
 b=GhYdYFLXFJXh5zSkyxbtaOLdL2Mv6d5vu79p5tIymsm2h8nz38K8VjOfYzmMIlt2v2RB
 iypJ1URsuj3Vi6HjlgiruS6IvNOjJyte9A3yODp9E0bRNtlrufAZYVuSSSIs101gfszd
 UjA+HOgyjnY39k2qTuJyLvU1MOpGAaGXb112odFFn0v1eZ0mXB6Am/oJ42y9gyyvbCuI
 bHIvhYy2z8/O7rJWPNx45+UuTxuGH091vwGgjVKd0PAJ/WM1BL5WA8hd9A+iwjJ5V4T/
 cOWr21zZciVQZDlf7iwjyehsZfq1mo9N2Iboo7aiomWDOiZI8bBibBJjDLlyEEhq+BQw CQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 34cfb2tj5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 09:35:21 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TDTqpL131704;
        Thu, 29 Oct 2020 09:35:21 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0a-00154901.pphosted.com with ESMTP id 34fuadbc05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 09:35:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPnYP9LZ82mhr0o0jot+bO3xbtGG6tsBqR8UWtJFKYDCbZfmiPftQziuc5cG7eiN5qmEyh31GTzYO9A9wyENXiJLnPQH0J7Ei0VkFpgDg1yCMGA0QGh2hO5PCKm9955oOwib2IthJhuklf6WOfwcMcX6N85VwQtsmuDdf8czRAbOTKZubYk4x0ERSZgHYlwvYcdJu4DEZ14nHvMPHs8oSGgrA86diR7FKIv4rAlO0+wm8bCr3nHN6u6qVkhKO3bDS4tFdtcR8j4/gx/EW0ZfKIWg2dMwKZo3X2SuiuIyBmx1QlY8/20gMDRF2+rBNqn9RfoFV7YbVFLp4nxsYf7yTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDh8Qm89exH9mh8deZsTCrC4lpPwSIr/9wW7eGoqbQM=;
 b=LtfCTCZZZ4l7hu6NQ+t9+jJC8RYqYUDu5hBZTorDd2uejDJc4flWeNiOSQYXyqQdIHnZ0K7JKNS28G4dsXYNHw68H64XpJ0r+SQ901NEGint4QMXZkkzNUqZ75J+Qwnkx/RqwUWhanXeUA0TtNvrbx22fQ6Iht3AcwwsJsLRnb4Zw7EL9nZq1EbPDhwbqgM610veu9V1dQ/NZDBfxm+Xro+scxf7tANrbdqJDd61tiskFZR2RTHm28YahWDd/3T9ipqXzn7/YafGB+1ZKI9yOq+TCpZ+K9W/xnO9+FkEc5XW0eGbRGfcx3Q/tynO01WBqISdRYimyEtW0p4R5CJDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDh8Qm89exH9mh8deZsTCrC4lpPwSIr/9wW7eGoqbQM=;
 b=nrqyXZ8KuDIBMl8qi7iK/KXoydMWi5UpcJWy1YwYGbWqF4F77jNz2Ezx9oiDMxaajjK0auRs+VxXQyi1rP5fd7Qtab5mmM/M86g85vCyTtFTF81R4grZsCsJ4ugluOVoio8AFb+ZUbDK9DQy9xSOS9VfwUSLFcNuGNJ+hZ6bx+k=
Received: from CY4PR19MB1254.namprd19.prod.outlook.com (2603:10b6:903:109::19)
 by CY4PR19MB1080.namprd19.prod.outlook.com (2603:10b6:903:a5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Thu, 29 Oct
 2020 13:35:19 +0000
Received: from CY4PR19MB1254.namprd19.prod.outlook.com
 ([fe80::c14:9bc6:d9e5:4e45]) by CY4PR19MB1254.namprd19.prod.outlook.com
 ([fe80::c14:9bc6:d9e5:4e45%5]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 13:35:19 +0000
From:   "Bharathi, Divya" <Divya.Bharathi@Dell.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: rectify DELL WMI SYSMAN DRIVERS section
Thread-Topic: [PATCH] MAINTAINERS: rectify DELL WMI SYSMAN DRIVERS section
Thread-Index: AQHWrejsNlpIp2ND6U+aEJwEujM7sqmulEfg
Date:   Thu, 29 Oct 2020 13:35:19 +0000
Message-ID: <CY4PR19MB125445B8D71FFEF6E234D40285140@CY4PR19MB1254.namprd19.prod.outlook.com>
References: <20201029114425.22520-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20201029114425.22520-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [223.186.128.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1434a05-b76c-4254-699a-08d87c0f7ac8
x-ms-traffictypediagnostic: CY4PR19MB1080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR19MB1080201A794756778B0D36EC85140@CY4PR19MB1080.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y17C/u3qes+TcUmyzU+5MOxhORLlUAGeGQnW0h4YXtGctasPerQwbC/1vju/qTdr7jPfqw7vYCs89dxCrj1vLX8tHr3Et5UxNwuqs+2FaeCYkjLNAus5OWoB6V7pAWQoInaXlb2GIMNbDZwRTkRRORv21RzJhDQl/eiHrLBic3pp4bxlV3AwTLqRMoFZ4745Ka/gWLr0qCbnwj04HFdVQi6K1e/aUT4duD8rGZEBEm+myF7EqXTjYC0k/1/CBSUG8oZk4vmo+xO7TDn90LG+aae4Xchq44n50h3zjdAqSA/aa/f+X/K+Hel/JI0f6kOe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR19MB1254.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(86362001)(2906002)(8676002)(186003)(26005)(4326008)(7696005)(6506007)(83380400001)(33656002)(54906003)(110136005)(52536014)(55016002)(786003)(5660300002)(316002)(76116006)(66946007)(64756008)(66556008)(9686003)(8936002)(478600001)(66446008)(4744005)(66476007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cArUtInWFS3Rq0lKT7dgXcBKVj36uRpqs58fMozHRZIUY3ZWr6vX9bG8wMaFMHN5N8AaDbNqQVZePfwn3Ghao7edeiGKljaqoOt+Q4A36qnRzHwBtLH0FPtvM8iH2u7aAVmJTY+cOSE32ZsevMnFSKflfvydCo68aAMVSjdB93HDfPmdiFq57OSJUJ8eAJh3as8JjrJTUCVXUlhAEt33UY6E2VgU8cDDAI2hW3o3TDBn6oNDLkeqH2x0spFs15h4I+LFhPLsNewbLEEjQJhL7Qu+KkbvQjJ7ckL2L4ZGZn9CwM+jZfSg2b8sxea6qs2flMQFBPzUqWn0c/F3udKpQmUpXm8qJ+Bg2aUSSsJqp3T49//kjJuEZ9iimik2hiv2YJBjp0Xq+xjHRvikGvnVQZ4hjtz25iLIep/YSNqlmboy1rhbsz/nDrBEr3lDrmqRSxf1IR+jr1/SUu4pthOHxgGI6U7iW3XPVHgwlFlUUg/N9aEutdcP2nAJbS584HCscASQIemjawIi+g04uPCVzVgK9sb4IXM3wDCstWaevP5wgZdkY3Qdm9ZBSw9hiHF+IfWZC5xa/Ua3VsDkFOMcs7DKYQ/Nfyqmb0vx8YivjuqwMhuTJaL4XKNeiD3CwAwTblvb73E62gf7oRvS1vv3Lg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR19MB1254.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1434a05-b76c-4254-699a-08d87c0f7ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 13:35:19.7764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsOkCWF/HN8RIfaTcwgUxO0deSoUjyLMlyibKGRQTwCfkV0/n/++PRQQ7tc2MyS5DOtHz5CQMlJ65x2sH8Ba9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR19MB1080
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_06:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1011 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=497 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290098
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=613
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Commit e8a60aa7404b ("platform/x86: Introduce support for Systems
> Management Driver over WMI for Dell Systems") added a new section DELL
> WMI SYSMAN DRIVERS in MAINTAINERS, but slipped in a typo.
>=20
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains:
>=20
>   warning: no file matches    F:    drivers/platform/x86/dell-wmi-syman/*
>=20
> Point the file entry to the right location and add an entry for its
> Documentation while at it.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Divya Bharathi <divya.bharathi@dell.com>

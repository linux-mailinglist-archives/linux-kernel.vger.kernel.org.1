Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF09299102
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783889AbgJZP37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:29:59 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:1286 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1782957AbgJZP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:29:57 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QFKvIG022455;
        Mon, 26 Oct 2020 11:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=AV9fS3sSoWT+V0VmQkybykJykyXorBDVj9NVF293NHI=;
 b=n1iGmsjVVPqOCTo6sSQ/eOBBJV6vYv6TSdu3MFxoz0VrhfqFrG4Fx5+TCMkB6kh9iEdT
 AKHlLCajI185KmKglB2/BU41oTzs32FksM/NdMnDZb4kNN8BxULYUnLRx73fAYg89NFj
 wJnNpxY9JtHketQEq9x5TEZGj+SaU2gmFkA5VVs6YhDGeaPeKiMsYakKRixiqVc1mziD
 jfXUUn+yMYuSC338wXPkinttXI9kQRUIVRH+KbUhsyo7U/SQhNAyU2Qt0Rk/SjKS1Sh8
 RyG+CrJXGtRkNEnPHogjzqCgSXm8/PNKLBu6gX0X9TpHKBzWTKPyvMW6KiDF1kKOtvRB PQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 34ceu5q1xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 11:29:48 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QFTef6163370;
        Mon, 26 Oct 2020 11:29:47 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00154901.pphosted.com with ESMTP id 34e10c83gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 11:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDpYI2nXaMXCWv0DwI+QJOY/oESgETzMbmT2HEe9vO0dg+qcezORVxe9/fTc3rDpT0ztuWAwHaxYw2nqDJNjmTLbtM9BZ9z8RmfH/Aw+p6MWwtfUOB3NSJTogBwAOr/xZ3+vIsGu6L3GFZ/6uD6yYcznZL1OdRrevMZCbLJExfCVEGrPE7EZB8gImkym155XDcGUCTzwKQBVeryyyf484ywJ31xwTMEuHzgpCXxVqD+gbdnU1y9AmQ3jiFIlWdpa0+zw1wHQq0sPmSFFrDXSTgenqJrJrhaC/Ikr0ZpER/j06VY4eefzJb8e0U6f/sIz+0D/BdTlJQszLdY2O/8Leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV9fS3sSoWT+V0VmQkybykJykyXorBDVj9NVF293NHI=;
 b=RTsIvU/9oQjKNFCyb2dWikReM1AE8SLTtkjL+GWc3RBTBWjNYp/ikzA01T5Br7G3r9momp0dvxPt6JTZXtE1Np1hNoR70zp5ln9kTyduJ58JvYYCJjgCOl+pcQQ6wsrkXQzlGvxk8HZbDffvXhw8X0wTx8TV/Uz3U5OA5X2T5F39AJyJPU5rjhNtMEoi8KPSiTkP1Zs5RR5cyXNkXvcuFP9QSNSBjV9DG21d44zzEYen4/URiJVUpUybdO4+eXcGEtYQSKofhD12O2l2UYmhqQchcwXwRf5Xd2Yk0H4m2IBq2AxVx1DYRAzzyMsHUnyGxzV2ZnyuYMorTCdv91GBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV9fS3sSoWT+V0VmQkybykJykyXorBDVj9NVF293NHI=;
 b=Irff9QBrd8y4ZiRmPikYjVrybvZjGTA6WkDf8RBlDXalWaafJfLOlJriCElDOuyZyXm/n3xB4BnOJodQeA58W+Nl7SR5ZEqtc1kylxCUJA94Rt609fEEQlzTgEUqBWacO+tCAu0TBTEZmXglu4QYbeVOQVOyQX5plR89crGwslo=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB3963.namprd19.prod.outlook.com (2603:10b6:5:24a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 26 Oct
 2020 15:25:15 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 15:25:15 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: RE: [PATCH v6] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Topic: [PATCH v6] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Thread-Index: AQHWm7qb+Fl+xPp0qE6t08FS2LR06KmqE3oAgAAMApA=
Date:   Mon, 26 Oct 2020 15:25:15 +0000
Message-ID: <DM6PR19MB2636A7CAF82D8CB7DEEF7B2DFA190@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201006082618.209287-1-divya.bharathi@dell.com>
 <101db8e3-70f0-4e85-b4b9-008995939b1a@redhat.com>
In-Reply-To: <101db8e3-70f0-4e85-b4b9-008995939b1a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-10-26T15:20:50.5578503Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=6c09e18f-da97-4be7-bc4a-9dea062cae73;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c9b0fd9-794c-4b67-dd2d-08d879c356f0
x-ms-traffictypediagnostic: DM6PR19MB3963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB3963010B2B4116D9A5E8726BFA190@DM6PR19MB3963.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FW4Jwx3dLql264yHkqrTi3GiUn4tf2ROmMS7y0w+CYqBh62OkkMZIm4UyRe+w4z6hroX5Jge6xpX4NEMhXQ3VF1VPilX0WhBUcvNMgIxPD3OhQ1MYSHRzV5QsT6wuTF8+vqNfr4Ecry+J4onq1nYZS+ne36X61RPWBKLlN8/a+A8ghiiPH0GEdLem7RgoMsGuA88/u1G/6vJ0KL9BYlf42OKWh6ByrYVZQ7ww+6NJ37Vr6WIF+1UnglzsGUPNDRsVjaIQwvZ7FwkaStKzvr1P8uBoWgNaE8A7wnvU9nzrCgXkbB4qub/Ae7KNDS5UmwJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2906002)(66476007)(64756008)(66946007)(66556008)(9686003)(33656002)(8676002)(66446008)(76116006)(6506007)(4326008)(52536014)(7696005)(54906003)(5660300002)(86362001)(55016002)(26005)(110136005)(186003)(498600001)(558084003)(107886003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MH0W+hpwTrDgoeRWso58Whl7uJ9+YBiNtH3TGbQzqJbSPqr8EIyjRQgLN5A/TIDJ09HAJK/aftAck073C+2LCl5o5FytemY7j+Wt1BItcDjesgRa1yRw3hSHgGXT5p58EqRu9pnHTObo55otltNMoejLisyi7sbmdC0UCr2afBNeAf/N6DWK5fUWwh/zk0P+YsqY7vOQxUZ6vCWVByRPeom58fRtORXIxPE3SnS2E70kHTPzpPlMXsPKK7Bpo3AiKeuXxSFEMhGM7jZLvWd5cShU/Y2FYNx9d588hJKXC1Vw2naQcIIZiWhP1r2ew4qrFyn7kvxznqYjjVU8mj5eyA4nAGskvmYUuC54hqNJt9MW6zYV7WPU19P04tpIX6UQmYFw1xcSBlHtgY/ESv3WveaPYBptyAQEuRhgu2CC5JXanzxj0zvc5C3Y0wdqSLFU9qg8033+JNbca5zMPolMNuunIhjmbSUc4C3mbz7tDfhYAUWN4zau4q4bKrHZ/hczMu7TSQczf1iZ4vXGraybzUwKF9gK78x84gYtyW8PkvTR8ahgLGvmWrz4xXFKjn+/H9EQusTcJOCwldffK9MiJJ1bPysk56lkNEB4TeQqhKVfRLdcXUotFQ1B+k081sV1w/tuCGbiEvq3Jue321qVBw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9b0fd9-794c-4b67-dd2d-08d879c356f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 15:25:15.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hry/3PM5TIk17qP3iqeWZ9xgWmIV7gDrfIjERCWtMV5YGH/Q/ga8AiIgLv0xPphIKRi6ynhskUpzUhgEJEy5M+/naeoLZBf5HuATiqhetww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3963
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_08:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=595
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260108
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=711 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsNCj4gPiArCXByaW50X2hleF9kdW1wX2J5dGVzKCJzZXQgYXR0cmlidXRlIGRhdGE6ICIs
IERVTVBfUFJFRklYX05PTkUsIGJ1ZmZlciwNCj4gYnVmZmVyX3NpemUpOw0KPiANCj4gVGhpcyBz
ZWVtcyB0byBiZSBhIGRlYnVnZ2luZyBsZWZ0LW92ZXI/DQoNClllcyBpdCB3YXMgZm9yIGRlYnVn
Z2luZywgYnV0IGl0cyBjb25maWd1cmFibGUgdG8gdHVybiBvbiBieSBkeW5hbWljDQpkZWJ1ZyBh
cyBJIGNhbiB0ZWxsLiAgSXMgdGhhdCBub3QgY29ycmVjdD8NCg0KDQo=

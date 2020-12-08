Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7EF2D2352
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 06:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLHFtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 00:49:19 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:57506 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbgLHFtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 00:49:18 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B85l5T7025716;
        Mon, 7 Dec 2020 21:47:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=QoJlQr7FcgkQC2blRNDWUebLV473mnjT5jmTVihlqps=;
 b=rJDfBPtiw63NElSpDFXYtM+ww0BE2fDoXwHXS1bz7LGnelvy5CrAIAiJ7Pv/uXFXcNMc
 VCCqCghP+rmHZBbxZVxXGmbcky3F1Dw9Ebii7bKfIm1hFj9lEH7sWBq8ecFKiM0NBlIO
 68qpmW8b7ExwZhcX911siploiVL6AgvwyfG2+em/pKtErTwC0zaMznQgaOKO5MwlyqU0
 S2QrDLB4dX6LB+IOVxVzCtnxVBIqo2ukOL7vF7/JgMwqw0CGsrSQDa2w4I1eHkswdcE6
 9w0KP0U+sXo+9FmgqZ/leQ5Eq/D543xKFkKmjGGQCmxT4v9sJ2ZBgjv9jOkM954e/pzh Sw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3587n2q7mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 21:47:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0tpUU7AENovQvTuQ1QkLdqx2XBizUchkSJaiUYwZOFIBISnd7mHAfIfu/myd6yVDggLggmom3MpIZCnLcZVKEeXpH92RVRkcdSu2XaJiTlvifSyLPwm32iMTkM+1yIniwYjwSm/n/8gnoB1Jr2wb1VIgPqAgvHpSPnc/SdwkVDAmRBq+LNlOMr4QeM5PGlvFnc1m/jxBuXdMEtFAMURRO/QsNfQEcxDZKhOF9mD+f2u2CZy++UB7fNeCP++plbwGaFYn2LhsHfPiMzCsngg1vf/DJ3ZQyiyOqGY9+aS5VUAJMR4wzuoqPbXxSwss9ReT/fG1OEhYNW51IM0ffWFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoJlQr7FcgkQC2blRNDWUebLV473mnjT5jmTVihlqps=;
 b=eWVexf+SIbY4UuhryvBUCwE3ZmvRxelECs3Lk7MDrwuGnmwwqxjJQuqIYyIy4XBbmPsPL48HvusFXFJEm9/cTN7zp7i3mtPr+vUDKgrJHjwjgYhwYTaTr2npdUPE+6jUmrwcMsBcouyw3fF5+/Y11SOCGz4/ru46qmqObOoj/iPdtQ7A9QscoyqDF8Yj4GV5n50B0BR1rb17IfXzPZwYq2vsxCy8ANLPdqKOe7QJuAI5pN7yS85phPAnQGKNsKzFMm9LWaQEnSXu/XXxNjwP6yynYPrhcPGB29ePMBPcemcrPGoAzqc4gvn4u/FRluhJ0/MiTUiOrNhXBMwX78S0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoJlQr7FcgkQC2blRNDWUebLV473mnjT5jmTVihlqps=;
 b=tIpWOxRmiBURRKaPnOht685b7S8mbvf5ZOg/rX506j2x0FxJwOsqXXI+BvPKpOhcJQnzi850SOSfUltBB3im5TQRlc2sUszAYlumrok1NCPNm5Axc6luWrl2/ybe5lsTKqqCNJdXbJAgqnc55S7nsUNlsnErk51WEFTuSTej1Bc=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM5PR0701MB3640.namprd07.prod.outlook.com (2603:10b6:4:80::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Tue, 8 Dec 2020 05:47:51 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::cc3:be90:e83f:516]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::cc3:be90:e83f:516%3]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 05:47:51 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Nicolas Pitre <nico@fluxnic.net>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 2/7] i3c: master: use i3c_master_register only for
 main master
Thread-Topic: [PATCH v10 2/7] i3c: master: use i3c_master_register only for
 main master
Thread-Index: AQHWxuCK9YC2+rNE30iVVcs2nY9FcKnmXNiAgAZffLA=
Date:   Tue, 8 Dec 2020 05:47:51 +0000
Message-ID: <DM5PR07MB319618AFCB415501CD33741FC1CD0@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
 <1606717066-3785-1-git-send-email-pthombar@cadence.com>
 <2s3n7419-1nr9-8885-882o-7qrsos6qq6q@syhkavp.arg>
In-Reply-To: <2s3n7419-1nr9-8885-882o-7qrsos6qq6q@syhkavp.arg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lNTllYzdjNi0zOTE4LTExZWItODYxYS0wMDUwNTZjMDAwMDhcYW1lLXRlc3RcZTU5ZWM3YzgtMzkxOC0xMWViLTg2MWEtMDA1MDU2YzAwMDA4Ym9keS50eHQiIHN6PSI2ODkiIHQ9IjEzMjUxODgwMDY2OTQ3NDQ0MiIgaD0iTG1wczZjYnF6OGc4aWQ5ckZXMnlicHBpTmlJPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: fluxnic.net; dkim=none (message not signed)
 header.d=none;fluxnic.net; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [64.207.220.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a19a8643-e87b-4a06-5150-08d89b3ccd25
x-ms-traffictypediagnostic: DM5PR0701MB3640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR0701MB36408428B0C37177401C661EC1CD0@DM5PR0701MB3640.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: piyTrRsIyXtg6+543YM8EUx/hwtTgJenXVh4plJCD6PKS3WCVKIobmHA5C5TXzPbXLrgMmGGdqMMJ4F4pAfbXh6GwTKuDom15/tzHoHz+6tCio5k4k7qAwJ4NWszVeAlzlTF33EgVwsOS5oMiDfmRE6qjZFP0NWezLYhMtGxjOllVyPKNjB/b708ps7/iITyy4uCHv/1+IAa2lI4BUFmNuxcNbUNAjfEjjMmiik06CFH4YuYjPTnb59EI5rs7kwiCKXlRFJe9nL5tg7aKSlccbzWFtcd0yP8/v2CIcnc0DTN+ONdT5nLHyTIzinoGpiyYFlKRV0T1RGhwadP7Dy8hx7/viumHYlS/Wq+7/K/Rvy6zKr6Sh6TQuR3nU0ECBZl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(36092001)(66476007)(4326008)(5660300002)(6506007)(7696005)(52536014)(66446008)(64756008)(186003)(66556008)(71200400001)(66946007)(26005)(6916009)(2906002)(8676002)(478600001)(54906003)(8936002)(55016002)(76116006)(9686003)(83380400001)(33656002)(316002)(4744005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sCyJ15AIV8AjBnd05Th6erPejZWjvoBNbsTnoK2CpdcOb5gOC9ZQjG9Fg2Q6?=
 =?us-ascii?Q?3flcMxsXn4ZUmrhSJCcLV5YNUd/PQrdLyt7aSIsTSvr9Xg4WBcKl8jyOzUId?=
 =?us-ascii?Q?zLGGTLZbpI7mntJ/WnRbtdRaC0H4AwKXBx+j7sKDkF1L3E0wz8ts4igB3ds7?=
 =?us-ascii?Q?pneCWni0+I/DcNLbtkn/XoFPC7AWqCsRlc90cWXOSN7LbiLClA9YdzfNW69F?=
 =?us-ascii?Q?z2rUqKIHkqoyyKeJV82rl5QabD8nbWlHRLZQG3beoqVfZvyTbiHC741Ysy6g?=
 =?us-ascii?Q?EZbbTeOhZRTNFxt6PBsOIpQoHEXsA3ZdY6bP50ngHur4a4e62DZ+y726n5yu?=
 =?us-ascii?Q?Od7YhmSXPF5k0VwsdOf8+VPng3Vjtx7GgE13up8VcB1GCab0Csew1dz4a/Hw?=
 =?us-ascii?Q?5/4o2fZkNYdqg0ViMXd7j4kJqPxd36HJFkQoO42zJjFVIcGdij8HzZLrquR2?=
 =?us-ascii?Q?/xLoqleil6YKSg8hnQVoJLEPXVkoRZSw5J9LF1Xqt+yfUIbt+KVhScz3sgr1?=
 =?us-ascii?Q?YxiFlBN0RTgrw/0E5FgD615iVFmnnutkeV94VxR5e/dksVCUbZkjAm9RHzM6?=
 =?us-ascii?Q?lYGtcAVJOueIP3BEgcdQkTfhZERvrhnqTJCdgMeiEITxcf4O9lNsn55koZ+G?=
 =?us-ascii?Q?gRO/42yXZmvdSSbXGK6nIbtpM2+vltWV6t0GewrTavYQIol1GMK1SFhk1s6e?=
 =?us-ascii?Q?3lZeSf8LpxaZg6TQ5rp/8sLxplzJ7qq2plnrsHmh1rTQvnlS2h2iyjc+NMmy?=
 =?us-ascii?Q?i0V1A6Q+H7ljWJzdxtMiu3ncWIRtQjpnhPxmejT4KxDxrxU9O29gjKkiEQGu?=
 =?us-ascii?Q?QtX91KwMOwb5b6PVlAsQUySlZ6SehQLH1De4JhE1WYeVlWIemjXkfHKHmL30?=
 =?us-ascii?Q?gmmW5AzYUu+6xqq++4DArB2l+3Dpl2Yjn2OHvcxpsHnlvRg4d+wi3Xb2cz6l?=
 =?us-ascii?Q?AhZQ8KA7U+FPCwMU/OjW3agk1V1rUPbD5/PkTU6vUEI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3196.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19a8643-e87b-4a06-5150-08d89b3ccd25
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 05:47:51.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZ7WrGSq8tHznXPnvERqc6UnmOUjJx9u3BMMQ5ASYeM2daGdSD26t3hfL45u3131VpI5vj+Glos/zCEPFKEXi4cq47qmwAXLCri9HYdmnio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3640
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_19:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1011 phishscore=0 mlxlogscore=799 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012080035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This looks a bit confusing. Here you're rolling back detailss in
>i3c_primary_master_register() that were factored out in
>i3c_master_init(). If i3c_master_init() is successful, then you
>shouldn't be undoing its things openly in i3c_primary_master_register().
>Instead, there should be another function that does the reverse of
>i3c_master_init() here.

Every function do its cleanup in case of failures.
And if any failure occur after successful i3c_master_init(), we have
function i3c_master_bus_cleanup() which does the major cleanup.

Regards,
Parshuram Thombare

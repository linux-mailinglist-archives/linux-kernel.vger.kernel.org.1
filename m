Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCDC27E287
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgI3HYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:24:19 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50410 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbgI3HYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:24:18 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U7MOEn004047;
        Wed, 30 Sep 2020 00:24:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=8xQl5u6C0Q5b49OlFyKocbjEji/21SyYn0veIZFCJ+w=;
 b=HM6f4u5h5hfaLZDbK0h+qy++fLchaMamJFmReP+Mnh2UM2CJ6/ZC2fBJB95MO7UDK3LO
 bwgSNIh+Cg2IP3yMM9mYyqUed/7e6U45QLsrEZs9wR4RjiP1AKc8QaGRK1psAT3NMINY
 qQYTBX3RYlFGi/jHf2ee8OyiZaYviQEzSKdrgNuJ559FkglCKyU+w/Fh5VUuJnOgrVFs
 YL1FuealVO83mkuBdtq3kE7k8vu5xHZD/yVtokhZuSarbgmJBGCYYxuXVJwqdjAkzXsO
 c4lR0VC+O+69KSJNZssLgqy2fJJB7662ev11y5QVTAZ9av6NjtdhgQbdI3NEHNOXVCv9 Mw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33t26xn83c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 00:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki777CRMWZSawZLqB0QFG2pNDccnJtkT1g0tqlAG9TgOnbabGT1jfpILTMQZhsp7c/MG0TF5AVx57IFCaN9FU/sMTOzilqD75qBp3sVQ7BPk8m5ZVSnw/rceuQrYFG+YfTlOvS2vWBOoCx+yAC6eNIeBIA3eKizpcSxmQ4o/ZcAaHYjfjvN+sEyk0TjeKsKpm9yB7uEpQWmkQGg8UK81vPJkgq65nFqkH4n/ftGeKSj1tbH3jtKlRl/4K/0Ufpu+9SGLACy61KenVGtEmdXDnKmSJvcKxsYJlN/Q9n95IGKrfnDryTdW4xJoHUIZJz0zkQ+LGfwLMOOIQSayfEMgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xQl5u6C0Q5b49OlFyKocbjEji/21SyYn0veIZFCJ+w=;
 b=FvZR7kqPcuPT/ApwnI2Y1X2+motETceCPR3E3mz6/PVdYzfSTF+MsblBK2m96R2Bc+t89hd57SO0GkT6EVd6RaguzNqmWk7FxkN5KNMFUPAHH5uw6H7BWcmI4E869+O7BrlUDePZosvnXy8O17JLTMlHleTvZkhwWJM0m69uEd7Y/q+RnQaHbdLR3OIQ599yOd5zAPWlYv/f5fRfhwiS2A66gza2vUoJV8rGgZR9dKpcVZnMZIjh17LQPftV+2sEoGNF7/1Hu16W+2gp8+qaLmQrAkHlDZZ4gwoReOTNAkPJViLgP5O+eeYSlas5xlqFcTxJr3WirvZdOnlZSEuvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xQl5u6C0Q5b49OlFyKocbjEji/21SyYn0veIZFCJ+w=;
 b=66kOmm11xPzzSy1wQJWcN8lPezXHsQN1g2a//s/o9m8irIPAciRQHiNdL4yVHisO0hpi9wxr/pldbxXuQQqfLpucgV4SauIOYsPWxzJSw+ktzclEPs6Gp2Q3IYcXoCu/JO6poC/oDK3Et/Ilsyh5jVAOsbYZosJwVJjQZFJHpwU=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB6092.namprd07.prod.outlook.com (2603:10b6:5:18b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.25; Wed, 30 Sep 2020 07:24:06 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 07:24:06 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     "balbi@kernel.org" <balbi@kernel.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: RE: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
Thread-Topic: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead
 platform_get_irq_byname
Thread-Index: AQHWlvch/Roy1G/8IkO8ykqpdGeiF6mAxVwA
Date:   Wed, 30 Sep 2020 07:24:05 +0000
Message-ID: <DM6PR07MB55296FF277CC3A79EE820428DD330@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200930065758.23740-1-pawell@cadence.com>
In-Reply-To: <20200930065758.23740-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZTljY2IzNmYtMDJlZC0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGU5Y2NiMzcxLTAyZWQtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTUxNyIgdD0iMTMyNDU5MjQyNDI4MTQyODY4IiBoPSI0SzRVbSswNWVNUFdqdDR3dm11RjRzaFl1Unc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c19a24e-607b-4f9b-caf6-08d86511d0bd
x-ms-traffictypediagnostic: DM6PR07MB6092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB6092E329A24B84D6CEE7D39FDD330@DM6PR07MB6092.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:369;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SH/nuxUQNV5utmiEnoEQ3NGO8cHyPXIzdje5+4ZdQOyXMGnYtYYIlTR/XoTZRBlGDllnjsf/MPMhptahSeRXumzB9RUeYVmk/PE7Un8bmcx7Sia6/EI1Dz6porV6EZCQrLRUM0BCp4hQDxpyro/F8pIf6/tfKFVBWwuEhKFz50YV7RPP/X6VeF/FNyHLQHWMeWl2UVX8F89FmbE8mHYXHATba783JV1E+9rxQFTGPeUSZEWvxS1chQbnStFaJpCmdu4/hBRlGNrXuHdazzuf+EBzIC4DnoOjhpr3sRqMO9Dyc4X/YsOQ1cFXDrPyAFShwvcLh7ECd6Ci2FAkXba0NiECiBEsy7ElE/DUAXdZmI2k37X5S4yJY/mMVdgokJGflBmvstr81SQoF1uXwCNNdMvvJgt69lvlYNfSM4+wQcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(36092001)(4326008)(5660300002)(66446008)(107886003)(66556008)(66476007)(6506007)(6916009)(26005)(64756008)(8676002)(71200400001)(55016002)(52536014)(2906002)(54906003)(66946007)(7696005)(316002)(76116006)(186003)(478600001)(8936002)(9686003)(83380400001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WsqxgrbFoiJl/Yu3chTXgUWfeBRBWHy9h4D7eomRov9B/ujVz3TPu/1LQEHkWbFNNd7daqT+Qw3HFYjx1vQw+XHBgl4Is5Dt7j8AiFHE8LfLRGB3u9JEQLDDI2ewXBz5AdfV8xG5069PLkpq78APMCtebrWM7IPspwEt8+nJ2wGLrO+ByFR2kJIIM6zIolu07W3ICTJ0HydD3Nq/9lD8VxzxCGdOpjqXlOAfu5X8qsViS0V0nQYLJc5ihyAnRGHTlEHawbwkq8ETM5Wu6aB0GynFg9ycr2o0fDf8s5zoF+NMwTwFE5E5IQkaI2oMWVBdojOWKBLloW7gfR0myIBUH0QQxG+KfxVjDyQui2ggjf+A7LYR6dO5Z2shRiJPrjfwCYdQZzs4L2YKmGt4J2n31MrvKp5+62c0c2vZZxxnaS/bnPpe3M4m8nJu6InzW+yy+yA5BbvOmSygUZ1j7YsFb4ZMsKRXGDXeKoTKn53oheuPmrwG7GFdZOc/j/agzthGTAlOB/8MWeUXC1FJ2cGtuaEVuPbDKOAse0DB2kEbel5w54pij/ChDZ1SIxnj3qO08Aj3jI6WtL0pLurXliZjq+EPd4M1LqzxC38UFYEG6UBCOd7t2FmC9aHDk5F2T8K6mUQV58TcxZyfPgSXy4iTjw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c19a24e-607b-4f9b-caf6-08d86511d0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:24:06.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fz9xeRoH9BLqULVroyCVtvv1dS/iuWhrv70pyerABwM4IoPTt8fTGZEZ03zg9fN0rl9s1JtLOTXsgtUEnUKXc2MKTHCZvU9IahdfFA/g5mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6092
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_05:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=249
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My email server complains that delivery to peter.chan@nxp.org has failed.=20

This address has generated by  get_maintainer.pl. =20
I only updated email to correct:  peter.chan@nxp.com.

Regards,
Pawel

>To avoid duplicate error information patch replaces platform_get_irq_bynam=
e
>into platform_get_irq_byname_optional.
>
>A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
>
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>---
> drivers/usb/cdns3/core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>index a0f73d4711ae..a3f6dc44cf3a 100644
>--- a/drivers/usb/cdns3/core.c
>+++ b/drivers/usb/cdns3/core.c
>@@ -465,7 +465,7 @@ static int cdns3_probe(struct platform_device *pdev)
>
> 	cdns->xhci_res[1] =3D *res;
>
>-	cdns->dev_irq =3D platform_get_irq_byname(pdev, "peripheral");
>+	cdns->dev_irq =3D platform_get_irq_byname_optional(pdev, "peripheral");
> 	if (cdns->dev_irq =3D=3D -EPROBE_DEFER)
> 		return cdns->dev_irq;
>
>@@ -477,7 +477,7 @@ static int cdns3_probe(struct platform_device *pdev)
> 		return PTR_ERR(regs);
> 	cdns->dev_regs	=3D regs;
>
>-	cdns->otg_irq =3D platform_get_irq_byname(pdev, "otg");
>+	cdns->otg_irq =3D platform_get_irq_byname_optional(pdev, "otg");
> 	if (cdns->otg_irq =3D=3D -EPROBE_DEFER)
> 		return cdns->otg_irq;
>
>--
>2.17.1


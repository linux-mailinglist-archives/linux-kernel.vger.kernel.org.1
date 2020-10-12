Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55228B496
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbgJLM05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:26:57 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48016 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388334AbgJLM04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:26:56 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CCBtv4026468;
        Mon, 12 Oct 2020 05:26:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=2Mu/iHNLAbsA/w2oCV+S51oFxTj398hke/ltT6DdRKk=;
 b=tfhLYFpzHcS4BgIAXTVn5zOKJZRT8Ajxz9fMMqKuOE6jCuCS4WGnG2D+P1i9am1kYqou
 5Jkmq0y94QP6s+IIHDJQ1slOCU1Fe2Emv0NFNAjVtMytjTf7Rk7OqaCUwPRZHzrC4Wj0
 2k6twaI5QlGGpQPv838hQ4vYTOCr7idMzbI5VztmhYXahP/k9eJXnnUDWjQFGLOMAXM9
 eLJ9hhIHTCSYpvQDjcpgv+rMoBfcm817hxz5Y01QPSqY1lXas9akcJ/ic1BnvrYUNlia
 1GZX0lfQQR0q31BF4Ll31xBlAaagVxCjLEP+rV275O9tk+PYZ3Gj+jgaNPuEcqAYlQzZ qg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3439gvx4j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 05:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGCBKCwy7huGyydxk4wmjdxeJDLk265DfKALte8n88MWrlvlprbyzAyw/UzozISnEYTGBwaLRTFO5Pej3wrvC1zF82rOKK39dY02jG15uAqf1YujSin9aSwufjfmw467O2eYuMX0IZT5d4db75PSPvp0CDhvfyMWn9S5kEiG5c55lV9vqogvgV3aPc0efC/FDR4XEodABrQutIR7771gntHJxkd1A3LBQsZUMSU0qkwLOl9usiGCqM3BnkoDCDeqaNUkvmnnQb2w86mNxDJ7F7MzEtTtaLU9D9iLqtWEuyTj1aoFR+H47j5ziq4XdX/u215zi1TfHj6ZlSxTYy3KgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Mu/iHNLAbsA/w2oCV+S51oFxTj398hke/ltT6DdRKk=;
 b=fAWelOtjX3sQ7JiXLMBqvq410dLO7Nyr3RnbKGBoTMyO+dHZVpyz5D3K0R5/u32GBzUSiaypv+iYGBY/6CbN4cMob5vzlkfpljDpcdSaxyNS0hCbaEYfhO/IEvcS9sqZUyTd+0jjYRhJBRI9he/q6eKyTQDdMxEdcrAY83G9UMqo1C0Y2vCQBd8aWkRxFLPcXZ5T/UAX7wlpFFliG3G686FtxWJhweWIdIQ7yhA8AWD8I3VIyJXi8AiQ0NU725tD1nGz4uO1v5pXHHx/2TefkDDFslowU5hlpDT3Z5XjWlTkXsIPupfY3MZm3C24a4Ph3boTZosb/O/WftHBHjhlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Mu/iHNLAbsA/w2oCV+S51oFxTj398hke/ltT6DdRKk=;
 b=Tn9DJavHNjg1L2WFuTCXIe+lUfrV+WVKYfzwNoYmzjz4fpO809gTIWEKwYhuxsW8Y01y2kJ47i6bTrz7onEMnv3X3Ky8KiVx5c0A0nxPKSj2DppAclVP6mf6dVG3zd2bWugp6cTBrFZNyYgmIHdU0MB+fdesXGVpwH6cTn1TLZc=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB5964.namprd07.prod.outlook.com (2603:10b6:5:184::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.25; Mon, 12 Oct 2020 12:26:46 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 12:26:46 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2] usb: cdns3: Rids of duplicate error message
Thread-Topic: [PATCH v2] usb: cdns3: Rids of duplicate error message
Thread-Index: AQHWoGM1FxWyT46v30e8Ja/DW+/1b6mTnxYAgAAk0ICAABOtAIAAC2CAgAABFhA=
Date:   Mon, 12 Oct 2020 12:26:46 +0000
Message-ID: <DM6PR07MB552936CAFDDD55189FCCA37DDD070@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201012064256.8344-1-pawell@cadence.com>
 <e5ab2110-6bb0-ce06-be4f-010a030e307f@ti.com>
 <DM6PR07MB5529E8B3EC059F7DA43EEC25DD070@DM6PR07MB5529.namprd07.prod.outlook.com>
 <ab93c402-f721-d780-654b-7b74bc5b2ab1@ti.com>
 <20201012121831.GA17965@b29397-desktop>
In-Reply-To: <20201012121831.GA17965@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmZkYWUxM2YtMGM4Ni0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDJmZGFlMTQxLTBjODYtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjgwNyIgdD0iMTMyNDY5NzkyMDQzMjI0OTAyIiBoPSJFQnVlRlZrMjAvZXdCdHFibURVMk1kL293K2c9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f41d6b5-bb2c-4168-c900-08d86eaa15ee
x-ms-traffictypediagnostic: DM6PR07MB5964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB596485C3688F33BC487CFA89DD070@DM6PR07MB5964.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z1FOaYxRn4EmgtxVGRvi7B+4GWbaUDbReVWT5wy4zeYuRjbbmvzUJZIGZvL/7G6eMVXuwwQCYkUsvpe3tu+kYXERqEukomngVGcHbkQaDd+ZzupDlX4WJHnDD8sugGkejhKHyHMP3r14dobMyCDXwmPn9l7oSXkrZrKevmwOY0a+uNrCQ740ubpd1sNoVpD+oM10JIw1GVDPHuuahX2dcvjjc5EEdWRJ1js4Ywfa8JEmGw0jne5zyEz5cRY/wLLrrYsLaBCxM7+MazcTPUQFL30oRKHB/FebqZzqR7WLoIQLLJbR0uB7G/z93BdspCK4L8DSngwFhf/c6R2YSLIHfo2QjkTyEJm9935NFWW11V11gGuTI4ePXBORhbgqS3Ln
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(36092001)(33656002)(107886003)(86362001)(9686003)(110136005)(2906002)(54906003)(66946007)(316002)(55016002)(83380400001)(15650500001)(4326008)(6506007)(53546011)(8676002)(186003)(71200400001)(5660300002)(26005)(8936002)(66556008)(52536014)(7696005)(66446008)(76116006)(478600001)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: s5vYIyIj312l0AHzMe+XsHwHGmjaRFwlkAmhJAQDj6GtZZm24bOvJTKnUnOtBQNc07e40FjQQyfwR2FIhlt0vLigHMnl5jJt0zWAsBuqZMv5oWdB2crSPyu+KAPTPncylpq7Lr+f1sDsTaJO9leimzgVlCt3fMROxTaa2TNwBuyXnok+9rV6A4VSw3p+2hBFZhg4SvAncb7y8UH6jtczWj45sCs3HsJBF6nx52bMSctLu4B2JOU3n3OslsbqRejO/A8hlIiYhOAwYAyeQ5+csrI5XKg/QpDYL1KTEkZbR4xpVYRwxulCqWhjoMj1xl3EazNX4JdGx0o7q6MiqDZo7E4m2Z7VAjwRMEn3tuV0EQhXQVdoqcT7gNEJKH19mXvMMmIdMdcJGxpRZEE0kPRlhNs4vsE6Qlky+JEsNvVoM2jtZ93+9gAsZMo7N/m+MdrA38KCI2UAcvYiZLep3ZzqgK2BdRshS4RrEHhKx2lpjAcSunE4da0m9CAPHH4gpmXDi2acCIGLHQE2+dxqT4C5FzvcCQyTuU7NU7wmlE5Lvj2oNSl2YzC8NLvkgrvd6ZIpQimT5sSgr2IJQCN7BylaquF/XB9/vWmpuNcyrIpSoDUqAFLG2ND3RxxHX7cd5cRbRGgnoystFzHMxC50NlHhyA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f41d6b5-bb2c-4168-c900-08d86eaa15ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 12:26:46.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxkemUmgIjGaUyhXvuaAzoTTVhBnOU0B3iXPkc3MLaWhhe4w7UfGMxTmq1hhoO0sbDsNs+vKoSwRPQvdNAVbbdPEV1ripz/KByRx5D8NbiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5964
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_09:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>On 20-10-12 14:38:16, Roger Quadros wrote:
>> Pawel,
>>
>> On 12/10/2020 14:12, Pawel Laszczak wrote:
>> > Hi Roger,
>> >
>> > On 12/10/2020 09:42, Pawel Laszczak wrote:
>> > > On failure, the platform_get_irq_byname prints an error message
>> > > so, patch removes error message related to this function from
>> > > core.c file.
>> > >
>> > > A change was suggested during reviewing CDNSP driver by Chunfeng Yun=
.
>> > >
>> > > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> > > ---
>> > > Changelog:
>> > > v2
>> > > - simplified code as sugested by Roger Quadros.
>> > >
>> > >    drivers/usb/cdns3/core.c | 10 +---------
>> > >    1 file changed, 1 insertion(+), 9 deletions(-)
>> > >
>> > > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> > > index a0f73d4711ae..85ef3025b293 100644
>> > > --- a/drivers/usb/cdns3/core.c
>> > > +++ b/drivers/usb/cdns3/core.c
>> > > @@ -469,22 +469,14 @@ static int cdns3_probe(struct platform_device =
*pdev)
>> > >    	if (cdns->dev_irq =3D=3D -EPROBE_DEFER)
>> >
>> > Shouldn't this be
>> > 	if (cdns->dev_irq < 0)
>> > ?
>> >
>> > No, such line will change the original behavior of driver.
>> >
>> > Current patch allows to run driver when we support only host.
>> > In such case the dev_irq can be < 0 and we still can use host  side.
>>
>> In that case should we check if we need dev_irq and if so then error out=
.
>> i.e. if mode is "peripheral" or "otg"
>>
>> Also DT binding document says all 3 IRQs are mandatory. Do we need to up=
date that?
>>
>
>I agree with Roger, or you change the driver behaviour that return error
>if the dev_irq is < 0.

Ok, I will  change the  condition as suggested by Roger.=20

Pawel
>
>Peter
>>
>> >
>> > Regards,
>> > Pawel Laszczak
>> >
>> > >    		return cdns->dev_irq;
>> > > -	if (cdns->dev_irq < 0)
>> > > -		dev_err(dev, "couldn't get peripheral irq\n");
>> > > -
>> > >    	regs =3D devm_platform_ioremap_resource_byname(pdev, "dev");
>> > >    	if (IS_ERR(regs))
>> > >    		return PTR_ERR(regs);
>> > >    	cdns->dev_regs	=3D regs;
>> > >    	cdns->otg_irq =3D platform_get_irq_byname(pdev, "otg");
>> > > -	if (cdns->otg_irq =3D=3D -EPROBE_DEFER)
>> > > -		return cdns->otg_irq;
>> > > -
>> > > -	if (cdns->otg_irq < 0) {
>> > > -		dev_err(dev, "couldn't get otg irq\n");
>> > > +	if (cdns->otg_irq < 0)
>> > >    		return cdns->otg_irq;
>> > > -	}
>> > >    	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg"=
);
>> > >    	if (!res) {
>> > >
>> >
>>
>> --
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
>--
>
>Thanks,
>Peter Chen

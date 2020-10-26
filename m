Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5432298A28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769223AbgJZKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:14:37 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:61402 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1768390AbgJZJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:47:48 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09Q9i1Ns019155;
        Mon, 26 Oct 2020 02:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=OKtHjvOGgAx+uNLbxdZq2/y5SE1pejZmoepEflYQVnE=;
 b=IB4Ke4Cdvx5+7vhdk4CCMLfcxBVwiCgH//CvkbBGNS7FW6U3hneO1MfatCM7g3NPTvh+
 JxEJ/6w8XWRvDUksvNDVM53klyJg9O1FPFVyUSdh4UBaDsoFPQZnYgU8hCurbfXxfejz
 SHJbluhZV6EOCMMkwd9yGUckutWsKYkiNP7DvPvvzO6AgzgkVAKhoR4C1949uwF1gQO4
 7NoVlQwaFJVjdZVwJOEpeeknY6qSfgmYsMRAdeB4+5UOmtQL28T+0GOx6NxkQGSf5tku
 TF0wG2kZAzFW1ynA+UAF/m4BlVscBB4aSGDXH1ctsM9ZtXej1kl2ByfRfIjLsZb1MfMz Dw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34cfuwxtmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 02:47:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgXmEcrUexroA/nAdr5C2UxpcqDCeizrz3gzMav2Qkkw2cR1K3Y2f+CRFtmYxzczbhKrIivAIxNbUnA0A944mDYtogWVUP311D/RFjkoGmovPUsrgYbHt91JmD+G72R6j/c0WyQPsyzUF3u7ZWIsvLH4CiBgchpXg+Ovw70mNKjZ/Fuo8Va3toRRPimVM3tS6GzyR7MLjCE9CYH6yJKwgmL/+PNsaNkc+qrxckJlIUzZu9DXXDUo8Rlw8GdIBuVOs/rU2Ut8+70AdcTmg6CkgVhZztuieAtrYH0L1PsCj/js1bjLLESU1B9nJNm+vNj599SL6cYSJ6GqpOC8Abvwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKtHjvOGgAx+uNLbxdZq2/y5SE1pejZmoepEflYQVnE=;
 b=UxTYbF7iYQfrsf/c9jozZ7753pb4tlXv21CQtRPRU7ULOEHr6cOS/QB2hhbbaTqUjUId+Il6w3wNywEcfBzWDyp/SmZKOg7KrW9IoLpc0cRAvVio+4chzohwdRuWtioiU9LSiEJKfe5NeYtbok3DNjh+RlpUjStGhaesRcpDE+yHYwvZQ4psrDQdFaQlH891Mg++nYfDuKm5MOyZ74fA5qAhOl2fepG8V0NX/S530ifTcxrrLGvGzhlODVh3UZVWHNfBfc2x/EFPWdLcLNN3w97/vmpOlWUSFc0wSaNJNxFVpm0PFR42xGl4yyFTQENMjjlMhGVsqAGEgYa7s/pD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKtHjvOGgAx+uNLbxdZq2/y5SE1pejZmoepEflYQVnE=;
 b=iXDmJIEcENkQk2gP0jRtW/SLaqeIW9vkYlfw0lRnTh8yA0k3UhjsKDSGoyNKATwUztZLWJgYo3uccnYx+pBnS4w8CqIe24ZjVmuFcxhkF6bXPK6lB6WviDlERWn/POdWpeUlSG9LWoLrETzzkyiS3IdY4ViKs0efX6adjDO+JpE=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB5676.namprd07.prod.outlook.com (2603:10b6:5:78::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.26; Mon, 26 Oct 2020 09:47:36 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3477.027; Mon, 26 Oct 2020
 09:47:36 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3] usb: cdns3: Variable 'length' set but not used
Thread-Topic: [PATCH v3] usb: cdns3: Variable 'length' set but not used
Thread-Index: AQHWoq93MTVmC9gJQEy5qA/nl7dl3ampshBw
Date:   Mon, 26 Oct 2020 09:47:36 +0000
Message-ID: <DM6PR07MB55290EA090C418457C1E293BDD190@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201015045529.2022-1-pawell@cadence.com>
In-Reply-To: <20201015045529.2022-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDRhMDRmNDEtMTc3MC0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDQ0YTA0ZjQyLTE3NzAtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTU1MSIgdD0iMTMyNDgxNzkyNTMwNTE0NDgwIiBoPSJwenlic1RRRkUvYkluUXU4R3J2am4ySHhaSUE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92a48583-1ebc-43dd-4913-08d879942b63
x-ms-traffictypediagnostic: DM6PR07MB5676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB5676BCE6E64B356840BE1113DD190@DM6PR07MB5676.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jEzPiGAxk9rv1fvIQ4l8dcHQn+27BVmbT2xRS+qAU8fkVCtWB+WDkAITrQCCkhCToZnmzHKIsm8t85fPwPILtAQoc4Ij6Io62CX2hCJ03nErUzqV22P8eA5jL5vP4yQtwtGRtics71Mkis1KcKjeZpjoHAiIx7nz/Hu1j/KtonVWl/4V6dwMnlnUPrIqoBORX4MjFUUsUBl5Mtry+M6SeoeAjZdgyOI8Q6DCHo4kFeIbkUnGOsvViGUiuPSov79H1NVdfGNP4HUm3hRJ8f1UIm85y+CLW1T8rucMduBRm5rOQ1WvnX5rkxP4tJ1yH/nx4DKwavnNOyOg2kRiDz47nm5l92Ji8e/rCvZvCdWlvjpAZwJOrue7cLHO1IpaZAhf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(36092001)(186003)(26005)(8936002)(6916009)(316002)(107886003)(8676002)(83380400001)(71200400001)(6506007)(2906002)(7696005)(5660300002)(33656002)(9686003)(52536014)(54906003)(55016002)(4326008)(478600001)(76116006)(66446008)(64756008)(66556008)(86362001)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: x6eMWNP+/mzXSunWuVfDmkgDLuHSN5/iIawnw3pt/v1adxVlgOghmzVFctzU1LoSVIbsTVgVj823B9wW/mC/mzQqHvwCd4ai+wJRd9M/i6o1rhHiGnDMog6jKlbBujoVhYBeUyF/XTK899njOjPKRqYNi2CA0L2n++cmI6j0dyAOs0S5QqAuL439I2wcA0XkuTErbRaj1roFeEk39ugm0P4mp6lPWJVb+eNpcUmJS7sZZPRo5meawdnZeF2y7zD/l1JRZjA8bKp0wOP/pNhUuKHaSW+g1/7dYIqnMqkTx3gpaTWLALSgsRkBEZXdzVXecxQhWaWdRJheFou1/l4fboYJMbpUkGkOAKGBYZH7QoeYaNPBwUf66WQHd+pirJSBPVqnFT6IavoWn95W49MZ7upnTgSsjP5rty2wocz0uMlm7Lio0BZwyT04s7uevAiCGh47FpmU6VTZF8lLDYI1SLb4kQArWF9O5yW3XAgxF/vBqHx89flXNEkfM5UtVghD5Jc36sHoWRfgdXTEo+dG/Zkdc3QtlZxtlvG/vvS+QLRdk1crhYq6+DXHOs1Xz01vd//lD0QV7y6gYxVeXuQkyuFul//dpB/qTKfwyGc1xEeqNJ+wva9wfBtme7dgjM4ptPLqOvjvzRbhLTEIZPlxhg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a48583-1ebc-43dd-4913-08d879942b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 09:47:36.0804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pDHq1h3l+tsipo8BotGvoZZ+8TVZM8Augulf2Bj8YdoyBCrm6cXAUDvAIoEQ4c1TPzGRdkTB8AfBB4Y23cxS9CJoVhbmjtcGfMv/gv1W00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5676
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_06:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=808
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

A gentle ping.

I assume that you should add this and the rest overdue cdsn3 patches as fir=
st to you ci-for-usb-next branch.
Am I right?

Pawel

>Patch removes not used variable 'length' from
>cdns3_wa2_descmiss_copy_data function.
>
>Fixes: 141e70fef4ee ("usb: cdns3: gadget: need to handle sg case for worka=
round 2 case")
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>Acked-by: Roger Quadros <rogerq@ti.com>
>---
>Changelog:
>v3
>- added "Acked-by" tag.
>v2
>- added "Fixes" tag.
>
> drivers/usb/cdns3/gadget.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>index 6e7b70a2e352..692acf7b9b14 100644
>--- a/drivers/usb/cdns3/gadget.c
>+++ b/drivers/usb/cdns3/gadget.c
>@@ -506,7 +506,6 @@ static void cdns3_wa2_descmiss_copy_data(struct cdns3_=
endpoint *priv_ep,
>
> 	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
> 		int chunk_end;
>-		int length;
>
> 		descmiss_priv_req =3D
> 			cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
>@@ -517,7 +516,6 @@ static void cdns3_wa2_descmiss_copy_data(struct cdns3_=
endpoint *priv_ep,
> 			break;
>
> 		chunk_end =3D descmiss_priv_req->flags & REQUEST_INTERNAL_CH;
>-		length =3D request->actual + descmiss_req->actual;
> 		request->status =3D descmiss_req->status;
> 		__cdns3_descmiss_copy_data(request, descmiss_req);
> 		list_del_init(&descmiss_priv_req->list);
>--
>2.17.1


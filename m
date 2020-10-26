Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780BB298A21
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769241AbgJZKOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:14:39 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41022 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1768389AbgJZJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:47:48 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09Q9i1Nt019155;
        Mon, 26 Oct 2020 02:47:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=cC7I71pZM2+kLcCodsj8f0ar/o/bG6RMN+p7/DqPKLE=;
 b=EfDeJkE61GvvTi3cdsuIQJlXuSo6HL6dLqLpSab+l1Tont+WNtI5Q1L+XPY5jHwdHePw
 kPqPFW5cer9MKAl1zMN2SokCEit6Mh711csTXNk4TwVmSChKFa9A4CMFGiKFNMIr+h5X
 oa67r/TgWLXcuFnwlM+FqbCiFf7ci+o23ITnjtHmvBmd/6Jdu+cVa4paWXdVLKqPr3Vz
 4XqfgHMJI6TBPPEDYF/qP2c7kr9DUyP355WaaiUXU38GGfbfCKm3LKnfhX9NxanT+tpg
 PArJyjeKZZhcT2+/mGqTLrpvlVuRfYY8V4WN8BcoO4hL/xJ/6Zg2z/2dW23CC8NBlXBF HA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34cfuwxtmp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 02:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hukVRcJbtBeKwxoBiyeJIw6Lj7ZzELghB6ceAI7Lt2hWwvdOuzDR4P3OH0GGthZ7kUVkpJjdwHufdHbipgbEObkiyNUsM1JZe60E3CbD5e7aGWYybDAOopZSmuakZVtK4uwNNX+iTfv5Ot8OW9g48Iqf7i80NWB8YnLZdLaZKMWyCpu6nQXFV4hc51+DtHF3IKbA3uE9RDI2UAKhrV0P/gOC02iMLrsajDRJduiKZ/a+O3/UeSiR65X7jN0z7YzoxfyYe9XeAoT1sQYRjfM8WtyozvB1JcT/LFJCA5RpLKa8NVNZ92gRl4ejLHJCBSs40W6vpQQ2prCeHZF6C7dpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC7I71pZM2+kLcCodsj8f0ar/o/bG6RMN+p7/DqPKLE=;
 b=VDUjCuJ8ycxE5u+IO0PezPzIq6tdCuFpLJBppf9v8+dRWI4ppunlo0daqGVDmVI3itpwUgzjzLd9nyGjhZPjW1pChLLaA5YDY+3AQFckyWZ7SG/X7rVLAwrlymn9ygyBlP4NLTA6AOGedQaHpnfMdqzrCnVSIteUAyBPvsE6f9iqlpeuHZT2moQTLxH6qaGaPmnxtP5J7zz4y2tGo10COU/q4Y1wjD6rTczhlC0feY1sujwvqUXhV95SNd9BsQ+eP+BNmQ87ZPJmlyzlHiFEYe5IDilsolIrtQQboNiUxCYSh3NRRY8ngtHlzMTvngwJ1a7/70IAuwLOWinV+ukViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC7I71pZM2+kLcCodsj8f0ar/o/bG6RMN+p7/DqPKLE=;
 b=gEZvTrRA5/UMy4JewtwrYU441cfycgfgdJEWP8iLd1BraAYsqrIAcWtfgGK3sHcYbT/62Mp0rw2beIQN0lDUe9Hy/KAt4NTrOYKQywPSLOr0jzYm1pyN5GuaoHjJMsiTxGRCgbZeCB2JkpDBwwEKCpKj1jx+Os5xkjU0dPk1rY0=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB5676.namprd07.prod.outlook.com (2603:10b6:5:78::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.26; Mon, 26 Oct 2020 09:47:38 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3477.027; Mon, 26 Oct 2020
 09:47:38 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2] usb: cdns3: Add static to cdns3_gadget_exit function
Thread-Topic: [PATCH v2] usb: cdns3: Add static to cdns3_gadget_exit function
Thread-Index: AQHWoq+cH3FItHxynkuQfngNfkmmA6mpsR/g
Date:   Mon, 26 Oct 2020 09:47:38 +0000
Message-ID: <DM6PR07MB5529FAECD9AEF3A82B20B677DD190@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201015045606.2084-1-pawell@cadence.com>
In-Reply-To: <20201015045606.2084-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDRhMDRmNDYtMTc3MC0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDQ0YTA0ZjQ3LTE3NzAtMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTY3NSIgdD0iMTMyNDgxNzkyNTM1MTk5MDc2IiBoPSJFWG42YWxaNW95WG1QdUZGRWlYY3lKbXZBbUk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d3465d6-5dbf-4c19-73f7-08d879942cad
x-ms-traffictypediagnostic: DM6PR07MB5676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB56766FC5FCECE5007D66E778DD190@DM6PR07MB5676.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cn/M0FaNWvkB57yfJQjhSHkfDeLPquiaGc6s4ODAaqT7ul35RhA80Q61zE2A+xud45C2q08wLc4oj+GrhbwWEXnq3vOIr2DefXcHHz+544FYqF3w7gube8qLPSLt2Mnv61HJCgodtiiM1uWCPToEvsLADvBKokqSXBWwQbcTml/nkQzXr64PL5D/g2nmoWPwCcSn+lKNZVBfZU8ZEizVVN3Kl2yER1pM4WxibtM42NS+D4YD/EG+ATLOA2yP7z50N5gaNlV6SNJWFscfVkOWV8Bu6g1T2Ia+NTpOCjOmoogtCpdhAZgB4wUu3iGzrD/Y3N54um5W3ZxayCndElTnf262UCpVjd9tuLn62bOj8d5aJFuhsg7Y65KCuUPXUDJo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(36092001)(186003)(26005)(8936002)(316002)(107886003)(8676002)(83380400001)(71200400001)(6506007)(2906002)(7696005)(5660300002)(33656002)(110136005)(9686003)(52536014)(54906003)(55016002)(4326008)(478600001)(76116006)(66446008)(64756008)(66556008)(86362001)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sNd5tUklvBNIwfK6ItIVRW3QCDoT5erAOQCAapEB4JcVqwlXK8NUwKIcqQtNlBEmqBO3oy9+NujY+ZegYhQf/rqOsQpDlW91j5t6cbuG9H0igItYzZ0zYZh6+AKri1UCDwdELwTfy9axJM0lVZZZqAlCK3hgBRSoeUET8b990q8w0KjWCSlysXq0phiCB4HgLMaNVGxP14eJzwFCxpvRBs/Kq7Q7OlozpOGgIe00sXjXsVJEi9jULOL5T9w5DU9XDR4WzXOJup0nvEdLGEUOFicRI5WaWrAkFndQQtsPKaj8/IltH/c2pqqG2puRj/26LwUoeRdz67odcpx+gRyDILchuQ5MHaUDxo7cnchguTYdulo1shz30vbpNbwi8if4EtKJ/kOS7VhmPc/8CjZB/BOOKlAa9XZpgIYnyQF6QVqiyesdF7pG6vazqIvsUifi1qc10dxpI3FwaKZ3qRREpAopXhdkXam974QzjFhMvPeIKEwulK/gbgUek9HABg1Hb6GIaWTSguOlBQrPKO5cRAjd6CnFcl+CJ9wiJ5HyywgOg8ZilHkhb/AqzZFc4RLJx6XpJSvsj+vlz0dAGyHzkjk0LUZE29xDDsRXQZmNHgewS63LxM5iPeVSDeuy291CKoxbjcqG3tdmc2nh2OrWMw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3465d6-5dbf-4c19-73f7-08d879942cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 09:47:38.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yk4re0hxSC0tALpXt7TAeV1ycbQA5x0uQym6asc1pA/EI8RrTFIyWx4tI10Uwny2N1Au0bRI0ygrjqnRUxTfXeInRs6K8rOQDhALBNRb3HI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5676
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_06:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=904
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>Function cdns3_gadget_exit is used only in gadget.c file.
>This patch removes declaration and definition of this
>function from gadget-export.h file and makes it static.
>
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>Acked-by: Roger Quadros <rogerq@ti.com>
>---
>Changelog:
>v2
>- added "Ackded-by" tag.
>
> drivers/usb/cdns3/gadget-export.h | 3 ---
> drivers/usb/cdns3/gadget.c        | 2 +-
> 2 files changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-=
export.h
>index 577469eee961..702c5a267a92 100644
>--- a/drivers/usb/cdns3/gadget-export.h
>+++ b/drivers/usb/cdns3/gadget-export.h
>@@ -13,7 +13,6 @@
> #ifdef CONFIG_USB_CDNS3_GADGET
>
> int cdns3_gadget_init(struct cdns3 *cdns);
>-void cdns3_gadget_exit(struct cdns3 *cdns);
> #else
>
> static inline int cdns3_gadget_init(struct cdns3 *cdns)
>@@ -21,8 +20,6 @@ static inline int cdns3_gadget_init(struct cdns3 *cdns)
> 	return -ENXIO;
> }
>
>-static inline void cdns3_gadget_exit(struct cdns3 *cdns) { }
>-
> #endif
>
> #endif /* __LINUX_CDNS3_GADGET_EXPORT */
>diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>index 692acf7b9b14..6ff3aa3db497 100644
>--- a/drivers/usb/cdns3/gadget.c
>+++ b/drivers/usb/cdns3/gadget.c
>@@ -3069,7 +3069,7 @@ static void cdns3_gadget_release(struct device *dev)
> 	kfree(priv_dev);
> }
>
>-void cdns3_gadget_exit(struct cdns3 *cdns)
>+static void cdns3_gadget_exit(struct cdns3 *cdns)
> {
> 	struct cdns3_device *priv_dev;
>
>--
>2.17.1


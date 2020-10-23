Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9EF296B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460891AbgJWIwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:52:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41188 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S460810AbgJWIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:52:04 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09N8iw7n025653;
        Fri, 23 Oct 2020 04:51:50 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-00128a01.pphosted.com with ESMTP id 34aq7pq9b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 04:51:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDQAWsnod5V6/JMrc1R+i87lTUTBB7ZjpsU6m9kkebMqkQVx3WzUVJFh7hj2QSLTApzRpzFsz9zlMiVcEBpp1M5x5phffwFt8Hfi35VuEEw30H6xIEL1VSivn79wTCiAUPQ0HGOCN3JncOt+mVHq2fVBhPKD4ErC7RK1B1VzkL2FbvEIPQ3Zj2BdqvZuUifL0DQmA8X75xN5x74mrfW3mSRdRn7e+OoHvCw3djPQmsh7MrKZfKtuTwaG/C+O2NuJWuX8Fla/lP70Gzs01+rLJlKdwtC1Kfl0PAXuXfjVEb8Vw7doXoHclTfH6nXyALcj0bgQpob99eMAlEViBCHJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oESS6NGqnINhwfsSi0spfEs8A5pB72JGaoOuhaydN+I=;
 b=oNeyZXqKHftv71/jLdDAUbQ3RrEoKnWCFTnKbGyoCPd/0D9iyolghAq2zInAAESf1Ok0S4+3gD88DkLvflDlJzFLWbeCDRPvehgapEM3l0iHpl8mV/O/KFVS5bOatzC0/u3Fgu89cJ73mcs9M09KqBXoEpS/aRC/1DcDhjqZhqvvoQ7y3VDVMTMgWQj7O8jVgCmoNgdOLtX/eHW5xnpO1hxef0LVTEz3ne7uNmm3Z0vQVRVFglsVwnMR9bydeV+nNi1igYif/EBvyqtc4lGAHmkEgge5qKXllS950B8O5ZuJIEK7y1kquaJbyI2bwbd5dfiqvRYbSQWXLNPVSN/OHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oESS6NGqnINhwfsSi0spfEs8A5pB72JGaoOuhaydN+I=;
 b=g8gfet04B6eD1uxy1/Vh3qtmfQ1aearjxaNqMUzpw92fZvSKPDhDNJOlgS6V7IuFj5hVQ2X1xRJ4BvDqSEYq6YiH0rEWlHZLGW9IfYTv+1iIbdsar7YGC76tJ4GhlYm5DlqC+JWEsUWWrxWo6BrTneZA4rarMju+c/m1dbrd9iU=
Received: from DM6PR03MB5274.namprd03.prod.outlook.com (2603:10b6:5:24b::14)
 by DM5PR03MB2601.namprd03.prod.outlook.com (2603:10b6:3:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Fri, 23 Oct
 2020 08:51:48 +0000
Received: from DM6PR03MB5274.namprd03.prod.outlook.com
 ([fe80::a009:4abe:2aee:b0dd]) by DM6PR03MB5274.namprd03.prod.outlook.com
 ([fe80::a009:4abe:2aee:b0dd%4]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 08:51:48 +0000
From:   "Togorean, Bogdan" <Bogdan.Togorean@analog.com>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH 1/2] drm/adi: axi-hdmi-tx: Add support for AXI HDMI TX IP
 core
Thread-Topic: [PATCH 1/2] drm/adi: axi-hdmi-tx: Add support for AXI HDMI TX IP
 core
Thread-Index: AQHWmwh5xmwgGy1BWUuP733ye4eTYKmaYpMAgAqabZA=
Date:   Fri, 23 Oct 2020 08:51:48 +0000
Message-ID: <DM6PR03MB52748E16A02E8AE049379D569B1A0@DM6PR03MB5274.namprd03.prod.outlook.com>
References: <20201005141226.180655-1-bogdan.togorean@analog.com>
 <20201016145500.GA1325536@ravnborg.org>
In-Reply-To: <20201016145500.GA1325536@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYnRvZ29yZWFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1mYTU1YzIwYy0xNTBjLTExZWItODZjNi0xODFk?=
 =?us-ascii?Q?ZWE1NDZlZDJcYW1lLXRlc3RcZmE1NWMyMGUtMTUwYy0xMWViLTg2YzYtMTgx?=
 =?us-ascii?Q?ZGVhNTQ2ZWQyYm9keS50eHQiIHN6PSIyMDU3IiB0PSIxMzI0NzkxNjcwNTg3?=
 =?us-ascii?Q?NDYyMjQiIGg9Ik5iNjBWVTRycDZmVFR5VUNjbk5CM1dzNjZFbz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QndHNjI4R2FuV0FjTk55Y2gzMjBHWHcwM0p5SGZiUVpjREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBWS9HcUp3QUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
authentication-results: ravnborg.org; dkim=none (message not signed)
 header.d=none;ravnborg.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cef92a6-9ee1-4443-adae-08d87730e0b4
x-ms-traffictypediagnostic: DM5PR03MB2601:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR03MB260159E7EC86984E911EBAFE9B1A0@DM5PR03MB2601.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7uJKmzkMLQnUR2so3wKmDPwRoa4kA5530NMu3SoK1se0KG83i9uF1F2hEuJ9pltKwntn88dV+zzD6/kmzgAOGMmDcybRZNPu8dkxJg32jufs78xNn9JEX3eXLIHaYl25dSwja4Nw2yAuWr7pNBZhX/pQsCIcmJrmyay2n2xnWf1DCqyd45JsIKlasO28GlaKhgUoXAFdY7f1D3z9UPgMAEt38JY6FjTsS4ny1NE2MtB7+5oggFT6eVy5z2BJ5NyzJV/0RQEB8GyTJfKwbTCz2059fHNVsS1j4Nn4/tk32novL4T63/RG9e05WpUHEWe8Qylb5gSbRfEeoilmcXZDIj9IHrGkg1HP/Yg9+LqUHf5auyN9mVPte7IpxsiqP4F+TWI1pw5t27eL6g1zcoKqQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5274.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(64756008)(316002)(55016002)(8676002)(52536014)(6916009)(8936002)(71200400001)(478600001)(33656002)(76116006)(966005)(2906002)(9686003)(186003)(86362001)(66946007)(54906003)(4326008)(107886003)(5660300002)(7696005)(6506007)(66446008)(26005)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rcoK06Z83rkr+WGCmabgVxuS0NbLYTifumdvt2txivHa+SYJzVXa+WKypz2g6OtqN3E9mE5zrB9ZWDPp7RJMFP7Zyo0Y9UPB7VEJ8aMJXfLRypd92p8dkVQZDeQiZIfa1qO2gWQZMRWXkipKx7ZfMi0RL0/NoX7CN85fMWP296xqpRWkxFbQ8q+0EkAyxz5LCR99akJg1l0oqAhORcQbQLfChXOYBFYS+QAqY4IVVPSHTkIX15Ll0v9ElteaYaNVleVe3B106PQaiw89xBDcL5xuCdUhBit5B26oCbpUh3CsP8NN+vz6/skBgJ3/oiJNbSeFiWGe1bqs/BoLp5IAJLSZGcCHwf1oPJXC6FYoYPDG6cvju0pxTAkETUf0m68SKecdmvX4jP/6yFqvLYlgXDPQCwl6X8WYOaAHT7ZRs75FwWSoPQCsBql35/EwrsjurJcTiJDMbqRX21Dnl/KYwmfyCQNnzmU/OF2hWc8RQnAKN+lT35jOHVPRcmMCW2L3qb7tCd7hxGn0Wg6Oq4KnB4vxDTfAm/inYMas627aXtmFQW9EegZTKYV637BKtWQ4xEtXyP+h7TTNz1mnlWiINH2xKVuzbwb1qByBXi81kHsLoFOWA0A5mI/VF9cKVG7pd+b7PiwVeU97Skp/7TyqKg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cef92a6-9ee1-4443-adae-08d87730e0b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 08:51:48.4201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttvosz1ZIjlzQ5vGfu7Wp/MB6g2YB8yBjg8bQwspN9TyYraR6ETjbhXa6Uz5B1NP2RMkDFn50z40JN3Vmbf1AeDjgv08eHYTISwdJPH+f78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2601
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_04:2020-10-23,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Sam for your review,
I'll send now V2 implementing all your remarks.

Best regards,
Bogdan

>=20
> Hi Bogdan
>=20
> On Mon, Oct 05, 2020 at 05:12:08PM +0300, Bogdan Togorean wrote:
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > The AXI HDMI HDL driver is the driver for the HDL graphics core which i=
s
> > used on various FPGA designs. It's mostly used to interface with the
> > ADV7511 driver on some Zynq boards (e.g. ZC702 & ZedBoard).
> >
> > Link: https://wiki.analog.com/resources/tools-software/linux-drivers/dr=
m/hdl-
> axi-hdmi
> > Link: https://wiki.analog.com/resources/fpga/docs/axi_hdmi_tx
>=20
> Thanks for submitting the driver - a few high level comments after
> browsing the driver:
>=20
> - Use drmm_mode_config_init() to utilize new cleanup
> - Look at other uses of drm_driver - there is macros that makes this
>   much simpler / smaller
> - Use devm_drm_dev_alloc() to allocate axi_hdmi_tx_private
>   To do so embed drm_device in axi_hdmi_tx_private - which is the way to
>   do it today
> - Do not use ddev->dev_private, it is deprecated
> - Use dev_err_probe() when you risk to see a PROBE_DEFER
> - In all include blocks sort the include alphabetically
> - Use the new interface to drm_bridge_attach() - where display driver
>   creates the connector
> - See if the Kconfig selects can be trimmed - the framebuffer releated
>   selects looks wrong (others get it wrong too)
> - Check if you can use the simple encoder - see
>   drm_simple_encoder_init()
>=20
> If this is a simple one plane, one crtc display driver then it should
> use the drm_simple_* support. Or the changelog should explain why not.
>=20
> We want the drivers as simple as we can - and they shall use as much of
> the helper infrastructure as they can.
>=20
> We continue to develop the helper infrastructure so it is expected that
> there is some lacking behind as is the case here.
>=20
>         Sam
>=20


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE422742A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIVNHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:07:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:61880 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726573AbgIVNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:07:11 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MD5VMl016185;
        Tue, 22 Sep 2020 06:06:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=1xyfUfl3Kygx8SoPoc0odW/GqcGUKS3DJknLSxmhHJQ=;
 b=HF58O6QYXte7TldUY+TmWZzd2ak1yact/nkq9gnfwqraNGeWMfNeDIRi/ruZJov37M3K
 FMdn1zOh3gNLng/CEE1EDymhoNvHYYdpsffVIdGAqD8rzkC0W877+E0fbIwWvvkemBr8
 nuF9Asdo9Ru3dYsXClm9I6ugzQ4jzMF0Q7HkdZIqilDdTaA4LwMrFn3rQ/Y0wFDyyXM+
 bBOd9aUsv/donH1x6miauVYi1cYZAgjpd2oYHT/LmRG/5N+lojalyi+2JwDxddfeD0n1
 BC9dq3UwOvG57Rhwy3LQbzBDd9vJB/UMTdBBjeOLcB8PZfyUBv4W5ACxM7/eUOBOPu+1 lg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33ndjwt0q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 06:06:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBD3FtPFFyL0AozNenXq+REh4xqJR5Cl+B0a0IbQqUIjt+/Q/lgjBZ+Tg7WG4KVE+OVYSM+6w/77KFqWLOigo0xzEKkAxmDCg5pfPH5cAnELGXw8hnvicAU05493zt8HUfhNNBqTZ6cB29rTvUtC1GM2iaxbHzsWslDqnJFqDNnvMvxDehVRnkidR8+hrlaFtF24ZgTYCEHov9lxi7iFJKGrqwiDwU1XctDmbr6hTkeZadA8CWWd/BuMX7Q/iv0imOtzee/LC5YEKfR754tj7N5wqRMe+x7sV4SLt3HbTs+tPg/6caPJGs7G/Tc41y/5/u1AgBiLYdXvLg2vk7dELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xyfUfl3Kygx8SoPoc0odW/GqcGUKS3DJknLSxmhHJQ=;
 b=GRjDMulxHESJrpjv+Rx2ih3VUatFYT9qXHrbspt+mn5z9qKHIpwnDsAXFN11vATfsszba4SRcSoEp5rjO8Fu/FHdtdAtz1+1/Wqh+6WdWrXRBBfn5URdB4kvoF7HLUI0swezfgV6oDKs1cdqWTK1idoYPL8piB4mc4v5oS2klYFmceLqzmz4DgSh5gaFQgDv6R7yTZrMRvCpHUN8dM/AH6IFXM2PZFAFha873q02Cx+Y6XVSZeHj336dHIUOJPCP0qE29KETrxWNqmfvcg5EKn3PHiMQpxHz+9wpvYwYgp52NHVrtxUzUiRnZwkBEtLm8cw159xoy0ylDrf/oixxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xyfUfl3Kygx8SoPoc0odW/GqcGUKS3DJknLSxmhHJQ=;
 b=ZILidAdbGAji0mHz4jZqKwV/mK3SqqopE2gU9oZhCWHq99+UJMrxB78KtVF6e4euaxi8UcozTGb1ad4EgyQhDBlz3Po8uON/O3MZIpwAlmmyOYAGwJf5rlXEIZPICWXRHYD/a28x3T0vgR6u9oYy8lRd7PK5RsdEIKfnim9Ukio=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM5PR07MB4037.namprd07.prod.outlook.com (2603:10b6:4:b2::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15; Tue, 22 Sep 2020 13:06:26 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::2087:7f2b:5dc6:a960%6]) with mapi id 15.20.3391.011; Tue, 22 Sep 2020
 13:06:26 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWS3YSDa4tJNrkMUOR89XcmNbpYKjqdbIAgAABeQCABIBZgIAADfQAgIYgtQA=
Date:   Tue, 22 Sep 2020 13:06:26 +0000
Message-ID: <DM6PR07MB5529B75D3CF135D540749C1DDD3B0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <878sga5nfr.fsf@kernel.org>
 <BL0PR07MB5522A8796EE7BFB5062A8E76DD930@BL0PR07MB5522.namprd07.prod.outlook.com>
 <20200629034213.GB30684@b29397-desktop> <20200629043146.GA323164@kroah.com>
In-Reply-To: <20200629043146.GA323164@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjk0MmRjZjQtZmNkNC0xMWVhLTg3NmEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDY5NDJkY2Y1LWZjZDQtMTFlYS04NzZhLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDU1MyIgdD0iMTMyNDUyNTM1ODI4MTM5MDMxIiBoPSJvU2YyRFBZVkJmdjZJam96WTA0dExpeWRtU1E9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6016882-7a46-44a2-56fa-08d85ef85048
x-ms-traffictypediagnostic: DM5PR07MB4037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB4037BE73B9A210B1D9C50D35DD3B0@DM5PR07MB4037.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +rCw0BfkDCbgHCbRMdAcERPrAT/SAH6tH7DeYzPA/OweulrkvmvJqIuYe4KOGYb3S2l1yOdmDxp+Cf1EVsclaZOq4BOpbIFcLlIGoIFT4by6OysfkOEtbjZdQLuwXewogIa2th7FM3L1VOs//iQH9mlvdz+UNitQZww/GbVjoQe4qXuE/E/FaA0jwaVYLjVbpaCZfuYPxj4axUPkWompbk/CCUAGS7RKTExWi4Wu5tHBTJ35XlW/3zXzG6t9Wm/MOFQIIdoPP0tv2OPd9r0P/RW+NZeK5PUZsXUv1hGpliZL7TPlqedQKr7wOs8TDT9VOy2mMzxEtWcLBB8uJW1LHvAt2sLI/QPvWJDdLKtKild32Qd/bxPZVa7iRVt60MvY9FuAvjSWYBBqGZbfd12r90xVN0RXIulhDZ5O2pHPUSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(36092001)(5660300002)(71200400001)(86362001)(478600001)(107886003)(26005)(33656002)(6506007)(186003)(316002)(7696005)(8676002)(53546011)(54906003)(8936002)(55016002)(9686003)(4326008)(7416002)(2906002)(83380400001)(52536014)(76116006)(110136005)(66476007)(66556008)(64756008)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GEK/tUmxRnSBRDyNejgUjP7g6FJRdV1ImRJp8O6NOEQk3XCsblDzgFlnEBfHIuEyioAUo0bmAhHCvHhalJbTgu+HVweZyNfncL3Y6bt+s4jmcA3c8HFui5+JdL1aIkmRYxY8w/lXUqnPJCGcTBAZDyEM11Wb+pHTn468JVPOmd6ZlYtPkWhONJcNrALSLiLIproBkBC0Xysb5swH43y+ClGxsQRvG0QfwFFaytUyLRND8o/e7dN1NWkdAjqdlg168yo+eYJTrwvznDlw0gam3FKwjIMON8UG/hX+/qOwFxijFnW9F4Gh57faaff2sCXe7baqoSpukfsz5SJIOg0jLe3DGJvoWfV8aYySSKnB8aV9uLUGu3TxrxyV0y39qLtMpUkWTN8qzHqlCieJvn1tSvWHrOXINz7c6fTy1A205zg4inQBW59YCWkBvazxAge52gKlx1+fr+TEcrUsmNHah3b+wsNzIS/tfsalmCHIBOMJ3V9mtxIA06RUv9Vo0RVewzUwnVXVgebAG4BgZaq7dom7pteeC5jemFmddGmHb63uX75RDHxxqYV1iwxhtSjtK7wmyGl8GCVqpGt92Ee7SVoPh31Hz+TEzr8i1lFosUA4bfhHf8YTfpnUIdHGb4IRrSdiZkmKVaopjWYsX5P/LA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6016882-7a46-44a2-56fa-08d85ef85048
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 13:06:26.1985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3c4dZAai6BVg6sbq/+j7gWeEmBM/pTyeWKWxrElv28fyTp7Ei9A8raqXzqZ32oYXtLreGSPtMgMY8HfWGTUwCRtuegPXwIUUOqSamcRzhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4037
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_12:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxlogscore=704 clxscore=1011 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>On Mon, Jun 29, 2020 at 03:41:49AM +0000, Peter Chen wrote:
>> On 20-06-26 07:19:56, Pawel Laszczak wrote:
>> > Hi Felipe,
>> >
>> > >
>> > >Hi,
>> > >
>> > >Pawel Laszczak <pawell@cadence.com> writes:
>> > >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>> > >>
>> > >> The Cadence USBSS DRD Controller is a highly configurable IP Core w=
hich
>> > >> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>> > >> Host Only (XHCI)configurations.
>> > >>
>> > >> The current driver has been validated with FPGA burned. We have sup=
port
>> > >> for PCIe bus, which is used on FPGA prototyping.
>> > >>
>> > >> The host side of USBSS-DRD controller is compliance with XHCI
>> > >> specification, so it works with standard XHCI Linux driver.
>> > >>
>> > >> The host side of USBSS DRD controller is compliant with XHCI.
>> > >> The architecture for device side is almost the same as for host sid=
e,
>> > >> and most of the XHCI specification can be used to understand how
>> > >> this controller operates.
>> > >>
>> > >> This controller and driver support Full Speed, Hight Speed, Supper =
Speed
>> > >> and Supper Speed Plus USB protocol.
>> > >>
>> > >> The prefix cdnsp used in driver has chosen by analogy to cdn3 drive=
r.
>> > >> The last letter of this acronym means PLUS. The formal name of cont=
roller
>> > >> is USBSSP but it's to generic so I've decided to use CDNSP.
>> > >>
>> > >> The patch 1: adds DT binding.
>> > >> The patch 2: adds PCI to platform wrapper used on Cadnece testing
>> > >>              platform. It is FPGA based on platform.
>> > >> The patches 3-5: add the main part of driver and has been intention=
ally
>> > >>              split into 3 part. In my opinion such division should =
not
>> > >>              affect understanding and reviewing the driver, and cau=
se that
>> > >>              main patch (4/5) is little smaller. Patch 3 introduces=
 main
>> > >>              header file for driver, 4 is the main part that implem=
ents all
>> > >>              functionality of driver and 5 introduces tracepoints.
>> > >
>> > >I'm more interested in how is this different from CDNS3. Aren't they =
SW compatible?
>> >
>> > In general, the controller can be split into 2 part- DRD part and the =
rest UDC.
>> >
>> > The second part UDC which consist gadget.c, ring.c and mem.c file is c=
ompletely different.
>> >
>> > The DRD part contains drd.c and core.c.
>> > cdnsp drd.c is similar to cdns3 drd.c but it's little different. CDNSP=
 has similar, but has different register space.
>> > Some register was moved, some was removed and some was added.
>> >
>> > core.c is very similar and eventually could be common for both drivers=
.  I thought about this but
>> > I wanted to avoid interfering with cdns3 driver at this point CDNSP is=
 still under testing and
>> > CDNS3 is used by some products on the market.
>>
>> Pawel, I suggest adding CDNSP at driver/staging first since it is still
>> under testing. When you are thinking the driver (as well as hardware) ar=
e
>> mature, you could try to add gadget part (eg, gadget-v2) and make
>> necessary changes for core.c.
>
>I only take code for drivers/staging/ that for some reason is not
>meeting the normal coding style/rules/whatever.  For stuff that is an
>obvious duplicate of existing code like this, and needs to be
>rearchitected.  It is much more work to try to convert code once it is
>in the tree than to just do it out of the tree on your own and resubmit
>it, as you don't have to follow the in-kernel rules of "one patch does
>one thing" that you would if it was in staging.
>
>So don't think that staging is the right place for this, just spend a
>few weeks to get it right and then resubmit it.
>

I had idea to reuse indirect the core.c and drd.c in cdnsp driver. Of cours=
e, I've made
the necessary changes to make possible reuse this code.
My approach was to add this file in Makefile in cdnsp but this concept fail=
ed.=20
It even worked until I started testing cdns3 and cdnsp as build in kernel :=
)

With this approach I have issue with " multiple definition of .. "

How should it look like such reusable code ?

After my experience with above concept I think that only way is to move com=
mon code
to separate module,  similar as it is in drivers/usb/common directory or li=
bcomposite.ko module.

Am I right that it's the only correct way ?

Regards,
Pawel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9B2DA806
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 07:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLOGPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 01:15:02 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:43072 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbgLOGPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:15:02 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BF6ADhP011626;
        Mon, 14 Dec 2020 22:14:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=h6MPOvQO4APr0UmdRQhlXcxjqUpeeFAXbrby9UIC+6w=;
 b=ixkFJ49lduwbH4/ECrFGJ0zVThn6CLOcmyZckNt2y/bKpUb/pYMYMQSTyRfetw/ddblh
 WhU8R5CcXrYZoC/h2WwKGg1mGOtxmgG2btaWa4MYseQECdTGEUClH9swpWDCuaM8998/
 LBG9jM2rm8Df3ESt/9gd4mDc6M+8N+uOxKMS5JxAAzGtrJC/o54Ln8iGOX2zzrW4BDlI
 ako6z3CLzqPYgqc2fgDLKiI+AqrtTMr8BWf/YV1b0JMfS3uCSF8jtkTDHrSK1Wt8KEwr
 4Orz7fsDdRIcJMcbFP+A5T0sYKPS0LGACsSYoZ16UdlTdCpQijKLmuqfJvATB+77ptOq lQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-0014ca01.pphosted.com with ESMTP id 35ctb2r1h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 22:14:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHxegCe1/1z2opiFON92BEBhxC96k7RX22Lk2tuwWzbaqwCnQ5022czY+RJUXVPmbJ0si2nvQ8MXPLm/cno6HXG5VX4bBgR0DCDUEJLkJ8rcOblVLQfDzq5t6e2C3jQByP2Gc0cPCpiobNGPym4MemxN9Dh5033T6ldDG/M3T599q8NzsG0LMAi7pt9jJ5TERXVSQjy6hOXSffEXOuI/d+JCLniJ/lVBRUWOxgA0m04cR93xgIfaswdGVzJ2W4fyUjEYnujG3w9Fp7Dxi4uO5RxlnoRxSuglK+jPhFNJd/1xJFEs884hwZqkibtA1OQHvx/t/TYQKNUfnwDRwfUUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6MPOvQO4APr0UmdRQhlXcxjqUpeeFAXbrby9UIC+6w=;
 b=Kb1qYgzl3Vw1xrlqnVW0xUsg7GSUdcHU1UwiX+vfHgZeqrUuFDlJeE2Xxm/BgQSmnO2T1hJKMJtgMCNzcQTmDqFGBEzVCt5Tb50c09L1xJxAHeVqwS6D5gLSM5DP3FN6M2G6olM38h+6q3YadZgO9aeZSBuf0n1bgZf0xM2FUfP0Yn850W6QYY2z2kzv1m/rrVdqm9ue9v0bDjqfFOZEBpBe7izgJCmg5YZ9296UEj9SrTiUVvtZ90wFu/+nm1ipHu7TSPNVm1xd1qEVuw023VnKh3k9caBOjordnZxoLkz5LTszk0Q7V2RRv0cqmBg4JxbUXJv/2nJ9hda1dq5cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6MPOvQO4APr0UmdRQhlXcxjqUpeeFAXbrby9UIC+6w=;
 b=PbAODtYAJn1+lXDrLKgOTKKVHKaFQwi9JZ2b15CA0uDiEhDSrrxqFI4gH5dL66Iw8+17Gfp9NJZuk9nUaTntfvx9VWzz7GEphGQ1bPW00pXABvLY1K1X3jPk2Z30xnOHAwyouZD7qJIGQv5PzWbl3we6/JRCbAGvK731WUwDkE4=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BY5PR07MB7234.namprd07.prod.outlook.com (2603:10b6:a03:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Tue, 15 Dec
 2020 06:14:07 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::b09c:4a2d:608f:a0ab]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::b09c:4a2d:608f:a0ab%3]) with mapi id 15.20.3654.024; Tue, 15 Dec 2020
 06:14:07 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH 1/2] usb: cdnsp: Fixes for sparse warnings
Thread-Topic: [PATCH 1/2] usb: cdnsp: Fixes for sparse warnings
Thread-Index: AQHW0hEzfzHRJiXuwk6j4hQGX0Mu/qn3m8+AgAABj0CAAA5DgIAAAnVA
Date:   Tue, 15 Dec 2020 06:14:07 +0000
Message-ID: <BYAPR07MB5381C42748CC8276E9D21F15DDC60@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20201214120344.26344-1-pawell@cadence.com>
 <20201215050528.GB2142@b29397-desktop>
 <BYAPR07MB5381FB3C8AF9039D8C30E8AFDDC60@BYAPR07MB5381.namprd07.prod.outlook.com>
 <20201215060206.GB18223@b29397-desktop>
In-Reply-To: <20201215060206.GB18223@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYmIyNmM5YjItM2U5Yy0xMWViLTg3NzUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XGJiMjZjOWI0LTNlOWMtMTFlYi04Nzc1LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTYzNTIiIHQ9IjEzMjUyNDg2NDQ1MDc5MzM4MSIgaD0iOUdDNGxNZkx1UU1SbnhNNlUrRktYeXVDS0xRPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f573a25d-d2a2-47fd-c982-08d8a0c0a166
x-ms-traffictypediagnostic: BY5PR07MB7234:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR07MB7234B8900EA15A752664C8A5DDC60@BY5PR07MB7234.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pvq6Ngs+DzO+ymzJf3Qy+aRk51PfotCzo1hd1V97bT8rInw4s0rQld9VsZqz4v7seYreCma2uIRDbsr0P5s59cPmT0mg84gOq9YbHgYxVRyeEYPzhHootUB4F0teaKJn9EVSJP4PnGJklJLezjSmc3MCruuEsJGYWWcnBsA64FPhkidOrI0WQk7d0RFIIb+gzYXsBZtyrKDBlqVArNYh/h2ANEFHHdWQT2cKVd2g0JchbOImDEMZmBehEEtnHvLyyeBYzjr20u1SBsA+cYQx9jJemuptgVmqFVO1I8pMTZp0K0v4Pt2GCO+LEH0fLJJonv54ztz8HJZHy7veZkUfluTf9EQMmE+uhntiHox6K45Bf4d38/Q/DVF5WYNwuU5O4xqVOBCuMcV52v+y5ywSFMA1lex7WluRQEZxtebQo/KMoUNX3CNmRInjlfULPY2/sAdWzSiEzHRBMvEs0L7wMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(36092001)(4326008)(7696005)(66476007)(71200400001)(54906003)(66446008)(64756008)(2906002)(33656002)(186003)(8936002)(26005)(508600001)(66556008)(107886003)(76116006)(6916009)(66946007)(6506007)(83380400001)(52536014)(86362001)(30864003)(9686003)(8676002)(5660300002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bF4p0jqkWBmQAORvGFbTCh5TXgZhn19pIp0D3yEmAiwk2lGrUaU+TRH9UJA2?=
 =?us-ascii?Q?N7oIPMD18Gk90vEbs+FkqeeAm9rkafBGY43u+pjFXYT9bICbA5CF3sFzEVt4?=
 =?us-ascii?Q?S/CS3J3/r0KxfD6JeQ62zQUAP4xi4ksJxY1u3xeA1HtYwGF2Wjf3WPM6QfHr?=
 =?us-ascii?Q?OUT2BsXqJUiFDg8yMti7zNMpFwSSz6eisLm7gzwNQr0eqClCzwAGCIqqDOKv?=
 =?us-ascii?Q?MLYUVHL6rQ4BFsjkHVUF/szfsGdTyxzqngbbUCm5lYLgewJsaW09kOzvG9/d?=
 =?us-ascii?Q?Pd35XVFBkfwszlB1j3qX0JboFx8TY2hj7TV6WeMjk910C0W+6Gmonl3wbfou?=
 =?us-ascii?Q?j2mLpo91uu0qztYXeICkPm8f3Z0kpYcamQ7T2kZEKb1pgJ0WmLtsQlRklQWJ?=
 =?us-ascii?Q?GQVDTvRoMJFYqwETecA8NOCwCOOf3AchOH5EO7MJMWUVpFYDnAAz+EHrI12d?=
 =?us-ascii?Q?ezmT2BYocfovlnn9JqL8+zR5IyZX5iPmh/A3oSjpElHpUp6ZaktlDmoG4AJC?=
 =?us-ascii?Q?9fk0vWRsjsEAOhjlU2Fs32efEh6NLxrOkIQpVfPGI39HG6eu/8UA4n+xVMxc?=
 =?us-ascii?Q?4QoGtZbomQuMiJDHO6DCEPoGZTk9eFuR64Fec4NKofzVD9PDUlUl8ACRGISU?=
 =?us-ascii?Q?XxT75qodCL474Mhy7/s0FJiiZkJfq3ajcPeT2SX3uz3CXO5c/f0y1F3Y2pQo?=
 =?us-ascii?Q?b89c5N+tTgJ5pTLsc8Fwb6gm5IhtpZpIYuaTYrUsIC7JN99yXfITcKKoaVe9?=
 =?us-ascii?Q?q5oya9Fg5SeNe2MLCwV+SpybueX1ok5N9E6t8WQKUEE1NUENV0FcY3eejNfy?=
 =?us-ascii?Q?40uT2pOc5y6I7H3BNarvrK9uHiT6qgtPm4cshB4MBHVGVoftUb3uWGrvrmU+?=
 =?us-ascii?Q?p2EANivDVQi0TovzXETf4uEq6v2ECQCTiNLXu9eFeFWM5Gj33xJjbK5AYHuZ?=
 =?us-ascii?Q?gfjPyZ7/p2sG0QtKCbdCFZcCFq5/IkvG27MZDe9I4Io=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f573a25d-d2a2-47fd-c982-08d8a0c0a166
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 06:14:07.3868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiDiqDYAi9BOIKn12wAqxfDambBWNT/mwbjQ2vLaNCXCjXlyd3So0n1thwAoupD3INB5XRTURuD4wKQgsJCpnitWiYrxJ3bP87GzjcZPd8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7234
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_03:2020-12-11,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012150041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 20-12-15 05:27:38, Pawel Laszczak wrote:
>> >
>> >
>> >On 20-12-14 13:03:44, Pawel Laszczak wrote:
>> >> Patch fixes all sparse warnings in cdsnp driver.
>> >>
>> >> It fixes the following warnings:
>> >> cdnsp-ring.c:1441: warning: incorrect type in assignment
>> >> cdnsp-ring.c:1444: warning: restricted __le32 degrades to integer
>> >> cdnsp-ring.c:2200: warning: dubious: x | !y
>> >> cdnsp-gadget.c:501: warning: incorrect type in assignment
>> >> cdnsp-gadget.c:504: warning: restricted __le32 degrades to integer
>> >> cdnsp-gadget.c:507: warning: restricted __le32 degrades to integer
>> >> cdnsp-gadget.c:508: warning: restricted __le32 degrades to integer
>> >> cdnsp-gadget.c:509: warning: invalid assignment: |=3D
>> >> cdnsp-gadget.c:510: warning: cast from restricted __le32
>> >> cdnsp-gadget.c:558: warning: incorrect type in assignment
>> >> cdnsp-gadget.c:561: warning: restricted __le32 degrades to integer
>> >> cdnsp-gadget.c:570: warning: restricted __le32 degrades to integer
>> >> cdnsp-gadget.c:1571: warning: incorrect type in argument 1
>> >> cdnsp-gadget.c:1602: warning: restricted __le32 degrades to integer
>> >> cdnsp-gadget.c:1760: warning: incorrect type in assignment
>> >> cdnsp-gadget.c:1762: warning: incorrect type in assignment
>> >> cdnsp-gadget.c:1763: warning: incorrect type in assignment
>> >> cdnsp-gadget.c:1764: warning: incorrect type in assignment
>> >> cdnsp-gadget.c:1765: warning: incorrect type in assignment
>> >> cdnsp-gadget.c:1766: warning: incorrect type in assignment
>> >> cdnsp-gadget.c:1767: warning: incorrect type in assignment
>> >> cdnsp-gadget.c:458: warning: cast truncates bits from constant value
>> >>                     (ffffffff07ffffff becomes 7ffffff)
>> >> cdnsp-gadget.c:666: warning: cast truncates bits from constant value
>> >>                     (ffffffff07ffffff becomes 7ffffff)
>> >> cdnsp-mem.c:762: warning: incorrect type in assignment
>> >> cdnsp-mem.c:763: warning: incorrect type in assignment
>> >> cdnsp-mem.c:928: warning: cast from restricted __le16
>> >> cdnsp-mem.c:1187: warning: incorrect type in assignment
>> >> cdnsp-mem.c:1191: warning: incorrect type in assignment
>> >> cdnsp-ep0.c:142: warning: incorrect type in assignment
>> >> cdnsp-ep0.c:144: warning: restricted __le32 degrades to integer
>> >> cdnsp-ep0.c:147: warning: restricted __le32 degrades to integer
>> >> cdnsp-ep0.c:148: warning: restricted __le32 degrades to integer
>> >> cdnsp-ep0.c:179: warning: incorrect type in argument 1
>> >> cdnsp-ep0.c:311: warning: incorrect type in argument 1
>> >> cdnsp-ep0.c:469: warning: incorrect type in assignment
>> >> cdnsp-trace.h:611:1: warning: cast from restricted __le32
>> >>
>> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> >> Reported-by: kernel test robot <lkp@intel.com>
>> >
>> >Hi Pawel,
>> >
>> >The Reported-by tag should be above your Sob tag, I will change it.
>> >Except the patch reported build error by kernel test robot, I will appl=
y
>> >your other four patches after finishing the compile test.
>> >
>> >Peter
>>
>> Hi Peter,
>>
>> I'm going to fix the "usb: cdns3: Adds missing __iomem markers"  today.
>> I haven't  seen any issue on ARCH=3Dparisc. Maybe it's some specific ris=
cv arch issue.
>>
>> I believe that:
>> [auto build test WARNING on next-20201211]
>> [cannot apply to peter.chen-usb/ci-for-usb-next v5.10 v5.10-rc7 v5.10-rc=
6 v5.10]
>>
>> is not the problem. I based on  peter.chen-usb/for-usb-next.
>>
>> Also I can't open the url from kernel test robot report.
>> Maybe there is some temporary issue with server.
>>
>
>Thanks for checking it, I have already pushed your other four patches.
>Besides, there is still a build error issue for new cdns3 driver.
>
>https://urldefense.com/v3/__https://www.spinics.net/lists/linux-
>usb/msg206073.html__;!!EHscmS1ygiU1lA!X6rYk64ILtzjyHW903LAhBRjMKi9C2eyJWEX=
VlEZm0ly2BiNzY2wK46Ulq7q5w$
>

Did you applied: [PATCH] usb: cdnsp: Fix for undefined reference to `usb_hc=
d_is_primary_hcd' ?

Pawel

>Peter
>> Thanks,
>> Pawel
>>
>> >> ---
>> >>  drivers/usb/cdns3/cdnsp-debug.h  |  2 +-
>> >>  drivers/usb/cdns3/cdnsp-ep0.c    | 13 ++++++-------
>> >>  drivers/usb/cdns3/cdnsp-gadget.c | 24 +++++++++---------------
>> >>  drivers/usb/cdns3/cdnsp-gadget.h | 13 +++++++------
>> >>  drivers/usb/cdns3/cdnsp-mem.c    | 11 ++++++-----
>> >>  drivers/usb/cdns3/cdnsp-ring.c   |  4 ++--
>> >>  drivers/usb/cdns3/cdnsp-trace.h  |  2 +-
>> >>  7 files changed, 32 insertions(+), 37 deletions(-)
>> >>
>> >> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdns=
p-debug.h
>> >> index d6345d4d2911..a8776df2d4e0 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-debug.h
>> >> +++ b/drivers/usb/cdns3/cdnsp-debug.h
>> >> @@ -414,7 +414,7 @@ static inline const char *cdnsp_decode_slot_conte=
xt(u32 info, u32 info2,
>> >>  		s =3D "UNKNOWN speed";
>> >>  	}
>> >>
>> >> -	ret =3D sprintf(str, "%s Ctx Entries %ld",
>> >> +	ret =3D sprintf(str, "%s Ctx Entries %d",
>> >>  		      s, (info & LAST_CTX_MASK) >> 27);
>> >>
>> >>  	ret +=3D sprintf(str + ret, " [Intr %ld] Addr %ld State %s",
>> >> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-=
ep0.c
>> >> index d55b59ed7381..e2b1bcb3f80e 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-ep0.c
>> >> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
>> >> @@ -137,10 +137,8 @@ int cdnsp_status_stage(struct cdnsp_device *pdev=
)
>> >>  	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
>> >>  }
>> >>
>> >> -static int cdnsp_w_index_to_ep_index(__le32  wIndex)
>> >> +static int cdnsp_w_index_to_ep_index(u16 wIndex)
>> >>  {
>> >> -	wIndex =3D le32_to_cpu(wIndex);
>> >> -
>> >>  	if (!(wIndex & USB_ENDPOINT_NUMBER_MASK))
>> >>  		return 0;
>> >>
>> >> @@ -176,7 +174,8 @@ static int cdnsp_ep0_handle_status(struct cdnsp_d=
evice *pdev,
>> >>  		 */
>> >>  		return cdnsp_ep0_delegate_req(pdev, ctrl);
>> >>  	case USB_RECIP_ENDPOINT:
>> >> -		pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
>> >> +		ep_sts =3D cdnsp_w_index_to_ep_index(le16_to_cpu(ctrl->wIndex));
>> >> +		pep =3D &pdev->eps[ep_sts];
>> >>  		ep_sts =3D GET_EP_CTX_STATE(pep->out_ctx);
>> >>
>> >>  		/* check if endpoint is stalled */
>> >> @@ -305,10 +304,10 @@ static int cdnsp_ep0_handle_feature_endpoint(st=
ruct cdnsp_device *pdev,
>> >>  					     int set)
>> >>  {
>> >>  	struct cdnsp_ep *pep;
>> >> -	u32 wValue;
>> >> +	u16 wValue;
>> >>
>> >>  	wValue =3D le16_to_cpu(ctrl->wValue);
>> >> -	pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
>> >> +	pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(le16_to_cpu(ctrl->wInd=
ex))];
>> >>
>> >>  	switch (wValue) {
>> >>  	case USB_ENDPOINT_HALT:
>> >> @@ -435,7 +434,7 @@ void cdnsp_setup_analyze(struct cdnsp_device *pde=
v)
>> >>  {
>> >>  	struct usb_ctrlrequest *ctrl =3D &pdev->setup;
>> >>  	int ret =3D 0;
>> >> -	__le16 len;
>> >> +	u16 len;
>> >>
>> >>  	trace_cdnsp_ctrl_req(ctrl);
>> >>
>> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdn=
sp-gadget.c
>> >> index 1668f72fdf30..f28f1508f049 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> >> @@ -491,7 +491,7 @@ static void cdnsp_invalidate_ep_events(struct cdn=
sp_device *pdev,
>> >>  	struct cdnsp_segment *segment;
>> >>  	union cdnsp_trb *event;
>> >>  	u32 cycle_state;
>> >> -	__le32  data;
>> >> +	u32  data;
>> >>
>> >>  	event =3D pdev->event_ring->dequeue;
>> >>  	segment =3D pdev->event_ring->deq_seg;
>> >> @@ -527,9 +527,9 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device =
*pdev)
>> >>  	dma_addr_t cmd_deq_dma;
>> >>  	union cdnsp_trb *event;
>> >>  	u32 cycle_state;
>> >> -	__le32  flags;
>> >>  	int ret, val;
>> >>  	u64 cmd_dma;
>> >> +	u32  flags;
>> >>
>> >>  	cmd_trb =3D pdev->cmd.command_trb;
>> >>  	pdev->cmd.status =3D 0;
>> >> @@ -1568,7 +1568,7 @@ static void cdnsp_get_ep_buffering(struct cdnsp=
_device *pdev,
>> >>  		return;
>> >>  	}
>> >>
>> >> -	endpoints =3D HCS_ENDPOINTS(readl(&pdev->hcs_params1)) / 2;
>> >> +	endpoints =3D HCS_ENDPOINTS(pdev->hcs_params1) / 2;
>> >>
>> >>  	/* Set to XBUF_TX_TAG_MASK_0 register. */
>> >>  	reg +=3D XBUF_TX_CMD_OFFSET + (endpoints * 2 + 2) * sizeof(u32);
>> >> @@ -1754,22 +1754,16 @@ void cdnsp_irq_reset(struct cdnsp_device *pde=
v)
>> >>  static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
>> >>  {
>> >>  	void __iomem *reg =3D &pdev->cap_regs->hc_capbase;
>> >> -	struct cdnsp_rev_cap *rev_cap;
>> >>
>> >>  	reg +=3D cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
>> >> -	rev_cap =3D reg;
>> >> -
>> >> -	pdev->rev_cap.ctrl_revision =3D readl(&rev_cap->ctrl_revision);
>> >> -	pdev->rev_cap.rtl_revision =3D readl(&rev_cap->rtl_revision);
>> >> -	pdev->rev_cap.ep_supported =3D readl(&rev_cap->ep_supported);
>> >> -	pdev->rev_cap.ext_cap =3D readl(&rev_cap->ext_cap);
>> >> -	pdev->rev_cap.rx_buff_size =3D readl(&rev_cap->rx_buff_size);
>> >> -	pdev->rev_cap.tx_buff_size =3D readl(&rev_cap->tx_buff_size);
>> >> +	pdev->rev_cap  =3D reg;
>> >>
>> >>  	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
>> >> -		 pdev->rev_cap.ctrl_revision, pdev->rev_cap.rtl_revision,
>> >> -		 pdev->rev_cap.ep_supported, pdev->rev_cap.rx_buff_size,
>> >> -		 pdev->rev_cap.tx_buff_size);
>> >> +		 readl(&pdev->rev_cap->ctrl_revision),
>> >> +		 readl(&pdev->rev_cap->rtl_revision),
>> >> +		 readl(&pdev->rev_cap->ep_supported),
>> >> +		 readl(&pdev->rev_cap->rx_buff_size),
>> >> +		 readl(&pdev->rev_cap->tx_buff_size));
>> >>  }
>> >>
>> >>  static int cdnsp_gen_setup(struct cdnsp_device *pdev)
>> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdn=
sp-gadget.h
>> >> index 8eb1b85a08b4..6bbb26548c04 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>> >> @@ -493,11 +493,12 @@ struct cdnsp_3xport_cap {
>> >>  #define CDNSP_VER_1 0x00000000
>> >>  #define CDNSP_VER_2 0x10000000
>> >>
>> >> -#define CDNSP_IF_EP_EXIST(pdev, ep_num, dir) ((pdev)->rev_cap.ep_sup=
ported & \
>> >> -			  (BIT(ep_num) << ((dir) ? 0 : 16)))
>> >> +#define CDNSP_IF_EP_EXIST(pdev, ep_num, dir) \
>> >> +			 (readl(&(pdev)->rev_cap->ep_supported) & \
>> >> +			 (BIT(ep_num) << ((dir) ? 0 : 16)))
>> >>
>> >>  /**
>> >> - * struct cdnsp_rev_cap - controller capabilities .
>> >> + * struct cdnsp_rev_cap - controller capabilities.
>> >>   * @ext_cap: Header for RTL Revision Extended Capability.
>> >>   * @rtl_revision: RTL revision.
>> >>   * @rx_buff_size: Rx buffer sizes.
>> >> @@ -594,7 +595,7 @@ struct cdnsp_slot_ctx {
>> >>  #define DEV_SPEED		GENMASK(23, 20)
>> >>  #define GET_DEV_SPEED(n)	(((n) & DEV_SPEED) >> 20)
>> >>  /* Index of the last valid endpoint context in this device context -=
 27:31. */
>> >> -#define LAST_CTX_MASK		GENMASK(31, 27)
>> >> +#define LAST_CTX_MASK		((unsigned int)GENMASK(31, 27))
>> >>  #define LAST_CTX(p)		((p) << 27)
>> >>  #define LAST_CTX_TO_EP_NUM(p)	(((p) >> 27) - 1)
>> >>  #define SLOT_FLAG		BIT(0)
>> >> @@ -1351,9 +1352,9 @@ struct cdnsp_port {
>> >>   * @ir_set: Current interrupter register set.
>> >>   * @port20_regs: Port 2.0 Peripheral Configuration Registers.
>> >>   * @port3x_regs: USB3.x Port Peripheral Configuration Registers.
>> >> + * @rev_cap: Controller Capabilities Registers.
>> >>   * @hcs_params1: Cached register copies of read-only HCSPARAMS1
>> >>   * @hcc_params: Cached register copies of read-only HCCPARAMS1
>> >> - * @rev_cap: Controller capability.
>> >>   * @setup: Temporary buffer for setup packet.
>> >>   * @ep0_preq: Internal allocated request used during enumeration.
>> >>   * @ep0_stage: ep0 stage during enumeration process.
>> >> @@ -1402,12 +1403,12 @@ struct cdnsp_device {
>> >>  	struct	cdnsp_intr_reg __iomem *ir_set;
>> >>  	struct cdnsp_20port_cap __iomem *port20_regs;
>> >>  	struct cdnsp_3xport_cap __iomem *port3x_regs;
>> >> +	struct cdnsp_rev_cap __iomem *rev_cap;
>> >>
>> >>  	/* Cached register copies of read-only CDNSP data */
>> >>  	__u32 hcs_params1;
>> >>  	__u32 hcs_params3;
>> >>  	__u32 hcc_params;
>> >> -	struct cdnsp_rev_cap rev_cap;
>> >>  	/* Lock used in interrupt thread context. */
>> >>  	spinlock_t lock;
>> >>  	struct usb_ctrlrequest setup;
>> >> diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-=
mem.c
>> >> index 4c7d77fb097e..7a84e928710e 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-mem.c
>> >> +++ b/drivers/usb/cdns3/cdnsp-mem.c
>> >> @@ -759,8 +759,9 @@ int cdnsp_setup_addressable_priv_dev(struct cdnsp=
_device *pdev)
>> >>
>> >>  	port =3D DEV_PORT(pdev->active_port->port_num);
>> >>  	slot_ctx->dev_port |=3D cpu_to_le32(port);
>> >> -	slot_ctx->dev_state =3D (pdev->device_address & DEV_ADDR_MASK);
>> >> -	ep0_ctx->tx_info =3D EP_AVG_TRB_LENGTH(0x8);
>> >> +	slot_ctx->dev_state =3D cpu_to_le32((pdev->device_address &
>> >> +					   DEV_ADDR_MASK));
>> >> +	ep0_ctx->tx_info =3D cpu_to_le32(EP_AVG_TRB_LENGTH(0x8));
>> >>  	ep0_ctx->ep_info2 =3D cpu_to_le32(EP_TYPE(CTRL_EP));
>> >>  	ep0_ctx->ep_info2 |=3D cpu_to_le32(MAX_BURST(0) | ERROR_COUNT(3) |
>> >>  					 max_packets);
>> >> @@ -925,7 +926,7 @@ static u32 cdnsp_get_max_esit_payload(struct usb_=
gadget *g,
>> >>  	/* SuperSpeedPlus Isoc ep sending over 48k per EIST. */
>> >>  	if (g->speed >=3D USB_SPEED_SUPER_PLUS &&
>> >>  	    USB_SS_SSP_ISOC_COMP(pep->endpoint.desc->bmAttributes))
>> >> -		return le32_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
>> >> +		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
>> >>  	/* SuperSpeed or SuperSpeedPlus Isoc ep with less than 48k per esit=
 */
>> >>  	else if (g->speed >=3D USB_SPEED_SUPER)
>> >>  		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
>> >> @@ -1184,11 +1185,11 @@ static int cdnsp_setup_port_arrays(struct cdn=
sp_device *pdev)
>> >>
>> >>  	trace_cdnsp_init("Found USB 2.0 ports and  USB 3.0 ports.");
>> >>
>> >> -	pdev->usb2_port.regs =3D (struct cdnsp_port_regs *)
>> >> +	pdev->usb2_port.regs =3D (struct cdnsp_port_regs __iomem *)
>> >>  			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
>> >>  				(pdev->usb2_port.port_num - 1));
>> >>
>> >> -	pdev->usb3_port.regs =3D (struct cdnsp_port_regs *)
>> >> +	pdev->usb3_port.regs =3D (struct cdnsp_port_regs __iomem *)
>> >>  			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
>> >>  				(pdev->usb3_port.port_num - 1));
>> >>
>> >> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp=
-ring.c
>> >> index 874d9ff5406c..e15e13ba27dc 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-ring.c
>> >> +++ b/drivers/usb/cdns3/cdnsp-ring.c
>> >> @@ -1432,7 +1432,7 @@ static bool cdnsp_handle_event(struct cdnsp_dev=
ice *pdev)
>> >>  	unsigned int comp_code;
>> >>  	union cdnsp_trb *event;
>> >>  	bool update_ptrs =3D true;
>> >> -	__le32 cycle_bit;
>> >> +	u32 cycle_bit;
>> >>  	int ret =3D 0;
>> >>  	u32 flags;
>> >>
>> >> @@ -2198,7 +2198,7 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_dev=
ice *pdev,
>> >>  	 * inverted in the first TDs isoc TRB.
>> >>  	 */
>> >>  	field =3D TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
>> >> -		!start_cycle | TRB_SIA | TRB_TBC(burst_count);
>> >> +		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
>> >>
>> >>  	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
>> >>  	for (i =3D 0; i < trbs_per_td; i++) {
>> >> diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdns=
p-trace.h
>> >> index b68e282464d2..a9de1daadf07 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-trace.h
>> >> +++ b/drivers/usb/cdns3/cdnsp-trace.h
>> >> @@ -620,7 +620,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_slot_ctx,
>> >>  	TP_fast_assign(
>> >>  		__entry->info =3D le32_to_cpu(ctx->dev_info);
>> >>  		__entry->info2 =3D le32_to_cpu(ctx->dev_port);
>> >> -		__entry->int_target =3D le64_to_cpu(ctx->int_target);
>> >> +		__entry->int_target =3D le32_to_cpu(ctx->int_target);
>> >>  		__entry->state =3D le32_to_cpu(ctx->dev_state);
>> >>  	),
>> >>  	TP_printk("%s", cdnsp_decode_slot_context(__entry->info,
>> >> --
>> >> 2.17.1
>> >>
>>
>> --
>>
>> Regards
>> Pawel Laszcak
>
>--
>
>Thanks,
>Peter Chen

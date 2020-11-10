Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CDC2AD583
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgKJLn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:43:56 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:40778 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730108AbgKJLnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:43:47 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AABbiYe007038;
        Tue, 10 Nov 2020 03:43:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=TtXGHhACjfz8Ps0N21N52xQy9kXRKdO13Q8xFxpEivA=;
 b=NKsYUEbWYEgl5qu83Fm68La6O0RGlfNbioKMqm4X59pjYZ2zk7+56HN9bCGTY1i7qo6V
 1jd2TjwyVbPALREPV/J5j+KaBsQ4Sg5vXPGr/SjqEUJ2BketiREmjjBNoBtfRWAYbQM6
 H96v1raXQUVrsO6mQasnoDOd5D9OS/m9O3QfXfKzcNTh5+k40++C0lVveYbs63CDJUJQ
 TNPDVNaMkBnA/P+yfJ0tSpB4ycWqpB47OvXqUm4wISUfN4wrDTRwDjvU5UVLR2T/eLc1
 SBczz68aR8iSskcGDpjj3o3eGo/bjgTV5VRA+rqP1U6L0AxEf/thFjsmYPSAVd9NYSRK TA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34ns14aft2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 03:43:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aC3MdFdpnGgkB1NXmkz0Q16vSd5aoZea85a86SXVRfTbP1u8L2I2YkipDWlZRTgPrvmhfL1RR9wiz/DQIwrjYRGQv34WgS8U81zYKzl8ajeA6WEpTRJ3OPVHGgm8INz8a2SuLSAv+k4uxI5K/7akatbkZDJqONsIKi0llSnMt5f8N5b9UdXWLNl8MV5BzfEvs/uxWudh3jOjSxEFmfGHzjNv3w6MJy/sMclI5hcMCu2t9ieBzKPE8BaLJgRa12BIQ558nuluV1Misc6/KlCzpKrH2APBQNAUcrQPZ9U0KzOGKFxE3p95EfIvtZdZOh5jTMyFnINuIL3rqVzJOZKX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtXGHhACjfz8Ps0N21N52xQy9kXRKdO13Q8xFxpEivA=;
 b=BJ2way55f3EkKBztiPAp0hdNFVxkIxTprSPIz7uuBRpWb2D1/b4YrnM4RqkeFVm88MPxRb4b9nnGDMXcbzeC7M0MqjrG3Cd/LvMUn4q+zKJPXVxKjbvdKHT7YcZAkinjrAKkIgeuWGGOj4pbVHIcsaH8d/9fugJFv2mdhVkpZBxtZ+yApiadsNZ+9peQqYNUi1A08cx2ynIEapsxghGLsAoi8HiOfdfV9yJGqcGpWWDdCMVPyDO4qacS+comqrCnvuJ2Zfskep16q3ugr7cSGlQdzfScVVVwX92N+eT+IQDZMT5tIVxQWdbV4AqJm6PdppxTrhIlVqFPy3PcMtP5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtXGHhACjfz8Ps0N21N52xQy9kXRKdO13Q8xFxpEivA=;
 b=DJhLKTgvZB4h0PtPCoLFMsaH8pExsx764C4IcuzhyWNv88pV+BR8QUv+vElYKvSKKODbokYdi5we/ytAQj/bnOhbXMwLJDry4gBB7aqzCBRNVRYM4u2idIvk8XaUDtHFp+iFnyUIwyDKY0FIvo6CjsKmSBSo9eCeKdjbE4/Wd84=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB6362.namprd07.prod.outlook.com (2603:10b6:5:179::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Tue, 10 Nov 2020 11:43:00 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f977:ce71:755d:bed6]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f977:ce71:755d:bed6%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 11:43:00 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate
 module
Thread-Topic: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate
 module
Thread-Index: AQHWtDIwjXrTHzGzLka9II0WlmWMgKnBGfiAgAAAUrCAACSOAIAABRoAgAAABOA=
Date:   Tue, 10 Nov 2020 11:42:59 +0000
Message-ID: <DM6PR07MB552957F3C0D3E321C527578BDDE90@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201106114300.1245-1-pawell@cadence.com>
 <20201106114300.1245-4-pawell@cadence.com>
 <20201110090854.GB22481@b29397-desktop>
 <DM6PR07MB55294E87F6D76BA3C04E510ADDE90@DM6PR07MB5529.namprd07.prod.outlook.com>
 <20201110112054.GC22481@b29397-desktop> <X6p7+nXa/H4uqj0+@kroah.com>
In-Reply-To: <X6p7+nXa/H4uqj0+@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZGY2OWI2NjctMjM0OS0xMWViLTg3NmItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGRmNjliNjY5LTIzNDktMTFlYi04NzZiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTI5NyIgdD0iMTMyNDk0ODIxNzYyOTA2NzUwIiBoPSJpUTJpTVdRMjZXSVFXVlFuWndHUDd6dmR3MWs9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae54f9c6-c8f3-4261-7c00-08d8856dc674
x-ms-traffictypediagnostic: DM6PR07MB6362:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB6362A324B10AD66F58364B8BDDE90@DM6PR07MB6362.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TO/dBZAgsF0gxq/rhedtRyPB4Q5MDjFSOuuxEopobcAWhMEwHNxWPThZlj0FdGIzIE9IAZFsT+Nf4CrLykCnV6JHMvpb6c3iTxGe37jcT2o6tm9m88QfinXfOOIqoVoKsbT9TRJ/lG7rLTfbDmUqin+Vktz591UcKHgGTpd8LghuGiIGnzIGjJLVcUSqpcZdRb/hL/ex+EseaulUeHR2Y3e14h25GLk7O0GTi/42JdDBQkc8NbGHQPW+BR3w7djGvjpZWSvCEx1RZiawtwx38Y+M6z4QN9bAT+y6CyHB7rA/bIPAlrv7RRG/4ZgrWQYKJ/WZedpjx5OZL9bfdDnR4SbRng8nzl/xNboNBNUqA02LXpR9JfJQD/JAc8rFgO1+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(36092001)(8936002)(83380400001)(110136005)(55016002)(2906002)(26005)(8676002)(316002)(186003)(7696005)(33656002)(478600001)(6506007)(53546011)(76116006)(66556008)(66946007)(66476007)(66446008)(54906003)(5660300002)(71200400001)(9686003)(52536014)(64756008)(4326008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VCmxw9ArVdaw+Hzs9P3lLCJ98w5trmdJDRQ9Fl1xyLK/r28pSQpoQI/Jl6yfszvZS9htjRNK0esd8MwWHpvidzE9cHirvAsp/+7vZhd96jluinE1HqLBqzWx7Be0IhEgDgUmeBvKxkl68f8jZm9G5snGp8d6ZIwkpku7Bi8ZXOj0lwjy14dO78WCFRCAHlJf/n4E64fF8gWXV55MdBdrXY10MAPCUxOcqU1RXWXSfkCwbRfUs5v8LaPv7t6JxSlDD1wFB1qh+mDXoUUbsSGvhd4mc+kOixV+tsV8Xm5ZgC55H9lFURNqA9ZQ/UQWwzCFuBNUd4qYZss1oXVPBs/YqOsLiLJTgQvlHU3zsdY6++yr0sEeap6QWcFe8sEZpnKqSXE2V/DhoxqjbF8rpNv2TSY/ROgXMD5pDlpcHuPLAwVoA23wrwndgOAmv6uyg6YePSUXQm5cNjX8EntmSj69yGt2YpaNhSj+sHh3CrZPKvt5ZkXbNa7Kf9SLBE74v/cSHoQOqHQ+oeGfWrQziVC6lzfZiUkB8fD7Yt3FFHlFPfAgStSgldu/6kJ5+MrNLDv93fgClecgHdC1itsohE0ZK6666WWiWQhkn326tfIsdkqyLMdZV4eUn1nA6GpVI/iZLz7W+5yT+sxDufFhqWMvQGDYxAPKlxy6TUetXqnsvpj8D1470LmuUgr9bO/NvI9A+f216uO7Al0c3gfYO0z++pAF3bqB9FT14jz3MyNNvpZh0S5c5XpbcyTytduZf+u6zUJW4gIUNPnO7Ay3RO99L1SR+rD97XdhbNBuDQawZOKgAC67CUu2IYu+FydFiYx658qorTwMvylA4UcchPuHB0n2YaXrVu8yq/G7HzuLnY2BdIGeaAwNkWDPS1mCfeAo2KoUXEe7xvCkoiVQfZR0oA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae54f9c6-c8f3-4261-7c00-08d8856dc674
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 11:42:59.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8hptiEjbgS472NbmjbFW1WYP2Z18VnCCyBIKSzh22tK9dudMxOmzdqf3jsxgSctfGgkmyHUZqw/5RwySVILL8OtQhwKAWb7WJtwhv41EsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6362
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 mlxlogscore=549 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Tue, Nov 10, 2020 at 11:21:22AM +0000, Peter Chen wrote:
>> On 20-11-10 09:20:54, Pawel Laszczak wrote:
>> > Hi,
>> >
>> > >>
>> > >>  int cdns3_hw_role_switch(struct cdns3 *cdns);
>> > >> -int cdns3_init(struct cdns3 *cdns);
>> > >> -int cdns3_remove(struct cdns3 *cdns);
>> > >> +extern int cdns3_init(struct cdns3 *cdns);
>> > >> +extern int cdns3_remove(struct cdns3 *cdns);
>> > >
>> > >Why add "extern" here and below?
>> > >
>> >
>> > These functions are the API between cdnsp and cdns3 modules.
>> > It's looks like a common approach in kernel.
>> > Many or even most of API function in kernel has "extern".
>> >
>>
>> Even you have not written "extern" keyword, the "extern" is
>> added implicitly by compiler. Usually, we use "extern" for variable
>> or the function is defined at assembly. You could see some
>> "extern" keyword use cases at include/linux/device.h.
>
>We are moving away from using this keyword for functions now, if at all
>possible please.  Only use it for variables, I think checkpatch now
>catches it as well.
>

Ok, I will remove all extern from driver.=20
Removing it also will remove checkpatch.pl warmings.

Thanks
Pawel

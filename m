Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9565F27D933
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgI2Uri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:47:38 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:35332 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgI2Urh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:47:37 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TKgO3p010359;
        Tue, 29 Sep 2020 16:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=YZXr6s92rbRfdpmLbnt4OTwtDTOr//IdRTqWsZIjWq4=;
 b=eYe1Eo7zoiQ53HnxGxT59jun6xUT+qZJs+6UhUTrmYYNNIxkacBzGobG1XIbgQaaLl/3
 zl+oonCHmHPgDbhnoRMwkl6u2g/SDh5IKIy7I9BMgBv+ch58JHvY5x9nYVudFIwbYdkf
 mx2vFcSSptF6YndeVq8gdGThtHRa11ZwqxgcwOMP7H35y+cuZ6NeJryG9BUZUZUhoeb3
 px9udiGEYoBy4fiNKoP2wpO3CiGpGKJy1m8fv+ulUR2BgbgDRpSuJ9iLyfaQXI31M358
 d/P5kRvaoOacaTV22OuckyflcK+9RgdxoxhhWTg4YNqbswB06G6BOotAZz1w4j1NCIlV mQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 33t0sxjuda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 16:47:29 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TKiIPM080650;
        Tue, 29 Sep 2020 16:47:29 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00154901.pphosted.com with ESMTP id 33vaaq1vfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 16:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0dDN0zSDMCK9rgw5k3fUjOBHuDK+szmll7IzbnOYe03d/uzVD+LEmM00YSt/kWYuJbaFcWTJs8pXL4YTgSTuVr977AJQTzHB4ReVYaPWCXSbb0XPvkn38EN4q4H7qPJ4OGO4nJ5OiH8o5ItuoZuFtYa6H5MF7UXPLTyJc2DcMqTWnm0Y73Aftjbrg4oV3M0G3YT1t5ifjihmBAc/DH7tUzqSKQoYm8vbdE2z1X+70nZ7OJ//Q1ErrjuVNdnl9zs21yTNsjPX4uUklMMBB63H6PuyaQXXqXKFLynXdworrjr9N3GmmgIofr6IeyqMAjqU5q8gZnOUN8Amv7o5AgVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZXr6s92rbRfdpmLbnt4OTwtDTOr//IdRTqWsZIjWq4=;
 b=TUXXZNPYswwbsgvI3oGMNwoD8FfsBGceTEI+J44OjCauR32roJzsyp9KCP+UgqU8C4zFYqicJifxK32iaU+qpxaNzePd8+SugqaLWOf9iNsLeynQKHP50Ry2+yvAxGk68R5B800ZS0qI4H6XzkYWHBFqWasbt84gf849aoprwdkKXfoyqgleO/yPqgbB7b35fBHLiUoRE+PXLuPG1EjUUM6qyxdnq5ZxEVMJ7ozXNu7fL3Kugr9YYnFWkeE9o6d4GTsmndKizbCvXvxoePU19FX2fonkcl92oufPEg66xUFHqOpPsukNTt0gEfxJ3VQIpCTbxmIxL5i0NSOTAWbThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZXr6s92rbRfdpmLbnt4OTwtDTOr//IdRTqWsZIjWq4=;
 b=UbfT+1g2+yBDT+xgZ0p00wAS4fftcZ4jBW24Etg4O3IKgQXYhfGUaWvySHlHeyjuOLdbCHYkMyGCjB9Dml9GbZTnJ4K8Tk0g11G8/IlylnRQXvG7HsIR5OPcYTFDwB86cphJ/t3exvuqFdAL7iTBhdywFzltP60GrgQmu7I4gOM=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DS7PR19MB4488.namprd19.prod.outlook.com (2603:10b6:5:2c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Tue, 29 Sep
 2020 20:47:26 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 20:47:26 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?iso-8859-2?Q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: RE: Keyboard regression by intel-vbtn
Thread-Topic: Keyboard regression by intel-vbtn
Thread-Index: AQHWlj1nM3jkeRr7qUSqdoVr/WDD66l/V1WAgAACMACAAAiVgIAABMgAgAAjUpSAAAiigIAAGG+wgABpVeA=
Date:   Tue, 29 Sep 2020 20:47:26 +0000
Message-ID: <DM6PR19MB2636BD25C7C828D28CF27CC8FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
 <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
 <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
 <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-29T14:21:56.7117850Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=ca234379-621d-4f4e-98a9-ed8fde90e046;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [2600:1700:70:f700:4924:2a57:f653:596a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28dae1fa-6ec6-4360-3282-08d864b8dff2
x-ms-traffictypediagnostic: DS7PR19MB4488:
x-microsoft-antispam-prvs: <DS7PR19MB448863405382C863826998ADFA320@DS7PR19MB4488.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pkl/dM5Hihywi8ktHjjrFOotEJ8iWF40tEoT2AApjZ5X+e3yHlLJnsWfaP60rBP65N3iGYHYTfqkP36uXx7CKwOW+YpPLqJ6DrAQ6EQZev7CDE1MgEISHtHIV87ef6IUjuKH9iqaA2xTzFhapofjqYgRrQfdX1rQE0nmcSu9XQqNxxnAl/16OgBggw3iwkf2UWCb5vPgpwyBBmWAO+5TaC3crR7l0o1xSrTKryl02IF6ir7osovRkiRisubg8SPyGzzVuaaobGI0StWdMCyFWwd+wWavS3uiytQA9HkdC6oBAczq8xCpVi0+sWpMalqYXnUZIEB9jKWO26Jlot1IBpus7UMfOUnty1yUhMsnGrocdyD2GK2MR+5ev8P/8sX6vUunsmkwzRj9us1O6iRN63hH/K672FYni6uDM8vLPg39QSOieONImxu15toPsRd1cc5e0m+YToS7VhS+rmZMKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66446008)(4326008)(8676002)(4744005)(66476007)(7696005)(83380400001)(54906003)(66556008)(66946007)(55016002)(8936002)(2940100002)(76116006)(52536014)(9686003)(110136005)(498600001)(186003)(5660300002)(86362001)(966005)(71200400001)(33656002)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mz0Lf/ljI8wIlmDf0hksNYfgVhL80LVTl7QIM2SLBIivkOH87Xatzt2ZcVbu83Ei0US6YbTZwnZ08zDhX91suAX34DVgcx/P6Bvj/ufFLECYKRWTsz/OF3m8DMmRbfvG2lBnenrBG6top/njyiJNx9JJFUFOHjEz1kvRQVRi8dHcqLGn6kEm5eH6pKKI3VD6QjBunhiBPZVnNBl2XlK2PaIWAsEy23tnwJCA80ejeRlKicJdrfa1MHP87OYJkaqJs6erK4nIEQbb8g6x3Whl+JLaVzStVppf3ZTtZaoJlGAROq66T6xlMp5KIq/ptPqon54MIfdsYP4aKKYVy4/mVREdKcHzKr8Uo6DOGMqsqDDW8tQw6cA8RNdqOp4api5D5DTeqQbNdlpSv9lNMUbYvhororKKTtEw0RVML42Ray7DAkZs0ca6ov3MOg7DnufAhLfLYd6taU/aSsUtAinijiNdpXtjsJYkE3UpSDt8vD67yDP+7Q78NW7Pc+Lr1KcVwIhpnl2RGbWIOBGSa2SNeM6MLJy4IaVr+3FUvrw6ThPFiZltp50JFXVhtxX0C/znoJL1gxIo178jPutyJ0FHiaTWrvK01XPS7f+mhwwUvtuShZ4TctQAaXz8loAyvXMQ9wYeveJ1V+GSduxGjP3tSSE6vpgyAskwBGLvDGPbqyPd0sWjUUBpqiSZAzKNCr4yGdK0SjvzZXPF5LfrC0/y1w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dae1fa-6ec6-4360-3282-08d864b8dff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 20:47:26.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlqrsWgt1oW/0iVNVcc9mGqqesANiYbkG1UO1WL3rvh4vGVC3Ej7tVJKqFVMwQZfdAVFNfEC7tUIPjMi8A4LB99NcDAM+Wud087MfqcDpbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4488
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_14:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=540 priorityscore=1501 clxscore=1015
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290175
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=632 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290175
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> I requested on the Ubuntu bug for someone to provide these.
>=20

Joe Barnett was kind enough to share two ACPI dumps to compare.
Not affected:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394/+attachment/54=
15318/+files/1.2.0.acpidump

Affected:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394/+attachment/54=
15405/+files/1.13.0.acpidump

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3B62EFBC1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbhAHXht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:37:49 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1047 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbhAHXhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:37:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff8eca20000>; Fri, 08 Jan 2021 15:37:06 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 Jan
 2021 23:37:06 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 8 Jan 2021 23:37:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irK7eimKxdeP3R1ouTnuW6nOG1Ndpj8VwFdDHxx0rBhl9z5x0MZs+R3LHjjnnHl2MOy42++5HvUrbSU+mBNaxOPmQnUccP+cpx8qqffMQWUIHEkVwhpU6pDw4JX/45+lpyhTp2Me5dglEeSNYl74EkM5RiKREU9MnEFP6ktg7s2FVLre3ESXFvsENkbMUi36FKw8Z8mW0dZTi9VpD43B+q3b0L5DBSEJrW7EOI3zEbTQxDFrxcxl/97ygz6VGqq44xIpTs1HZxUsDfdRv8R2+dVLcW3PGiyr6un+nmtdUJLa0gfpklaVpi+DNxwripQT5u2WJEJsPNpE+SqFe6HiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B71/ITEBGKHtwczG/L3WwTtEosWgDj9T6EFjjg9mCc=;
 b=IyxZTp8Tk0Nt+91UfpAwgau9VF9IjUmx415fuSb1jRIPfpL2KUiqCcYOroZl66pnd8D3TWUHbf7+JRcMRvM3rEnUXxiuGKkXinzfEWkLJG/sw+ckW673U6WZhf28k1i7oTT9J8LWLkgI4juYhBmjiw6o/S6uK5wISxmMpXYpsx3kISeC54o0F4RvWQfaFKRa/1/t8/gKK2m7BnLsPE8JjcC51/TGiaUEWPkzvvcp+h67E4cehYH1XocTCvAz8JavNh2ZltHOuQEubticowJYOrKT9GtL0gTmqV/l1/oeyjEaJHsxhSQargfKDhr83qYtOfL5PDKyPMFt+cq6O6i3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 23:37:04 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b967:2757:6a06:a4a6]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b967:2757:6a06:a4a6%7]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 23:37:04 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Corey Minyard <minyard@acm.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ipmi_msghandler.c question
Thread-Topic: ipmi_msghandler.c question
Thread-Index: Adbl4rhW61oYiA8oSfGIt0aDhmZBeg==
Date:   Fri, 8 Jan 2021 23:37:04 +0000
Message-ID: <CH2PR12MB38958D50FDBA94E2127CA993D7AE0@CH2PR12MB3895.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5d1d08e-76c8-4a1f-e5e0-08d8b42e4e25
x-ms-traffictypediagnostic: CH2PR12MB4213:
x-microsoft-antispam-prvs: <CH2PR12MB42132045658C26F5E84784BFD7AE0@CH2PR12MB4213.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zfu+aY42vAw82IZYmsY8+zh7hfZIMo/IWoO+c82SOCc541i0lBbyUux/IOeiF000SzKJzN5WErBxgViLUyD+Syv9x2GfEeP3FIjksuyLmytq/htMH78A0vF6eNcXVT0brwMtqhSnnuHhVj9oa/IPQnFnPAACInWJP9FDeY9sdS3anLIfCyLZTq32DA+B+az9VPLCrGm9aOF/isPxSwvfwnQo/tsMzTr91VppRvOCFjKiznji2qaBVdYJBR8++eyj/eXtaGsfNuPEe+3QZDKd+ymU4gUs/+fYn6HrpN4MrfL3QiXPzwFs5cvArWE1S2sw4xu6Ic7SYQz8omW6+iXXf3nxu0/V6r3ghXmVkmJKCVN5pirVf2YLvwTLq/YKJO89cOheV8FyJmGdOK1s4MleYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(55016002)(9686003)(5660300002)(110136005)(4744005)(8676002)(7696005)(66556008)(66446008)(66476007)(66946007)(76116006)(316002)(64756008)(2906002)(186003)(26005)(8936002)(478600001)(6506007)(71200400001)(52536014)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oofJSU0A+I7dnmSNup/ir5ZM/AmI37vxCiNuPIj/hp9cop1DSQgHB6P8P7hU?=
 =?us-ascii?Q?GccVb+zbzYicEz20vbY0tTASMICFTahdgnJJQp4BhPBLYQyCnhZbKUJ5e/dE?=
 =?us-ascii?Q?6y2R0yWY0cu0aXM1SIpiAFD4xzjwxoKFHfjbTGNJwSk8HDDkBNTJTIxnJTrW?=
 =?us-ascii?Q?/7y8TUmCCu2jxLfb1b2Qp98HpeepQleeGi+PBwkhJDW88igrpAa5bXXbiwGN?=
 =?us-ascii?Q?S+2woY3lwrK7dGL9220bPKhxt+TDhZwHTylnEG31X/LCz5SgeS8iek7LceTW?=
 =?us-ascii?Q?cH2iXy+jeIt3V1QK9RC/2I8EpkQ4TjXhZPWcgcuVTYOvzUl1G8fjUIuQJ7fO?=
 =?us-ascii?Q?svszIOxMh61dBLDhSwxsXwVyHALnIY0QKxflVuxuRh6iNvMt36oNz5OMlqlG?=
 =?us-ascii?Q?sUKrDO6Y1LE4pLYtIKxX468r/cJrbOzKzWp7wJSV38YrDYKsfmNJRipscFmF?=
 =?us-ascii?Q?kzLHfHemBTgliK6VB3rCu/KlOa7eMDG2O9x8bD3H/n064kzXQkMrQ4/vU0i4?=
 =?us-ascii?Q?K90hTSdHDKu1UT9YeZEXh7MHdZh8gPfIz3iPeNY6uqA5aPobLPGyx9va2ztA?=
 =?us-ascii?Q?xDD8binyQm+fsgfFEJUscUFbZ63E+aGh8sQKTzGw7Ez9DCpHgcVUM4phZKOz?=
 =?us-ascii?Q?ifRoQ+J2AZTgS6+49qyfTsVgRd0ChTD2o3XdA1KlSqDqtv8JywgrhhmYkp37?=
 =?us-ascii?Q?T9CENNdeil+XUgJLmtRq6h1QlaUQhX2R6UecjfhCzX/G9biGjQ6LfPf0A0ju?=
 =?us-ascii?Q?7rWFATo1nBSWIRLF3i2yHLUCvaCJ5QtZ6H7n2Z8AxvVEoybB/iV6JRmFch0N?=
 =?us-ascii?Q?LJD9Wzy6TvN8tgkMkaZVsUgJ57OzRU25Z/ID5DfDFqw0lLpdryreUOXUG8vN?=
 =?us-ascii?Q?KlXLb1dMcjMSsb95arh2keVJK2j/AXchB1Uzwjdq5mm+e85BAClBPM/XgwJO?=
 =?us-ascii?Q?10dTcirq5DLWLdARkxh5FL/WIwPKFGr11YWTZn9ZLHI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d1d08e-76c8-4a1f-e5e0-08d8b42e4e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 23:37:04.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLiwBb692tUIzKri1nr2ADrSzh4netwaMHJQBBixgUvEvIQJh334Bo68a8fefVs5rm+cWaxuz6J9/NbXrJ0QnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610149026; bh=5B71/ITEBGKHtwczG/L3WwTtEosWgDj9T6EFjjg9mCc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
         Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:x-ms-exchange-transport-forked:
         Content-Type:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=puZLCha12Fxi31EUJKVn7TxKCTIclljsxbLbJ8w+HIQaB5CGcovjkz6tKsTKGUZDl
         qxlAh0pL28IawrInGTVq6JKmUk9Vvi4nutf+7hpwkXwNIhijKzBWffd23NjggQ/1l8
         n2w27stfzPmanX64P8ugJbSPvXMJaqX18r23Bx8qT1IQNr73E6LZerR/1oQXdZKjmQ
         +dkOkgR1LVQUM0q5T7mMST7TZ1A/s46qpZwKwi1jgYmtt58SnUATC7VxW2/Nc/SF5R
         3WIts1b/mCiGGRB1ylwZSEt6ztM8mWCiQp757htAV+Xl0PGUr2GvLdXbp5b5wC0IAw
         bARucGxFmESCQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

I have a question for you related to the following function in ipmi_msghand=
ler.c

static void __get_guid(struct ipmi_smi *intf)
{
	int rv;
	struct bmc_device *bmc =3D intf->bmc;

	bmc->dyn_guid_set =3D 2;
	intf->null_user_handler =3D guid_handler;
	rv =3D send_guid_cmd(intf, 0);
	if (rv)
		/* Send failed, no GUID available. */
		bmc->dyn_guid_set =3D 0;
	else
		wait_event(intf->waitq, bmc->dyn_guid_set !=3D 2);

	/* dyn_guid_set makes the guid data available. */
	smp_rmb();

	intf->null_user_handler =3D NULL;
}

Why is wait_event used as opposed to wait_event_timeout? In the context whe=
re the dyn_guid_set value doesn't change from 2, this would run forever. Wo=
uldn't we want to timeout after a certain amount of time?

Thanks.
Asmaa

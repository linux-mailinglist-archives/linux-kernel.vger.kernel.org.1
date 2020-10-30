Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634E22A02A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJ3KRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:17:52 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:56481
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgJ3KRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:17:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCCVMYbQYHAmVfUOr7lm6mhCDRif3ofAmLE1UYhUrlsqquanddMYigY6C2vOwkrfFI1h6HnoTjD4l5SbUXU+antJRKfIZ3vMyWesMhNxMlxymAGsP16pcT1P0KvQigM9L1LyCYi9E4oki7/XQ1+qJcdtaqWqA5IRJq+hM4nVvWu6LHIak2hMtyUWSQMVaQuDFTTtGSZWU3g6HOGVhFPw771T9h5ydQCAMG4fiTT9rsENnzXTepVGnx/V32CnZimfi0Rh0oTdhJ/XAE0GBz98z/7NeksTTMXl3YkzgYVqD2jsotGRcLxGB3jPoUPSo7hwI2qE/k7UERgDP9TlGFbt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usebVktceIoYGgqTzo2Nm72LGONYoa8QJMtCtTVq2n8=;
 b=PuT0jcsJtzSkTb2i+i273T8EcgyqBOe4tO0PIZyunHv/1C9We3815XKMjuh4LaQwUEBDIj68TSA8VD50GfQJHr93RzX5ig5ZB9ZOfPu5FD8tvY25hgth7KgHFokpWjbNgpyWhdaaN3qG18x/ISkLvabfgL7KF8nzL3O/fIztW1VcWdl/K/gxnKY15lEB3s1DrIwxYknrH+u5bNcRasfzK+8ZfdlU2OH6ZbJfsuMZ3486dP0hzLnvY/4uEuEu3vwwFdJgzlcP6tx3eacbzSyK2/uHhgb2ZGTDmkjexI0wAY6mnua9Nz3TM4OmiKhBis14GGaP8POP98cNbg0QlecJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usebVktceIoYGgqTzo2Nm72LGONYoa8QJMtCtTVq2n8=;
 b=RcYsexpptAi37P76MS7Y6TMLcFV4X6OvjkoQ1kWTX/TdmA6VW/1U7gBgsF6vQ2fYADnA1hUGF5NN7w1/B2rB2PJ6pKa0mGUl7qAwRySQY2TUtcJQBPxjQgfAK3NNpwXY+YU5rj98xhUihR81XEfPUkBfPjC7JRYPQUNG8H5jiFQ=
Received: from SN4PR0201MB3472.namprd02.prod.outlook.com
 (2603:10b6:803:48::19) by SN6PR02MB5389.namprd02.prod.outlook.com
 (2603:10b6:805:e1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 10:17:48 +0000
Received: from SN4PR0201MB3472.namprd02.prod.outlook.com
 ([fe80::91b6:5ae:e8d5:2d5f]) by SN4PR0201MB3472.namprd02.prod.outlook.com
 ([fe80::91b6:5ae:e8d5:2d5f%6]) with mapi id 15.20.3477.028; Fri, 30 Oct 2020
 10:17:47 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Harshal Chaudhari <harshalchau04@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Derek Kiernan <dkiernan@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: xilinx_sdfec: add compat_ptr_ioctl()
Thread-Topic: [PATCH] misc: xilinx_sdfec: add compat_ptr_ioctl()
Thread-Index: AQHWq7DXhLHdnUTr2kmvVFzvFhkfaKmv8jvg
Date:   Fri, 30 Oct 2020 10:17:47 +0000
Message-ID: <SN4PR0201MB34725868C7009E7290B396FBCB150@SN4PR0201MB3472.namprd02.prod.outlook.com>
References: <20201026155801.16053-1-harshalchau04@gmail.com>
In-Reply-To: <20201026155801.16053-1-harshalchau04@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5c9fb00-c55a-4a76-0eaf-08d87cbd0ce2
x-ms-traffictypediagnostic: SN6PR02MB5389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB53891F251F8DC097CACA2E05CB150@SN6PR02MB5389.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WmJNZBMuvMTgXp+NvBefZdgRL9zoIhD3aoWBLGL/Mckg4z6NKWRC1Nn79jaPqWQGMKsJvIussyDaQq0ztZ53eF5EBuZc10WP3bSfSyuqAA344cbiXQbk/mdyvMVRBb2RBtCDKwPYr2JOZ2RznN3RVs+yNSSvl2ftUcd9DfbFShbLAlRj0ZGujKNcxAzdPXZ9hbzaKK6AjvZj/7ltPECRYP3m+SH319OhEiRarWcjAMtapGdWbo9WN6/sRgm9VdfAsqkCUaHHutgehlNGyHPxVCbYHaWwzxhPPKpeEmApIKAdjK+tfr+EisicYBkquP9ObJBPKagGlr7OD+gyqwBddQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB3472.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(66946007)(76116006)(66476007)(66556008)(64756008)(86362001)(66446008)(26005)(71200400001)(478600001)(52536014)(186003)(2906002)(33656002)(110136005)(83380400001)(4326008)(316002)(54906003)(7696005)(9686003)(53546011)(8676002)(8936002)(55016002)(5660300002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: e6jG0ZN1ia839PJrQkCWd48zWRFYI7W74BV4jo2J9VMzsshW9avfkcSsVVuuJMbVA8MjjgDEhNAiD+sJLjdfVUb3+3L6YOJl9du/5TAFAle9La8TgPjWoO9CZmFiYzdfpMwQBm7Q/cTwbgffvCx6CfKWdtYO9rT/kMFS/FsRYKR/Jt2w+SDHug3ynwWOumUdKz2cDLwZW3ckBDoYQCZRfOMu86NuEz8G2JverRhmFjakTumBOqmT2RiLyTe7LQjbKTxjR/6SHtx9IL8Q2quXhpcIWeeedRT6xWbxMlib78JB/dttaY26ziDlF9wBrilMBqehMapHHIwEVY+9/EZKUrdIIHxsm2M1xvsjXYfAJJKHITPqHcNXyMGDfdynbnNOUxlg1sAPNf8uxJ7V8xQRvwv3d9ZfCUZtW2k07TQ8/7aL9k9t9GkuSJG1mTl84+/bfgv6Fh6kV0DX21nFjypwy2L8T9E1LQ6JQRqSEhX9C5ihFS7qm6D0a41SBZWhqTFaWzhOxwfek4tC+XO7tFO2u2EFn+Rjhj2K9B1Op8tZ79WgCWQqFPyRKr+oPXO7azFPMqxM/iHIZR4nPiXGBUiKhdOYgsClGv1jGv2G/j2YIigJWkSr05cttm2WNBuc0mvx2jnZUwX473wKZY7hqV0TAA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB3472.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c9fb00-c55a-4a76-0eaf-08d87cbd0ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 10:17:47.7341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aa6os0EPMg8Jn2fEI4+c4K8R9r/LQfGaoTkw63iqB8N4O3KtxXgZtAaMPWDHHTG9uKqrBv5y3HUg1EXE7697Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5389
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harshal,

The code change is fine, no comment,=20
but testing will be done at the beginning of the next week.
Sorry for the late reply,

Regards
Dragan


> -----Original Message-----
> From: Harshal Chaudhari <harshalchau04@gmail.com>
> Sent: Monday 26 October 2020 15:58
> To: gregkh@linuxfoundation.org
> Cc: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.co=
m>; arnd@arndb.de; Michal Simek
> <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-kernel@=
vger.kernel.org
> Subject: [PATCH] misc: xilinx_sdfec: add compat_ptr_ioctl()
>=20
> Driver has a trivial helper function to convert
> the pointer argument and then call the native ioctl handler.
> But now we have a generic implementation for that, so we can use it.
>=20
> Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>
> ---
>  drivers/misc/xilinx_sdfec.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 92291292756a..6f252793dceb 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -1016,14 +1016,6 @@ static long xsdfec_dev_ioctl(struct file *fptr, un=
signed int cmd,
>  	return rval;
>  }
>=20
> -#ifdef CONFIG_COMPAT
> -static long xsdfec_dev_compat_ioctl(struct file *file, unsigned int cmd,
> -				    unsigned long data)
> -{
> -	return xsdfec_dev_ioctl(file, cmd, (unsigned long)compat_ptr(data));
> -}
> -#endif
> -
>  static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
>  {
>  	__poll_t mask =3D 0;
> @@ -1054,9 +1046,7 @@ static const struct file_operations xsdfec_fops =3D=
 {
>  	.release =3D xsdfec_dev_release,
>  	.unlocked_ioctl =3D xsdfec_dev_ioctl,
>  	.poll =3D xsdfec_poll,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl =3D xsdfec_dev_compat_ioctl,
> -#endif
> +	.compat_ioctl =3D compat_ptr_ioctl,
>  };
>=20
>  static int xsdfec_parse_of(struct xsdfec_dev *xsdfec)
> --
> 2.17.1


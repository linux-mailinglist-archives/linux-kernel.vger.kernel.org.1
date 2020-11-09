Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971EA2AC1E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgKIRK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:10:28 -0500
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:64319
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730010AbgKIRK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:10:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PH5pUCsTWO6N+pFNpTb+3t2u7Bu+0hwecSPpSQZWXQE0njzIVgM88Sk3hn5EHVXZBp9loIuBOsAlhESuVgPjZc1+ClkH5z1W/31EGORxIA1IM5K10hWEHxyrMGDUjefj3amV6kOwUcxWUr5rZo1i5qMI4lp+foMqecfzRHus+G+DFrnibN3Kr4kc0YZVpr400ptfPtLHpTXg8JvT708RqCl9REHSxeOKT4hXHzxItKarvRO+4UfemkM8Hkm/lC9wVUKAs0sUqjrGlWLL8HTkJ3BWU8k6ZA7HGXBW6lSG2un6zqrqkTTZcVQWl0ntcaLSGsHnJSR2LmdelLp0JClHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x141PXCGXcppZFpzpt5ScF0R38JNdnQhjI1qziZ1HAM=;
 b=W7hR9XAzmkZ5dBXMlTFQBc15VBj6pRkpAK/jOBlyq9DQTzrHpeDftef3Nfk+23/Lwx4IEEBqmowlyC/qJxnrmahvZa/rlKzIaH8EA2J0vH074mwnjAzwaR6OITjT05ZwtUgY+RIGyLWrQVBQ9xxTQRj+De2LAo+2rs3wag+SjBSe1wfTX7ufRi+uJxKtbnoL3krsZvd328bn3VY4dmBuiPitTOFsWvo4OkjCWHQ6oNiueBg96QSCLWAQUmNiSEEB51TKRqwVnSLMfIQ9VsD6kGiTCnJl1mcuyoSL5Rd03ZPl+PqTNm0NiPB/UqN+zkmPiystikSWA9Eh5FV5s/Z+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x141PXCGXcppZFpzpt5ScF0R38JNdnQhjI1qziZ1HAM=;
 b=AX4bJw2PdNZMiBOQ+nlwSbJy0CjhBmJSfSuloJOG1kPaUiN1ojYJpf9VV43J+jHjuAxIqCXgqR0sNOvp0e1fXPr9gQvzsXSLPAUpE2f8IG3vmYMZm2DlRNY2rJ0tPUJrGvXt9h7BjxDH+RIjaBpuD+eLhLJkdmPVbKYT/bVTwr8=
Received: from SN4PR0201MB3472.namprd02.prod.outlook.com
 (2603:10b6:803:48::19) by SN6PR02MB3949.namprd02.prod.outlook.com
 (2603:10b6:805:39::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:10:25 +0000
Received: from SN4PR0201MB3472.namprd02.prod.outlook.com
 ([fe80::91b6:5ae:e8d5:2d5f]) by SN4PR0201MB3472.namprd02.prod.outlook.com
 ([fe80::91b6:5ae:e8d5:2d5f%6]) with mapi id 15.20.3477.038; Mon, 9 Nov 2020
 17:10:24 +0000
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
Thread-Index: AQHWq7DXhLHdnUTr2kmvVFzvFhkfaKnAHuXg
Date:   Mon, 9 Nov 2020 17:10:24 +0000
Message-ID: <SN4PR0201MB3472051AEFD34AB114827ABBCBEA0@SN4PR0201MB3472.namprd02.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 72acd98c-9e98-46da-a543-08d884d25957
x-ms-traffictypediagnostic: SN6PR02MB3949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB3949369978D719A9B65C724ACBEA0@SN6PR02MB3949.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2gIjYb+SVZcRWlrmsITi/D/NkKKluD0X06Dt8m3N2C/9G4YY4uS9cPIsymObjiQAcLdqQl9/DW2QUXEh0FRc3LaPfJ/o4yzvGnfJgBaINEUEYHqqMzbpZtBAVfZ2MrEhARb8VYkcV8mAzM2bqpnch44O5O455cCNIWGxrOnqnFr01FrcXZbWJFwaiSwSmtEtdi0HSr/fkB3I5BTFU//5sIvAn4beTgfg6silFajI/e583JNwIcRgYbffFlVYPYaryE2mgdPs5OKUn53clENI0h9ujxf6vhTmoiSsBNeFEKumvrUGiVNeOa7uMspvBWX+BepOspiTFH7b4Oxo4XS8aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB3472.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(83380400001)(8936002)(478600001)(186003)(26005)(4326008)(6506007)(55016002)(53546011)(9686003)(7696005)(8676002)(66446008)(33656002)(64756008)(66556008)(66476007)(66946007)(5660300002)(76116006)(316002)(2906002)(110136005)(86362001)(52536014)(71200400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ePqulB92SdTfAhNYdBUVe1RZSCKRnKnQcBeQot83Tyeg8wVJocRyKr2lf34KXYEPKFpJOPAOjfRVTZzhffR7ccJH8cepMnItU2h0WkF0ePmTx0E2X2wI3qyzf+H6T+2rA0JkiO3SONboWDLSClBFLe9Or9DW90DKdRBQ47MdeI1twwpKTrm7I/1J9WMB2BinHdOWf7rqEN2bzuqphvvVvzDZ3cvyoF0VJlLWEXTvgXNVobwMHRiA0kLsYT8W2EHmMKsFSjC7xS6Tt8XUe8Kwo5nFV2KrBOWn082AXQ0NCCp7LP5TOosG3cKf0vPRJ+U3bH7KI9aE+2RLfWVoHtOjtHye9IVrcvWb7g72Py/ZqkLsBxo0+9siw9MqeEWna/AeLZHn4fm/X22bU7mShIEaxVLJAjcMmQD9tXnTAY8Cw2cqh7URoqQ47cA8Q4slbGp5JU6Bwvvo9dGtrCWgYP3jwb2oHyqrerYGlEiOaAbzxlI8a/KDvEj+DTyTkonRd8LiCWH21Zv3H0zTxVI8V35dFY3JiSAru3+AIfrKwJMFbWvO82IqwD78RGpRpJaPOU3hgyih4PsvzPE41F4YUw0PBKf0IYk6kpTY9vtGNomGevLXtuBJ/0DfSZiUu+ZHReBMi1T88UMVyObsArt+rm3egA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB3472.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72acd98c-9e98-46da-a543-08d884d25957
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 17:10:24.9100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uo0O5t8O773+xZyMuui/4tB+14LYstsefXb0WOyfBR2hJdG0v35QJiVCegU8qVlhVsJHD78AFZJ00DyFCzYEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB3949
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>


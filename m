Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432192B7266
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKQX2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:28:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:61718 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgKQX2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:28:45 -0500
IronPort-SDR: Zd/f6cFb+G/sFkmgxdMTerv3RWCiB7/ptBcnZQkDB5tBum2ph4B9Cfn3QgL6OO868JxqqLUAef
 ijIXeud6EKyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158806428"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158806428"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 15:28:44 -0800
IronPort-SDR: Kwh6AC+TGcyeXWTb8OByHlCE8Hk+LhNjJyFl6uMAD2cClhFuigkliaLlDTXQIv+3BWNShjfwBk
 8tBw4ofwVF6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="476100590"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2020 15:28:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 15:28:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 15:28:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 15:28:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2ixfsl3Lv4l94ZJHUdKH/V6ftwBksu+rZyeLjky7NqLi54eITTY7aLJoL19wk3lzwjHR7d86o/c5Bhj/N+yeKtJLyNp4d5Zk0P1C8GrCj8J1YLNxIH0gWCHioGtlNvDh4DIVHFrtaAOyRvoQ5fijlztknMe+O3/0c87lj0W1Jaqfa+QT4uYn65EcruLLps4j2h6sntnIRPlC3SGIdqmnYabDkheMMsyP5fXtxU/Hg3/889Ywm+ij4cKy8xD9uQIt+5MmipwtXFjrrAgK3qiqJHXfCg7lf8U2YOD+C9Ck9vvthhTjxD8OXlmG1LjAn0i+PexaqbkvpmjF+IZ2AoUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrANTlxTyPKMahYwyBB8Fetu8ghDqCO+Urjz4zw1GPo=;
 b=MVnDurOZxIHkiEbsziQP31sDNdc4gnyzRMV5vwiipJe6xMerOuXiYEnBUQEqJV2KKznMz2rWkBkTe9VBB+psy/9mf0n8hRhVBgE6kAevk2IaM3XyY1708w+LdruCmqC5JEcKldqC52c60xmGufkt/cGje/uYjjcOhoM+ItgIKufvqrTZJJxaDAtPOwNqfwj6jCLAhV5YPA8p9epnmOlailFu5Kl4nC0FrOK03pE7BYUgdMCfGo45s+MDKZrjHEvP2eHCxXXSkfQDnb6R7wlc0qFVOPHrLe7POwkHatHjqGDxlvOSuiOku+NlslHNNnAZ9fWsO6I/9upAr8BI78zLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrANTlxTyPKMahYwyBB8Fetu8ghDqCO+Urjz4zw1GPo=;
 b=cZ8Iv+TZ6G1NY7hgEUY18KKUVbM+nWt0kZIfUjMG3uLqoUGoDaFhP/S6RmPsUDLnRN8hy2PAv7ULfYLcZrkbQmFUpg0aGZQ3ZqXcHJjmGP2A4qC+ljCBX99AjEblmTFogmtEDoV5agAnvdFSuSblije+SJjgwur/8UydClmfYJU=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MWHPR11MB1984.namprd11.prod.outlook.com (2603:10b6:300:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 23:28:43 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.028; Tue, 17 Nov 2020
 23:28:43 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Subject: RE: [PATCH v2 5/8] usb: typec: Use Thunderbolt 3 cable discover mode
 VDO in Enter_USB message
Thread-Topic: [PATCH v2 5/8] usb: typec: Use Thunderbolt 3 cable discover mode
 VDO in Enter_USB message
Thread-Index: AQHWuftciqlUTahejUqMxUOZ9NQlpKnMQSQAgAC9BJA=
Date:   Tue, 17 Nov 2020 23:28:43 +0000
Message-ID: <MWHPR11MB00482D9AA8FF011EA8A859AAA9E20@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-6-utkarsh.h.patel@intel.com>
 <20201117120952.GE3437448@kuha.fi.intel.com>
In-Reply-To: <20201117120952.GE3437448@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.39.100.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e842c5c8-dfae-414f-6ec7-08d88b5085f9
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB198485F436ED43FF57B2F487A9E20@MWHPR11MB1984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2uRk62yS/lc78WRC8WeaDbOmPLdX1ZTbBFcZoop8ChwLHiV7JzxMkXLtanU9+EwmIgnfCUvAFTSFREAsZIsLUkdNUCytrF6Oh1jzQJH3GBRtt2eXAE3UJ3F1zcJtoqy4xBWvQZWi+N5B0/4r7zT1phFzDUy0YJA6yZFPbowg+qFzX9TeLsh6GFCWU1H0YPoF/y/iC8kd1INmgAZ3JidyoKl58Zi6r32YVOHResCneE4dJJAIZZNeQuVL7SdsV8ib42JxfIrFV5hiGFwBaNalv0lB3rL1U7S0NDL9WxqbXOvp/ksas4Uw2vXuQpxtL6Vk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(15650500001)(2906002)(55016002)(86362001)(64756008)(76116006)(6916009)(498600001)(4326008)(54906003)(71200400001)(186003)(6506007)(33656002)(9686003)(53546011)(8936002)(5660300002)(66556008)(52536014)(8676002)(7696005)(66446008)(66476007)(83380400001)(26005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: StIDjUCI/yh45LkDKJ4+Lah5DQilX1TL/imMccPeDGURNWjtwFD6xbMbtK2r/1NDsYHkF2hgZJZiEDJNECfi9KKyPwOFZkuSfM2L7Ai1YjLrXoQWmfw/ItEjoOeDrkLlUnZrqt0fzfpw+PpmWsJcGEq/b/OhNtoHFC3KUhuWqYt6dNSAljNsGTmjovL8iURTmxTSt2t+ATii9SuuIH0i06CSOP9MhY6xKaY+d5fMLC8CPozG/eLoDsyQP9/CEqx0dkCp6Ye2QJnY3xr4YtC0t8CMJlSHQF7vMzOcdZIhuw8AQUQW0MPJHsJdJsYszMpjXVTC16B59DDqisU/DIP5/5mSvaUIY0w2HXPSTL2ZscYy3DmOjR6kbAfKC5ZsPcg0jkC4gAtWwWgvgVo/MU0GglUA0JIq6QTrIgdYx8WuLyF1MkWUkcYALD2AhvhiCks4oR6XxVqqh7SY4r2/HswF03lqLrUJIU40Ni922E9H75G/daGcV6ZkKLuwPwWvUxDy+UJYyYZcrWsFFhEAvb2Wkh0H5fQHZEu9YXCRvXfOMlkz7NbmhtdLS836HSBFhPvJ2YP7oG+LqdznP6RDgF4MsGSPvHK6eBfJUhNcuts8CfQr5MhtdU83YqlZgkgwc3q1HhtOoVowqKS6/s8z+qfi9WY15CySnfLmhzLdhJ8qgT4Gtayt0A4vmLNq5PKK+YUqSdEKskVmG6U6Jzk0CmwNUV2Jx1D/c2BqksXScJKG8m9OGXQXRc64EeQI0pDNcXU6iXjrs7CFZQGqW4+y9CaA9Yxr4fEw7czfNv62ms2YBjasecO7iA598nzq5JwUqHk4q0/Pff8oDzIuy6W7vWyYqexQRnqIXAcl9Zwm/cKp6WJl+Yf5GYxdgnNo71iEnnY4arEUBR7cYKQpqQu+WZ+ZeQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e842c5c8-dfae-414f-6ec7-08d88b5085f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 23:28:43.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiPPxBLX91Bbpov4FZ3lFqiHfrlr5Y4Y6mwzBLRGBw4RhjvFOXxet5FY9VVPj+c786U2QByDSyf8WEt0/Esqs+Z/wFzYcHmdsEWwiMDb6pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Tuesday, November 17, 2020 4:10 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> pmalani@chromium.org; enric.balletbo@collabora.com; Mani, Rajmohan
> <rajmohan.mani@intel.com>; Shaikh, Azhar <azhar.shaikh@intel.com>
> Subject: Re: [PATCH v2 5/8] usb: typec: Use Thunderbolt 3 cable discover
> mode VDO in Enter_USB message
>=20
> On Fri, Nov 13, 2020 at 12:25:00PM -0800, Utkarsh Patel wrote:
> > USB4 also uses same cable properties as Thunderbolt 3 so use
> > Thunderbolt 3 cable discover mode VDO to fill details such as active
> > cable plug link training and cable rounded support.
>=20
> I'm sorry, but I think that has to be explained better. We only need the
> Thunderbolt 3 properties when we create the USB4 connection with
> Thunderbolt 3 cables. With USB4 cables that information is simply not
> available. Claiming that USB4 uses the same properties in general is not =
true.

Ack. I will change the commit message. =20

>=20
> > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > --
> > Changes in v2:
> > - No change.
> > --
> > ---
> >  include/linux/usb/typec.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> > index 6be558045942..d91e09d9d91c 100644
> > --- a/include/linux/usb/typec.h
> > +++ b/include/linux/usb/typec.h
> > @@ -75,6 +75,7 @@ enum typec_orientation {
> >  /*
> >   * struct enter_usb_data - Enter_USB Message details
> >   * @eudo: Enter_USB Data Object
> > + * @tbt_cable_vdo: TBT3 Cable Discover Mode Response
> >   * @active_link_training: Active Cable Plug Link Training
> >   *
> >   * @active_link_training is a flag that should be set with
> > uni-directional SBRX
>=20
> Please also explain the same here with a short comment. So basically, if =
the
> USB4 connection is created using TBT3 cable, then we need to supply also =
the
> TBT3 Cable VDO as part of this data. But if USB4 cable is used, then that
> member should not be filled at all.

Ack.=20

>=20
> > @@ -83,6 +84,7 @@ enum typec_orientation {
> >   */
> >  struct enter_usb_data {
> >  	u32			eudo;
> > +	u32			tbt_cable_vdo;
> >  	unsigned char		active_link_training:1;
> >  };
>=20
> thanks,
>=20
> --
> Heikki

Sincerely,
Utkarsh Patel.=20

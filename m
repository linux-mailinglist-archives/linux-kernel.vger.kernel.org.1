Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6B2AE5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbgKKBiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:38:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:38076 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732564AbgKKBiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:38:46 -0500
IronPort-SDR: wSD/yDbN6a5TIXVovTfVJsJ8/jV39BOZqelmcxH+5I4pzAD9/I3PjMYVmhzKGDd6FfX44Fpoxu
 UBA1v1T/cYhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="188054434"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="188054434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 17:38:46 -0800
IronPort-SDR: hGryR4Ni1m9yUzAm4dB8MG5hZM0pgD5ORjFZStwPm00NuM3hUemp8rge4SgdcbBstDIWJPxbSy
 WdhBKnsFoWNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="428607109"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2020 17:38:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 17:38:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 17:38:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 17:38:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeP5mkynihtwaFyu6RhiCg1OT9Y/O8uZZlxLp/ceZ6tWj+arOKZV7SDILMgYVnHYp8N1cLtFviTj8fj8Lw9EXg/wKzTnd7c9E5tzPJOBSnq2rznwAbpbS9HpdXul15uebGdkRvSXJbEYQAYB7JwmXS15qIEncs9iyoNxCEwJzgqynr8Pk6gWzT2lC4oPSad28Cxy5VsdArWg6UpMLRTeGJnyaFKmbsstOYJc+Z0Zh+ZUDRnv7SxoD7Q21yTfaQ5K1ZwvA8jC8f93hEtjBmZoNGUgHitSnzE0gUWUEubdfNf+1LqqcsZQ7sz71PfmEZC/SnRBzLgNCzuRrDvsCRbxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os2n82maRV/9RE+WJpeDmBw4hUfnNzlhkIU7p0MSDvg=;
 b=kA4x1QeSiPU2NArAxYXcflUVJ/89yu2bPQeKBQqxXY+UIUbT/olWlikIj85IrTfKHXWHn6nqUYgltM0piz5iafCpLynO/S394C6WC3QlNsStvn+PnbW8gwMF3cS4/7LX9WLminSgRwZKAeJipUWvg6EPl3Y6qcbogZ6fjlZCM6dxw/7P/wWaU1EyFNd5KNnzjBSeHjsaximc8HXt7kkv6cRDIqXU/bbFplonJPtPVlhqz5TPpCpFnp7thr/fQAYmRyGUjTeRF0/rQiB0Ykea38unE2SCmg4dB9WYn6NZRV4b2/+jgK5LfHJKBEGXy3WzaFRGXqG+lD9xjvDtl4t69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os2n82maRV/9RE+WJpeDmBw4hUfnNzlhkIU7p0MSDvg=;
 b=I4hyVPn5L6PdeZvkKkGFdZFCJeMO0wRvkwljd/xxQgH9QL/cY6j3fuQ/33C3mQHQryAY7KokR0R5z2KkG0NfO74zDYemsR5Jz8ttDs97rgg3en28CJ+yvRk5t5A67HrVhufXpogNdLX3XfcSltrDnxSn70ISYvRWmcqhG2aFPV8=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 01:38:44 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 01:38:44 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Subject: RE: [PATCH 4/8] usb: typec: Remove one bit support for the
 Thunderbolt rounded/non-rounded cable
Thread-Topic: [PATCH 4/8] usb: typec: Remove one bit support for the
 Thunderbolt rounded/non-rounded cable
Thread-Index: AQHWtvngzcAgg0YK1EqHP909A/hMtanBSZ+AgACAzCA=
Date:   Wed, 11 Nov 2020 01:38:44 +0000
Message-ID: <MWHPR11MB00485EFD8830E5D77B7B8193A9E80@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
 <20201110003716.5164-5-utkarsh.h.patel@intel.com>
 <20201110121951.GM1224435@kuha.fi.intel.com>
In-Reply-To: <20201110121951.GM1224435@kuha.fi.intel.com>
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
x-ms-office365-filtering-correlation-id: 22550adc-bc47-4dc2-a982-08d885e286fd
x-ms-traffictypediagnostic: MW3PR11MB4538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45385CF4C0B2910D6B220D9FA9E80@MW3PR11MB4538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nnFw6pO5zop47vsMayVFyf651wsyDjcT5GrrOND2RNlmwO7igxtTX4265n8NjE/3Pb+tstcuRcsAWET2p2Af0rUR9Q/bN+C4YaXILFHFx2JG0JDZkEeTjRzpJ4urcwoi8eqa4vS5iAV/Jj4cs8AAJIhj01DsVNntBi1kB4dvCKTU1PTFY+dkHKLFrZOeMbdTwcgnggoQZZNENQkiw+wuCfDkW51R+/qPJO1SjgrqX+VBsOr8r8DLCb0lXQyrXjWQMG/u08D8nfeoMaFLMsnxrxV0aLxU4l9toupekOK4530hUsBwSfmwTxkUawa6KCMbaaDi8uPHuPgCqjElxOp+6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(6916009)(52536014)(66946007)(8676002)(71200400001)(9686003)(64756008)(2906002)(5660300002)(33656002)(66476007)(8936002)(76116006)(4326008)(54906003)(316002)(53546011)(6506007)(478600001)(55016002)(86362001)(186003)(7696005)(83380400001)(26005)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +152BSbv5ox0bojXZTK48SnK/XQA11hTgTh3VaGaSB47jP3ZvXcj3IOHnCi7CSORNxPSFD/x6tnQiySmZZ/HDoZcKZpaUOIGYmZ1jkVxFoFUUjiEOEYrtjyBFOPjyf1CLfgfDnt0lIgQfSQXeK/6MyrT5iZ2bMRHlq8b39rH3JqGaJWONugkarI32EEevulOV2q9a4TYTvBK5q1loz6koYrTSIzvhT8uNMjCsPM0Bej3L5D4znTk8Z4y6WoEkPN+db9XmG2VeYezPT3nhCGgST+T4dGyk4Nr2RtKnajVQ+8caGOmlfZ+CVfTcqT2YUQ0Cl9PIAkoTpiaV8fghEzoiJFff8Z1WMEr1ktiahrOdR/qZFUFjQF8oNOjgOrkXdO1WafJrSZgJFibBgNif7GmWc08qWAeMSPLwqPWCL6O0GJ+5jfj8XgkMFw95D+nGrNAKb+vvBhCaNgfPoa+RQZ/eOIM78E3XspZzhDpZTxMgNbrUZzYyAjbKyv1hUTvFGXwoNg+bYmPsUb2xOGvs7OUGeTPSgZ8CQBUo1rWFXGj7SBN1h5CYgEr0dTi2EEurPEKj4BHwJwGIa+G4hwATsaUhC3OdG5cGhePLYscVix0VrFi5PhRTMHrx/pkOfKm9wuXIsF7tYFGeNIxN6SP/RrFQC1b7LwZPmNZk1sPQ+036lRnZbeJRedaP0d5WxS7ZlU46EKA41PgE6sqQPtYSkjyLI2ogLqCvexdj7IWTyCGgC6JAoh5jie2sKR7jscsLYkEU/2inZqVzH3OrcBPIUqvf7nm2uq73gw+PrrwLJb1njwDHqifZNe3gjsEqfBMaM95+j9ObecN/pTDcJ/t2um2HNJAc+2TbsmR9nNMAfIp4kG3c3+No7gdvH6QfWzOd5+DAywhYeNApJGwQsB1SqY2Eg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22550adc-bc47-4dc2-a982-08d885e286fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 01:38:44.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FW63qkjIXw6FqdudJqF+3ak/GwdOC/NgsPLl+GN4wLHWVlb4Am/wzDWii/AXryCPh9SRjugZeyrNR2IavuykwvzvqUoE0hhElmroL0XU3ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4538
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Tuesday, November 10, 2020 4:20 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> pmalani@chromium.org; enric.balletbo@collabora.com; Mani, Rajmohan
> <rajmohan.mani@intel.com>; Shaikh, Azhar <azhar.shaikh@intel.com>
> Subject: Re: [PATCH 4/8] usb: typec: Remove one bit support for the
> Thunderbolt rounded/non-rounded cable
>=20
> On Mon, Nov 09, 2020 at 04:37:12PM -0800, Utkarsh Patel wrote:
> > Two bits support for the Thunderbolt rounded/non-rounded cable has
> > been added to the header file.
> > Hence, removing unused TBT_CABLE_ROUNDED definition from the header
> file.
> >
> > Fixes: ca469c292edc ("usb: typec: Add definitions for Thunderbolt 3
> > Alternate Mode")
>=20
> And again?

Ack. I will remove the fix tag in v2.

>=20
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > ---
> >  include/linux/usb/typec_tbt.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/linux/usb/typec_tbt.h
> > b/include/linux/usb/typec_tbt.h index aad648d14bb3..63dd44b72e0c
> > 100644
> > --- a/include/linux/usb/typec_tbt.h
> > +++ b/include/linux/usb/typec_tbt.h
> > @@ -39,7 +39,6 @@ struct typec_thunderbolt_data {
> >  #define   TBT_CABLE_USB3_GEN1		1
> >  #define   TBT_CABLE_USB3_PASSIVE	2
> >  #define   TBT_CABLE_10_AND_20GBPS	3
> > -#define TBT_CABLE_ROUNDED		BIT(19)
> >  #define TBT_CABLE_ROUNDED_SUPPORT(_vdo_) \
> >  					(((_vdo_) & GENMASK(20, 19)) >> 19)
> >  #define   TBT_GEN3_NON_ROUNDED                 0
>=20
> thanks,
>=20
> --
> Heikki

Sincerely,
Utkarsh Patel.

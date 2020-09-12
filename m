Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4DA2676E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgILApt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 20:45:49 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:25409
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgILApb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 20:45:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBfeFRQ1KZUYd+L8bo2jzsK+AUh9kr7BMGq5v//v/Hx+jHioWg7Ym7NDZZnkz78n5JySyWYP8olkA0fLNdPZfIYQaXpW8rroEmsQ9rjZXKt1Nkyc11xYzRQ0RgdARZ90uwFjC02GxJi8K8jiNM4hyj3w+drqRQwwzfv89d6+1zYWVt73WzF73JywqdOrg39X/iQxaEAmi3++lNDbk0vECVBk4hM8d4/E/uJuFc8+lslM8HevdglCE/pvSA+VuZPzLYk+SV9kCR5l9AtcUxA4sv1+dJzs0zqqPJS7BRcl/En2eW/oJxHzjRV/XAXzmPOjHznoguxz4T2buxQw4tfUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E6dZcpzmvkIRclN2O8w1l45AIh9cWmgFsfAkoCwb34=;
 b=i1WBzuQgve+JeIagAkzy17amD7IvbyR58ntGAHKHXSLwQQaSRTZdpp/kop4L16Mq35spfEPYsTSftN3MPz93v70ajASomxEjgRoLVD5hoEdVfkylrmA7t1FFSI2ZDEpVpcIk19vX8itOjC1iTarwhRgMy0Wpn/+kl6BiEItTE12MN0k1xHU8C3ky7Tqe7WSX1ONM6k9x5KyIxxGS90wP6CbCVBlHLNea5jRj5O66Vnw3wJYSWpemY5z3WklGeNPXPv5ztU1iXmz1p9rAVkIkIEdb3GT0Z5BL91swGYGdYaaXndpjp90eMy9YDKqngArJzauYTg6j2WmGr/AjGSEpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E6dZcpzmvkIRclN2O8w1l45AIh9cWmgFsfAkoCwb34=;
 b=GHb7656eXm+cscLLMsOcOc+xuBCv9oxkDEZVc4ueS/VhX+8UNBAlmfwC78a5/9JowGJ531OL8/MLJpiDmlU1WVcGxBIcYEpuSunqy9DiyVC9rLGBYhxqmSw7Y3lSDykfrHC/Xer6KmsBwsC1dT4zuA/hEUTvYy9f5SY4k7qQNHo=
Received: from MN2PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:c0::39)
 by BY5PR02MB6641.namprd02.prod.outlook.com (2603:10b6:a03:200::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Sat, 12 Sep
 2020 00:45:26 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:c0:cafe::9) by MN2PR05CA0026.outlook.office365.com
 (2603:10b6:208:c0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.6 via Frontend
 Transport; Sat, 12 Sep 2020 00:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Sat, 12 Sep 2020 00:45:25
 +0000
Received: from [149.199.38.66] (port=45848 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1kGtfP-0000rk-Hp; Fri, 11 Sep 2020 17:45:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1kGtfQ-0006LC-Ot; Fri, 11 Sep 2020 17:45:24 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08C0jGPX005819;
        Fri, 11 Sep 2020 17:45:17 -0700
Received: from [172.19.75.82] (helo=xsjsycl40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1kGtfI-0006FZ-TI; Fri, 11 Sep 2020 17:45:16 -0700
Received: by xsjsycl40.xilinx.com (Postfix, from userid 13638)
        id D6F3B352C02; Fri, 11 Sep 2020 17:45:16 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:45:16 -0700
From:   Hyun Kwon <hyun.kwon@xilinx.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jason Yan <yanaijie@huawei.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Hulk Robot <hulkci@huawei.com>,
        Michal Simek <michals@xilinx.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm: xlnx: remove defined but not used
 'scaling_factors_666'
Message-ID: <20200912004516.GA3814876@xilinx.com>
References: <20200910140630.1191782-1-yanaijie@huawei.com>
 <20200910181418.GA3187626@xilinx.com>
 <20200911081519.GM438822@phenom.ffwll.local>
 <20200911162708.GA3715173@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911162708.GA3715173@xilinx.com>
Content-Transfer-Encoding: quoted-printable
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f19fd4-e733-43b7-45eb-08d856b5231d
X-MS-TrafficTypeDiagnostic: BY5PR02MB6641:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6641BB4319C42B9A66C29B9BD6250@BY5PR02MB6641.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdZ+J8D6HmQAoiOI5lTbP+ww1Dy278hy+RnwCFxbE2J3qxDpmG040e0JwAwu/l8NDWwgKT98gpTmtZPQCHc6KJ0MeoUJiUMPT/8M3gWbqpHCRrqYqSfWcrmNQdeGRvjaSuDy/aB2h1YLpDPFRSkwHWNwWU1v6aHmCZgf6huTqyHLP6KFmnVmxwp0O4flZ43sGrAvXAnyuOa7zL09TLkMxaP9KyfQxCtkIhl+nGar6rHuVviHeV2otlQO20vdNWVXnCcIvxnAAl89P4Y1gjMrmx8yKKEyUyx8Tx+T7dY1vS0TX8VxgHCJP2nr2ruogBsdjBNVlB6D5wVpfaivoevLDNUkX5ET9NfMdMmeg4zbly7Vrnf0N6R/QuRhOHViVl7r11HnR7keyKuXuGRBQuUBkiwZP6gFAouEJSdo+rHXfwmefPb3SAXbpZZPA5iIJt89sKSP3MFYsaWgGBj0gYQyAelTa8FxNorxnIX0JSCrZW4=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(396003)(46966005)(8676002)(47076004)(6266002)(33656002)(44832011)(8936002)(4326008)(2906002)(336012)(966005)(316002)(478600001)(1076003)(6916009)(426003)(54906003)(70206006)(2616005)(82310400003)(83380400001)(26005)(356005)(42186006)(70586007)(82740400003)(83080400001)(5660300002)(186003)(36756003)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2020 00:45:25.1005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f19fd4-e733-43b7-45eb-08d856b5231d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 09:27:08AM -0700, Hyun Kwon wrote:
> Hi Daniel,
>=20
> On Fri, Sep 11, 2020 at 01:15:19AM -0700, Daniel Vetter wrote:
> > On Thu, Sep 10, 2020 at 11:14:18AM -0700, Hyun Kwon wrote:
> > > Hi Jason,
> > >=20
> > > On Thu, Sep 10, 2020 at 07:06:30AM -0700, Jason Yan wrote:
> > > > This addresses the following gcc warning with "make W=3D1":
> > > >=20
> > > > drivers/gpu/drm/xlnx/zynqmp_disp.c:245:18: warning:
> > > > =E2=80=98scaling_factors_666=E2=80=99 defined but not used [-Wunu=
sed-const-variable=3D]
> > > >   245 | static const u32 scaling_factors_666[] =3D {
> > > >       |                  ^~~~~~~~~~~~~~~~~~~
> > > >=20
> > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> > >=20
> > > Reviewed-by: Hyun Kwon <hyun.kwon@xilinx.com>
> >=20
> > I think you're the maintainer, so please also push patches to
> > drm-misc-next. Otherwise they'll just get lost, or at least it's very
> > confusing when a maintainer reviews a patch but there's no indication=
 what
> > will happen with the patch.
>=20
> Right. I wanted to give it some time before pushing. I'll clearly state=
 going
> forward.
>=20

Pushed to drm-misc/drm-misc-next.

Thanks,
-hyun

> Thanks,
> -hyun
>=20
> > -Daniel
> >=20
> > >=20
> > > Thanks!
> > >=20
> > > -hyun
> > >=20
> > > > ---
> > > >  drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 ------
> > > >  1 file changed, 6 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm=
/xlnx/zynqmp_disp.c
> > > > index a455cfc1bee5..98bd48f13fd1 100644
> > > > --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > > +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > > > @@ -242,12 +242,6 @@ static const u32 scaling_factors_565[] =3D {
> > > >  	ZYNQMP_DISP_AV_BUF_5BIT_SF,
> > > >  };
> > > > =20
> > > > -static const u32 scaling_factors_666[] =3D {
> > > > -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> > > > -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> > > > -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> > > > -};
> > > > -
> > > >  static const u32 scaling_factors_888[] =3D {
> > > >  	ZYNQMP_DISP_AV_BUF_8BIT_SF,
> > > >  	ZYNQMP_DISP_AV_BUF_8BIT_SF,
> > > > --=20
> > > > 2.25.4
> > > >=20
> >=20
> > --=20
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

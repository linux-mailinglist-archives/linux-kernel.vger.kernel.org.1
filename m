Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64102A339C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKBTEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:04:33 -0500
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com ([40.107.244.40]:39841
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbgKBTEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:04:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFNEa2gT8C343XN7PCDXnuid3rjAyZm7A9sCskwvmXyFOBLgTp6RoPBhEo2nBoislOwP2txQNiVgSj4l9mhv8UFry4vPmBoP5Btr5QeFCKJN/uWvWLKaUXQtJ8jua6boqBzgDG3mEKHGboj+wJrpKqL9705JRTQXlAY/PPwfZN1bj4HZG0Z0QS2hNjNRHYPhNVl+XYkI3hoBpVimm7nK1XzAi2riLepPyr5hrI4kPWlaMERTBU8zx4yUAE0TDaNkkxadc7GI4eYk3Biwy7qlmkbo4wksmjb3+Mx8z9Vbeb3kK9IQUl5jp4tzMIaVi1IR1U/WY/biMWUQ3Q/0amRifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg04gcmYNn72ia6cKH8FltE6mxepZd8rqldgJeNk7DU=;
 b=nMDy9g3u5P5KbPbt9AjKqEMU6EK68wVsImOBxnjdJsOygTngP058mNc8Cg9gimKTo1+8KjZpVw+IQWi2c5YgZgSbxUOTwtr8sOlPWzpCU3RXO382QvtOr0fQ7bNnxVTAQZYAM6aAl17I3xF/3F/+rKJEgnHFI2UWGLbWrR+OrFEnOeouhpO6ZcBT4Ls/I0SwpTkdruof34QERWNAnEyKzGbemygP4Qwjg/AvnnYVsNn+NF1x1EqgQOxVjYQ9Deg7ghOjy39ho1sh08Yv7y0SP8JpeDyoLuieFuRE/3uxB07pYbI1RMAKmkktl14vzsCy38LOdMS3s5sCmQkTSrGrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg04gcmYNn72ia6cKH8FltE6mxepZd8rqldgJeNk7DU=;
 b=hf3dSmhMm8qvZTnJ3cU1i5WxF9ISQhUaM3NsUeAxXESR6X5s0VomjQn5dQAxhQ7NtEHTockNJ0KjiNBCxlOiwk489RME31TvENEE7YTIBq/JXUnU8alJIN99ikszmiRwb8txC+bNPHxn6jMABl2rVs1IV7v2GuppVJQaYA8axn0=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 19:04:29 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::8867:11f7:90b3:1627]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::8867:11f7:90b3:1627%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:04:29 +0000
From:   "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To:     Colin King <colin.king@canonical.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] drm/amdgpu: fix spelling mistake: "Successed" ->
 "Succeeded"
Thread-Topic: [PATCH][next] drm/amdgpu: fix spelling mistake: "Successed" ->
 "Succeeded"
Thread-Index: AQHWsSNGPFDZ86/4P0K4SYiY0L0LbKm1MoCA
Date:   Mon, 2 Nov 2020 19:04:29 +0000
Message-ID: <BL0PR12MB24336D1D2C03A015AAF5E5CA9C100@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20201102141654.699468-1-colin.king@canonical.com>
In-Reply-To: <20201102141654.699468-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-02T19:00:20Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d8fa551d-d2d3-4a81-bc12-00003d44c41f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-02T19:04:26Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 749a99e1-29e4-49c6-b83e-0000adb1d122
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [122.179.124.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d6da319-5de7-45cd-bf9c-08d87f622014
x-ms-traffictypediagnostic: MN2PR12MB4078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4078AB8E22929BB603E996CC9C100@MN2PR12MB4078.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:305;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xeAaMpi0cm0+yjBohW+t/rLaOIsiNIO/0YEPfsJTqsAudO3pw/KIjW/dB/y784DMJit6lf9W5VPBWkuaqXLHGR8di+ysntaXL8u2LJoTNIcv0VTsTubOoW9jrT0gLLfTD7SyS+OCx9ueXpamZyfoxKsTLFfx05gEO0k6EnyoudkCPekdJNpFEfMLpu5GXpa576OTPGA/pYjYz+m2vyFN+NWU5pwskoDW4yjkaMpmdNIQZU49qL/QAzlxcycchN/PZBHHmXvK1rcZ1Ue1ZX6l8BAQfz5O0YpEbAd1P/gMyv6ibALPDXL+vuC6ioSaOwnANHNjPEYijHnnm3qWz87MkwEq75NCboq31deu2+rQLTsZFetmo+X9oWlCamBxqbmevdsGqD+eMOOKhGuT1nNwCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2433.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(76116006)(8676002)(316002)(9686003)(8936002)(86362001)(26005)(186003)(966005)(52536014)(53546011)(33656002)(6506007)(7696005)(64756008)(66556008)(66476007)(66446008)(4326008)(55016002)(5660300002)(66946007)(2906002)(54906003)(71200400001)(45080400002)(83380400001)(110136005)(478600001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tUZgpUalLyvYVS35Px9rBOJRjv8szVtXLhTfERryZ2pvAxlVEiVn/9xK3Lxyu8VnQf9/PExF8HjJk+8uR34Dkb4ZHlgtdR50nlmkdg9cfRzBP0U7lHi0PAnTnKMb5ZebWJbzRnkZTptH6/a2OdhC6Qd6oNfGW8zfZOMU9VFNpg+Cs+ru3SEEzThXyMEz4j7ZOCXEohQtwwUNfHZ/ioJ8slPBk+j7QX3Y0q8zXEpA+ooc9ULc4lQjfEcKyhJ5qCkcZIjYO82G1orANqqeHIiASMWeUhg6J/6AwjqqkseF0AqJIwD4xBX6bPWi+6MfDTEpBvgBEyBYzaTaOB9thaNsbNcLcbeP0jtJjaq2YB3aobI3sPkghCZ1rRJ3bT0A3MOJZvQmTirOdM/DQHllYaK0I73wMFWyz8DcFiEuhi5F/G/xMbADIJzaJ14Ygse8Fe/HbthPmhCEhQTohgYp01n04vB+rthrKeezPxAGsfbE65a486dsAPoFh4R1Ph7bjta11m1/o97vkBiqYkQe5ZfP6beMTzg+ZcpKWsC479WLCQT+wqoWgW5iahdPsFKbe4WZKUiz3onvdObC8mJhK3fS+JDcco/sZmSxo7QUqfJwHTYJwRhb45q398h2k9GSeewDvw44jG4hZzpGldaDhMBNBQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6da319-5de7-45cd-bf9c-08d87f622014
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 19:04:29.3679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vafBLHLLsmvI5ua6MGzDpvnBIrIzjBEzCD3pK+QR6Tclxg71PtDge/zUunzf7Ly5ms1jZcPOnqej8zWUDfwF1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Colin Ki=
ng
Sent: Monday, November 2, 2020 7:47 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <dani=
el@ffwll.ch>; Dave Airlie <airlied@redhat.com>; amd-gfx@lists.freedesktop.o=
rg; dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: fix spelling mistake: "Successed" -> "Su=
cceeded"

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a deb_dbg message. Fix it.

Spell mistake in "deb_dbg" of commit message. With that fix (to dev_dbg):
Reviewed-by: Madhav Chauhan <madhav.chauhan@amd.com>

Regards,
Madhav

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vram_mgr.c
index 28a5c0d21b71..c99c2180785f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -296,7 +296,7 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resou=
rce_manager *man)
 		if (drm_mm_reserve_node(mm, &rsv->mm_node))
 			continue;
=20
-		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Successed\n",
+		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
 			rsv->mm_node.start, rsv->mm_node.size);
=20
 		vis_usage =3D amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
--=20
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cmadhav.c=
hauhan%40amd.com%7C563b9e348bf946c1894c08d87f3a6739%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637399236116555988%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D%2BiITYub2Q5HKNJXDwLRkrv%2FSpVmWt59oNVW2CmCgf3M%3D&amp;reserved=3D0

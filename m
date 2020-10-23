Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC2297118
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750320AbgJWOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:10:17 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9523 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750312AbgJWOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:10:16 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f92e4170002>; Fri, 23 Oct 2020 07:09:27 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 14:10:13 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 23 Oct 2020 14:10:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYybkCRaQd/nfra2rGwGoVrugJYbF9Y1qLQJ2e7hR01n8ZnWurdfHEwV7okxWLQTjOR4j55YZ8Vfs2CkaJzCUeNRGp8d8GHkZWUPI//a9F72ezrHK53KeKlzARIQkT9AvRlWx75m8UamYCc+4B3mAUQwaiDxKgItx5Eec9bauMqoAl6vB2nTKbFiPEhSd0XKU2WiHAXYoCj2UXRN/T5+e5eg+OT9l8qA61wnUAqqrVH+B3bMNZPfw4E7R0NNGE9rg7ijaIyFxUR+jKuTxt6AVtIGqbqkKr9NRcO+9CJmjY7TUvDAPg84nwE3zS+Z8nj3TsCNatbEjBiRw9wAk8JgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdHgsL3K5KBjH8TVyJbMH5zhGtnSbHFunDz+e+4iQ48=;
 b=dX38X8xtbkBa/mrEXPiqPA5J8ayNHoULyMHQsLj96bgJuqRcNje+04Kmdhh9VSxhxS9EDuf2/Zn3UdUbdiRGT+wSGwpNqdosOc/xuhYIunmbYS0M2I/VKaqR/lyzald+f7q1GrYpe8okyPD6lil5QRVFEu5vp8ajfOQvXvwEZLgD1rz02gpIF8nq8F/ctEB/4P9Ywp50TY+14zOsDp0l41Rx63JNmI3FKMdPd5Ez+iXYW36rScgNoe/zW0NX9+GIO9J+r3S5yftHxZpZ9GD4RoGWhM5xV8iy1isvXXM3wrVGbiIyhhBfdJ/o3Slrb1JKedmH/oGcwVU8p/pjoZlmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Fri, 23 Oct
 2020 14:10:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 14:10:11 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>, Ning Sun <ning.sun@intel.com>,
        <tboot-devel@lists.sourceforge.net>,
        Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
CC:     Gang Wei <gang.wei@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Joseph Cihula" <joseph.cihula@intel.com>,
        Shane Wang <shane.wang@intel.com>
Subject: [PATCH] x86, intel_txt: Use correct struct name for tboot_mm initializer
Date:   Fri, 23 Oct 2020 11:10:10 -0300
Message-ID: <0-v1-aa2f00cae409+47-txt_tboot_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:23a::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:23a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 14:10:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kVxli-005nAP-2R; Fri, 23 Oct 2020 11:10:10 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603462168; bh=kFxTVyV83TJy5FTqZGKYB9E60Sra3Lw0uYe0LuTIni8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=i2i0uFwWZ73pEJV/iI8qMVJZsOD0lAPFzQHpOEwIoroiVEEDFM2quvJqITRn+2am/
         v1+GXFKwjlcIJh8LjK/+31Yd+3vkADbklAXTg11bhfwkpzHFsGK2FYEwgg6UYRNS6U
         hP+vfuEtEIcvijUPOYMAUcUFRn6OaNwraeRgn8pRCRAn2B79CU53cwfjVbjkwC7Qic
         62qaWdr5MNowLThdNTGkk5RHZ2kOBXt+/b6q74X8O/jNtvz8uYnhnDHb4siGiFQcUK
         HZKXRZvpEBaptQpYEI7oT5xmCiCcCHDhYnJ24UIeEVuEVCgxXsQuM0K5wQPk3ojPs9
         E4nhISfGoBH6A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the locks this sets the correct lockdep map name, for mmlist it avoids
creating a corrupted mmlist that is not empty.

Seems like a copy&paste typo.

Fixes: 316253406959 ("x86, intel_txt: Intel TXT boot support")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/x86/kernel/tboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

If it is deliberate it deserves a big comment why..

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 992fb1415c0f1f..14298ecfa100fe 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -93,9 +93,9 @@ static struct mm_struct tboot_mm =3D {
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
 	.mm_count       =3D ATOMIC_INIT(1),
-	MMAP_LOCK_INITIALIZER(init_mm)
-	.page_table_lock =3D  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
-	.mmlist         =3D LIST_HEAD_INIT(init_mm.mmlist),
+	MMAP_LOCK_INITIALIZER(tboot_mm)
+	.page_table_lock =3D __SPIN_LOCK_UNLOCKED(tboot_mm.page_table_lock),
+	.mmlist         =3D LIST_HEAD_INIT(tboot_mm.mmlist),
 };
=20
 static inline void switch_to_tboot_pt(void)
--=20
2.28.0


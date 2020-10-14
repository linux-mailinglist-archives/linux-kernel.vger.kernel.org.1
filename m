Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E0228E767
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390827AbgJNTgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:36:41 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:53016 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390804AbgJNTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:36:41 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09EJOFva031201;
        Wed, 14 Oct 2020 14:36:38 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-00010702.pphosted.com with ESMTP id 3439x032h2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 14:36:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU/Jm0sjJq8chaoDYFbBf+TiXujjkH2NU7fJkrr8S57bpIq9AYTJvlIueLyQge/ObPTHhkt9busns+srU/PlVTu0vHnckZQ26MLJefP68wMr7yYdqNRJJZGs1884rI4GQbnw/5yVwuWR+m0oPWf50Johla5KbIYbzRp6wPp5meAzQXqFDiC/mMRHPB35Uu+UNbw4JFvGLMUvusB6A8gIuNntdyUtoP0CBeBVqICXUQZYKEAPrLd5VCwaqchGhnZ9NXFINa7H9psxJ36LxrJcc6YLSombV+kDtn2hb8eAJ2JazZ2MwW92os9wKh2IY2nU5dAAUDwq0pS4VzpUa7ZnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chcZrh6s7Qn9kFke3oQzjZ8qMI1qmcXseBiEpr2nW38=;
 b=cc6z+GHX1p7ClVIp/HPirwzhZf9aw7/28jGS7ky2wh+fibU36zz14oajrH4fp6yjcHMcHyF2LxO9mlysJmCzOtTKyz9dZWIUWaaM1iQCkfx3++pv4vLjc9oER/hYhFvgRfvJ6UpQ44Kd0giEaVNaHxLPcSxkm7oQTwIMAgCZaE39hL2Rv29Chqxx+XGdLcCG6vNuA1tNSVwlLkvmacmrR4TwDp6S85Sd2Hv4c0a5yV/aJLuKmJXo34/GHNpweVE4wrLEZD3aZQfTlKtEVPCoZ42k9uLxHSbi5gFKeVhhKkqADftdxyJa9byRjLURCBWHLuFitia4vAoxC8O2nNzrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chcZrh6s7Qn9kFke3oQzjZ8qMI1qmcXseBiEpr2nW38=;
 b=G31fL3mtbOC6unKvPJXsPAFqrzqT2bocQXchVC/W1f0SwisvKuLZLr5eJ5CIojY5xjUdbLZWJTWKJZlDRsEh4lIS0eWvNORBDeFQso+1VSVhmkX7D8V7epH0ZbzBACppvPadYAtQHYaGXxKuilTh6Me+J8bNQqvkRSdIOw1ZZVY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB3854.namprd04.prod.outlook.com
 (2603:10b6:805:48::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 19:36:36 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 19:36:36 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saravanak@google.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Michael Auchter <michael.auchter@ni.com>
Subject: [RFC PATCH 3/3] of: dynamic: add device links barrier before detach
Date:   Wed, 14 Oct 2020 14:36:15 -0500
Message-Id: <20201014193615.1045792-4-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201014193615.1045792-1-michael.auchter@ni.com>
References: <20201014193615.1045792-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 19:36:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca7fe1ba-ad8a-478d-0f2d-08d870787696
X-MS-TrafficTypeDiagnostic: SN6PR04MB3854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB38547E38C7E9D68D3A08E5A187050@SN6PR04MB3854.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:71;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjBeFGwGvX1KKWFImsYP8IRbc5hgZtqLHIpNzzPKQAjLKFmJALYJe9GsTILva7uV/GCvYjumHcGDDZ3BoiEhu0fzATOdMGGFTAEfWLKFhIUaF9i/oBN85wb75P8dAY0bZCg1DUPEkt08+QIFpTxvJ+FgVTowYIJCN2B+yeP3TCK324ktXGx3DfxWgtYNfbT8YVZ9VtcLh7qP7gRsUyIMHbxXKIvuMB/cK0coijJIZozrS2nLRx8Dj5YoyVlaq3dshg9I7TsW2u0OUxVx71JBf1WXYK7EwLVNK4i0SQ97VY4lbR4hCf0PI3O+r5yF+LYTjEBTE+1LgaYCwEL7mQOX9vUOvEHdrQO58eS/L3vVnskTPt3B/ARVUFSEJQYX5gLk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(346002)(376002)(186003)(16526019)(6506007)(2616005)(69590400008)(66946007)(86362001)(66476007)(66556008)(8936002)(6666004)(5660300002)(1076003)(4744005)(36756003)(4326008)(6512007)(2906002)(478600001)(6486002)(44832011)(52116002)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: j6Rg+yO8dSllmleXSIkGwGuUDhJISlRiGoQt5a0niImfMKUj/aL3nvvynK+E96BrMAK3a36qy0We7T2pRloCRFKTL674JQwGUOODGEy73ImAYf2fLIkRnTkqWIbS1kPBR1e2pTiTOJzFRC9RXW0/3IFwlUx4xH5h97Jv8j2OLrQ6zIaqEWAjQgpZvVaPb3jKDn3hKu4ltEUxXQHGy87nVZwhhptjF+J+HdivNXLRLqd5JrGxAPQFLZl1dRKSN7lHU979V57wi9Ysr/IXtIVYc32Ui0Dr76NJYo+3HTrKGCDCONOfF2jBO8qQeEGtY/XwkHvqtWU5spb7LkoZztBghhsl243Em9rs+dDce1BV5t7W0ncNBhvbJqxk/oAWuE3jGQTtRS4sKOsWClU8q10wMV8+gSyjL0zyVrQge/U8LjztRQeLZZdeT923URdrb2Kd0yoTayqNobUT9blifsUxIhJrFodolMdn4GxN+jABXEeeuiw0LddEOOwFx0W6+qZve0hOR9gSYSJq6jB0U5MY1zr1GcFTMDx3GV34SS1c6ReNSl8pZTM4MToU3MH2DPY5ME+IO0jdLlFqRRl5Sulv1XtX7k+1iOEPShVWWlwCcUR9B39u78E106hTJoUOJwCHa31NpIy5z8n041lG/ww8BKMp9yQwAOOPCv2EPYKvN/BHuM8v/ffKSbGQoa9FN0ZR1iQOr8La34kCEnQtxANGSg==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7fe1ba-ad8a-478d-0f2d-08d870787696
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 19:36:36.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXEbv8tifz4GPENBQoHxZz9XPEYER0Ifbzol6NK7sZX/g017pGEzt6tKtnivZltSOjptF/9F0t7UQYq7TggdAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3854
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_11:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=973 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010140135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/of/dynamic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 7478bfc8d440..a4e2881524e9 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
+#include <linux/device.h>
 
 #include "of_private.h"
 
@@ -688,6 +689,8 @@ void of_changeset_destroy(struct of_changeset *ocs)
 {
 	struct of_changeset_entry *ce, *cen;
 
+	device_links_barrier();
+
 	list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
 		__of_changeset_entry_destroy(ce);
 }
-- 
2.25.4


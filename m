Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6483D297624
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbgJWRxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:53:23 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:36321
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753824AbgJWRxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:53:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEaqTNztg/PwKveWQIKeka1yoe6tBAs9PpxgKR8PvUdm+ay+JAJsu9/NiHxp8rZZV+RA1LesRsQMZXodrA5sRzDx82N0Jxzl0t7eenaq9aTyGt5yNL1f5Fpg+4A51ln+AUj+EssnHdcecOQWeusLHx/KpWJZC5YeLC7e9Bgn1Jiyuo4j4Gq2tzwsmqCtDRkLPDsqbHIWgV5OtD2Qb+2ijNns/3YClX+8YMUn4FGqaNL6oDJp9v3jYrPwbx+l2gWwpZpFi+FO1mRTgKn5Gdtg4Ne1OrEDgpFXkLH5zEsodwd3ZrdoY0QSxA9CZ0bToEns7sjNRhuIMpEQBgpxifyCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXL+o+9zl5E8FeKRHxLgoeRy08h7kPrJ3VuAeyf1nvE=;
 b=e4huJM6U5o4EyJnQjpwhc35qQpICZ9Blj83WGxIMDtwBxnAxLJHNVHTsMowIkV+sQTDtOGuNz1hREH9fCv9hU8gZqrnrNFEFo5YjHIKYFvxlLS+5D1b1UhW/mp6ujvmnY63tzUFqRtJ37FFYqO3kTV2YUf53SaLhITROpjzmwZB3VCy6Au8CvsM98RuaTmDl+/UFSsJ6ifOcRANlhPXhnIvgz5uvyMs6bv/z25wcdV63ACMN7k+oMJnlpLuZgZTXwd7yG0PmDVoZtYU5XAXaBFSgsxvX4R/CrJ7FL3RUiEs1EV0cSiI8UkxapetrvZznVedViosb5pYbVHTfbKFOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=none
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXL+o+9zl5E8FeKRHxLgoeRy08h7kPrJ3VuAeyf1nvE=;
 b=MKQHDm36Rn6K4/MHIE5HFWCbGnSplJWBhJR/7UIIOQHYLmOlhYPzv9QGa76ObSO1hXgSgvTR3s+NJTd7fbkbu4qROqAWn+wC5iCnHaCEZnokRj+aCSugbNZT77uUzhijC/QNQc+3k6alF7CPyBZQ6HE16RiO8SIl7FOPb2ox1c8=
Received: from BN7PR06CA0059.namprd06.prod.outlook.com (2603:10b6:408:34::36)
 by MW2PR12MB2345.namprd12.prod.outlook.com (2603:10b6:907:2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Fri, 23 Oct
 2020 17:53:18 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::98) by BN7PR06CA0059.outlook.office365.com
 (2603:10b6:408:34::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 23 Oct 2020 17:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 17:53:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 23 Oct
 2020 12:53:18 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 23 Oct
 2020 12:53:17 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 23 Oct 2020 12:53:13 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Prike.Liang@amd.com>, <Alexander.Deucher@amd.com>,
        <Murali-krishna.Vemuri@amd.com>, <Virendra-Pratap.Arya@amd.com>,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: support other audio modes for raven
Date:   Fri, 23 Oct 2020 23:37:17 +0530
Message-ID: <1603476441-3506-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2125862-b1ca-4423-785a-08d8777c8640
X-MS-TrafficTypeDiagnostic: MW2PR12MB2345:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2345C38063BDB19D891A8D34971A0@MW2PR12MB2345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yW6UJBZzMbVoH2BtgDOF7Ht01dHq4zm6eQCu5wnPcaoUERkxM4bCfOGIOW50y8SiCU4TO1a1WTnMEzdYNZsVcmDZYUy8dXvIXAx1l4Z8yz7i23NN9Ura6sB53yBA+1SYYimh84zm03dvf5p2WeyLdq0uhlDzVAEuz9oDqvZJML7JN9somZYB8WdDqxfqpl1DQOsL03t0kMScJ74yZ1vj8twPG02SCwqjpemFnb1+cAz6GN6/xcgnoh4p3EWvde7B2OpPsjsYA4GXmTQc6Ec/kjvNyytcQ8UEOE77P+gdWwuKkGQqYIvVNDQEsN8xgWhW57tMu+QvxRfYeZHLZGIMuOMKfbXbfovhJj1NpwtahzHz9hgq1RQ/kwkG3zKCrQsaieJAUyZrFFsK0jBlYaIVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966005)(426003)(70586007)(83380400001)(2616005)(36756003)(478600001)(82310400003)(47076004)(4744005)(82740400003)(86362001)(316002)(4326008)(2906002)(54906003)(81166007)(26005)(336012)(7696005)(8676002)(70206006)(5660300002)(8936002)(356005)(186003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 17:53:18.4487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2125862-b1ca-4423-785a-08d8777c8640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2345
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP supports different audio configurations other than I2S.
This patch will fix acp driver probe failure for other audio
configurations.

Tested-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/raven/pci-acp3x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 31b797c..cd5b097 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -231,9 +231,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		}
 		break;
 	default:
-		dev_err(&pci->dev, "Invalid ACP audio mode : %d\n", val);
-		ret = -ENODEV;
-		goto disable_msi;
+		dev_info(&pci->dev, "ACP audio mode : %d\n", val);
 	}
 	pm_runtime_set_autosuspend_delay(&pci->dev, 2000);
 	pm_runtime_use_autosuspend(&pci->dev);
-- 
2.7.4


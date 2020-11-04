Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21BB2A5E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgKDG0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:26:52 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:59296
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727323AbgKDG0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:26:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efCTd/NOjw+urgrROLjIb6umn1Nn0ldrnMs2bUaIj26fw4Lxk8FSv+Af0GthUGWm/cyjV6kELVgrwGBCqWJM7LCMYpkobrFhXO+dBzC7OD+3Db+NpdUQfk7yjZo5aDmY7P1512F9/uIGTwxwojfk1YxM8JNuy/2eD5Pecaoh/O3598bXCNedJYXsWEIn06qYfXFu9XVXglVIHlUiZGiqyzvuZlP5S8T+RFOmnpDU3A66fNOQSg+9biFyMi76LSuQp7gUv3XfSLc+j3+tsg35tcTZzD9hl0eydGz/zVp+kjcmhkppWXdRIp6zSFptdixeCUnoUSzs5DG6qe8zmXcMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rma2gbnYUrRpWx0orrrNCp3t/JOQPQ82mlk0oXuFbuE=;
 b=Ve40U4bovGysA7eQJdTKepzv9qEhzSsubwAhKTtaTt1RiBtaSg8KEUVj1IN5HOT0ULysGhuMmehBKkTff3xaOo6VMF2SJZWtad8BQKQaND2lSItYD2Z1srybarCryhyVYcc6yI8XUMLJVhqh9bBDbtRj0Ek9SAUrjnImY2H57r920/7LlLGproFXpzlm9qTexJCGa6OjrcwwCmaRihgnNK1OsHIt/z+9z0D36fho6MhqqHWUmjCo9HyzcWmYQ+119ZWcWx5eUMmhHX2ODE0NoNIQxPIxd/VOSzJi7piNAddjfooacn67RAVDgzckszTkP6YvotmLfi+K75YJoO7QiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rma2gbnYUrRpWx0orrrNCp3t/JOQPQ82mlk0oXuFbuE=;
 b=PaSwp9gjP0VqA37QechZnycploZpNPFk8Oylwc/dPuKMKkpqB/JcPkbkm0+jAXju24dBaeUwKtwrUqPyTuV7oRs2D7kkkGtlWuFDPNL8GU36NGy2aGX6BEJnzmwdz8uPXOs4Lok5Q2onp19OkXpwgl6rtDGenM/ob0TqbvwB+cs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SN1PR12MB2398.namprd12.prod.outlook.com (2603:10b6:802:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 4 Nov
 2020 06:26:48 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::7cc5:ed9c:dece:6d74]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::7cc5:ed9c:dece:6d74%7]) with mapi id 15.20.3499.030; Wed, 4 Nov 2020
 06:26:48 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] AMD-TEE driver bug fixes
Date:   Wed,  4 Nov 2020 11:56:08 +0530
Message-Id: <cover.1604470183.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::23) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang6.amd.com (165.204.156.251) by MAXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 06:26:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b25d900-6b7b-445d-0642-08d8808a9bd0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2398295E5D8F1836E181CF85CFEF0@SN1PR12MB2398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUKa4xT6Ooean/6S5/jPobpKF0gatr5iXy0eOGP16KXsQ3yex4ghcKUMKyPfsrtBcJFbDBRl4QhQUdZWxdnfJUg/Wugr981MhQmtfz2k4lEjymhTqvEZ4/hXe1GZoyTKTFpzHcJuOGyrQ/uTFpiRmE4YDjR5X1p2OeEhLgewxt9igPesrQflIPz7Yc0p5X0ToiriGuIGcKnJtQWWtaHg3J/2WjqyY88+vqFOyZKe8F+WhjIewv3nMiI+GmmqiXebmZjtPaXBS7jN4kibdhJIb5FHxiv1hB79Y68y1Qrrq3kjZ0aZknpRNU6Sp4nOE9MjRwPAiP3XnHPzXdEUdWMYVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(6916009)(478600001)(4744005)(86362001)(52116002)(2906002)(7696005)(4326008)(5660300002)(316002)(54906003)(36756003)(186003)(6486002)(8936002)(66476007)(66946007)(66556008)(83380400001)(8676002)(2616005)(956004)(26005)(16526019)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6rNfweQnK//0dCUuMF80usvC8DV5bXXjyF2eJcNKAQzSF67dshi468ZvItnejnacGltV3aGXTVQwdhV+fqAXzoIRCNDow5NXixZy3LEzYsWLb1oXnXP5XaBdSjkHepRpeBJX+lToA1Che8JtQHwtJ6DRx6HGDJjpVx5dxWaBCh3eYmD9GtNRhuBEf+vRXYuZX9JDfNQL2w7UsdIjrpshyxM+V349YFkOwPVb+lVuw49kqAhZpM9VGolznJ4zi3G+lg2gfS8BCL/3K+kBcunyQhB2awr0lsvCGSfu4NR2fHdPRlgkQaaCpiBik0rKz9270FuGEjNm15gyU6tKH4J84s3xO5mzJr8lijk+6KcPuWMYe8i6TCse7PO8wT9Ny9Hb7Bdw1dg6XmXLqersKIzvbFQ4kpTLhlzRZvNx9A2To8rZGgokWiYgCpSnlWZbEk3d6W3g84y232veBzAlTZDSz/FPga4EJw3CtJeitLvyKGLy9xhgQSGX6f+S46XORPP3bQNHMeEXswz0gOz/XyCQsb5pxq3k7gszXW1X7lXdTFKRai0J3RmcQksyLziC6gtHsJR9mE8IU/HIJ1ns8mw6i0DjmrgoeBn/Oj50HF8WHYXZL3RozWsZMjESOI4PJ9x+E2mS2CR2OD56iuH8XDMEKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b25d900-6b7b-445d-0642-08d8808a9bd0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 06:26:48.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JloBPYVpHgeyQyiJkNfES/sFkG2ah5W/mhH6Xc0Ysn/oeIM6wVg+OqHZ6hbPvIyDrENOi+wzyAWmZtc5zAXTTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD-TEE driver keeps track of shared memory buffers and their
corresponding buffer id's in a global linked list. These buffers are
used to share data between x86 and AMD Secure Processor. This patchset
fixes issues related to maintaining mapped buffers in a shared linked
list.

Rijo Thomas (2):
  tee: amdtee: fix memory leak due to reset of global shm list
  tee: amdtee: synchronize access to shm list

 drivers/tee/amdtee/amdtee_private.h |  8 ++++----
 drivers/tee/amdtee/core.c           | 26 +++++++++++++++++++-------
 2 files changed, 23 insertions(+), 11 deletions(-)

--
2.17.1


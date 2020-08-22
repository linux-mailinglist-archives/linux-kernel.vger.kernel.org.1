Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E3824E77E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 14:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgHVMnp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 22 Aug 2020 08:43:45 -0400
Received: from mail-mw2nam10hn2239.outbound.protection.outlook.com ([52.100.157.239]:8033
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727827AbgHVMno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:43:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdJHf7Ev6AetnuQYgjXJHgIOd5B7i92oeCTov8uRh7T8pX/afCwbpMdqX+iaPqbPee9P+4I+J7cgqaAZKvAM6Q05C742bRBoUDxL8vZmS1rMg+YMgyE6qhYCAYZgIo/qvTmX3ceuIxQiGy+0VI0K2AAVT0tUBH9DZs0iWHmSBNazTYay13z3OUp2d783RBf9aYd6jGe5iTzYhHK7PsEaeyUJLczuOVJ4eQbzwIvyOVfisBZywVVUSZqcSke18WH7O733g6PwTAZf6l0GYEo14nvGvBf9v5PW3osuyz9TPnV0ovnJ/mVi/Kg1qyKVP0ZKIGQaqGHvKV7f8GENAcdKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHsNMrPevQfdnreekv++h7cRD8nWI+zpk5TiRGWqcIA=;
 b=jL27hK9msND3V/LkFCYkMSMsniG0TxGj06RlEnTHo0/yXIn6WwWCq51VliLhlPQoWzl9YTZa4rGodYrjGHAbi0AV0OPanzgjtBq3jCmkr9t0iKwgXM9RrbzITYyQQCl/krWsJrwsPdhShu/ZmHVzy8VJS1pdVR5ZOGPanbmRDb6FI9VnhyMsEW1PFPdaCrSVbV2/s3CBYGB9ozBeZ0Sr3nhffcD+CZAKhw2YYeJR51Qp9ehD1xwifspcsWwHRz3Do+GjyZtwVYOTdCtDlCsOwEdBxSKAY2MNHFL5/zYKJG0DkSXhTnEihU993FTyVpDZwt52MDEHr8owYT7teUPKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 170.118.157.237) smtp.rcpttodomain=webmail.co.za smtp.mailfrom=mgm-sa.com;
 dmarc=none action=none header.from=mgm-sa.com; dkim=none (message not
 signed); arc=none
Received: from SA0PR11CA0027.namprd11.prod.outlook.com (2603:10b6:806:d3::32)
 by BN3PR01MB1953.prod.exchangelabs.com (2a01:111:e400:7bb1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Sat, 22 Aug 2020 12:43:31 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::71) by SA0PR11CA0027.outlook.office365.com
 (2603:10b6:806:d3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Sat, 22 Aug 2020 12:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 170.118.157.237)
 smtp.mailfrom=mgm-sa.com; webmail.co.za; dkim=none (message not signed)
 header.d=none;webmail.co.za; dmarc=none action=none header.from=mgm-sa.com;
Received-SPF: None (protection.outlook.com: mgm-sa.com does not designate
 permitted sender hosts)
Received: from email.infores.com (170.118.157.237) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3305.24 via Frontend Transport; Sat, 22 Aug 2020 12:43:29 +0000
Received: from CRPEXCW110P.infores.com (10.106.12.54) by
 CRPEXCW110P.infores.com (10.106.12.54) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 22 Aug 2020 07:42:29 -0500
Received: from [94.102.50.177] (10.106.12.6) by CRPEXCW110P.infores.com
 (10.106.12.54) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 22 Aug 2020 07:42:27 -0500
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Re Greetings.
To:     Recipients <info@mgm-sa.com>
From:   Lawrence Pierre <info@mgm-sa.com>
Date:   Sat, 22 Aug 2020 05:42:21 -0700
Reply-To: <p0290715@gmail.com>
Message-ID: <34227a0469574ddd873009219022b0fc@CRPEXCW110P.infores.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81375761-e9a9-4b54-d84a-08d84698f8e0
X-MS-TrafficTypeDiagnostic: BN3PR01MB1953:
X-Microsoft-Antispam-PRVS: <BN3PR01MB19539F4669C1DCB47738F49CE3580@BN3PR01MB1953.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 2
X-Forefront-Antispam-Report: CIP:170.118.157.237;CTRY:US;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:email.infores.com;PTR:ErrorRetry;CAT:OSPM;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(7416002)(508600001)(5660300002)(16576012)(2906002)(66574015)(36906005)(336012)(8936002)(33180700007)(26005)(83380400001)(956004)(86362001)(2860700004)(9686003)(8676002)(32650700001)(6706004)(108616005)(356005)(24736004)(70206006)(70586007)(82310400002)(81166007)(7116003)(6666004)(6862004)(3480700007)(316002)(82740400003)(6200100001)(62346012);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpT2B0zUyiv5Xm+LB2+YXBehXiiSVlOy/HM1SoFN85sE/n8CW1BPdrRpSteM9N58fId8OlKRg8EWt5xjvGDCxiS/NFkSv1DisWnrDJ8/8oLjPbiN80fsmv7KhpD9C3rw36Lme5iUCvLCaKe00wKTrWBqBU8mgyAdfOzoml4iTYFcwAsp4OvBzblFtn6oQWhjmTMMD9K7b/meUvoJffh8GN27/VJ3i7NMBkHM9cIUiutOfJ0R0NgYcPyfb5qj5P1OJCQVkX85qApvrbmtaMU3qfX3la/DvEo3mPIOg8XAqdyeb3ZcBjjmSEe/MSAmW4bzQosFabkzkrj1y4RDAd8M794A5bjCceG0fLx9/LH3JpVryUA6rwgfqIzc4ENW/DIfyzH1dQZ9Fs5ZD+gzMPnhPUgIeh70vT6aYWy5shSWAjlnwPImM+++1lSx4KUderfV6u8nSXuVa4Ml3ZhElvs4XXUrvUx8a4GKNFfV4NNQQAMD3PZgCFHgehzCKzF1sJXXhefJgxd3jWKwsnXnZy2ZgVpfhseZUNBjZRVCXYVe6PEOpPpD8x6yzA1GKDaChqlt73egATBVvrR/lxsgXfhPdzBhpPAffcBB53Dgm+D+fX05UaZw0mZa0Ds04y3l7ZaucvJ/c19JHNn9Fb4Y30+PNwcI3J7zW/bJf59H/n6LEaAIb3QNe8UgAkCGUAW5vn5nHQRRKtsXW3qUdoeWoDStekfoJF5C5nVxZBjz68QwYMao8hEV5GYM9wsMvCoZ44Xf
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: iriworldwide.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2020 12:43:29.6184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81375761-e9a9-4b54-d84a-08d84698f8e0
X-MS-Exchange-CrossTenant-Id: 43728c20-4447-4b27-ac2e-4bdabb3c0121
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43728c20-4447-4b27-ac2e-4bdabb3c0121;Ip=[170.118.157.237];Helo=[email.infores.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB1953
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

am indeed glad to be in contact with you even though this medium of communication (internet) has been grossly abused by criminal minded
people making it difficult for people with genuine intention to correspond and exchange views without skepticism.
I am  Lawrence Pierre , financial assistant to late Jeffrey Epstein Financier owner, an American billionaire who died recently in new York prison.Two days before his death he instructed me to give $10,500,000 million dollars to an individual for charity work 40% will be for you that will handle the distribution of the fund and 60% goes for charity work .  Please you should keep this confidential to yourself.He also warned me to remain anonymous the public or the government should not be aware of this donation.
Take note: You will not be asked to pay Tax or legal fee charges is not applicable, as soon as you respond to this email that you can use this money wisely for charity work i will make urgent arrangement for this money to be with you in three-four  working days.
Reply me with the following details:
Full names:
Address:
Occupation:
Telephone number:
Regsards,
Lawrence Pierre

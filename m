Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F00278167
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgIYHV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:21:59 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:13241
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbgIYHV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:21:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4xpkWRGzlwnZhd1x5qGgcZzs4vCub/M/XKRy4qibrw0t8rfgWiuUOa1zXQ1uNMd6HOBI+KZBSWJKar4jJBJbHra24QLq/xbJHnxEUO0idAvXxl2PmtP+P6DlkSDxWdh43XpwjJ6f3ScF3yhBLoY4IscNc0lNw/u3NRg9EAamg2FINBs68pBVXpuYWLIdcqCKzE6tvb0diCc7CqtYpDt42juatrq43dN+1wspmPXlBHGHn06W5ar7JgKfkapWDziXN6JqGY9s7EbCkzT9AhOAIPqsG4NWQQMTh6cijYFuPmxlkNiID+2aGZLkDVa07YDj0+EJvpYHbVg8F6y55pWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NFD8n9t3i34+3j9Y+kemIVdlvhtpcoWOIaZP4VxX9U=;
 b=Rr0oi5Byonsq9twx0QPpmY8hO+dE2c64VWlor+yTeIVnWY9lEipfoDKhytFpIytuWS8IfU/VAZF/oun6HIuxYsPO3FDUHzIyLgGKkz14GW1om8YawmgJ16Wo8gtzC4G0aFgzSIZF2AUA8KVm0c5Dk31nlE7/cwckNjuUZSRvSwFHl/bjlbLVRVQsCRExlyLkDPfykY8GKM8wHk7Lwj5tTUNuHykBTc/IrcHt6//E0pdHFvjgcROw6Q+BVlTbrO+to5SVFJdP1+e3uZy2IHDX4CwAin4lFOEzOjfqqk3CixnijLBgVDqLyJztdsEbHD7mGhLLVa3GidBnLYJGYy8lEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NFD8n9t3i34+3j9Y+kemIVdlvhtpcoWOIaZP4VxX9U=;
 b=l3/cJO1ThwsJeQkKIn+nfLYigDnvmYAwo+SyLWYzNvAeIB1rUckTNi8nM5zKxFZ0pQSyz4l9m69Jxwsy4+zSY2yrHmcoTxlX0i1ucqfKtuUa/2kYJWxjn3msttPCHge8hOomaZnuVw34kkYV0WWqmjesJZIlqIBGRYoIOmS3Prc=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB3277.eurprd04.prod.outlook.com (2603:10a6:802:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 07:21:55 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:21:55 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 1/4] samples: mpssd: fix the build errors when enable DEBUG in mpssd.c
Date:   Fri, 25 Sep 2020 15:18:28 +0800
Message-Id: <20200925071831.8025-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925071831.8025-1-sherry.sun@nxp.com>
References: <20200925071831.8025-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0118.eurprd07.prod.outlook.com
 (2603:10a6:207:7::28) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM3PR07CA0118.eurprd07.prod.outlook.com (2603:10a6:207:7::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Fri, 25 Sep 2020 07:21:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee1472b6-15cc-46df-0519-08d86123ae4b
X-MS-TrafficTypeDiagnostic: VI1PR04MB3277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB32772CC136B92F256228FC2292360@VI1PR04MB3277.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJVED6iKbXtTYNW8BlATh3B6EBM9W3g8VXJqaRDui8tht9VnqRLHxw2ehyYhphOPsDOhPMKRj4fFZunC0a7ZHufEqfekpP3Gx49cmF+goQ5KgiHHITBWjNe0CTArZebPJBg5+V0guvmMZ/THPcN8R1wGrklDF2zn3iwUo8fHHLhb1bClfA67cAawFN6u8RzWwVSqik5zgWtQK4MP6b6XnxtGmH8RTE1n7kdv2yegR7Dpxqe0DwChIpBABCeE12z8OSzIHXQtJv97MUQ5oILCG4RBnaLBAK5ipjF3N83WvofQ/pghA+zg3KT0LkJFRMzaewA2Jk7fSHUY+n1uqUWFSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(316002)(2906002)(5660300002)(52116002)(6486002)(6506007)(186003)(16526019)(26005)(6512007)(36756003)(1076003)(8936002)(2616005)(44832011)(66946007)(66556008)(478600001)(66476007)(86362001)(8676002)(6666004)(83380400001)(956004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rNTFEqK5R/8p7xjWzRAs7h8bxTwSy0eVhCIbd4+QJBjB3dYGJT0aiXlHmC53bnzh+35AS7PcSdjYjtoPJZG6SEulWwobrKOBYKP+uIlA/zT2GooDZnW7TMTjpf9Zfn7LN9bTJJcCZifTDsdX+/DXXMNZDHM05Mj9RZVGLb5kWc/3VpAbj5OFMRHBzulnk75ARNhciYM1DO0Z0PhdxewmfRRLLt4Gk3pJKOUCHvfc7L08Pqf/Pgtt7M+paxAhG0vJfBBudyx96Iwvnyzt/ojJsZSDV38emyrhs+sFc7LnkUhM49YHEC5VMcTfnk8Eo7BrPpxjsWWqNZC12IofRWISfYlQhGZJd7x7GzVO6sU5aJXL+sjiuqND8hl3wg2EGwM2Ub9RbL5cMLm9XFb/a1EucnUkylROAfrRlbjnWqDosi54VCSJx4Qw8qTSV3s8N9RNox8QZzNTlU8JQYJRI3V1vfRs0SEL4ceDcung8fWkNHtVczQ5bepm5BrQinTwnySynPe8CX06XZ4VPfvybEUXTMbl08l6qITc9LwLbxOxpdFjrQuXkOyn9sM29NZAbN588VELVWFOTyYCN54hoebklWlrYRG1FjtxC3Si+61giH34XUo6nR/UvV3x1IDJM3qiMMmYbkPCnklcBtntaLxQuw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1472b6-15cc-46df-0519-08d86123ae4b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:21:55.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaOfjh6O6BZNQEVrJsYyN07pvheNrBlLeh51YOX6fuPb3IEcwBZqeP9znP7OO9kr7OoNKGT04Se0xf5ifxdyCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3277
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If enable DEBUG, will meet the following errors when build mpssd, so fix
them here. Only one error is listed here, other errors are similar.

mpssd.c: In function ‘virtio_net’:
mpssd.c:615:21: error: incompatible type for argument 2 of ‘disp_iovec’
     disp_iovec(mic, copy, __func__, __LINE__);
                     ^~~~
mpssd.c:361:1: note: expected ‘struct mic_copy_desc *’ but argument is of type ‘struct mic_copy_desc’
 disp_iovec(struct mic_info *mic, struct mic_copy_desc *copy,
 ^~~~~~~~~~

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 samples/mic/mpssd/mpssd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/samples/mic/mpssd/mpssd.c b/samples/mic/mpssd/mpssd.c
index a11bf6c5b53b..51d03545869e 100644
--- a/samples/mic/mpssd/mpssd.c
+++ b/samples/mic/mpssd/mpssd.c
@@ -612,7 +612,7 @@ virtio_net(void *arg)
 					copy.out_len, hdr->gso_type);
 #endif
 #ifdef DEBUG
-				disp_iovec(mic, copy, __func__, __LINE__);
+				disp_iovec(mic, &copy, __func__, __LINE__);
 				mpsslog("%s %s %d read from tap 0x%lx\n",
 					mic->name, __func__, __LINE__,
 					len);
@@ -632,7 +632,7 @@ virtio_net(void *arg)
 				if (!err)
 					verify_out_len(mic, &copy);
 #ifdef DEBUG
-				disp_iovec(mic, copy, __func__, __LINE__);
+				disp_iovec(mic, &copy, __func__, __LINE__);
 				mpsslog("%s %s %d wrote to net 0x%lx\n",
 					mic->name, __func__, __LINE__,
 					sum_iovec_len(&copy));
@@ -681,12 +681,12 @@ virtio_net(void *arg)
 						sizeof(struct virtio_net_hdr);
 					verify_out_len(mic, &copy);
 #ifdef DEBUG
-					disp_iovec(mic, copy, __func__,
+					disp_iovec(mic, &copy, __func__,
 						   __LINE__);
 					mpsslog("%s %s %d ",
 						mic->name, __func__, __LINE__);
 					mpsslog("read from net 0x%lx\n",
-						sum_iovec_len(copy));
+						sum_iovec_len(&copy));
 #endif
 					len = writev(net_poll[NET_FD_TUN].fd,
 						copy.iov, copy.iovcnt);
@@ -814,7 +814,7 @@ virtio_console(void *arg)
 			len = readv(pty_fd, copy.iov, copy.iovcnt);
 			if (len > 0) {
 #ifdef DEBUG
-				disp_iovec(mic, copy, __func__, __LINE__);
+				disp_iovec(mic, &copy, __func__, __LINE__);
 				mpsslog("%s %s %d read from tap 0x%lx\n",
 					mic->name, __func__, __LINE__,
 					len);
@@ -834,10 +834,10 @@ virtio_console(void *arg)
 				if (!err)
 					verify_out_len(mic, &copy);
 #ifdef DEBUG
-				disp_iovec(mic, copy, __func__, __LINE__);
+				disp_iovec(mic, &copy, __func__, __LINE__);
 				mpsslog("%s %s %d wrote to net 0x%lx\n",
 					mic->name, __func__, __LINE__,
-					sum_iovec_len(copy));
+					sum_iovec_len(&copy));
 #endif
 				/* Reinitialize IOV for next run */
 				iov0->iov_len = PAGE_SIZE;
@@ -866,12 +866,12 @@ virtio_console(void *arg)
 					iov1->iov_len = copy.out_len;
 					verify_out_len(mic, &copy);
 #ifdef DEBUG
-					disp_iovec(mic, copy, __func__,
+					disp_iovec(mic, &copy, __func__,
 						   __LINE__);
 					mpsslog("%s %s %d ",
 						mic->name, __func__, __LINE__);
 					mpsslog("read from net 0x%lx\n",
-						sum_iovec_len(copy));
+						sum_iovec_len(&copy));
 #endif
 					len = writev(pty_fd,
 						copy.iov, copy.iovcnt);
@@ -883,7 +883,7 @@ virtio_console(void *arg)
 							sum_iovec_len(&copy));
 					} else {
 #ifdef DEBUG
-						disp_iovec(mic, copy, __func__,
+						disp_iovec(mic, &copy, __func__,
 							   __LINE__);
 						mpsslog("%s %s %d ",
 							mic->name, __func__,
-- 
2.17.1


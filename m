Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7492327C099
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgI2JML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:12:11 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:53435
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgI2JMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:12:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2LPY0TwAKuW/nTl00rBqnc32Ks4RTiy9k/F9DXUuiLHQ6PLu4CGsup9ft/8Q3DyuDH4LCv8nRtPbQlzXc9tEATVI6g3L5LHHQ7EJnnARjqwWEYBR20hqsIr/i2AVilIj38j3mtaa3gqhjkRAAE4IwkhYOgRgvK17itW2W+krzgQp5Dn+OLhFrfCteFktSyiknYzL+3ApOHThdIdg4sqJsfE4SwQBJlexv+6Blz0HzI2Jpu6YRp99jeGrcEepAfvL+jnIPDHCTKK6+7S9E0/3/w+72h8YCa0fPghI7izL7skUsIGD+7iG2iwKdE2PkElVudRGvu4Zh1j6iraqA3vNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NFD8n9t3i34+3j9Y+kemIVdlvhtpcoWOIaZP4VxX9U=;
 b=GWM2ZczMm3ABwamBYnog3E9qSGrCMXIyT3SNSVfvnIsfy4rFgWP6xtcT+jh/Pg8nf2cSK4HmE2SMmc3LMdgOe18Hxv6jW9B/nKEy1pcrKaGv3xaRlMynRnXkbu1zjqcTDUqvISRB3iPWOgD9fviFPihUGfCXwAJ55hf7psEofQKVxf1udnw1+rZTIwL2Y5sgonYp0s9Lwp0QxFUe9Sg4i06bh0sx+F9ceI8+2EWxRB+v1F3gPFBeYaBBOKwoCYJLi5nr3+DiIzxhfN8fGYUCxqZABO0LSnRSHZ9u4MwlnqKTP7p/mwXyo8w6mhqGNE8GoYz32NbF8lj4G2F8ndNQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NFD8n9t3i34+3j9Y+kemIVdlvhtpcoWOIaZP4VxX9U=;
 b=R+ScAF+59kxKY1+CFBc7JXSRMaRvg11DEqGVCYIcf2hP+odHnKAMWeEKjqojiThFJA3tf97NwNARGXaymqprVu7k7zVrE5Zxu6CacsF/54dRW0UdKWyZ6pdi+h0O87ULlfGYSwtQzUyxmqV7jrtpKPrWmDpHJqW9wqT2uff5BjY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4064.eurprd04.prod.outlook.com (2603:10a6:803:4c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 09:12:05 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 09:12:05 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 1/4] samples: mpssd: fix the build errors when enable DEBUG
Date:   Tue, 29 Sep 2020 17:11:03 +0800
Message-Id: <20200929091106.24624-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929091106.24624-1-sherry.sun@nxp.com>
References: <20200929091106.24624-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR02CA0008.apcprd02.prod.outlook.com (2603:1096:3:17::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 09:12:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a86a781-5f65-4ecb-bf77-08d86457bbd1
X-MS-TrafficTypeDiagnostic: VI1PR04MB4064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4064955C7630C00E532CC5CF92320@VI1PR04MB4064.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dd56CBVrHX9gIXOd147gx237L+ddDZ0HU6cxDIDUJ4e6aKsR9YevXhPV1syl9wEWrv7jnim8ggT2B3xni6Br3l9tNq8DHs54ooKSTkzJi9B9K9s3TyX/kGt0d+yW7Fz2JNceVH6ZcXRXIofc9OuUbK+monB7WPUBrCyPzA8ep1GRPZNeHaCEaTP6+P+zGEvOxX7wkkpuw6O09M7W7i58RCXws5fGYa1ezGMqGZGLPSf0GYTOZDAC740mgajM+EpANl7nuGmE+MwVsn12xoc41nqNUPg0VOD8rpi8RiXc3z2cwpW5ZLhQOJ4f/91F13rb69Q3Aml97OqmiSM76YMbaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(8936002)(4326008)(52116002)(6506007)(83380400001)(5660300002)(1076003)(478600001)(66556008)(8676002)(86362001)(956004)(2616005)(2906002)(66946007)(36756003)(66476007)(6486002)(16526019)(6512007)(186003)(44832011)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FO60mIUJ7TqF4QoALbX64Jwsu4rbdK34U6t9Vjugvs4xzTt1qqlKViE2GBmqOlijVzL/P4eqj0HKF5OPcaArQ3rUZPbVG2XFyUW/UInWIuU5aleRwFa0/3G8wNNisCqMRcXAk0mX6tWAJmz0XWcvaEeXauSTny+oi1CCUOhTQLCIhQL8bw6T5iY9wnABdhpwU4PpfY5DuNefkXK0g+Q8KJHOq+nmgZEvjpZBddcJF599JmeXdpxMoIs24Gci2GEMJ/dqayn1qOtI1lbNk6hMHefkgJ2L6+wpTqrSCIn3SHxPV3YW9gvjgT2rwWH3UmGnYyZ6MBhRX5OgUK5LcmvM1KJxNMCv0JWMCMCqk9BhB9FrpGJlU1hkrjg1FvaFdpbgtua6xL7coo/BWjR+7RHrLWbIhquIrO9gKi4vlBnzsCa0tDOIT+Fc2Ccs3ZgCjhujzufPJD6ibCi1lBCMGlq6MrNnFx8B1e8mwkZii06WUu/FSXmVxf7B1xsD6Oxmyvjty6h2E+CXKdIDQWW0bV5VeGuMQS/2Wa9SAcE9NEkfqi0T0rJWMGImZkmsI8ENQSxi4yF60Ny2CLhkjDBdnO1vv7lD82P0hUU9bRz1huf5FEaIIjoZhX1WAm3lr8GsGTLvDHoOvvq0/UfugPr3VXeoIg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a86a781-5f65-4ecb-bf77-08d86457bbd1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 09:12:05.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wQaiGYZXDE28wqg8qahNBwDqVtitCKE55m+VZV/gUjyXE+P3K0yTsi5INdEva4bnHzNot7Oew/ze39e134YFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4064
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


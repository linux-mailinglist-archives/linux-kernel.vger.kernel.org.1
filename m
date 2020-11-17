Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC162B6945
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgKQQBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:01:18 -0500
Received: from mail-bn8nam11on2091.outbound.protection.outlook.com ([40.107.236.91]:16082
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbgKQQBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:01:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGiv1DyIOr9I93ZZTqOi7K5S5W6nmVqeSuLExUjRO+SbHxFJ3niEfyND4y9sA9nkpz8W2mlW71sQSRHNfTOi9g5HXd7RwxHfMaQhIy2cgnNW6s712smlGrA/sm0YlbK2piU/dcX2cUdpUyH04+HqehrDm/VPpcBlKjeB5YDKv9LIt09VZMneiucRJokzbwFdwKPHMC7kxbdkR8uc6FgCbVwCG7UUnJS87g7TLNUWyhs1lL29KOJwPqsq0UhB4B60dZLiyU9V1ckLv92bw0lYB8RN4tY4CGNiOEhl3DGsMJcP+RWILSWJvN7cfe6EeYw2sfb/s7T2tMK6C+pB7JYRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tG7pNxmWoxb3pXZtS5axLkqVYVhtjGInIgigiwMehI=;
 b=d1YrksOqopZty1N9828GUGBJ8wyqGqJkdM6zCKrMUTdu6SbiiYh0ep5jpi97OU9/qIaKWQ39abHWjbGTBpMsynl0pCTbwdRtFErvYCSiPkyEyrfuamHa7ESC+JVJRz35cBYzZwI9QT+2oEBtck+xNbXIilgR8Pfd2tvy/xD7sRpoYcec7HSidloGJ8NtRagK05EPZ9t1BZ0awWZZ6hW3DrUrinziAr1NgcUpdm3wqBggkfhVhaQMM5P8Xt8ubhM6d9+ISrD2KYouv+mpUu9fPAmJOH80XDRRysPo7zBD0H5cY6QRFK32NX2Btrz30GjWS90YIjl8ovtbzk6FbJ1pxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tG7pNxmWoxb3pXZtS5axLkqVYVhtjGInIgigiwMehI=;
 b=fKKGcZ9+e4lJV3e7VpK7/VTK1EGTO1xUSj7/qW+Y3JMuKmON1VbUV0Ggjx7/7n6TXb2T1ytY/wGZ5ZicN0mpvrNU6DDle8A7NUuo/nBDo2QrtfDgDr2LCF1QTKVrod1y2hIkCzvqqmTKewBSXQCPBiFIdTWRV7/5gCVVcm7/WOE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from BN6PR11MB3874.namprd11.prod.outlook.com (2603:10b6:405:81::18)
 by BN6PR1101MB2067.namprd11.prod.outlook.com (2603:10b6:405:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 17 Nov
 2020 16:01:08 +0000
Received: from BN6PR11MB3874.namprd11.prod.outlook.com
 ([fe80::8036:d1d5:1b59:ee34]) by BN6PR11MB3874.namprd11.prod.outlook.com
 ([fe80::8036:d1d5:1b59:ee34%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 16:01:07 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     linux-kernel@vger.kernel.org
Cc:     initramfs@vger.kernel.org, kyungsik.lee@lge.com,
        yinghai@kernel.org, JBeulich@suse.com
Subject: [PATCH v2] unlz4: Handle 0-size chunks, ignore trailing padding
Date:   Tue, 17 Nov 2020 11:00:54 -0500
Message-Id: <20201117160054.7780-1-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [174.70.73.170]
X-ClientProxiedBy: BN4PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:403:3::13) To BN6PR11MB3874.namprd11.prod.outlook.com
 (2603:10b6:405:81::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (174.70.73.170) by BN4PR13CA0003.namprd13.prod.outlook.com (2603:10b6:403:3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.12 via Frontend Transport; Tue, 17 Nov 2020 16:01:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1eb2e05-5136-4b14-3ee9-08d88b11fe87
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2067:
X-Microsoft-Antispam-PRVS: <BN6PR1101MB2067F953CB3B0192E473CEE8B1E20@BN6PR1101MB2067.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaHFMGsDV5dImyQSZL0cH3x97ZbkI2eo6bvFRYwwUHT1dxtywRAYqJ6EfgzDzwSFzB5Qgv0LYR3FTGgwg4jIfcys9f+VbygUHOnYd6/RIeBaPIcFE8uAqJYJhllnzL7f92h8Q4rSeXUO8aZOqc4+yBLhRoQ9HNEb5WE+4gpLFP6ZOzyDufGRHA5A5h7o9poFnscrd7Q1xP6N/di0vBBTx/K/E2gM1LdsgDkok8EXZUCLhBp4x1semUQXrYEiLjOKajkoQR5D55VGyX1y+RqK+fSzy88UuHR+HPxwfqt8us+4Ir1q1F2JN5LXwjikb8g5nsF06wLgt00FRJOZE1QkyJa+sLSLK6ir0u8V271fJkaNlLM/e9so31ZgIVzyX5mA1B5eXr1YVPq9Wr6zPCGccA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(39840400004)(136003)(83380400001)(2616005)(16799955002)(52116002)(956004)(16526019)(6486002)(7696005)(1076003)(86362001)(9686003)(8936002)(6916009)(36756003)(2906002)(5660300002)(8676002)(316002)(478600001)(966005)(26005)(6666004)(186003)(4326008)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: duXT1Wxz7Z/PxP7NdkFi/grpRJtLq/O4KmKGoBT2goBf6Z9UWSEX5sJGDX+gaHISlTpGn0rVdEKI6PR9VxTskdHcmn5BlKfAQiUaKkyEUASD2fJBB4l9GklTtck4extOJVOm3nFUWKkxLbxxbYbJj+gz2RHPMQlUgBJJd7UvI24km9G1ayV/yumcOfRXmN3n5ET7pggEEenXAXAsxvjcCXL43LB4aTkMOG+LoHcv9a80R4u92HeiGLdOO3mmGqpFVL9TV3Cgb1NdVkJhYi9lcfYygjOygDZEatFwXzCN33IM0yaSHerPh5xZ2jtFS915wMsaaLwpX7CncExpRJEoSBcIA4dABnMukXZLrFFmmR6Hj+vEo/cR0XDQQaOJ769JvrRA2Rn8Kklf85PltKalm6d7E6UBflSn9C5FjjmfKl6VVcYgaVXHEn0Ayy0KKUOisepkjz6sIAa1Eh96cbWGCRjjlUJS9Cb2VgxNj9foBsjUD4YGAAn0n8/7qY8gHTaLKRHebsU+Pg+GDneoeBG3DZvssGlVncQPklTCr4tftU8790Hd8Idv4cY3i8VhcMWZLSCV4Vd7vqdmxcSRK0wEfPZbcZfhUBoJPjCz9TbVt6V0I7lUaPhiB10pN7LBptjr/wGSasMuNIgVt3i88ZtGItubtPFPNEyiztjNzmBIJ9mhVj2HUnrvzizSQmth2neAyZdhy/263t1iKISMhpQ/Qa1Xthf3jwDTrdIGxaganKQKberIMS+MGPF/nFmRaru/xCrhllrDeZIMfTGwAnb5bPDo90kj6E0zN6LNsCP6Hfu+Z4Xh9pCcXpjCRuBdv43XlgcilV5jPJRECtsc5TebSqDWSerpMCBrHA8NfkrnXc36Cm5ICLpGrhfL5lMdXHswaEWQ0PuREsp+X4aZhvr5xQ==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eb2e05-5136-4b14-3ee9-08d88b11fe87
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 16:01:07.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvblKGK+QYAgUja524gMFxsviFwuzevjkHqBJiIASKvwHUb/wtGo6R0VsXuHVyD5YcwcpkUvuy+lS/nFafrd+7U5/hZHq0Mk0RtsKd4DAnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

SHORT DESCRIPTION:

There are two places in unlz4() function where reads beyond the end of a
buffer happen under certain conditions which had been observed in real life
on stock Ubuntu 20.04 x86_64 with several vanilla mainline kernels,
including 5.10.0. As a result of this issue, the kernel fails to decompress
LZ4-compressed initramfs with following message showing up in the logs:

initramfs unpacking failed: Decoding failed

Note that in most cases the affected system is still able to proceed with
the boot process to completion.

The patch had been tested on Ubuntu 20.04 x86_64 with kernel 5.4.66 and
5.10.0.

LONG DESCRIPTION:

Background.
Not so long ago we've noticed that some of our Ubuntu 20.04 x86_64 test
systems often fail to boot newly generated initramfs image. After
extensive investigation we determined that a failure required the
following combination for our 5.4.66-rt38 kernel with some additional
custom patches:

Real x86_64 hardware or QEMU
UEFI boot
Ubunutu 20.04 (or 20.04.1) x86_64
CONFIG_BLK_DEV_RAM=y in .config
COMPRESS=lz4 in initramfs.conf
Freshly compiled and installed kernel
Freshly generated and installed initramfs image

In our testing, such a combination would often produce a non-bootable
system. It is important to note that [un]bootability of the system was
later tracked down to particular instances of initramfs images, and would
follow them if they were to be switched around/transferred to other
systems. What is even more important is that consecutive re-generations of
initramfs images from the same source and binary materials would yield
about 75% of "bad" images. Further, once the image is identified as "bad",
it always stays "bad"; once one is "good" it always stays "good". Reverting
CONFIG_BLK_DEV_RAM to "m" (default in Ubuntu), or changing COMPRESS to
"gzip" yields a 100% bootable system. Decompressing "bad" initramfs image
with "unmkinitramfs" yields *exactly* the same set of binaries, as verified
by matching MD5 sums to those from "good" image.

Speculation.
Based on general observations, it appears that Ubuntu's userland toolchain
cannot consistently generate exactly the same compressed initramfs image,
likely due to some variations in timestamps between the runs. This causes
variations in compressed lz4 data stream. Further, either initramfs tools
or lz4 libraries appear to pad compressed lz4 output to closest 4-byte
boundary. lz4 v1.9.2 that ships with Ubuntu 20.04 appears to be able to
handle such padding just fine, while lz4 (supposedly v1.8.3) within Linux
kernel cannot. Several reports of somewhat similar behavior had been
recently circulation through different bug tracking systems and discussion
forums [1-4].
I also suspect only that systems which can mount permanent root directly
(or with help of modules contained in first, supposedly uncompressed, part
of initramfs, or the ones with statically linked modules) can actually
complete the boot when LZ4 decompression fails. This would certainly
explain why most of Ubuntu systems still manage to boot even after failing
to decompress the image. CONFIG_BLK_DEV_RAM=y made system unbootable in our
case since unconditional presence of ramdisk block device at time of
failing initramfs changed how and where the kernel is looking for /init
(basically, looking at ramdisk only).

The facts.
Regardless of whether Ubuntu 20.04 toolchain produces a valid
lz4-compressed initramfs image or not, current version of unlz4() function
in kernel has two code paths which had been observed attempting to read
beyond the buffer end when presented with one of the "padded"/"bad"
initramfs images generated by stock Ubuntu 20.04 toolchain. Some
configurations of some 5.4 kernels are known to fail to boot in such cases.
This behavior also becomes evident on vanilla 5.10.0-rc3 and 5.10.0-rc4
kernels with addition of two logging statements for corresponding edge
cases, even though it does not prevent system from booting in most generic
configurations.

Further investigation is likely warranted to confirm whether userland
toolchain contains any bugs and/or whether any of these cases constitute
violation of LZ4 and/or initramfs specification.

cc: stable@vger.kernel.org
Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

---

References

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1835660
[2] https://github.com/linuxmint/mint20-beta/issues/90
[3] https://askubuntu.com/questions/1245458/getting-the-message-0-283078-initramfs-unpacking-failed-decoding-failed-wh
[4] https://forums.linuxmint.com/viewtopic.php?t=323152

Please CC: me directly on all replies.

 lib/decompress_unlz4.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/decompress_unlz4.c b/lib/decompress_unlz4.c
index c0cfcfd486be..a016643a6dc5 100644
--- a/lib/decompress_unlz4.c
+++ b/lib/decompress_unlz4.c
@@ -125,6 +125,21 @@ STATIC inline int INIT unlz4(u8 *input, long in_len,
 			continue;
 		}
 
+		if (chunksize == 0) {
+			/*
+			 * Nothing to decode...
+			 * FIXME: this could be an error condition due
+			 * to invalid or corrupt data. However, some
+			 * userspace tools had been observed producing
+			 * otherwise valid initramfs images which happen
+			 * to hit this condition.
+			 * TODO: need to figure out whether the latest
+			 * LZ4 and initramfs specifications allows for
+			 * zero-sized chunks.
+			 * See similar message below.
+			 */
+			break;
+		}
 
 		if (posp)
 			*posp += 4;
@@ -179,6 +194,20 @@ STATIC inline int INIT unlz4(u8 *input, long in_len,
 			else if (size < 0) {
 				error("data corrupted");
 				goto exit_2;
+			} else if (size < 4) {
+				/*
+				 * Ignore any undersized junk/padding...
+				 * FIXME: this could be an error condition due
+				 * to invalid or corrupt data. However, some
+				 * userspace tools had been observed producing
+				 * otherwise valid initramfs images which happen
+				 * to hit this condition.
+				 * TODO: need to figure out whether the latest
+				 * LZ4 and initramfs specifications allows for
+				 * small padding at the end of the chunk.
+				 * See similar message above.
+				 */
+				break;
 			}
 			inp += chunksize;
 		}
-- 
2.17.1


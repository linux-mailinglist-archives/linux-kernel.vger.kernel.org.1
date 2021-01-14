Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1842F6BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbhANUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbhANUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:03:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:03:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so5562661wmz.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=surgut.co.uk; s=google;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nN6PRtS5pLhLaXXAjEjLtwK6vbI+9DCsM0hEkAJhqwM=;
        b=IxaeE8gbqJuU3nw9Yn0ATXzzpVmjJVhFCNqQr5/cuwJkZQnwmgebeRmEgG6xZphS6H
         5VdRpgoRzb1xbOyaoz0a6xOzKjaUyz59Y1PHe0fNGaY0Wmqv7CdBW1K2UWvqdCC2jyOB
         hDOR0nhuo+VnlVkOmg60ltT5UUJvbBTSJ41pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=nN6PRtS5pLhLaXXAjEjLtwK6vbI+9DCsM0hEkAJhqwM=;
        b=BSrT12V1WHFvtxnjZ7zppOLLZ7dYaIevXSyV2VEwWHW++WsOt9KIa8i2ZNC3XzyDOc
         9dolA8rqiCtk0J44EX61YAcnCy1h5Bb66FPN29g9N1X3ErwCmbscAZWXwf/ssGffoQUF
         HEioF9XqRKdBMRgfHneQaWrRhuU15YK6jyM965DUFUfUEGPNgZm2P27i48o4Um1WFzMk
         HPPYov2ozJuLESViYlJ6LBGbJT6YR1/9loWQvFhDchTo/knEhkDknwbEUWu39x0WvqP7
         w5TnPrYm0M0KCnbBm1I9XJeKlySt7auM+fkpzqu0eClkFInGLttmD6oxd45hL0D+3BC9
         nCEw==
X-Gm-Message-State: AOAM5320BF1ODDDtPZNubXRik9jiK+sRvc+4X0LuXrJTmOFYoUwNfb4x
        DUL8HMpPjAq9LzNI/D9xNYqbrJKIFODbkg==
X-Google-Smtp-Source: ABdhPJzkWrAUtRQl5/J4I3xMSoKLfgi54KQ2WXg0n9ry8mr28pzW1Aa0NNfw/tJBN/UVr1RjltlYww==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr5395432wmh.132.1610654590348;
        Thu, 14 Jan 2021 12:03:10 -0800 (PST)
Received: from localhost ([2a01:4b00:85fd:d700:ae8f:3959:416e:cfc4])
        by smtp.gmail.com with ESMTPSA id h9sm10684700wre.24.2021.01.14.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 12:03:09 -0800 (PST)
Sender: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
From:   Dimitri John Ledkov <xnox@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dimitri John Ledkov <xnox@ubuntu.com>
Subject: [PATCH] lib/decompress_unlz4.c: correctly handle zero-padding around initrds.
Date:   Thu, 14 Jan 2021 20:02:56 +0000
Message-Id: <20210114200256.196589-1-xnox@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lz4 compatible decompressor is simple. The format is underspecified and
relies on EOF notification to determine when to stop. Initramfs buffer
format[1] explicitly states that it can have arbitrary number of zero
padding. Thus when operating without a fill function, be extra careful to
ensure that sizes less than 4, or apperantly empty chunksizes are treated
as EOF.

To test this I have created two cpio initrds, first a normal one,
main.cpio. And second one with just a single /test-file with content
"second" second.cpio. Then i compressed both of them with gzip, and with
lz4 -l. Then I created a padding of 4 bytes (dd if=/dev/zero of=pad4 bs=1
count=4). To create four testcase initrds:

 1) main.cpio.gzip + extra.cpio.gzip = pad0.gzip
 2) main.cpio.lz4  + extra.cpio.lz4 = pad0.lz4
 3) main.cpio.gzip + pad4 + extra.cpio.gzip = pad4.gzip
 4) main.cpio.lz4  + pad4 + extra.cpio.lz4 = pad4.lz4

The pad4 test-cases replicate the initrd load by grub, as it pads and
aligns every initrd it loads.

All of the above boot, however /test-file was not accessible in the initrd
for the testcase #4, as decoding in lz4 decompressor failed. Also an error
message printed which usually is harmless.

Whith a patched kernel, all of the above testcases now pass, and /test-file
is accessible.

This fixes lz4 initrd decompress warning on every boot with grub. And more
importantly this fixes inability to load multiple lz4 compressed initrds
with grub.

I guess I should convert above decompressor streams with/without padding
into kunit tests, across all decompressor algorithms.

[1] ./Documentation/driver-api/early-userspace/buffer-format.rst

BugLink: https://bugs.launchpad.net/bugs/1835660
Signed-off-by: Dimitri John Ledkov <xnox@ubuntu.com>
---
 lib/decompress_unlz4.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/decompress_unlz4.c b/lib/decompress_unlz4.c
index c0cfcfd486be..e6327391b6b6 100644
--- a/lib/decompress_unlz4.c
+++ b/lib/decompress_unlz4.c
@@ -112,6 +112,9 @@ STATIC inline int INIT unlz4(u8 *input, long in_len,
 				error("data corrupted");
 				goto exit_2;
 			}
+		} else if (size < 4) {
+			/* empty or end-of-file */
+			goto exit_3;
 		}
 
 		chunksize = get_unaligned_le32(inp);
@@ -125,6 +128,10 @@ STATIC inline int INIT unlz4(u8 *input, long in_len,
 			continue;
 		}
 
+		if (!fill && chunksize == 0) {
+			/* empty or end-of-file */
+			goto exit_3;
+		}
 
 		if (posp)
 			*posp += 4;
@@ -184,6 +191,7 @@ STATIC inline int INIT unlz4(u8 *input, long in_len,
 		}
 	}
 
+exit_3:
 	ret = 0;
 exit_2:
 	if (!input)
-- 
2.27.0


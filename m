Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8248A2E7664
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgL3GAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgL3GAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:00:30 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC8BC061799
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 21:59:50 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c79so9200724pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 21:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HdLUYemGiEmRhFOxJCoWxfElzaavQObvDEFcrLMsjbU=;
        b=FkuDyxEvmzXmU69s84fw5GI/7svQhvMtouak09N2zw4vvAiZV9f5L3RrqPgiV5ArBB
         vXtT8E+de0DL9thZN115kbtzmiukFMEo3oNmbEFR00m/dyZ3RdDhiddey4xxuBNIi0yg
         MDz9QzEE9R4X1pTnD0SD/Meq5I+TB+P+HpW2/X7ZgE2rwyq1wF57Sa+fpn1dW31yqPy2
         tS1EWzlfTnT0A5Psb/dBhFGV+01BDiRooNJmMstu1PNhEaki+sfycCNbi5mR6S3Ym4DX
         oh0KAOR0iAakvs+Sh3/QzXkklicPeCIcSQ4++6qYrSVXz2lH3vrj7rFB/+Af9M5AFvai
         0z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HdLUYemGiEmRhFOxJCoWxfElzaavQObvDEFcrLMsjbU=;
        b=pBkCFBRSFJul6lJQfXoaGMIxvOkk+BbWPY3EgVbItdOF467dBZQrC0D3kL43+7u57h
         0MR8pF97PIXbw82IF6bC+ivnF4iuqP6J9ORWynj67jR0kPBOyup7EZiYOQx++t2RbHMM
         h7neRPXk/kBgLIrBjBDGGZztsNdoVcUH7snKKDkf8G1/2nzEnSmp42D/esz2VgLHcGTJ
         TAyZP+9ut9AFZ/Ibven4wHGwEGM6wCoB+JYkkG0B4Lp7PAT3F2bH6mE0b4hUkjKVt7Pb
         OgOWszQA5RGacx2Fq58EV70yHHABRvfN4qzhR4OrSchPnFEQJQoyxSWOiZG2CduMtD2T
         ngmQ==
X-Gm-Message-State: AOAM532QbIGy9YTs77yNdP7jgou25uwuzxpi68ys21dRjD/RZQDaJuma
        wINcGBbOiKl5NLfe8VyJ3ePp3xfPQnU=
X-Google-Smtp-Source: ABdhPJztUhBtEjTZ9M80l+2UYjr13DwY4bvgIBglbcOVgQ3FFoDxeil5jKO27zctcOCzPCiKWhV8Ag==
X-Received: by 2002:a63:c84a:: with SMTP id l10mr14797337pgi.159.1609307989158;
        Tue, 29 Dec 2020 21:59:49 -0800 (PST)
Received: from localhost.localdomain ([45.41.181.217])
        by smtp.gmail.com with ESMTPSA id h16sm47034685pgd.62.2020.12.29.21.59.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2020 21:59:48 -0800 (PST)
From:   Hongfei Shang <shfwin6@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hongfei Shang <shanghongfei@kylinos.cn>
Subject: [PATCH] initramfs: fix "Decoding failed"
Date:   Wed, 30 Dec 2020 13:59:40 +0800
Message-Id: <20201230055940.17784-1-shfwin6@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongfei Shang <shanghongfei@kylinos.cn>

when initrd image file load in memory, it is align to 4 bytes,
so there are may be some padding bytes(<4),
should ignore these padding bytes and handle as normal end

before: (when size of initrd.img is: size%4 = 1, 2 or 3)
"Initramfs unpacking failed: Decoding failed"

after:
no error message

Signed-off-by: Hongfei Shang <shanghongfei@kylinos.cn>
---
 lib/decompress_unlz4.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/decompress_unlz4.c b/lib/decompress_unlz4.c
index c0cfcfd486be..7527f1541dfd 100644
--- a/lib/decompress_unlz4.c
+++ b/lib/decompress_unlz4.c
@@ -181,6 +181,14 @@ STATIC inline int INIT unlz4(u8 *input, long in_len,
 				goto exit_2;
 			}
 			inp += chunksize;
+
+			if (size < 4) {
+				unsigned int padding = 0;
+
+				memcpy(&padding, inp, size);
+				if (padding == 0)
+					break;
+			}
 		}
 	}
 
-- 
2.25.1


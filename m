Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B483C2DD503
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgLQQP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgLQQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:15:55 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF3CC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 08:15:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id be12so2341818plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 08:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWcwQWRHez3gIHia6wDyGTXC4huvBrkLRyK3EXFiFkU=;
        b=H54oRTnfvKxoo4Dvlf3Gy8Qlc+wk199jlu0xCzmjojprS27Qt5Rm8hlsBlrWvSvYkr
         +FZyb133SSq0kBs9KWxoUCHxWk05OYxD4jnF2cYlj7VIaU4Q2Zw/abNppmR9MvR/W5IN
         TFKzuUebZN3DoHgtRdCBhHWH9YqsyKm5OwRnEC5tjk/jGtEPba//Pajmz7yyMWXp1YRh
         3zknxW5gc5kpW7EGiaZfce6ndBRTd0LNBdsCMayR4SiPCCIUD/CeUyNq1YCsG9a4a29k
         TzSv49ygj4lFvQlTJLBC//OkMU4TZLDc4qKoTPW2OmfP805KXVoLzLMiiJjcjtfsHe9J
         wzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWcwQWRHez3gIHia6wDyGTXC4huvBrkLRyK3EXFiFkU=;
        b=SRr1rJjedLzYB9JFILFl66USpQBTuqnVfpMlxCbNYIrOg/fp6yVXbYHQzMZUBtyh5S
         qocVfsZXGxYJwbapp+ddEUYYkUpjOZdIlVt5Q+MKwBJ/ytGBSde5Qg0qqPkRwQEi9NNO
         2cN9wJ3sKZ6oJJ523gmkuQ2mkpeEhGUa3DZ9k/yS3KqEYT8eCkh1QDTbPA57CtPomcjU
         RmmBJxwNlQxYimB/wuVBtUVZRaYQbCMCjpJvZ13nBAvzDyUH7Guk9oyroHP87U3ie+xZ
         YCgoJLLjCTt8icqn6++7VEDmxupsgVZTaBRjiv6QzLByhnh3B/C1qhViq5GxOKiuJRyU
         3iTA==
X-Gm-Message-State: AOAM532xaPg/I46TuqzhjNDfw3Wy4Ya3ZAvR9oCXRbRzDvCxuhy+Rgib
        h4QGyn7ivWNwrCYI6fzxVzs=
X-Google-Smtp-Source: ABdhPJxnvmKlf6nqzTotx/tiWoPWLa1/qPj6kF14k48nYV5rc1RU/rvdEgbSg1W9d7cHa8kfa8B5mQ==
X-Received: by 2002:a17:902:b406:b029:db:3c3:e4cd with SMTP id x6-20020a170902b406b02900db03c3e4cdmr23116plr.79.1608221715073;
        Thu, 17 Dec 2020 08:15:15 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id c24sm6718785pgi.71.2020.12.17.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 08:15:14 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH] f2fs-tools: man page fix for sload compression
Date:   Fri, 18 Dec 2020 00:15:09 +0800
Message-Id: <20201217161509.866105-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

Fix man page for sload.f2fs compression support

Signed-off-by: Robin Hsu <robinhsu@google.com>
---
 man/sload.f2fs.8 | 94 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 84 insertions(+), 10 deletions(-)

diff --git a/man/sload.f2fs.8 b/man/sload.f2fs.8
index d07330c..c165b35 100644
--- a/man/sload.f2fs.8
+++ b/man/sload.f2fs.8
@@ -7,22 +7,48 @@ sload.f2fs \- load directories and files into the device directly
 .B sload.f2fs
 [
 .B \-f
-.I source directory path
+.I source-directory-path
 ]
 [
 .B \-t
-.I mount point
+.I mount-point
 ]
 [
 .B \-d
 .I debugging-level
 ]
+[
+.B \-c
+[
+.B \-L
+.I log-of-blocks-per-cluster
+]
+[
+.B \-a
+.I compression-algorithm
+]
+[
+.B \-x
+.I file-extension-to-exclude-from-compression
+|
+.B \-i
+.I file-extension-to-include-for-compression
+]
+[
+.B \-m
+.I minimum-compressed-blocks-per-cluster
+]
+[
+.B \-r
+]
+]
 .I device
 .SH DESCRIPTION
 .B sload.f2fs
-is used to load directories and files into a disk partition.
-\fIdevice\fP is the special file corresponding to the device (e.g.
-\fI/dev/sdXX\fP).
+is used to load directories and files into a disk partition, or an F2FS
+image (file).
+\fIdevice\fP could a special file corresponding to the device (e.g.
+\fI/dev/sdXX\fP), or an F2FS image file.
 
 .PP
 The exit code returned by
@@ -30,24 +56,72 @@ The exit code returned by
 is 0 on success and -1 on failure.
 .SH OPTIONS
 .TP
-.BI \-f " source directory path"
+.BI \-f " source-directory-path"
 Specify the source directory path to be loaded.
 .TP
-.BI \-t " mount point path"
+.BI \-t " mount-point-path"
 Specify the mount point path in the partition to load.
 .TP
 .BI \-d " debug-level"
 Specify the level of debugging options.
 The default number is 0, which shows basic debugging messages.
 .TP
+.BI \-c
+Enable a cluster-based file compression.
+The file would be chopped into clusters, and each cluster is compressed
+independently.
+.TP
+.BI \-L " log-of-blocks-per-cluster
+Specify cluster size in power of two blocks.
+The minimum value is 2 (4 blocks, default).
+The maximum value is 8 (256 blocks).
+Note that a block contains 4096 bytes.
+This option must be used with option \fB\-c\fR.
+.TP
+.BI \-a " compression-algorithm"
+Choose the algorithm for compression. Available options are:
+lzo, lz4 (default).
+This option must be used with option \fB\-c\fR.
+.TP
+.BI \-i " file-extension-to-include-for-compression"
+Specify a file extension to include for the compression.
+To specify multiple file extensions, use multiple option \fB\-i\fR's.
+Files having one of the listed extensions will be compressed.
+This option must be used with option \fB\-c\fR.
+.TP
+.BI \-x " file-extension-to-exclude-from-compression"
+Specify a file extension to exclude from compression.
+To specify multiple file extensions, use multiple option \fB\-x\fR's.
+Files having one of the listed extensions won't be compressed.
+This option must be used with option \fB\-c\fR.
+.TP
+.BI \-m " minimum-compressed-blocks-per-cluster"
+Specify a minimum block count saved (by compression) per cluster.
+The minimum value is 1 (default).
+Maximum value is the cluster size in blocks minus 1.
+If compression of a cluster fails to save at least the minimum compressed
+block count given by the option, the cluster will not be compressed.
+This option must be used with option \fB\-c\fR.
+.TP
+.BI \-r
+Specify read-only flag for the compressed files.
+It allows filesystem to release compressed space to the users, since, without
+this option, filesystem should keep the space for future file updates.
+This option must be used with option \fB\-c\fR.
+
+.SH NOTES
+If neither \fB\-i\fR nor \fB\-x\fR is used, all files will be compressed.
+Obviously, option \fB\-i\fR and \fB-x\fR can not be used together.
+
 .SH AUTHOR
 This version of
 .B sload.f2fs
-has been written by Hou Pengyang <houpengyang@huawei.com>,
-Liu Shuoran <liushuoran@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
+has been contributed by Hou Pengyang <houpengyang@huawei.com>,
+Liu Shuoran <liushuoran@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
+Robin Hsu <robinhsu@google.com>
 .SH AVAILABILITY
 .B sload.f2fs
-is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
+is available from <git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git>.
 .SH SEE ALSO
 .BR mkfs.f2fs(8),
 .BR fsck.f2fs(8),
-- 
2.29.2.684.gfbc64c5ab5-goog


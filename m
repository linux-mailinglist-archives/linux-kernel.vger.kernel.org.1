Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB18B2F5B65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbhANHgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbhANHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:36:08 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6DCC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:35:28 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 30so3196589pgr.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eze22wqcpsTWbd1NuHKH1Yw11vYjsb5gy7SRhvZr/P4=;
        b=kqkKOaXkiBCJ6zNgIrer5E0F+51dO/snWGNUUQJhlBQQhExQRArBcImjl6USts8KVN
         R9lXyn9X9dy9YWL98MgXmbH//eKKb9bjWoggNrtQZg6e8J0Qw6envQJ4CrgCadQuzs4v
         vDfCvM0dd624GU2UBuxqer32lOsO4D2sXgxkJEi1cHcer7UcBo5WZ9tSQnKNaWZS4r6f
         49YP4tiRE20CS5L1+HdgCQLBOOERkDgaQH4aQU+90KgvFeeZo0mgTBHP9g70n90NHdy4
         bOv7fP2AZ7OB0Vb0+C/1nZkhO/UtBKQmkiUQ3N+areQI2ErvcOgGIMitiWuNnFRHke08
         hemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eze22wqcpsTWbd1NuHKH1Yw11vYjsb5gy7SRhvZr/P4=;
        b=qaDbcbN5qBg2TcoK0ORykz7bIsQSIrCT36rLewmEnaEPeXwEfI/3QpPCh7goWP8XYn
         LaYj0YYcTDnwUpHc5Y21D7ajc5MQfEHc3RvXDkxs7PQRFkD/TWeXFsibMTkvwhoXuT+u
         WFzvB8CxXTXWU9Q57HJMEp7C++yqORR7gKkApFF8ESzu9+Qdi8AFwmLs8uVOs7Tjf/ax
         f0VRR8juDUFtETRJwRYz6jZ4+/gUXV+W+J+Nti1YqUelkrS6l3NFGiDJKavehnpPTzNI
         QAOi1e410n3wv/k/vGiiJmqSxSc5RNTCsw2Jpkpw+Ut0s3I+uMRSCTTaxgC6xfdCDEUz
         M50g==
X-Gm-Message-State: AOAM532pABZS+x8ThcSFmhEbK6mGmQ1zRQliEzeoys4LUgIv1cMb6jFi
        nky6LXxwl2c8XzJ7yJSGhWDwGQVxp0819Q==
X-Google-Smtp-Source: ABdhPJzltz7TUsfamMjWZb42Eg905F+9IU8AQxpguZCcD7hZCoUinsYvWUQu7dTjW+zWJ1wRYr/lyg==
X-Received: by 2002:a62:7bcd:0:b029:19e:9bb7:6db3 with SMTP id w196-20020a627bcd0000b029019e9bb76db3mr6370186pfc.34.1610609727872;
        Wed, 13 Jan 2021 23:35:27 -0800 (PST)
Received: from localhost.localdomain ([2405:201:600d:a089:b1fd:acc0:2bb9:df96])
        by smtp.googlemail.com with ESMTPSA id x20sm4442145pfc.3.2021.01.13.23.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 23:35:27 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] checkpatch: fix false positive for COMMIT_LOG_LONG_LINE with URLs
Date:   Thu, 14 Jan 2021 13:05:12 +0530
Message-Id: <20210114073513.15773-2-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114073513.15773-1-yashsri421@gmail.com>
References: <84492ae9-7452-d296-49ab-4d37eed3b968@gmail.com>
 <20210114073513.15773-1-yashsri421@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch warns for long line in commit messages even for
URL lines.

An evaluation over v5.6..v5.8 found that out of 1703 warnings reported
by this class, 161 are due to the line containg URLs. Out of these 161,
53 are due to lines where URL is the first non-whitespace character of
the line.

E.g. running checkpatch on commit 3cde818cd02b ("ASoC: topology:
Consolidate how dtexts and dvalues are freed") reports this warning:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html

Avoid giving users warning for character limit for such cases, instead
suggest them to prefix the URLs with "Link:"

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e6857bdfcb2d..e8851ce73149 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3023,9 +3023,14 @@ sub process {
 		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
 					# A Fixes: or Link: line or signature tag line
 		      $commit_log_possible_stack_dump)) {
-			WARN("COMMIT_LOG_LONG_LINE",
-			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
-			$commit_log_long_line = 1;
+			if ($line =~ /^\s*[a-z][\w\.\+\-]*:\/\/\S+/i) {
+				WARN("COMMIT_LOG_LONG_LINE",
+				     "Consider prefixing the URL with 'Link:'\n" . $herecurr);
+			} else {
+				WARN("COMMIT_LOG_LONG_LINE",
+				     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+				$commit_log_long_line = 1;
+			}
 		}
 
 # Reset possible stack dump if a blank line is found
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F146328E841
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgJNVPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730735AbgJNVPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602710150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=mqhbYTRX5f/rqDmOf+PPGbtTcPsW2ZMsmxyvTA9h6L8=;
        b=FL0zpCBzxban+N9YAnwS8OyKaT3T848mhBrhGk1rumOKtfoEWdO17+lwRFaTZ0qfjJJaYN
        ahpaf8Q6wV5eq1gUTw7iuaSuoXqVam5DiSIEJ9dvmtBqv2PS2ALU20t29u6DIH9oXTfGsl
        vJPho09dgqwpiaoYoURU01yFaS9pObI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-hNE1LqMBNmCwKjbKKd8wvw-1; Wed, 14 Oct 2020 17:15:48 -0400
X-MC-Unique: hNE1LqMBNmCwKjbKKd8wvw-1
Received: by mail-oi1-f197.google.com with SMTP id k7so169529oif.22
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mqhbYTRX5f/rqDmOf+PPGbtTcPsW2ZMsmxyvTA9h6L8=;
        b=p9uJk4Rf560nK2PY28Az9ccKga33yARiW9yUtq7N/GCzCMncr4rVRHrszBehndUSXB
         YY3KWz057DO6xXiyePVOyd2s05/OTx7lj1j0629fmNQNroV8KDfj/SZSVrqrKwc4/wRx
         /WeKsYG2bzMyCmyS2Y3zQ5BNS7F2hzQzO9HnruIPt+ocgZh+UjWNiUxEPlE7nz92xDth
         9mhQgRpcSQRiEyHpXsG/hWlN8wBVKcXiv4GUkcGyO3fEefQAzoRwmd0Ki2QYLSsmenXM
         VIvvF+tEghqrVjGVlkxTqQaXO6s+LghXtTlI52l9Qi9V5b9uB39T41kNnT//dMBFvT3B
         pz3w==
X-Gm-Message-State: AOAM533K7bVNn/tCjBktPIE+/XwJswaxnm7LAuEVzc4yRxbQ0CfhJd1z
        CiK10RN8/ccEnDf18wnBHtV7hGZ0WNwQBktMswEi5SVy1zawo21bbH4bID3U1F+JSge3dKEI33E
        11q8+tiy1UDNuZ45ZTAUiseGx
X-Received: by 2002:aca:1b0b:: with SMTP id b11mr66902oib.114.1602710147528;
        Wed, 14 Oct 2020 14:15:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/ntLIQpoSVHmHklbFbracAAf5YW6jjcH04gnMhz2S5dUQLRzVXbrWxaSpOuaHxsapNjbTaw==
X-Received: by 2002:aca:1b0b:: with SMTP id b11mr66890oib.114.1602710147255;
        Wed, 14 Oct 2020 14:15:47 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l109sm227351otc.10.2020.10.14.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:15:46 -0700 (PDT)
From:   trix@redhat.com
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] checkpatch: add a fixer for missing newline at eof
Date:   Wed, 14 Oct 2020 14:15:40 -0700
Message-Id: <20201014211540.15732-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the trailing error message from the fixed lines

Signed-off-by: Tom Rix <trix@redhat.com>
---
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..7d3db096bc44 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3393,8 +3393,11 @@ sub process {
 
 # check for adding lines without a newline.
 		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
-			WARN("MISSING_EOF_NEWLINE",
-			     "adding a line without newline at end of file\n" . $herecurr);
+			if (WARN("MISSING_EOF_NEWLINE",
+			         "adding a line without newline at end of file\n" . $herecurr) &&
+			    $fix) {
+			    fix_delete_line($fixlinenr+1, "No newline at end of file");
+			}
 		}
 
 # check we are in a valid source file C or perl if not then ignore this hunk
-- 
2.18.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B45B29125C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 16:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438337AbgJQOZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 10:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438311AbgJQOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 10:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602944755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Fina9xjGfQjLJcMKnuyLY9FANp2OLEMutAlknMUNKNg=;
        b=RG239HcyjgwK6GmvZ9X2ZridePM88r3cMP4Hv8goB+nclTUmbDvIFF5LNJxnQweNLc9HdL
        CSRi81nhpAJLz/+mf688MnwOIHW/h57AjAqyuNYHv0+BwubcFcWPUsV20zALhqvZ098b7d
        9KqYxjprLrjCACnstpebHfma5B5kYHU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-qMuNFrdKNVCRGEf7bwpdoQ-1; Sat, 17 Oct 2020 10:25:53 -0400
X-MC-Unique: qMuNFrdKNVCRGEf7bwpdoQ-1
Received: by mail-ot1-f69.google.com with SMTP id t15so2262145otm.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 07:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fina9xjGfQjLJcMKnuyLY9FANp2OLEMutAlknMUNKNg=;
        b=WuC4h5QiuSVEFXszoRiEeW//Gc22DKjhSoWLadVZXgAysEvljLjLtNuko87xIYYx8m
         p4sLtoxGyK2fWjXiRwCJcYEDVw6lyZ6oI38Jk4x357X9N6hhqNlSV0JWXD7Mr4mo7cJ7
         eytKAaMcwojPSc1tuesvWt1qZZGBqpNEZG4OyF0Z1favKLy+vdX82L6eIwILT/o7yk7d
         aJA5bpNYkVvjOdNUwkgemBYK6xFEYnqGbjKeyrkMO9E6tysDkBtiR80fSHjc8WXr7FWn
         Wp1lTkZEy5eV+IDroT21WIJ+iaeAh3MNN+dwcjDOm+Zqt5jkQ0AulRpzJGvY04X9RdzP
         rtww==
X-Gm-Message-State: AOAM5321BgLAPDqO3F6G8rJanV3ArB5HX4V4cVIfgCScRkbPDgXNWhou
        eMoC6dNBn+PRpMxQ/Mckb7qw3ElMpOWroAPG8GHhq8iMiIbDJ/wzlr+bvh/HH06TLl5WIKNDOBf
        AiuxdHyjkgUAaX8WVRv6dOL6U
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr6005892oie.152.1602944752261;
        Sat, 17 Oct 2020 07:25:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp5JsWnS/iKSglSU0HzBdjOiYLNs1vTpv5mARyAuyFDIC6APFhrzYNbidLZ7v1wMZH9QDs5A==
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr6005879oie.152.1602944752038;
        Sat, 17 Oct 2020 07:25:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o2sm1915128oia.42.2020.10.17.07.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 07:25:51 -0700 (PDT)
From:   trix@redhat.com
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] checkpatch: add a fixer for missing newline at eof
Date:   Sat, 17 Oct 2020 07:25:46 -0700
Message-Id: <20201017142546.28988-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the trailing error message from the fixed lines

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: fix whitespace
---
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..f9e78a5385ad 100755
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
+				fix_delete_line($fixlinenr+1, "No newline at end of file");
+			}
 		}
 
 # check we are in a valid source file C or perl if not then ignore this hunk
-- 
2.18.1


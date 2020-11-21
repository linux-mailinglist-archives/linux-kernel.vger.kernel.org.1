Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E4E2BBED2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 13:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgKUMET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 07:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgKUMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:04:18 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479BFC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 04:04:18 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so9797274pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 04:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vB6erz0iSltUmu1ups0rIJoifSN+h/NyHvYUgOGpG0U=;
        b=AM18rV8EoPHDgb8rbLV1eD9SADIObHan1JDSifwQ4wEpc/PU43mcI2qhEP9yWDTbLm
         ul/aDEpZdon8RpIlmTQLWwjEQYj9mjva0LAvF2a96zEoW3KFMmfg5XEYedE/NAZlA5i9
         XJd/kNopIfEzxn927gnlI0HeP94omfvCJw0G3q6SY/n6Zax1YbAR3Y5QhqRqPMzYO3Qm
         OQPZoRpJvdQd1o2CxDGrIKjBIjGWYHkby6E/1Xt6o5FlgTGT1GpWYm8pMcY3ezxtTHaX
         8ql0YawT3L7hyc3vDwcS515iRw9xxSZjDQ8MXGwrjKU4fDiC3rjVHwGiFPJpfeQ5sKHI
         vb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vB6erz0iSltUmu1ups0rIJoifSN+h/NyHvYUgOGpG0U=;
        b=EhbNV/n6LNQY8TcbH5I4DlIrBXeKjZx3W8loMkug+YZ9skOjAfYx4/lCwoNqEa0cJb
         p3D/dj1WZMoAVkyw99uwqS9JIZtms4dUBnoe/xapzvrfUNrebQGAX2EtDly4Yzn0y66O
         7asZBkfR/dBpo59OcMtbYo4wPM4dvr1MjF505ZLg7aa5t2z7aGHRyjpOqBOD8jEwTPls
         H0FoUwa6zjemSfC5/CbTgMFZiN+asZjHTmuoRaX4q7K3Ubet4XYMOelu3QM/Mhc4Mu1J
         qHDEG/plZ0bLX9jH+iRduDiXVedv/y7QXRdEd13MRAy2iyx++WdPPG6bzXVfZF9OZxZb
         AJGw==
X-Gm-Message-State: AOAM5305wNv9on1Ufj/u+/jzlvbWrUW4etGXMMekGy/OHEeL7zneAOg5
        MFaQgPAJiF6ITv4I8peeZTk=
X-Google-Smtp-Source: ABdhPJz2OyHbBcTaKG10mjWhy7fajs265EV2JNvpT80dysb/xRrR5X8qVxGMJg+9V31RDbEUstZWUw==
X-Received: by 2002:aa7:9395:0:b029:18b:bd17:2ea with SMTP id t21-20020aa793950000b029018bbd1702eamr18304344pfe.48.1605960257558;
        Sat, 21 Nov 2020 04:04:17 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:400:4498:ed91:20bf:333c:1bc4])
        by smtp.googlemail.com with ESMTPSA id 15sm15460199pjy.0.2020.11.21.04.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 04:04:16 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] checkpatch: add fix option for ASSIGNMENT_CONTINUATIONS
Date:   Sat, 21 Nov 2020 17:34:07 +0530
Message-Id: <20201121120407.22942-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1d7692d0-359f-6b6a-32d4-1627ebd8b100@gmail.com>
References: <1d7692d0-359f-6b6a-32d4-1627ebd8b100@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch warns us if an assignment operator is placed
at the start of a line and not at the end of previous line.

E.g., running checkpatch on commit 8195b1396ec8 ("hv_netvsc: fix
deadlock on hotplug") reports:

CHECK: Assignment operator '=' should be on the previous line
+	struct netvsc_device *nvdev
+		= container_of(w, struct netvsc_device, subchan_work);

Provide a simple fix by appending assignment operator to the previous
line and removing from the current line, if both the lines are additions
(ie start with '+')

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
add check if both the lines are additions (ie start with '+')

Changes in v3:
quote $operator; test with division assignment operator ('/=')

Changes in v4:
fix incorrect use of quote

 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2749f32dffe9..d4c8d42cb13e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3533,8 +3533,14 @@ sub process {
 
 # check for assignments on the start of a line
 		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
-			CHK("ASSIGNMENT_CONTINUATIONS",
-			    "Assignment operator '$1' should be on the previous line\n" . $hereprev);
+			my $operator = $1;
+			if (CHK("ASSIGNMENT_CONTINUATIONS",
+				"Assignment operator '$1' should be on the previous line\n" . $hereprev) &&
+			    $fix && $prevrawline =~ /^\+/) {
+				# add assignment operator to the previous line, remove from current line
+				$fixed[$fixlinenr - 1] .= " $operator";
+				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
+			}
 		}
 
 # check for && or || at the start of a line
-- 
2.17.1


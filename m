Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33429EAED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgJ2Lou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2Lot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:44:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0419BC0613CF;
        Thu, 29 Oct 2020 04:44:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dk16so2776370ejb.12;
        Thu, 29 Oct 2020 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LKpRS+J3S4zW7SsBfByGoHcVAvgpeitHzH7HZNlxGe0=;
        b=XrOLgCfqm30w4SIyLTVie2fXWr3o5oTqTkamg/t53md3H3edriKLdjk6e77/pUklE6
         +YB47rDOLuakBUBm4gMDOhExApuC5idkou2FfzjB1b0G1rJrYRCD61kieHRADAi9Rh9A
         GO5t6xcCLnCEtpvh+GSJZ63nvhkNuV4qG5w4zvCKrSejSMDoj+saxEHvyL6Hfd86Tkh7
         IOxfQ0uk03nrlSt5z/LgqVx3nv4f7q8Ok2Lc+DTPgG22s21+cv7ycCtvzGRupDhBXN3z
         GtEtbm3jJhVPIPZ5TZQKosSBwUgKkSI9KSpM/OjTgPrVhWzqh8/JR2IRsKGR3NTNnCvL
         WQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LKpRS+J3S4zW7SsBfByGoHcVAvgpeitHzH7HZNlxGe0=;
        b=bPt1qnarE3R5NP9xMRFU/NfKROs/75O7mE/T3bvjIpSOHi9OUKHPE4Fmp8N7+m8ibn
         F/C98HsFNtTLWh6lBa9vFw1UNaOthL0SIK4lqXRgSTTgeyViZu1joOPbaoTHIxuXzzF8
         zFskC83rKSjsBxER4/3eysk3CzldOb3sXw55jU2fxR1OCw7art6mA7uIYqzZrqE3Duad
         Aj1f/zz9i/MfMT6twR9E09ZCDhObVVU5z5qgfKBivXxxx3xnBvmCy1Cdk965P2CJ7dtm
         1a7gqMOCY82hTwRPKVMAhzy+eh5cRgTgwrEmEJ2iTeG7pTI2oTpYBf5QJbkof37kgUWa
         dFbQ==
X-Gm-Message-State: AOAM531ErLUWXKkRHXXsSdgfaIICOnTtjd3VamulwhQATCfWhttuFQ+t
        NbAXCEr4nvgY1uXkaAPtmP0=
X-Google-Smtp-Source: ABdhPJwPIGKw5qbd87rBfffccrIvL3vijxnbjkvfgcNESlYp8KnsyxxBfxvX5n5wgaBgcHM0wVLAwA==
X-Received: by 2002:a17:906:444:: with SMTP id e4mr3917154eja.218.1603971887632;
        Thu, 29 Oct 2020 04:44:47 -0700 (PDT)
Received: from felia.fritz.box (mue-88-130-59-025.dsl.tropolys.de. [88.130.59.25])
        by smtp.gmail.com with ESMTPSA id x2sm1385593edr.65.2020.10.29.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 04:44:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Divya Bharathi <divya.bharathi@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify DELL WMI SYSMAN DRIVERS section
Date:   Thu, 29 Oct 2020 12:44:25 +0100
Message-Id: <20201029114425.22520-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e8a60aa7404b ("platform/x86: Introduce support for Systems
Management Driver over WMI for Dell Systems") added a new section
DELL WMI SYSMAN DRIVERS in MAINTAINERS, but slipped in a typo.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/platform/x86/dell-wmi-syman/*

Point the file entry to the right location and add an entry for its
Documentation while at it.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Divya, please ack.

Hans, please pick this minor non-urgent patch into your -next x86 platform
driver tree on top of commit mentioned above.

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8a905354ee9..a0a86daa9c51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4974,7 +4974,8 @@ M:	Mario Limonciello <mario.limonciello@dell.com>
 M:	Prasanth Ksr <prasanth.ksr@dell.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/dell-wmi-syman/*
+F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
+F:	drivers/platform/x86/dell-wmi-sysman/
 
 DELL WMI NOTIFICATIONS DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
-- 
2.17.1


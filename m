Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD726FB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRL1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRLZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:25:45 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCBEC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 04:25:35 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id f18so2012274wrv.19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=MY3i44yKq0Q24PaD5n8EanwCf2JmOR1H8DRTTFWUHr0=;
        b=It0pkiRmu495R60Y2vKHX+kUpiz6SA4dN5Dp++AaGwowg4m57GbV0kw7LMC4vHY3Q4
         1tr0C2hq5TfQEUNFqCrkIV9kIFDQ0N632EkDGg9L01cUxPo2MFAyWXl+iFyemUZQFgux
         D2OdMevISdXe1b8cgtT8TSKNmdPzU08UywjxaEVqwlVCw5cK5JiIlcjWRmS1eE+CsuOt
         Kmys1Tpw/ON68W1lZNAC0kc+iEWeoCLqA2W53erU069VcSNVsj5W/d+ydFebHjsmlUG6
         sP1LAHH4E+mthVm0KuXAdwKP0EKQ9a+xD70+ELG2GDonP73qtd4GGTF5/PK59m0s56Et
         jJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=MY3i44yKq0Q24PaD5n8EanwCf2JmOR1H8DRTTFWUHr0=;
        b=IEAcqDJYlZ/1b+PH4GFettCDvSZMQTllcHcD6qk34StdbS3eZ5DqMowZruvJQMeavz
         m/O9T+hraKhIM7iNYtOEkNbtVOb86yvRRnXC+qy3WhyJTSQ0aXM3SaXuQwO6VJM0PAPp
         bzQp4ynJuPZ7AFmI4bUTFtfCezgA2trwRJPLnXhaOcuOXfVpy7iScQ8khb2kziCJQh3J
         Iq12IwexMUP9/7D1/sbTQsVUIYcXCH4LUR8JN8sfJq4OzC938wDLDitD1eQ628+pQgnP
         Cy/ol9UrxYy9CJQmB3RrZYhzcgVvpvUCaMCvf+96AvIfMn+opHVizs3+B/J1dihyVmi8
         vtow==
X-Gm-Message-State: AOAM531GrCxsCUs72QcInZR9xKwc9WuwYmcR0IWBs0p7q0Vig1Tcw0fr
        YVb6jmbHxum+9Era/3pyhBvB6/g/LQ==
X-Google-Smtp-Source: ABdhPJw866apNRLHdHyAEgyAZKtvFR8LlhowbDXSsLQNFyXGdKao4DoF9LQxNidwdG/nijywAWPn04Tymg==
X-Received: from katla.muc.corp.google.com ([2a00:79e0:15:10:7220:84ff:fe0d:f6a2])
 (user=misch job=sendgmr) by 2002:a05:600c:4103:: with SMTP id
 j3mr14926391wmi.130.1600428333317; Fri, 18 Sep 2020 04:25:33 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:24:59 +0200
Message-Id: <20200918112459.918328-1-misch@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH] efivarfs: Replace invalid slashes with exclamation marks in dentries.
From:   Michael Schaller <misch@google.com>
Cc:     michael@5challer.de, Michael Schaller <misch@google.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch efivarfs_alloc_dentry creates dentries with slashes in
their name if the respective EFI variable has slashes in its name. This in
turn causes EIO on getdents64, which prevents a complete directory listing
of /sys/firmware/efi/efivars/.

This patch replaces the invalid shlashes with exclamation marks like
kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.
---
 fs/efivarfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 28bb5689333a..15880a68faad 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -141,6 +141,9 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 
 	name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
 
+	/* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
+	strreplace(name, '/', '!');
+
 	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
 				   is_removable);
 	if (!inode)
-- 
2.28.0.681.g6f77f65b4e-goog


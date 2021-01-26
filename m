Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FAB304EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405261AbhA0Bc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbhAZShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:37:42 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D71C061788
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:35:21 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d4so10258548plh.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52fk0kbTrSyL0AV53feeXDmkSTW51BS9ESJn2yxoUuM=;
        b=BXnVKBBewzcmU+iInQU6fc2SRb1zGGDmJYV7q/3MuDLdwJOU29DFVx3acEOV8hTGmM
         7JlY+CBo3+V/aBej5Sv9kWso4Uyj/+NpTWoNudQw/1uvF+Pzym5KeQMvoD0OtWBGEuN9
         HkVxGuHu+SbfoxTR39spoz6B78B9VUUEvTR2ULAJnwnKeST9hjcjyCy/vQ9hfIqJtuBF
         Ptn6YNlj8DgAGEH6QjYecrtXf6nnQWaIp2GSmRBsm03XyOHhQK1BqNbSWY9rlUvx4OT6
         0lWRTKEq9RBxbTLWWN/5hSe/Tuw7URFdgFe48IIrYBy9z5HuDERH0vlLcOHP+Pid5aCM
         OJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52fk0kbTrSyL0AV53feeXDmkSTW51BS9ESJn2yxoUuM=;
        b=iQDFIOOHl+B+MrXoW0FBk8qsvE/8OCiB3DaNXkHHmxd+/2Wq7kqc3slotYIVDCKcEp
         Ib4QkR1cy2athFF1YkjxeHVHR69AXOt83fIyTIs3TqhDTMLUR1O9/yNcWxD3fUvtDJx0
         85WoQ1W9uoApp/t9/bXFpJ5lfsqHz+H50pBIIjBUwLsHOrM7Tvt1OcCLdgJULPf4KZx1
         gxZXQnnqDC2M+XtcOAe2GmlDC/87DHLs+Km0NpFtkda13lMWZA8dqfh7gYD+6SYpnUGj
         lqaElVR2xp8SI7uNMuYGVRqVjUbAw0pCXThZqif/uwHQTaZiWY0nW+KmjH2/eL2B82Uy
         JfjA==
X-Gm-Message-State: AOAM532RCHcMt+6bvs3Z3Q/Kl/FDSNUZyKQb//2mNxga+odtkP6qeiYv
        EWGT6Qq053xKUOSARypOhoE=
X-Google-Smtp-Source: ABdhPJzj/wTR+p6KFUxo/iXhBe+SKn79OGD4mI7OeiNEsMrK7LnfYumb2eGNfQ8MfKUikPNJQos0tw==
X-Received: by 2002:a17:902:ac87:b029:e0:17b:68d2 with SMTP id h7-20020a170902ac87b02900e0017b68d2mr7404713plr.0.1611686120618;
        Tue, 26 Jan 2021 10:35:20 -0800 (PST)
Received: from localhost.localdomain ([49.37.2.129])
        by smtp.gmail.com with ESMTPSA id a31sm19713654pgb.93.2021.01.26.10.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:35:19 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH RFC 0/3] checkpatch: add verbose mode
Date:   Wed, 27 Jan 2021 00:05:18 +0530
Message-Id: <20210126183521.26535-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a verbose mode to checkpatch.
The verbose test descriptions are loaded from the
checkpatch documentation and parsed by checkpatch.

The documentation itself needs more work. More input
on the usage and test descriptions are needed.

Also the visual aspects of the verbose mode needs
some work put into. The usual printing of verbose
descriptions can cause confusion and maybe hard to
distinguish from the actual warnings.

Please note that this is only an initial attempt
and any comments are welcome.

Dwaipayan Ray (3):
  checkpatch: add verbose mode
  docs: add documentation for checkpatch
  docs: add documentation for checkpatch

 Documentation/dev-tools/checkpatch.rst | 283 +++++++++++++++++++++++++
 Documentation/dev-tools/index.rst      |   1 +
 scripts/checkpatch.pl                  |  55 +++++
 3 files changed, 339 insertions(+)
 create mode 100644 Documentation/dev-tools/checkpatch.rst

-- 
2.30.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1F62A2A29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgKBL5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgKBL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251BDC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so14230944wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69IfAsi6LtilJcxN9H1dLNlaFHP8/FNXpQcqIkHFmFo=;
        b=L4uYar5qRO/hFgdQ7zHxvADTV9n7y9/rmCyAqujQ9/OvyWoDa54aoap/g3Id8dk6ye
         7E9WHASpEEnZM9jgOpndOgh9dafaSEOBRM4KHsO+vJFDVILxon9muQAwWwUOgYZqMZCc
         n7NJlFDrYLEurp8EbBUPCmLyGU2iEr58/kabAns/pslTEKpFVPHi41HuW9sG/n5Xa7ix
         pv9uRN/aRWzI7b29NAbDuv022CSMcvY/HpefR1/xI2RIwDWdiG21sxq+kgQIsbohpogZ
         G+u3N+vADJ0LY50zw35btmgGgqDRZr19xCxpYFKD8sxCRDW51XEuDfdU6j+qspyXIzEA
         Sbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69IfAsi6LtilJcxN9H1dLNlaFHP8/FNXpQcqIkHFmFo=;
        b=ih+d6Cs+sonXd7eqIcSWHdLMOemgpn1Ab/ObJKG8ISmFcutUg22eTFzn34YoBzUXO8
         vkw12hGAwCW23T/ftZ87TgYxEX0HMvSOh1BIyp6wmPNwEYmKG3H0LSmhBDTsrDVPnm5C
         ZoTvJaRKLwa8pE7I0g6uUmKOw2jAuNYr4AlLHZkft7GyoxLZfxAT2jf7Aagz4joORLbW
         f2rxLP7mv31UdrQWE3/91mmG2FbZpD3SSCNML3DRMVg/2Xa28yY0dDe6k7DpK5XTzGG0
         gkvurxQqEMMoeb22jhGLjLSSUHbfLKNsAyKmVuYRJvqus3k+96hhCXHmUgX/Yhxd7cwT
         zXKw==
X-Gm-Message-State: AOAM531XWWjvO12bHrWrMmsynk+j8PwpxPpDFmaa+PitS1K1t+jd21B8
        tYRkqwx5XQ93uVKupJTdyp452w==
X-Google-Smtp-Source: ABdhPJwWcnL9dwvgFiESKDq03B35ARQmCkl99XNGu3LhEH5jcWXaNtSlA8bREKi81iEREMX8YBRcig==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr19398003wrs.406.1604318251830;
        Mon, 02 Nov 2020 03:57:31 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/19] Rid W=1 warnings in SCSI
Date:   Mon,  2 Nov 2020 11:57:09 +0000
Message-Id: <20201102115728.1077697-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (19):
  scsi: aic7xxx: aic79xx_osm: Remove unused variable 'saved_scsiid'
  scsi: mpt3sas: mpt3sas_scsih: Fix function documentation formatting
  scsi: lpfc: lpfc_scsi: Fix a whole host of kernel-doc issues
  scsi: lpfc: lpfc_attr: Demote kernel-doc format for redefined
    functions
  scsi: lpfc: lpfc_attr: Fix-up a bunch of kernel-doc misdemeanours
  scsi: lpfc: lpfc_debugfs: Fix a couple of function documentation
    issues
  scsi: lpfc: lpfc_bsg: Provide correct documentation for a bunch of
    functions
  scsi: esas2r: esas2r_disc: Place brackets around a potentially empty
    if()
  scsi: esas2r: esas2r_init: Place brackets around a potentially empty
    if()
  scsi: lpfc: lpfc_nvme: Remove unused variable 'phba'
  scsi: ufs: ufshcd: Fix some function doc-rot
  scsi: lpfc: lpfc_nvme: Fix some kernel-doc related issues
  scsi: esas2r: esas2r_int: Add brackets around potentially empty if()s
  scsi: lpfc: lpfc_nvmet: Fix-up some formatting and doc-rot issues
  scsi: esas2r: esas2r_main: Demote non-conformant kernel-doc header
  scsi: advansys: Relocate or remove unused variables
  scsi: dc395x: Remove a few unused variables
  scsi: dc395x: Mark 's_stat2' as __maybe_unused
  scsi: hpsa: Strip out a bunch of set but unused variables

 drivers/scsi/advansys.c              | 16 ++------
 drivers/scsi/aic7xxx/aic79xx_osm.c   |  3 +-
 drivers/scsi/dc395x.c                | 15 +++-----
 drivers/scsi/esas2r/esas2r_disc.c    |  3 +-
 drivers/scsi/esas2r/esas2r_init.c    |  5 ++-
 drivers/scsi/esas2r/esas2r_int.c     |  8 ++--
 drivers/scsi/esas2r/esas2r_main.c    |  8 +---
 drivers/scsi/hpsa.c                  | 25 ++++---------
 drivers/scsi/lpfc/lpfc_attr.c        | 56 +++++++++++++++++-----------
 drivers/scsi/lpfc/lpfc_bsg.c         | 34 ++++++++---------
 drivers/scsi/lpfc/lpfc_debugfs.c     |  3 +-
 drivers/scsi/lpfc/lpfc_nvme.c        | 37 ++++++++----------
 drivers/scsi/lpfc/lpfc_nvmet.c       | 17 ++++-----
 drivers/scsi/lpfc/lpfc_scsi.c        | 48 +++++++++++++++---------
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |  8 ++--
 drivers/scsi/ufs/ufshcd.c            |  3 +-
 16 files changed, 141 insertions(+), 148 deletions(-)

-- 
2.25.1


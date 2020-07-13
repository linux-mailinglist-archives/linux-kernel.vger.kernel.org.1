Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331C521D127
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgGMIBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgGMIAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:00:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42562C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so14743159wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1f2VykJlM3ygLpY+EskgDzDL15LmxoT0Iv4BzUdNoA=;
        b=qt186vtKt/PK9OFVozF2ZRakTSgUeJRV1rrbbqIKCx7/qsazwzFJ+7UmD1xgA05o3z
         KOIGkNlEK6gM72mGnM8EMNzSKe5sNFw/q+a4vwVXV1vgV3v2qpKkgLosG42A5Bz/cURJ
         n/TVPhX3q/sgAGqeyi+cUZcinU7LHM57nf8ED48+sziFHwCaPxn8y23NfGnk5FoLkcdP
         vE9V9B5h3JcgZSk5p1mtloek9yXl7FDeDPWQHmaFlMsphXUqByWh4fXfs/W1yZT8iDcI
         AYoPpHCJ2pAFp/vTiK5O1N3FCTLTP8DywpDNAn1wy8PLNgkNno80PYS+ZaxIqW2ndN4k
         R4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1f2VykJlM3ygLpY+EskgDzDL15LmxoT0Iv4BzUdNoA=;
        b=awWNL/y5+9aN9DlWvi98ohTLwAxQihbeHx8vht74YCvqS+HtoIsH6NHwtBfkTX2WkI
         9dHsM48Foa3otf6HF6B4IWQFu+l0BmwVqbA/nDJFbbQhpvx3wJs7fUWh71mmVY1U7Wog
         TuYXU6Ff5yMwo/B26pw/QrCD8JDGFafPejbW0sLvGKH1RglxTL6qRCoNk7zq+/dFwRFe
         ijjyagyeJueDk16NSN0YtiOOMzdH4PBD1ZO8jx0FV0piqFyfh58A8oy9gjDz5qYvs0VO
         dSiO1KhY03knRhGgKuy5OSunQYprAhJRafuBYK4FKpAapeBUAJ2roFYX/ngweetx+WAW
         zHPw==
X-Gm-Message-State: AOAM531g7OPqZmgeqeg3SZAqSxwMMSq7EUn0Ct1iOAs1FHDlAm304HPQ
        rbE/g463uGw6OQUXysetAjxBCw==
X-Google-Smtp-Source: ABdhPJxH84D/9opvqFIODJ7EdCyqyBHoMySBXyJRPSJ95zQfXyDTcQoDqv0ufs9OhvaubRyrArzOog==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr50742755wrl.246.1594627223033;
        Mon, 13 Jul 2020 01:00:23 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id 33sm24383549wri.16.2020.07.13.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:00:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Brian King <brking@us.ibm.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH v2 14/24] scsi: ipr: Fix struct packed-not-aligned issues
Date:   Mon, 13 Jul 2020 08:59:51 +0100
Message-Id: <20200713080001.128044-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713080001.128044-1-lee.jones@linaro.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/ipr.h:1687:1: warning: alignment 1 of ‘struct ipr_dump_location_entry’ is less than 4 [-Wpacked-not-aligned]
 1687 | }__attribute__((packed));
 | ^
 drivers/scsi/ipr.h:1711:1: warning: alignment 1 of ‘struct ipr_driver_dump’ is less than 4 [-Wpacked-not-aligned]
 1711 | }__attribute__((packed));
 | ^

Cc: Brian King <brking@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/ipr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ipr.h b/drivers/scsi/ipr.h
index 9a0d3d7293206..783ee03ad9ea2 100644
--- a/drivers/scsi/ipr.h
+++ b/drivers/scsi/ipr.h
@@ -1684,7 +1684,7 @@ struct ipr_dump_entry_header {
 struct ipr_dump_location_entry {
 	struct ipr_dump_entry_header hdr;
 	u8 location[20];
-}__attribute__((packed));
+}__attribute__((packed, aligned (4)));
 
 struct ipr_dump_trace_entry {
 	struct ipr_dump_entry_header hdr;
@@ -1708,7 +1708,7 @@ struct ipr_driver_dump {
 	struct ipr_dump_location_entry location_entry;
 	struct ipr_dump_ioa_type_entry ioa_type_entry;
 	struct ipr_dump_trace_entry trace_entry;
-}__attribute__((packed));
+}__attribute__((packed, aligned (4)));
 
 struct ipr_ioa_dump {
 	struct ipr_dump_entry_header hdr;
-- 
2.25.1


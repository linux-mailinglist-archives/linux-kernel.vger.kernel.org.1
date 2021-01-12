Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499C82F2776
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 06:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbhALFCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 00:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbhALFCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:02:02 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9528C061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:01:21 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id w18so1521122iot.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXHqQP41N3rV88+DLNWGFkao8mGamdbDcqmwVDhqSuQ=;
        b=kQdxXH4aiPXiCK7igcopEM+n2fXCDrzTmd0e8eLAq6UrxGv2JuSO13vLd5UdEpUiQX
         i14SeTdN4vWJA7dpVzwQqMt86t5bOnhRNWAsGSVcEQ2bi4h8KwUysb4Cars857sEkMID
         C9nZOrdBgDQV19Hrv/8LgDL9WWF7iNsZC2LsH55yypWr+UIZe2sR08OC/ieDc3vbpQzb
         b2c//pQa4sMa9xifyiDQ4kh/krg52u2B8UPTZQ+RwezQSpdGL5M0IsPoZLtT0ENYL0kq
         yfgPg2Ua+kCeHJTfRnox9xkwD7K4zBF4Xv+TsSVMQY9DdCuITm/I5QCajp17zvnVsr35
         TRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXHqQP41N3rV88+DLNWGFkao8mGamdbDcqmwVDhqSuQ=;
        b=HOPVeKbznAQNIEhvXn6IMLCNiN/2jY2bJfh1+qDubN1O7WK+CTdtouavnNb9QyoFWD
         rPOwhnmG4tJFF0ODoU1jKkuM6123w0y9T6eQJUzg2RYE67QEQr8oMKW3olryqwxLbDR5
         1lGZH7/OW5MngsUgLVuVlROSS5SeLl6yD8+gTEZew5JisLCNE6qLTBNKlcBzTN2kEEyx
         F54wKH724n9JNlL+3ozhOtcfz59GJfAUD4JP8kddbj/NGmBFkCdWx3XYWfjxlv559NSk
         OMt0NtNvteUTHvcjS79Gme51jErAwRlYBLTaU2jlywcVhcVFk+Q17NXNtmQnEHdKCyxa
         SY1Q==
X-Gm-Message-State: AOAM532jpUQu1XwAfggkqjkZOLz1WtFi1YJ8ktGNvA8rChFvK/xMToRF
        peB297aHdMCo/RjnHHIA1Yw=
X-Google-Smtp-Source: ABdhPJwy7RjNAxxGFjKOYYWOixhb5Vr9IcK2cwkzBrVa8rvuHc7ATHcSv/GWtTtpKFER2vx71JV6zg==
X-Received: by 2002:a92:d1c9:: with SMTP id u9mr2450975ilg.282.1610427681265;
        Mon, 11 Jan 2021 21:01:21 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.246])
        by smtp.gmail.com with ESMTPSA id c9sm1531212ili.34.2021.01.11.21.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 21:01:20 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: x866: kernel: cpu:  Take away a single latter to match the structure member below
Date:   Tue, 12 Jan 2021 10:31:11 +0530
Message-Id: <20210112050111.5584-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/kernlfs/kernfs/p

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ee71c47844cb..3bfca0bebf56 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -142,7 +142,7 @@ enum rdtgrp_mode {

 /**
  * struct mongroup - store mon group's data in resctrl fs.
- * @mon_data_kn		kernlfs node for the mon_data directory
+ * @mon_data_kn		kernfs node for the mon_data directory
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
--
2.26.2


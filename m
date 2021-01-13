Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0879C2F417D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbhAMCEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAMCEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:04:33 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5867AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:03:53 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 186so345767qkj.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1qK/oi9CKYihvbV2PXB3Jjv2ivAzo9fIlXKJJlx8dRA=;
        b=HnAoc5Q1qguK9upMGVl69Nzt/TyGjoXerneQkjToCQ1XqDcUYrahbtzWOvu81XjTMI
         DAKdfTiAmoxfsVYkKulMqM2IEdVJtWcgotiBlpMnmn5pJOp8vkxHrhgsWQE5TBQt9ipW
         EtZbSt3y091R7avdtKWZ4mpWsmW5gZcd0IFRAYYIQCgk6l2xHzQFrHwVWYSHl9Yta5Uu
         bXffsr4huRQ4r9915cIO33gKbxNKbdQXDQQDrFmQ5Ug823lEnm0RVGN+UT9Jhc365AcT
         X16yL1bNjVYCHgwj022KlZxUsDSIPc5AaBAagt+aeM9QkJzFmPiBO7wiqUHnVVRIQaiT
         aRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1qK/oi9CKYihvbV2PXB3Jjv2ivAzo9fIlXKJJlx8dRA=;
        b=sfC1WObv0Rgbkfs5JT1oymVeOaVy070WnKtwAzkuMG18/mu/0DKIkktx8SHC7UgtOG
         2zIqMDok6BNK3ke8pbKxFrMWjy41P8YCNVbSA/0bkTiF87WZug0mqI+Q6cCD1TFeQoLe
         cijePSzloeN6kw4jWFz/HJsGTYn7akTBFqZNyFpxlL8t/43WqAOpCAz2Nn9VAxC/+J6w
         9yVeGF0kI7m1PNQCmfDJxnqjs4FbxQtGTLmqbDY1xG32NO/D1fTNZuVIeHg+BB/q8bdg
         wNzdnTKhqPC9pWCB/5brMDYVOrenzWrABjSu/dfygIrL0feQa1QVSoarM7SYc1LwDmC7
         PPzA==
X-Gm-Message-State: AOAM532OKXbsUhpBdUjlJ0yfQLQ/HxKF1AaSjwk7RpAz4xqjOnn8JIBm
        XU6mhiCj7LsiFdT0RHpkHhw=
X-Google-Smtp-Source: ABdhPJwCUY//32203vf3VttVmZFrixLvFDZFU3eraZqIPvVCTgFpLLjN2Dn4B0iiVdloI3Jj9aDENQ==
X-Received: by 2002:a37:a80a:: with SMTP id r10mr2811355qke.448.1610503432467;
        Tue, 12 Jan 2021 18:03:52 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.149])
        by smtp.gmail.com with ESMTPSA id 16sm334906qkf.112.2021.01.12.18.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 18:03:51 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Cc:     rdunlap@infradead.org, reinette.chatre@intel.com,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V4] arch: kernel: cpu: x86/resctrl:  Takes a letter away and append a colon to match below struct member
Date:   Wed, 13 Jan 2021 07:33:33 +0530
Message-Id: <20210113020333.29803-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/kernlfs/kernfs/
s/@mon_data_kn/@mon_data_kn:/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Changes from V3: Fix the subject line typo stuc to struct and mention cpu architecture
 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ee71c47844cb..ef9e2c0809b8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -142,7 +142,7 @@ enum rdtgrp_mode {

 /**
  * struct mongroup - store mon group's data in resctrl fs.
- * @mon_data_kn		kernlfs node for the mon_data directory
+ * @mon_data_kn:		kernfs node for the mon_data directory
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
--
2.20.1


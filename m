Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF12F27DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 06:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbhALF2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 00:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731814AbhALF2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:28:20 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE2C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:27:40 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y19so1611144iov.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hJAm5PDrJ+l3KZlDxNotVtb+h2kh7NhezHkZdvXRFk=;
        b=S6E2qHgwT0LZmUukZJ7TRzmfSdrRXmB44HQMdPkxhP4sbHNjk8Di0ClVe79XAsY3iQ
         gScSA3Ut4cFADQRaKLqnq/JplpPnWxeZiptamZglv2hK0jB33A8dAQm8M43u454dYQRg
         Z2kTYaWR0MTxzDeu8e+c2BVbxVmZkuSXU7zMVEZEwZwIsdDTd0GYoz2fL7AvrX4YAh9g
         zhYZxgujO2y0nxbYlezNtrd9ZsSwRTYb7hY+Ei1Tqch1fouCFsiwGZh/DUHRVRGBpi/u
         Ut4ncSqWPPDPbGRb8xzB7BUl47GWCIWLP9zasqPGzkVLouc6wPLXp16LnxTHXH1OvOCE
         DgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hJAm5PDrJ+l3KZlDxNotVtb+h2kh7NhezHkZdvXRFk=;
        b=LiwZzBnN7iAUj4AkCAnpc3fWosJkj5COHPN2lnbABCiLuTO8/lOIM1bBNY6D93r/Z/
         8qx2owVloj52diqwjmxnjfc95lo2OozmBpdSI+r5CMXi2XTE+vSdcswBYpaPxBrve7de
         QYyPwl2+QdlbR68byqHnpMqxN3melxTyeDC9UdfOqB474v8HSb4npN3ogYMhCryqIoww
         tmAYbYiY9iRU9AvzvoI+iVGTamZcHNVwHz5TseJXZOImzNupCltB4VV8TR8KRRitKEhH
         CmGW2dg1vHNxE7svqRV0DtC4Gt8I6uCUCubbhoVOZFV/SzCR9mRiKx+ieq8PaZeO/SNw
         dGVg==
X-Gm-Message-State: AOAM5334FAs3yf+ufKMPFOa4s/kYL7s5PK3+nJQ+jBkavUvYiJOZqUZ1
        Hpszh3HZU64cxeAn9hYBv8qAxh5mIHQIxh5g
X-Google-Smtp-Source: ABdhPJxWXxsl1TwTk1Gci7LHINmr15nQjjBRIloX0VMapVI8nsDfSFgsHcaXx8t41iAOqRrsY9LDEQ==
X-Received: by 2002:a92:bd0f:: with SMTP id c15mr2387052ile.296.1610429259775;
        Mon, 11 Jan 2021 21:27:39 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.246])
        by smtp.gmail.com with ESMTPSA id 11sm264487ilq.88.2021.01.11.21.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 21:27:38 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] arch: x86: kernel: cpu: Takes a letter away and put a semicolon too, to match below stuc member
Date:   Tue, 12 Jan 2021 10:57:30 +0530
Message-Id: <20210112052730.24677-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/kernlfs/kernfs/

 A semicolon at the end of member name

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 As pointed out by Gustavo and Randy in version one of this patch

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
2.26.2


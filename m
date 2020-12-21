Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132432DFDD9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgLUQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgLUQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608566418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f9ktLnnvSqo4qDYoG72uj35ketj6iNKNm8K0dv0IwXU=;
        b=YM3T3oq0pP6G42dvAGYZBGvTJTgbmVIR7QEwv6Qt5Sg9JboT8TSSyFQgPvsxikfZOzVEE4
        8cVO7O7W8S+odAyu7gRVRZdoNxPlVAraXYEuxdgalKAETEm01hO/doJDvzEQHqXC8z4tM2
        FgkbdYps9BjTbVYh0PbHDTlUABRnP3g=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-TiH7LelKMDS30iWuPCHi5w-1; Mon, 21 Dec 2020 11:00:17 -0500
X-MC-Unique: TiH7LelKMDS30iWuPCHi5w-1
Received: by mail-ot1-f72.google.com with SMTP id j22so5227299otq.16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9ktLnnvSqo4qDYoG72uj35ketj6iNKNm8K0dv0IwXU=;
        b=rahpKDh9++B1+CQKEKUOw7aEJVvsx3NlNC8h7ySiD0ZHDFg+DPi0oITaVJfeFpY4kU
         TsRNxWpZhlSJhuJZIsh2046IVaOXWzsc3Gjxzr9PK3u6KKpY0DYuff2DnGs5sSg1gi51
         QDhXAN2YmgpD1tAf1cMItcP/cdEAKdRypUTFDDOW1VNuTu0qAJshZzruz/ICm7Cr54ZN
         hE0Zxn+khBfSoOJaUf2GmmofFEK+Zs2gzsVPKvwgZE9G+60xs359vU6q34bI5i39rmBj
         CA084x8hWiTtdyWmWmocxQbWZBDM0i1tKYHyCpgvVgAwz1KaLUkQXSxu3h7O3QcjCyhd
         WDDg==
X-Gm-Message-State: AOAM532fONLltf6VzeLGxchLOyqz9aZWIfPxOOmihwWrQy10kBIK2L8V
        btsjMSPts3aNG4KtWONB+wJMaGvJWZbniYNypQmhCRNYTgilwq8Au/IpE7Ho5NoH1XZr5Ko88ci
        wo7dxVAvuOfRbn+ZraeN9Oj66
X-Received: by 2002:a9d:4715:: with SMTP id a21mr12941613otf.220.1608566416281;
        Mon, 21 Dec 2020 08:00:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwN/2SSmcvPltqlVzgYxlriRwZSsmMyce3N1hNtIrklWPD2ZFlawXcqMtAnS6qsxhxt6Ft+w==
X-Received: by 2002:a9d:4715:: with SMTP id a21mr12941597otf.220.1608566416096;
        Mon, 21 Dec 2020 08:00:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 8sm3784513oii.45.2020.12.21.08.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:00:15 -0800 (PST)
From:   trix@redhat.com
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] x86/resctrl: add printf attribute to log function
Date:   Mon, 21 Dec 2020 08:00:09 -0800
Message-Id: <20201221160009.3752017-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Attributing the function allows the compiler to more thoroughly
check the use of the function with -Wformat and similar flags.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ee71c47844cb..c4d320d02fd5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -572,6 +572,7 @@ union cpuid_0x10_x_edx {
 
 void rdt_last_cmd_clear(void);
 void rdt_last_cmd_puts(const char *s);
+__printf(1, 2)
 void rdt_last_cmd_printf(const char *fmt, ...);
 
 void rdt_ctrl_update(void *arg);
-- 
2.27.0


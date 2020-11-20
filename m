Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3652BB127
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgKTRGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgKTRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:06:00 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D97C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:05:58 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so9113563wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nV/VCCpzz6ZqW1252kGY60a9yllsB8Tak3sXCoTX8Xc=;
        b=MdUaz2f1d9WtEQBJlVL5FrATWv67G89bcwXU/x4of4SkOEp/rrSBFEzlyxrcMKnCjm
         RijSf6KWe/EbqvrPo9Jg1nh/B532eUBi6JSjICWMRJXhMYwNFgtr264+5wATTTVojFEW
         3gKOpo3zJ9XdGWBIa6RekPvUBkaWEiGaGQZi+cxmql+QfXQfwLrwX+KYfgnO2F/sutBg
         Vdr1JjQf7ZEUKRpRRZIpDRNb8P2rOGnrX1cERSUpCh6IL9pQLYGJTi3hgEu1z0T4PG/+
         hpl0HjwcMTxVsT5JEpEcF39YEwAcmo82Ia2GpKjMJiB6oAVHOf4lufdTkpvC6yX70qFU
         i5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nV/VCCpzz6ZqW1252kGY60a9yllsB8Tak3sXCoTX8Xc=;
        b=UiaabMQnVn7OFDWh3DwxrhTyOKQgUH1F/wNrhK3deJewUCgKrf1FyfNWsuCAwRcS0x
         XODbX4D4BaN6SAWmDtT/w/0tWpHk7VYV1EH+wF2ra8vA8fCSYfzjETrD4csgsFUuKSJ9
         aHlAo9mTmfuAtahLyXCvL4CLLonOxRRMT1wSdWkhEymrqw6PoAqwV6cT/rRTZmGEDV7k
         bkPaBBjvdCIBOhZ+R88s9qMYtwUhXzERF8gXfsTRXBGuscnxBcsR+cWpMyRJNSrAS19S
         778+lA/IztVTXFMza4ljCA8NeY/5YekRT9FVmLi08qi8O4adX+V6GXZEHq5YwHjdA8o4
         zVTQ==
X-Gm-Message-State: AOAM5306IxaAGkr4+SJQ6C92OFAhyRaGKtwXP5DfGi38EggDqYsfowSW
        H9My7mN3q5llLf4HDGP/rtjmjMo+30uLvGSC
X-Google-Smtp-Source: ABdhPJw7vPNYS15a/XK+cgM34JDORVS+emeM/MQAOi47B5HCZD9KaRpl34vzCV92Dkl+aGhhl5+cXw==
X-Received: by 2002:a1c:1b43:: with SMTP id b64mr10493362wmb.64.1605891956635;
        Fri, 20 Nov 2020 09:05:56 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id k1sm5695356wrp.23.2020.11.20.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 09:05:55 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Tyler Hicks <code@tyhicks.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] seccomp: Remove bogus __user annotations
Date:   Fri, 20 Nov 2020 18:05:45 +0100
Message-Id: <20201120170545.1419332-1-jannh@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffers that are passed to read_actions_logged() and write_actions_logged()
are in kernel memory; the sysctl core takes care of copying from/to
userspace.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Reviewed-by: Tyler Hicks <code@tyhicks.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
v2: corrected "Fixes" tag

 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 8ad7a293255a..c2bff3561846 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1968,7 +1968,7 @@ static bool seccomp_actions_logged_from_names(u32 *ac=
tions_logged, char *names)
 	return true;
 }
=20
-static int read_actions_logged(struct ctl_table *ro_table, void __user *bu=
ffer,
+static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
 			       size_t *lenp, loff_t *ppos)
 {
 	char names[sizeof(seccomp_actions_avail)];
@@ -1986,7 +1986,7 @@ static int read_actions_logged(struct ctl_table *ro_t=
able, void __user *buffer,
 	return proc_dostring(&table, 0, buffer, lenp, ppos);
 }
=20
-static int write_actions_logged(struct ctl_table *ro_table, void __user *b=
uffer,
+static int write_actions_logged(struct ctl_table *ro_table, void *buffer,
 				size_t *lenp, loff_t *ppos, u32 *actions_logged)
 {
 	char names[sizeof(seccomp_actions_avail)];

base-commit: 4d02da974ea85a62074efedf354e82778f910d82
--=20
2.29.2.454.gaff20da3a2-goog


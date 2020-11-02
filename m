Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E142A36EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKBXGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgKBXGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:06:16 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24EC0617A6;
        Mon,  2 Nov 2020 15:06:15 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id oq3so19367645ejb.7;
        Mon, 02 Nov 2020 15:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2EKPuLB9qVPZGLQktABXmMbo9rPSG0cnyuFoqhjoQVI=;
        b=j1wXeFEXGLam5I1JsoCNmhBnfjjTtNDmH6v6SxX5Yp/UWWCqXhrAw9wQcS5b4XGNXn
         Av+YeQk5G2I1BDq8YUpHhxxbF1ruIhbgv6rtgDjGUloBH440id8pqM5G53YlnIZGGvDy
         FrYAppEQ09r2Wrq1/HIyP208pGis24JuoTb/RDqXMdMB5rUXm/nXD6XrBUsxapm82Z1J
         jE+qAFRYa53YgRrooJlrwGbQPTmYJICpWxeIZGEfnOHeST6TWykX+GtJ4oFnwLbwlKR1
         7Dx2pVRbkmD42kdk8EqNqZchF46VJIoOVef4WCj6EvjH7OysNW+t+60mo+TZp/oJEpK0
         pC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2EKPuLB9qVPZGLQktABXmMbo9rPSG0cnyuFoqhjoQVI=;
        b=hgz7ONbhPmfP1j8tfZvaOqssifFa7Zvk20Sf34WhE2MJhJM4ph9IUcztyStUTY3QHl
         R1h1zNbtkTvvbvoxUQjoCPZH/oyimHQ2bFR7XzFqyKtqL7hNyXLOOEVs9I0MsEZ3H0gW
         dV0+BzXdV/5S7nkB/vHuSSc816QDqcNxa9fbTtU7smSQNo+TLCAyAC8DIfreCWCwOerg
         oojk6DONXQpQniQmeOXpLpHWx90QYOotf5ZAHjo8bZ8e85RuR5XkzsIFYXWLbZjgupsL
         iaZIiEaSLLWKfF2U7BYbd8BUTiuppfCj42vOmyKlTsYHuMr9eurq/h+ikqto7CZr5T0K
         1hHg==
X-Gm-Message-State: AOAM532aP/Hb0Nx8itX+Wp1nKKBHHx4m+txfI6zebiNxChg57z4Fr79I
        JXkqaf9UBen5v11DL/CeecxaQjov7tUx7g==
X-Google-Smtp-Source: ABdhPJxAsId4qp8rqrVzKbSp0NmcNVTx82XF2It0zP846UpH58AagQ5qUtkK6j4zZwTAJ4SeV7ZlYw==
X-Received: by 2002:a17:906:6453:: with SMTP id l19mr17493281ejn.366.1604358373937;
        Mon, 02 Nov 2020 15:06:13 -0800 (PST)
Received: from necip-pc.vpn.ucf.edu ([85.153.224.24])
        by smtp.gmail.com with ESMTPSA id zm12sm8412701ejb.62.2020.11.02.15.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:06:13 -0800 (PST)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] sparc64: fix kconfig dependency bug for COMPAT
Date:   Tue,  3 Nov 2020 02:06:02 +0300
Message-Id: <20201102230601.644472-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When COMPAT is enabled and BINFMT_ELF is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for COMPAT_BINFMT_ELF
  Depends on [n]: COMPAT [=y] && BINFMT_ELF [=n]
  Selected by [y]:
  - COMPAT [=y] && SPARC64 [=y]

The reason is that COMPAT selects COMPAT_BINFMT_ELF without depending on
or selecting BINFMT_ELF while COMPAT_BINFMT_ELF depends on BINFMT_ELF.
This can also fail building the kernel as demonstrated in a bug report.

Honor the kconfig dependency to remove unmet direct dependency warnings
and avoid any potential build failures.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209885
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 arch/sparc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a6ca135442f9..22df5f0beed5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -496,6 +496,7 @@ config COMPAT
 	bool
 	depends on SPARC64
 	default y
+	select BINFMT_ELF
 	select COMPAT_BINFMT_ELF
 	select HAVE_UID16
 	select ARCH_WANT_OLD_COMPAT_IPC
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441F02FD8DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbhATSwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:52:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390308AbhATRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYWTEQ/huFSMzsrpwj0azmoT19+DGoe9MjwOTg0OH5c=;
        b=VQfdmpvLiNUG/rg8bb2SiU2SD5RkPgvq6wGcCKuiq06IlDeMUxqtEsDCP+YAp+aEDESoKC
        H5amCVrnJjdyyGUZ6VNouxTTFAd306zmolqgEz2dIkOdtVvbT9KfQrI4KlFOuf/LJSY275
        ekW3mmTU6Bin26Npi07xI7kSNS6ISlE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-eWTuLNwAMbG3sd-pg1z5BA-1; Wed, 20 Jan 2021 12:38:47 -0500
X-MC-Unique: eWTuLNwAMbG3sd-pg1z5BA-1
Received: by mail-wr1-f72.google.com with SMTP id n11so11937130wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYWTEQ/huFSMzsrpwj0azmoT19+DGoe9MjwOTg0OH5c=;
        b=uXcUctJgjJQIzFTh3pYpmE2mFzF4/g0Qq/lydjPvZqY1oZP2c3EXDtscPwn+9PcX8h
         6qzjGHupSrhyrGDPEKJCnDp3W+74LVLhaUYcrt06/v0SQZ/h5QoW6jR+3M8C2GiBmi9U
         55c1eWG6iB4D+1yrXWwxkMdXv06edivOO9YbE+uTi2Ba/vDiIbZ0bKfcyczYAGDUbXg7
         8wu6WIImKCS5UVKF/YFgIoPWXeMj0tQJJH+vG4dFtFoDHpzOK0bnVKZsUx4VOz3o/+Rs
         UooRn+IasWC3CTEhxPx0jDN+RsECq05/slonecrotoIefBbthU3HV2gOTmLvZYY/ziPD
         3lMg==
X-Gm-Message-State: AOAM5301cRfn9zWESGcxE0iNuEkeEw/e0wnPCM0rSgpW/arhHnE5e+nh
        d4kFLqMKtW23y8R5j/9jVY69aR1i0QG5kLZXP1Xj5WmtQngscBssf6zjDTzkCeSuKIMAaPj0WUl
        bUwpqmf9jaOtSkUw6CaF2lvuRQopUjEA47jC6U5OKpI2laIn4b6gHXlxyA67uqS9sNYC7mzbDjH
        gG
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr5387441wme.37.1611164326187;
        Wed, 20 Jan 2021 09:38:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTEEAVF5Wb5DvfyKAa6iIpcJZxKaj/uKR/NeIqD5Cr6bWjyZklj7zuAijYtvvTiqRBg2VXRA==
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr5387418wme.37.1611164325951;
        Wed, 20 Jan 2021 09:38:45 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:45 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Raphael Gault <raphael.gault@arm.com>,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 17/17] objtool: arm64: Enable stack validation for arm64
Date:   Wed, 20 Jan 2021 18:38:00 +0100
Message-Id: <20210120173800.1660730-18-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add build option to run stack validation at compile time.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93a320cc8e03..3f297d61b56b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -185,6 +185,7 @@ config ARM64
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
+	select HAVE_STACK_VALIDATION if CC_IS_GCC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
-- 
2.25.4


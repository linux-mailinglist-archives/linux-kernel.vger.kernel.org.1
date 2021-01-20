Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F022FD8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392243AbhATSvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:51:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390047AbhATRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGGCmA0OrDAFQ859/Q0LnejciDnPGfHlYFyTyvifQtk=;
        b=eGmZcYGE0h/Y8fXx0KRtSR1jxg/4LWz6TO2YYAQ3TTNz5kpCOZ17z1q63cidN3Rq5qC9C4
        hw53UE7bh/8mzzECZcRarlmJJYtczN1jXOxCb830ORfq7Q2RSSrftTTEIOYAmyAEXgeuK7
        TcZonuhbDNcvm12WmniHPHsBxaWgEYQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-Sj4SLjamOEOopUpfjY_jig-1; Wed, 20 Jan 2021 12:38:33 -0500
X-MC-Unique: Sj4SLjamOEOopUpfjY_jig-1
Received: by mail-wm1-f70.google.com with SMTP id u67so1305827wmg.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGGCmA0OrDAFQ859/Q0LnejciDnPGfHlYFyTyvifQtk=;
        b=RmxOt2vIBhJV19V5wyBTDX9guO2lSqAKJeSkxBrdGSSW7WYGlzFMx/aTBeWR9cyGB7
         Q7cS8MZilLDr2SR7RS+HxNHlnfeaqK2okIN92r2eH9pvkPUbwJm6TqpvEcodqrlqVhF2
         HYO1sdgX9RDWEoMQkpa0K7pdZUdDjNSOjsOdO0fXpSIHNkk93gzvUNeu+eHlttpqyxME
         wErqT/geio70lv5iGhQ/gnmUiLXakduvQgJlpaPKNenpbfU17ySp6zkCEUbGhKdL9gw/
         kYgut+HBs9hxSalwr3vaRqmBeWWeXnyEyAsNNZwChc5CYTVC69ANrDCAeyN/mdShjddZ
         1EqA==
X-Gm-Message-State: AOAM533EFKLeMTwqRqfIcxhC11HPEpp3+hNk4hfZEyQ/ZHJqokJQRZ5G
        lJ8xEA0jmfJSptT+ddH5/Qbqsl8mIQflniyFcu7DPhWQesCewnWYCuf3udK0OHYeJmEcEEgxUi/
        3UQYprzK/jJ8n9U+9oxg5hVfjG33rPRWE2CUV1uklmk+b2LecD6u8WyvdRLlciCFNpOEqicd2QC
        4h
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr10650937wrq.359.1611164311930;
        Wed, 20 Jan 2021 09:38:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykIx+mFRDz39bWZUr6EuNu+ftrUmcrlFbF3bvA/9HzFKbHf9ER+LSC2Ppw5dI+TMNMsSLSCQ==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr10650911wrq.359.1611164311737;
        Wed, 20 Jan 2021 09:38:31 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:31 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 11/17] efi: libstub: Ignore relocations for .discard sections
Date:   Wed, 20 Jan 2021 18:37:54 +0100
Message-Id: <20210120173800.1660730-12-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EFI stub cannot have absolute relocations in sections affecting the
execution flow. However, for sections that get discarded at link time,
it doesn't really matter if they have absolute relocations.

Ignore the relocation associated with such sections.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 8a94388e38b3..70e9c7f45d30 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -133,7 +133,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 #
 quiet_cmd_stubcopy = STUBCPY $@
       cmd_stubcopy =							\
-	$(STRIP) --strip-debug -o $@ $<;				\
+	$(STRIP) --strip-debug --remove-relocations=".discard.*" -o $@ $<;		\
 	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
 		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
 		/bin/false;						\
-- 
2.25.4


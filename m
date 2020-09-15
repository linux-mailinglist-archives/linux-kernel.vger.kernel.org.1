Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D071126A04A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIOH5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:57:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58834 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726200AbgIOHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600156416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xh3QZ8ID/7ql002ovloJv8B+3KJ5CVPIhkMReh+pQ9Q=;
        b=Ns9LYz8oMW2AeW3ATsjrhaKOY9uFgntJxePCIqI0avQZoIsFzAyJ6kYmCe4JUk1b1DWzgD
        5FXtyWDFoSLNcRKOuWliX+fjsdPVKhs19bBan7XPqmQSjctvwPnRsIvvOkeroDGJJokciW
        ewSVnK92T4yLSjSXk1cdIWQvwwZytQY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-cEi-hpc7OPqKfno41JhAEQ-1; Tue, 15 Sep 2020 03:53:34 -0400
X-MC-Unique: cEi-hpc7OPqKfno41JhAEQ-1
Received: by mail-wr1-f72.google.com with SMTP id x15so894056wrm.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xh3QZ8ID/7ql002ovloJv8B+3KJ5CVPIhkMReh+pQ9Q=;
        b=scO7z5C0QtWESQ81H8Tjb28pCbgO6fnLYpXqYLpcclJ/fj9+WYmD4bITh67I92VX57
         /OwZOweiX+ST7StVugOclj1l8k974vfEMowdJZ/oz5KO1PUEUuhnSlfeA9q//A92/KX4
         JWgaClsznwv64wtPjewoSDRGh1ePLLkQt+BazbC+YJQgYQ/rQ+JEtv3PJ+2ApA6AQgL9
         Cs4SY0MTEUHoRf1m1SNBCc2kHxa+NVNbo12Hj/1TV8/I/aA/Qa4XxsNEs9ig+I52W4d+
         c2epbqh4mv8JUX7jHkwrfa04aPG/rPjNi6c1dPX7MdZZlOOJLFFXz0d0GyLIHU4Dtgus
         yf9Q==
X-Gm-Message-State: AOAM530s9qcKXxX1zMVQCLlw3WbEfJ1BBZzambH7hp0hFEjZZk0ZS2JU
        0lS9u7LIzcVGFdlKz1TLq/0gOH9WOJFVmjFhKscX6Vf2m7sjwBQrGGxATdkHfxuBwyrxTzee5ZZ
        OXFSAu5xdx6o7UA0KjY3/5GO4
X-Received: by 2002:a7b:cd8b:: with SMTP id y11mr3328246wmj.172.1600156413192;
        Tue, 15 Sep 2020 00:53:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS1Fjlx86ZUvAqrxA6yTfTYJJl0wekkDxr5EmXWVBknBneNhDNskiWqNXEiMwxYKm59Lq/PA==
X-Received: by 2002:a7b:cd8b:: with SMTP id y11mr3328236wmj.172.1600156413053;
        Tue, 15 Sep 2020 00:53:33 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id t16sm25301572wrm.57.2020.09.15.00.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:53:32 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 2/3] objtool: check: Ignore unreachable fake jumps
Date:   Tue, 15 Sep 2020 08:53:17 +0100
Message-Id: <20200915075318.7336-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915075318.7336-1-jthierry@redhat.com>
References: <20200915075318.7336-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for alternative code to unconditionally jump out of the
alternative region. In such a case, if a fake jump is added at the end
of the alternative instructions, the fake jump will never be reached.
Since the fake jump is just a mean to make sure code validation does not
go beyond the set of alternatives, reaching it is not a requirement.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fd2edab8e672..cd7c6698d316 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2648,6 +2648,9 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 
+	if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->offset == FAKE_JUMP_OFFSET)
+		return true;
+
 	if (!insn->func)
 		return false;
 
-- 
2.21.3


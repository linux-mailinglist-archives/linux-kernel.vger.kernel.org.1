Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111802DFE0B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgLUQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgLUQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608568043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7fZUcPsvm/ONP1AJjS676dOQ+Tew/+ryrHSYFTiFb6Q=;
        b=PD7ncMWECeme8FAh/HAUMR1WfLWfm1DuilI7KvDxbAMZdHUogTzAblaE9PGNdRVsflhLzH
        8DRLZgUUSr/BX3Po/HfbNukQRXUtUqRTxIURy2TbofCkOht/IqYZBagHwfCxZs560fsGJQ
        xaMcsVMxI0nt/sCHsVPvJsJeRN3TWmI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-lzIc4HEzNPaTsmLijwIDcA-1; Mon, 21 Dec 2020 11:27:21 -0500
X-MC-Unique: lzIc4HEzNPaTsmLijwIDcA-1
Received: by mail-oo1-f70.google.com with SMTP id m1so4016736ooj.23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7fZUcPsvm/ONP1AJjS676dOQ+Tew/+ryrHSYFTiFb6Q=;
        b=mDSN4I8Fs3grfIeV5sxIJhq52/ZVj8+LGdCxdwgnKExYlHttNXl2sR/gmza3pj8GNU
         I+FVidADadgHtq0tHc5yrhDUC371/DGV8dNP45N159ViNFlQ2rr6PcFKR92j9TFp3V0V
         8yPIfIq/O7ou4wNOTJC/yk27CZ42yhEhA4qeIRuttyYbV62nrcDJs2zd2FnMpMjDRrOk
         zf8Du8doU6nM36eUB+ln71Ra09w1DJk2xnjD/45pW6vS5L38V4jMf30IWzN2PxR2Fn7e
         I95mLlxRXdPdgopaG+Z+lACKOVFrBL2FgUByGevbY14i1bppY/DQUCGzdsjIUplLwMN9
         iUFA==
X-Gm-Message-State: AOAM533BjIQca4c9X+u0SAqIDTOtx0Yi5tvxxbbARhwqbnwIBUMTj5KN
        dxBGyjimrxxb4QDADa/FM+GpdovcKzNF/iHI/EgAdnONdAJOpPpZBJUrfAHzGohwdMPDq9VAzAz
        CL0uYa44QD4VLOKuuEYs/q3M/
X-Received: by 2002:a9d:12c:: with SMTP id 41mr12559395otu.77.1608568040848;
        Mon, 21 Dec 2020 08:27:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIFHQxCwxfTsGuY0Q82c9DuHI9dCiXlcm4VSz7iME2mvcSwHUDQ1APIMr+I8TELxiBhbk58A==
X-Received: by 2002:a9d:12c:: with SMTP id 41mr12559382otu.77.1608568040671;
        Mon, 21 Dec 2020 08:27:20 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r25sm3946516otp.23.2020.12.21.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:27:20 -0800 (PST)
From:   trix@redhat.com
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] tracing: add printf attribute to log function
Date:   Mon, 21 Dec 2020 08:27:15 -0800
Message-Id: <20201221162715.3757291-1-trix@redhat.com>
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
 include/linux/trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 886a4ffd9d45..be1e130ed87c 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -34,8 +34,9 @@ int unregister_ftrace_export(struct trace_export *export);
 struct trace_array;
 
 void trace_printk_init_buffers(void);
+__printf(3, 4)
 int trace_array_printk(struct trace_array *tr, unsigned long ip,
-		const char *fmt, ...);
+		       const char *fmt, ...);
 int trace_array_init_printk(struct trace_array *tr);
 void trace_array_put(struct trace_array *tr);
 struct trace_array *trace_array_get_by_name(const char *name);
-- 
2.27.0


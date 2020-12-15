Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152832DAF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgLOOyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:54:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729770AbgLOOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ompx6jQ8zGERoq0RC6yve0+nHkEYL2wxaj8e3jFemHI=;
        b=Uity7y9ItZLSTFhezyAPrecn67FQKu2cgRt4I6XGNfmztyJ+t/YRRYq3Upv526KW5BgDgY
        myk4lO8wUFOJ6Hmrwj/2bjbV2yrKR+6J2qy8F/B2WIh4Dx8W0aCApmMIh7/AgB/TjYO+OF
        iNdqpAM7+TF/zjbrUlDtmZfvC5LJF7o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-eYvHippdMGanpNtPx6o-8A-1; Tue, 15 Dec 2020 09:53:12 -0500
X-MC-Unique: eYvHippdMGanpNtPx6o-8A-1
Received: by mail-qt1-f198.google.com with SMTP id n12so14522556qta.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ompx6jQ8zGERoq0RC6yve0+nHkEYL2wxaj8e3jFemHI=;
        b=MN7NlIAnw0d78cj/D74C4ShTI6QCeRtKqS2lVxWwQf3nZn/GuoR913xCa+KjpmCuFM
         /MfwWi0m5309V6KrBxGaJKbxR4QQnmm661VL6Z1hvfytk3+F6yHv7XTgFE6mG0WjU3Vr
         cCw86FXtM0PtEfxeUwBY3eLEfnC0wY0iWQY6U5RvHh5QIHDC5+J9eQfslOIENeioFrEA
         43bdRRR78Y2j+rL6E/XgNGytYeNChsdeTeqyNd1k6shVTBdltyb2h0NzJW30tzjSeLb3
         ziqFtBww/FaHZFDKW6UZn+1zWefvI/AkOnNZ29SKQR/YMUHcTk72lwyqgmzr6rP7xAOo
         NeJQ==
X-Gm-Message-State: AOAM532Wjof7UkqbjmNbGz5NYwotAxfoe0cZStZhbdGvGgwv54y7JMxm
        rqT+Ta5T6OTcSA4GYRAs837zm6WNIOZJx3rcrcbYfW8qDuWtc6tu2e+SoRvwVlHqX2rUCJbNSpu
        LvtRt5tO84SwZzhtiGjDiGxv1
X-Received: by 2002:a37:4a90:: with SMTP id x138mr40235614qka.186.1608043991752;
        Tue, 15 Dec 2020 06:53:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpXzQKMn+/7g/okl1FhtOglvIXN986uZb3Ek+BsWSPZKBONAGFHOLfAhOMToD/UhaCvlRdBw==
X-Received: by 2002:a37:4a90:: with SMTP id x138mr40235598qka.186.1608043991537;
        Tue, 15 Dec 2020 06:53:11 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r201sm17185721qka.114.2020.12.15.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:53:10 -0800 (PST)
From:   trix@redhat.com
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] greybus: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 06:53:06 -0800
Message-Id: <20201215145306.1901598-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/greybus/greybus_trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/greybus/greybus_trace.h b/drivers/greybus/greybus_trace.h
index 1bc9f1275c65..616a3bd61aa6 100644
--- a/drivers/greybus/greybus_trace.h
+++ b/drivers/greybus/greybus_trace.h
@@ -40,7 +40,7 @@ DECLARE_EVENT_CLASS(gb_message,
 		__entry->result = message->header->result;
 	),
 
-	TP_printk("size=%hu operation_id=0x%04x type=0x%02x result=0x%02x",
+	TP_printk("size=%u operation_id=0x%04x type=0x%02x result=0x%02x",
 		  __entry->size, __entry->operation_id,
 		  __entry->type, __entry->result)
 );
@@ -317,7 +317,7 @@ DECLARE_EVENT_CLASS(gb_interface,
 		__entry->mode_switch = intf->mode_switch;
 	),
 
-	TP_printk("intf_id=%hhu device_id=%hhu module_id=%hhu D=%d J=%d A=%d E=%d M=%d",
+	TP_printk("intf_id=%u device_id=%u module_id=%u D=%d J=%d A=%d E=%d M=%d",
 		__entry->id, __entry->device_id, __entry->module_id,
 		__entry->disconnected, __entry->ejected, __entry->active,
 		__entry->enabled, __entry->mode_switch)
@@ -391,7 +391,7 @@ DECLARE_EVENT_CLASS(gb_module,
 		__entry->disconnected = module->disconnected;
 	),
 
-	TP_printk("hd_bus_id=%d module_id=%hhu num_interfaces=%zu disconnected=%d",
+	TP_printk("hd_bus_id=%d module_id=%u num_interfaces=%zu disconnected=%d",
 		__entry->hd_bus_id, __entry->module_id,
 		__entry->num_interfaces, __entry->disconnected)
 );
-- 
2.27.0


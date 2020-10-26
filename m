Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B603E2996A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792762AbgJZTPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1783064AbgJZTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603739709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+B8RU8GaSsfIoo++o6WwZDC13Vzg4HDPXwZRisdyOVA=;
        b=TnUcqevfvg1YmC1Q4/NlcWcay17NjMcCXLufrfcVxef7LFxnAMaFzJ4Jffegc6Xjjjyi1a
        fX8R4MKinzOxfTu8YgpkJvNbWHmoEXoVUI4XCUsMDfalyuwIrvEJafKTKU1U4U8hD5c+zh
        Dpdtu6CK3wyXGhATbolfG0wcCpWNhAk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-cqsFCmFiOLOfePjVQrx08A-1; Mon, 26 Oct 2020 15:14:59 -0400
X-MC-Unique: cqsFCmFiOLOfePjVQrx08A-1
Received: by mail-ot1-f70.google.com with SMTP id u5so1481839otb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+B8RU8GaSsfIoo++o6WwZDC13Vzg4HDPXwZRisdyOVA=;
        b=q4loEDmAt7ELRpJfAntuly4eCmhb441A2dtXRFN0ew3ZOqecjPyAEhF3p383Px0dvn
         oT22t7Uf2E1ODnhKiQUS/B+43utx9Jvh++ZLfQ3rslu4rhTunsVDc6EVASqBJLx6YxUE
         bqkHmmRcaARxfrPCatkAvG7jVa+WTbHMlrycASzA7req1oWhu88S7wvZSUWMswr381eE
         j7r9f2C8aFVis2/D2xfRaePTqjGlu5d32NAW0AZ8iE3MDH68wzreQZ0Wjs1Qu4nJAqNT
         Yr3EnkuW15eY/Z8CixkB3gFUlal5r3E1Utmq9Abfsxq2MFPVnOyxawgaUJjWJKrtIkrU
         Uvmw==
X-Gm-Message-State: AOAM532XXbCw3IJb0uGq83xzYBb+rd006YRvOADp1s5wg6sEGK976ZvJ
        1meu1XYx9qA5lqtebz643JYJJSrEb4KDYObdwSqSts9qbVOnq5F6qU6IO4c2fXVhpzqzlLuD8z+
        O6tPLkhj5m/XKtUvJV/0YI7nP
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr12192361oto.64.1603739698636;
        Mon, 26 Oct 2020 12:14:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQdHHxBau2UJ1fjutzv8M4KSiDRNEo8dGY9X2K3l31+DK1KbyNlL2H1UkkV9q9GVuEVmeqDg==
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr12192345oto.64.1603739698391;
        Mon, 26 Oct 2020 12:14:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j3sm1931500oij.9.2020.10.26.12.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:14:57 -0700 (PDT)
From:   trix@redhat.com
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] usb: serial: iuu_phoenix remove unneeded break
Date:   Mon, 26 Oct 2020 12:14:50 -0700
Message-Id: <20201026191450.1429945-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: split from original larger patch
---
 drivers/usb/serial/iuu_phoenix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index b4ba79123d9d..f1201d4de297 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -850,7 +850,6 @@ static int iuu_uart_baud(struct usb_serial_port *port, u32 baud_base,
 	default:
 		kfree(dataout);
 		return IUU_INVALID_PARAMETER;
-		break;
 	}
 
 	switch (parity & 0xF0) {
@@ -864,7 +863,6 @@ static int iuu_uart_baud(struct usb_serial_port *port, u32 baud_base,
 	default:
 		kfree(dataout);
 		return IUU_INVALID_PARAMETER;
-		break;
 	}
 
 	status = bulk_immediate(port, dataout, DataCount);
-- 
2.18.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD26B2FB814
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392001AbhASL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391799AbhASLsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:48:00 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E6DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 03:47:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l23so12026836pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 03:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7yJDey0M+HW/YQk4Qnou/+vJASlcwRgxX1tZO/12uc=;
        b=XheqXA0hvMXgSeZ/+sY8OuNzqj5RtUqLV7XUp9iDcbrxN4C/H006GSgCdY6pCRZ+6A
         YP4PN3F2p5Kr7Ty8III6swOElYekyLY5rZkqJSH4FbuFUf2Di0N21HcH2+hAssViFDSC
         S0EOkeMwd9aQEEzPqMdvZ2SeYdA5F+VvRBMR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7yJDey0M+HW/YQk4Qnou/+vJASlcwRgxX1tZO/12uc=;
        b=R0l8O01Yl669CCoBGu7Y1Qgt+cp7QJJvUH65KS0NX5FXox0v/3QJTbhqQe+vIYfe2m
         SWumb8l+LXDhyLHj1ImfswH0h+fvUGsfxUVvWkIyu16iCmKxGLmgI6Ix255Lxo1j5Gex
         vuHZhPjpic5U5Qaf72g0DBwxlXMmpY58LapeABkcomyZX3uVm3LPcV6ppuPVhETyKRqU
         iZHfF3MP6bnY8X+WZkDOEn2JkLi59YZ/iOZq1Oahnl2ryU35CaBqC9Gdv9PwGnyt8Wrq
         6MsUSU6HP461x4WKGEjjwFa846+3dURiyyh8xM3VEZzAkNslLlxXsXWz66JNVhSi01Y4
         bnJg==
X-Gm-Message-State: AOAM533bdXSOa97hDtBqEpSJ8rv0hyhMwYVc9VNsFAAEBkeFYJ66RB5r
        bK+5m90nDYhkK/+f+peg8nTrWg==
X-Google-Smtp-Source: ABdhPJwKkaeHsZKLVvtVi3Idy2+qMHHrfOaNv4MG3cu9uCgasAbEp6he3pKE0HDPzeG7iHBOxS8N0Q==
X-Received: by 2002:a17:90a:fd0b:: with SMTP id cv11mr5019491pjb.26.1611056840071;
        Tue, 19 Jan 2021 03:47:20 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3d01:2769:7769:a4b0])
        by smtp.gmail.com with ESMTPSA id gx21sm3456732pjb.31.2021.01.19.03.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 03:47:19 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.chou@realtek.com, hildawu@realtek.com,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: hci_h5: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for btrtl
Date:   Tue, 19 Jan 2021 19:47:00 +0800
Message-Id: <20210119114700.3662156-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek Bluetooth controllers can do both LE scan and BR/EDR inquiry
at once, need to set HCI_QUIRK_SIMULTANEOUS_DISCOVERY quirk.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/bluetooth/hci_h5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fb9817f97d45..27e96681d583 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -906,6 +906,11 @@ static int h5_btrtl_setup(struct h5 *h5)
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
 
+	/* Enable controller to do both LE scan and BR/EDR inquiry
+	 * simultaneously.
+	 */
+	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
+
 out_free:
 	btrtl_free(btrtl_dev);
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog


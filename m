Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF882982D8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417755AbgJYRqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:46:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44310 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417729AbgJYRqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:46:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id b1so8902419lfp.11;
        Sun, 25 Oct 2020 10:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGTT39jWlLeV6qw6JuECAsw5LeIu6htUw8WodmgXEVI=;
        b=XkVvJzDzd3Qn/fZ4eBvE/vaL7nah2jIhXOw59rXgbUpCPGNfg+Zj46Oa79BtXIc0zF
         zDzUsR7JkjpzrQgB3f6ywCFuI55suyyBb6gGV/Y9eYY4fisoSUEymxN8gXdcMnnv1oEd
         eCs4SgHH9y6aOiVqZhq3vKfylG+v2btIXlv40y7hwe9cWGnkpCOET52hTARxoOm6ukzD
         Q+7IqBDPoTtxqJ9EHRexx+cAP66LB4KB65gfJYi5whc5l58C363RyhgwlPnIlJ4WSWJj
         7lnKZ1MwbW1ViSPEH0InGRQc0ZnNEI9jfZPUaVbHTuGU7NkB+A73ZBwWix5hvxjYfUJg
         dueA==
X-Gm-Message-State: AOAM532f/qlMDOcE6WgqXsNVduhsSQls3JSIcg/xTkxm3h/lZuEJnpTG
        f8ldaNp6A+1qxXgXRYYOiV22MwccWg4fHg==
X-Google-Smtp-Source: ABdhPJyg3MdoMNccmbHEu+WlbVdesSjkOhQXLYIvMsk57nibY5czw5DG9W3f7mjm8LuJdCh4vy7v6g==
X-Received: by 2002:a19:407:: with SMTP id 7mr3676131lfe.291.1603647999803;
        Sun, 25 Oct 2020 10:46:39 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id e19sm793673lfn.241.2020.10.25.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:46:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kWk6J-0007Hn-6X; Sun, 25 Oct 2020 18:46:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 09/14] USB: serial: keyspan_pda: increase transmitter threshold
Date:   Sun, 25 Oct 2020 18:45:55 +0100
Message-Id: <20201025174600.27896-10-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025174600.27896-1-johan@kernel.org>
References: <20201025174600.27896-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the transmitter threshold so that writing isn't resumed until
128 bytes are available in the device buffer thereby allowing for larger
and more efficient transfers.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index b3fb2ecefb31..3816bbc928b2 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -40,7 +40,7 @@
 #define DRIVER_AUTHOR "Brian Warner <warner@lothar.com>"
 #define DRIVER_DESC "USB Keyspan PDA Converter driver"
 
-#define KEYSPAN_TX_THRESHOLD	16
+#define KEYSPAN_TX_THRESHOLD	128
 
 struct keyspan_pda_private {
 	int			tx_room;
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B12F5C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbhANIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:07:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbhANIGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:06:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD98123A57;
        Thu, 14 Jan 2021 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=aM+KUU8ND9pyof4k4ykSf1dVmSEm8guTu48Zq/aOrf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4NqcvP0nUPY2+HwZQCa3P3Qty+DCPQOpt2FxL8ZXN0PQcmWo7Le3ZdKbcG/SOi6s
         MzYDcHleMrNAfTdNkYoK5YlEkqvheOOU78YjjXiPDQb0MjMys7pQTt2+6Ktcv275d2
         g+KywtcbpVfqw+Ku0Dtur8A6BSnx7MWq0Qm04Jl4UoKIVv5uIpAgvBFEFXpp/ptvs1
         WTeBcbUCFuKtMRZaOYQPy6BaepHq9KxJMTM+HjtcF5fKWugBEaiB5sOccyfpebX+5/
         Hfq8OpNqLQAkfm0mS9oQvjfUM/df9MiQCG+98pYeMPEAGa9Bzpi2FVLdiTIUlesbdk
         /18zqSh2nVQVQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxco-00EQ74-Hy; Thu, 14 Jan 2021 09:04:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 16/16] platform/surface: aggregator: fix a kernel-doc markup
Date:   Thu, 14 Jan 2021 09:04:52 +0100
Message-Id: <4a6bf33cfbd06654d78294127f2b6d354d073089.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup:

	../drivers/platform/surface/aggregator/ssh_request_layer.c:1065: warning: expecting prototype for ssh_rtl_tx_start(). Prototype was for ssh_rtl_start() instead

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/platform/surface/aggregator/ssh_request_layer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index bb1c862411a2..25db4d638cfa 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -1056,7 +1056,7 @@ void ssh_rtl_destroy(struct ssh_rtl *rtl)
 }
 
 /**
- * ssh_rtl_tx_start() - Start request transmitter and receiver.
+ * ssh_rtl_start() - Start request transmitter and receiver.
  * @rtl: The request transport layer.
  *
  * Return: Returns zero on success, a negative error code on failure.
-- 
2.29.2


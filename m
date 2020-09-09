Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8CC263346
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIIRAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730631AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E59822227;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=2/yKtEUICes8Nbwus1uyctYK8EdcFW1fE//ARdB9QF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vr14xcXryE0ERgqBs+nLcsfPoWHnAbO1EY093bosqoOe2E039x9mKItxYQlGLCL2b
         bKtm/7T7xrLwpXj/r0ASWB9zD5Fpq2PeOOlq0HMoL40MECPF5XYpoehUDckqj/4tKH
         kz5cFEr3IVb1HetQyTP/cqTayT3Hu3p/pqDrkPlU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXU-Kf; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/30] iio: industrialio-core.c: solve a kernel-doc warning
Date:   Wed,  9 Sep 2020 16:10:52 +0200
Message-Id: <dbcb8abc849ea52a3262fdece50aa978a55aac26.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-doc currently compains with:
	./drivers/iio/industrialio-core.c:177: warning: Function parameter or member 'indio_dev' not described in 'iio_get_debugfs_dentry'
	./drivers/iio/industrialio-core.c:1530: warning: Function parameter or member 'parent' not described in 'iio_device_alloc'

The problem is that the comment just before iio_get_debugfs_dentry()
is just a comment, and not really a kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d882c7f31ba9..b05ff9154310 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -169,7 +169,7 @@ static const char * const iio_chan_info_postfix[] = {
 };
 
 #if defined(CONFIG_DEBUG_FS)
-/**
+/*
  * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
  * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is undefined
  */
-- 
2.26.2


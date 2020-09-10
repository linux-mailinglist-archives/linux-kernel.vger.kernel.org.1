Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B44265499
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgIJV7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgIJLLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:11:02 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C788220684;
        Thu, 10 Sep 2020 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599736256;
        bh=hwbguJAyWYPwpsu2D9i8rT7/tZ9bdITwH1YQjeqWGeY=;
        h=From:To:Cc:Subject:Date:From;
        b=yU9kK7kDFEFEj4H2bNq6YF57ElD9FDd6tMPu4RNKVVzIr6NO1swabRB0YYIl1rBus
         cH149spIdCImg539GhPPFyBg20iIAuna9Qwz4jgm9JwX/Qu2UfzxF9Ng5PcL7eqdLn
         hUaQNH1qaHSsJAtSudoIgt0yJyK17f3H90cv+0AE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGKTd-00ELvC-8a; Thu, 10 Sep 2020 13:10:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] drm: kernel-doc: add description for a new function parameter
Date:   Thu, 10 Sep 2020 13:10:51 +0200
Message-Id: <c089fc458b7347e5ab287dab9fb661979736566d.1599736241.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by "make htmldocs":

	./drivers/gpu/drm/drm_prime.c:808: warning: Function parameter or member 'dev' not described in 'drm_prime_pages_to_sg'

Add a description for the new parameter.

Fixes: 707d561f77b5 ("drm: allow limiting the scatter list size.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/drm_prime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 8a6a3c99b7d8..45e70ecdfa45 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -793,6 +793,7 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
 
 /**
  * drm_prime_pages_to_sg - converts a page array into an sg list
+ * @dev: DRM device
  * @pages: pointer to the array of page pointers to convert
  * @nr_pages: length of the page vector
  *
-- 
2.26.2


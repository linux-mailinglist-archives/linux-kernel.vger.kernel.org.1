Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7F224E69
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgGSAbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:31:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC58DC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7sFkFwKstgR+U/+AAfi4Sm94t8B3RubKdUJorJhLltM=; b=GtYlE+tG+VgbC+vLPMMnVT1lo8
        bQTJ2uOGISh4UXpBk43R2gtxa7qmm2drbFNRdfTB4CF+xtSbwRi9h8sMAbrNK6QtmTeWhtQaZvx5p
        SKczTXBjZnjmwM8S+lhWFcT9ziuCCfvb2N3QBzWo1H4B8OHsKaGoikLEwbJoO58+06PyhKiMWTHfP
        UY34WCVQCIhTPz3HFC1O7D6Zcl98kQ3M+hUqs7unqhnOa2l2nUCOVI4mpuPfRI2J7IB6H7uG4ysX7
        SF6uoNmwya17CPbJXWuuN9+y9yAVom7dEnTFyShH2zfZGYfTSTi7Sh+PM5Uipr/dYjp4FFHa+Pgz6
        Dcn9PlPg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxER-0002sA-8Z; Sun, 19 Jul 2020 00:31:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Nishanth Menon <nm@ti.com>,
        Aneesh V <aneesh@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: [PATCH] platform_data: emif_plat.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:31:03 -0700
Message-Id: <20200719003103.20949-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "if" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Aneesh V <aneesh@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
---
 include/linux/platform_data/emif_plat.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/platform_data/emif_plat.h
+++ linux-next-20200717/include/linux/platform_data/emif_plat.h
@@ -98,7 +98,7 @@ struct emif_custom_configs {
  *			as type, bus width, density etc
  * @timings:		Timings information from device datasheet passed
  *			as an array of 'struct lpddr2_timings'. Can be NULL
- *			if if default timings are ok
+ *			if default timings are ok
  * @timings_arr_size:	Size of the timings array. Depends on the number
  *			of different frequencies for which timings data
  *			is provided

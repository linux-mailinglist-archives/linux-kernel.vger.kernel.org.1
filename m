Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D3826F57A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIRFsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIRFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:48:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0922CC06174A;
        Thu, 17 Sep 2020 22:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=YeZIwM7SO9RXrO6BU+e2U/JIv8uOLMaqxKEZGRIyB5Q=; b=FiFTV3flg1XugbyGwWrb6onjLu
        bPaFnpzvpQRAg3wj4iCXe11m/YGFK6qvCOvg3k4kSEscCJ0V5BxPpzYoyXzItZMHGCvVChyuBaNDR
        53E2ZJNbjexPJ1FoFEzIKYJGPdUe59vS1b9JONIHeP0+7XPqxPnuz7VUtEGDCGxIr1bkOMFE6Xw4f
        ohipPIG1Avs0Kr/IDorgoDjcQa0MDz2f5782ZytOIRkN2KObRPIJpvb0cT1C8Z59cW/NRYi/L/Rg+
        E++LoZgzTnaIWKCd3L8ERAbpD0L43kw9TSSHs3xMQPTe0AzI4VuQl0p+g6CVqB7gn9Lal3LSd+bkB
        3MlBb1mQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ9Ff-0002BQ-MK; Fri, 18 Sep 2020 05:48:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/admin-guide: kernel-parameters: fix "disable_ddw" wording
Date:   Thu, 17 Sep 2020 22:48:03 -0700
Message-Id: <20200918054803.6588-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop and extraneous word (if) in a sentence.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200917.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20200917/Documentation/admin-guide/kernel-parameters.txt
@@ -951,7 +951,7 @@
 			Arch Perfmon v4 (Skylake and newer).
 
 	disable_ddw	[PPC/PSERIES]
-			Disable Dynamic DMA Window support. Use this if
+			Disable Dynamic DMA Window support. Use this
 			to workaround buggy firmware.
 
 	disable_ipv6=	[IPV6]

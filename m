Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0023198A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 08:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgG2G1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 02:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgG2G11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:27:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F8C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MteXG/Grkxdqd50qllzh7qUhK2KVKCiTNBml01htQmw=; b=LyFsOo3R0tiBMGmvk2ENOmTcOC
        t+P8tSN4ZgPkGvobqYc1DX0E7Kh/G9PcwupDg9oHWoF2MsoDttWmGNuU1/JmOud4QNx80GMLB2JEw
        /S03IClwvVgHyOuuigF4SJJ2OOpf8tCnbIlh+zehOgAu/cmC03P4dxGLKmMdw3lxMZkdcUOFQ2s4Z
        yMCzSn3T36M7gSm0jIpC8ZmjcAypN1y0kaYOC+HBKp8ywUDVK3DyNzLzu/yXc8Vq/tEdKUxNZMM0c
        +qI3tgkWJTg/1eIYsl0yycPSeh4d3OLbHOkRD3tsKuz9mXWgCbXimHQE9UN8gt8ceX4l0Baf6JyBv
        A8qBp52g==;
Received: from 089144218008.atnat0027.highway.a1.net ([89.144.218.8] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0fYi-00041p-3c; Wed, 29 Jul 2020 06:27:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/7] modules: inherit TAINT_PROPRIETARY_MODULE
Date:   Wed, 29 Jul 2020 08:27:11 +0200
Message-Id: <20200729062711.13016-8-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729062711.13016-1-hch@lst.de>
References: <20200729062711.13016-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a TAINT_PROPRIETARY_MODULE exports symbol, inherit the tain flag
for all modules importing these symbols, and don't allow loading
symbols from TAINT_PROPRIETARY_MODULE modules if the module previously
imported gplonly symbols.  Add a anti-circumvention devices so people
don't accidentally get themselves into trouble this way.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/module.h |  1 +
 kernel/module.c        | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index c9bc3412ae4465..d49e033563dadf 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -389,6 +389,7 @@ struct module {
 	unsigned int num_gpl_syms;
 	const struct kernel_symbol *gpl_syms;
 	const s32 *gpl_crcs;
+	bool using_gplonly_symbols;
 
 #ifdef CONFIG_UNUSED_SYMBOLS
 	/* unused exported symbols. */
diff --git a/kernel/module.c b/kernel/module.c
index a907bc57d343f9..eb6ab2f4b81aaa 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1456,6 +1456,18 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	if (!sym)
 		goto unlock;
 
+	if (licence == GPL_ONLY)
+		mod->using_gplonly_symbols = true;
+
+	if (owner && test_bit(TAINT_PROPRIETARY_MODULE, &owner->taints)) {
+		if (mod->using_gplonly_symbols) {
+			sym = NULL;
+			goto getname;
+		}
+		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
+				 LOCKDEP_NOW_UNRELIABLE);
+	}
+
 	if (!check_version(info, name, mod, crc)) {
 		sym = ERR_PTR(-EINVAL);
 		goto getname;
-- 
2.27.0


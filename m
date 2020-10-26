Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576C829932C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786876AbgJZQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1786711AbgJZQ5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:57:22 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6CE52224A;
        Mon, 26 Oct 2020 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603731442;
        bh=KJYE8gFCxcABOu+mEh1/geb/uvls5Kdzq9bEPy3r3WA=;
        h=From:To:Cc:Subject:Date:From;
        b=mwTgG+ghrS6T6iSLk4o3A1Hvrlvx5MPbBTjN2iUiafRZQfdvqPlnxkZ8Z0xcC3188
         Eej8oZZx9Il5aXSINQD6i5Rzj6f2zBZrcRuJhE+niebQA4k52ngNOlat02e12LuFIt
         SktXasRb5POhEX2YkF2Y9meQRuhVvgcmUxwfA88M=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: make snd_kcontrol_new name a normal string
Date:   Mon, 26 Oct 2020 17:52:18 +0100
Message-Id: <20201026165715.3723704-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When building with W=2, there are lots of warnings about the
snd_kcontrol_new name field being an array of 'unsigned char'
but initialized to a string:

include/sound/soc.h:93:48: warning: pointer targets in initialization of 'const unsigned char *' from 'char *' differ in signedness [-Wpointer-sign]

Make it a regular 'char *' to avoid flooding the build log with this.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/control.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index e128cff10dfa..77d9fa10812d 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -42,7 +42,7 @@ struct snd_kcontrol_new {
 	snd_ctl_elem_iface_t iface;	/* interface identifier */
 	unsigned int device;		/* device/client number */
 	unsigned int subdevice;		/* subdevice (substream) number */
-	const unsigned char *name;	/* ASCII name of item */
+	const char *name;		/* ASCII name of item */
 	unsigned int index;		/* index of item */
 	unsigned int access;		/* access rights */
 	unsigned int count;		/* count of same elements */
-- 
2.27.0


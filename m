Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BFA28CD67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgJML7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbgJMLyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:43 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEBB122404;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=78BG9Iu2yAlND/COH/HKK6//gm3h8RbYRE58LCuOyj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsK7hZKtJHTp+v/vQK7XgM0QCL3nZxAgSJGWungnQzL/zeI6v/B32acVF1enJu+A9
         IRprqu9BkcwN4dzKVUpjjIYEAtgjJJPbBEVgieSPRbCuk+VUU8v322xh1wkbfjKvrM
         cwkig0bWKbK+uTEmlbTrA2y5DEC6r1TBITVQkz5U=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUx-PS; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v6 39/80] docs: writing-an-alsa-driver.rst: fix some bad c:func: markups
Date:   Tue, 13 Oct 2020 13:53:54 +0200
Message-Id: <d01b867cb61f9bcbd810ed31be080705fd31f0aa.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some such markups are invalid, as reported by Sphinx:

	./Documentation/sound/kernel-api/writing-an-alsa-driver.rst:3317: WARNING: Unparseable C cross-reference: 'snd_rawmidi_transmit*'
	Invalid C declaration: Expected end of definition. [error at 20]
	  snd_rawmidi_transmit*
	  --------------------^
	./Documentation/sound/kernel-api/writing-an-alsa-driver.rst:3917: WARNING: Unparseable C cross-reference: 'copy_from/to_user'
	Invalid C declaration: Expected end of definition. [error at 9]
	  copy_from/to_user
	  ---------^

The first case seems to be better replaced by a literal.

For the second one, let's generate cross-references, by
spliting it in two.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index 85d6e9c643ef..73bbd59afc33 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -3315,8 +3315,7 @@ data and removes them from the buffer at once:
   }
 
 If you know beforehand how many bytes you can accept, you can use a
-buffer size greater than one with the
-:c:func:`snd_rawmidi_transmit\*()` functions.
+buffer size greater than one with the ``snd_rawmidi_transmit*()`` functions.
 
 The ``trigger`` callback must not sleep. If the hardware FIFO is full
 before the substream buffer has been emptied, you have to continue
@@ -3916,7 +3915,7 @@ the maximum size of the proc file access.
 
 The read/write callbacks of raw mode are more direct than the text mode.
 You need to use a low-level I/O functions such as
-:c:func:`copy_from/to_user()` to transfer the data.
+:c:func:`copy_from_user()` and :c:func:`copy_to_user()` to transfer the data.
 
 ::
 
-- 
2.26.2


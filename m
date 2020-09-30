Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCEE27E9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgI3N1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbgI3NZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:22 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5CA23A52;
        Wed, 30 Sep 2020 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=BA0rUNfQv2vTH4SLnc/FqbEBD7kAUkAlpsHlup8dym8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoZX0js5gUXgcROd/wYy5mIzlvUKaoE8hTeskV/UPb/swsJr3psniP3jvJRXjaOgw
         t9YYCe/tq2Tjiphika3JjZD7BZL/y93nz668ZTqdpoJJGSLxGLICR31gqeWtesTQ5A
         o1p2bGl7hBSP/a27mck8xIA9+CDenCO4TW904dhI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6h-001XKf-Eh; Wed, 30 Sep 2020 15:25:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 39/52] docs: writing-an-alsa-driver.rst: fix some bad c:func: markups
Date:   Wed, 30 Sep 2020 15:25:02 +0200
Message-Id: <9c68c182ae5aa978d68b64695b1e3292fcf58e76.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
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


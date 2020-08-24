Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28B024F096
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgHXACg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 20:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgHXACf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 20:02:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B346C061573;
        Sun, 23 Aug 2020 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=p5Qc68KZfangV2bqxREUc+eShqFQXctpwYrlmpxjIr8=; b=u2LVtBXOpVCWkjmFnz56jg0W6X
        lMQd5XnkdBCTw1c1ZJ28jHHvaEgNpA9VHyNjlCOZOo4+PCoxVDbBaYYpDkl9a/PU81lfdxndFzBej
        Ce4/xsnSBDiSt+uARqwnekKbUf23tse6eiCOC4UOAEErL4IbkVYC6N2hSLOo0tux2hrNxV7LDUddQ
        nLP5Dtu/nLIJJeoxEOXz6OfFHzUQ7TyG1kJNToumrbmUJissHgIEh12VBmsAYJVSB4Y40/cPF9Hgh
        phDxmIcGUCRVkxPHb+UPUkd38eIBzuK7FGA2LwiuGQ+o/dkUwySI4mQ4qfi/dUt/g2jtLyGeHyjuw
        7q8fU0fg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9zwQ-0002Vm-87; Mon, 24 Aug 2020 00:02:26 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: sound/cards: fix heading underline lengths for
 https: changes
Message-ID: <357ee576-32a2-6e2b-1db6-78be39253846@infradead.org>
Date:   Sun, 23 Aug 2020 17:02:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix documentation build warnings for underline length too short,
caused by s/http/https/ and not changing the accompanying underlines.

Documentation/sound/cards/audigy-mixer.rst:335: WARNING: Title underline too short.
US Patents (https://www.uspto.gov/)
----------------------------------

Documentation/sound/cards/sb-live-mixer.rst:340: WARNING: Title underline too short.
US Patents (https://www.uspto.gov/)
----------------------------------

Fixes: 7ed33ea6b4fa ("ALSA: Replace HTTP links with HTTPS ones")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander A. Klimov <grandmaster@al2klimov.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/cards/audigy-mixer.rst  |    2 +-
 Documentation/sound/cards/sb-live-mixer.rst |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- lnx-59-rc2.orig/Documentation/sound/cards/audigy-mixer.rst
+++ lnx-59-rc2/Documentation/sound/cards/audigy-mixer.rst
@@ -332,7 +332,7 @@ WO 9901953 (A1)
 
 
 US Patents (https://www.uspto.gov/)
-----------------------------------
+-----------------------------------
 
 US 5925841
 	Digital Sampling Instrument employing cache memory (Jul. 20, 1999)
--- lnx-59-rc2.orig/Documentation/sound/cards/sb-live-mixer.rst
+++ lnx-59-rc2/Documentation/sound/cards/sb-live-mixer.rst
@@ -337,7 +337,7 @@ WO 9901953 (A1)
 
 
 US Patents (https://www.uspto.gov/)
-----------------------------------
+-----------------------------------
 
 US 5925841
 	Digital Sampling Instrument employing cache memory (Jul. 20, 1999)


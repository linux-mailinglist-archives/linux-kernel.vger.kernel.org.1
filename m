Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B472E8B4C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 08:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbhACHvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 02:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbhACHvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 02:51:40 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E94C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 23:50:59 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D7rXy2Tx3zPk0d;
        Sun,  3 Jan 2021 08:50:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1609660258; bh=gGPiPvTU12A2zMeIGjCVoYnQ4p6wZnnzEibE3Ao2pUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=mvVcOxywuXxENKuvwFuY4Ka3Ew0J+nW9rowHgTffemuTXraDLeAE5mn+QHlUL3dcH
         PMLaqtHwZ04E4AKtop28jqoE11ViHCCHaJ1wR1pFyypwx/RmMjr+AAomWI8jgVLEU5
         DJH7IHh2t3tdAIternpIdnZzL+5zBvDPeZLl69Gd3Z+ySuLO8TsHBXJAUuURGJqA1M
         s54NQ01tF3KVcP/7usYPiUQssEdTcYPVUZKcZWUmEY2udfSNQ2im1WrSGjrTqR6/X0
         cKp0525CXs2s0KPFVCEYmUd3c/JKPpLmXJU/SwFMcshrRHv1Om7rqxVcQ+CjRiL/Cl
         sDpDJBEWOR9TQ==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from localhost.localdomain (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX188qj8WbbrQ4Oza5NKfizdYo8BzkFBgJ2c=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D7rXw0dXVzPjlR;
        Sun,  3 Jan 2021 08:50:56 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, akpm@linux-foundation.org,
        nicolai.fischer@fau.de, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH v3 4/5] checkpatch: kconfig: clarify warning for paragraph length
Date:   Sun,  3 Jan 2021 08:50:14 +0100
Message-Id: <20210103075015.23946-5-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210103075015.23946-1-nicolai.fischer@fau.de>
References: <20201226140511.662368-1-nicolai.fischer@fau.de>
 <20210103075015.23946-1-nicolai.fischer@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch displays a warning if it detects a help text
of a Kconfig option which is too short. However the warning does
not contain any further information.
This adds the expected and currently detected number of lines
to the warning, which makes it more obvious why checkpatch
is warning.

Furthermore this makes it easier to quickly identify false
positives, e.g. when a help message contains a Kconfig keyword
and falsely triggers checkpatch to stop counting lines,
it will be more apparent, because the user can see how many lines
they wrote and how many of those were counted correctly.

Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 209880810aaa..805b5870803f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3356,7 +3356,7 @@ sub process {
 			}
 			if ($is_start && $is_end && $length < $min_conf_desc_length) {
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+				     "please write a paragraph ($length/$min_conf_desc_length lines) that describes the config symbol fully\n" . $herecurr);
 			}
 			if ($is_start && $is_end && defined $help_stat_real) {
 				WARN("CONFIG_DESCRIPTION",
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5141C9AC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 21:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgEGTSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 15:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGTSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:18:02 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CF821835;
        Thu,  7 May 2020 19:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879082;
        bh=6u2Zjd4cCAJplBkIJArkC26yIzl29BGwwVH3o2xHtus=;
        h=Date:From:To:Cc:Subject:From;
        b=KJ7s41EA/KoUExDhcHun9qGSDWEpgm/fTIP9T9CzHUw4Jhqsz64KiFgt9cTc+tzQ2
         a/1gXi4RyMPG7UC9ubhXx19jnsIbGpm6KoDr//HwybVANQgxObEtbnMIVvhgeq4bRF
         Al/JgIZkn/n4NLqevOxa/qXJnx9tV+tHjHLz/VFI=
Date:   Thu, 7 May 2020 14:22:28 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: soc-core: Replace zero-length array with flexible-array
Message-ID: <20200507192228.GA16355@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/sound/soc-dapm.h |    2 +-
 include/sound/soc.h      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 08495f8d86dc..cc3dcb815282 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -689,7 +689,7 @@ struct snd_soc_dapm_context {
 /* A list of widgets associated with an object, typically a snd_kcontrol */
 struct snd_soc_dapm_widget_list {
 	int num_widgets;
-	struct snd_soc_dapm_widget *widgets[0];
+	struct snd_soc_dapm_widget *widgets[];
 };
 
 #define for_each_dapm_widgets(list, i, widget)				\
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 13458e4fbb13..3e14442de2ec 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1167,7 +1167,7 @@ struct snd_soc_pcm_runtime {
 	unsigned int fe_compr:1; /* for Dynamic PCM */
 
 	int num_components;
-	struct snd_soc_component *components[0]; /* CPU/Codec/Platform */
+	struct snd_soc_component *components[]; /* CPU/Codec/Platform */
 };
 /* see soc_new_pcm_runtime()  */
 #define asoc_rtd_to_cpu(rtd, n)   (rtd)->dais[n]


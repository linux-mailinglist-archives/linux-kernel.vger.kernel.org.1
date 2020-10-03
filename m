Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316082824A6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJCOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJCOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1647C0613E7;
        Sat,  3 Oct 2020 07:20:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x23so4346668wmi.3;
        Sat, 03 Oct 2020 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtWLIs+ABqD/g0IXPDD3VKHyPb2fpUunYsOW1RNzSt8=;
        b=Ddz+TfC8thUbjRIWE9CADEThm6NXn/JNQM+w/Q3utD0NBJ6IcW+akyWxTBPAnDpwXZ
         LEgqkF1FrNlGychpUEFYv1iijq7vHGUlyg7oo4BMGbsyCFL7JhXcJc76YOKj2/aLmzO9
         4iN3D56FWZPQ4zXVSCDQRQFnvlrNBCtbuFXgjYkUe7PnoC4Fce+WKgxq6uRnNihvU/Bv
         wHEQa7ceZSmQ5eBM1c4sO9k15TCVWuxOSv9iV/KS/bK8AecdJkwb4tZ/swt3Yu2eDfhT
         nc5OizHUO0ZD4P7qOcHrXW+D8zE63YewwKWCc+qenE2kg0otGmksMtzWiaOwO8deSHO8
         tktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtWLIs+ABqD/g0IXPDD3VKHyPb2fpUunYsOW1RNzSt8=;
        b=tJQJWTj6vR6CWjUq9P6EYfIMibZ6iNSTk2hdpKNBmw6vyDKEI/bz9j4I7/AsVgB+br
         osiSYK/vQ+/P/xe5DP0a7V3cVrROv1yJ8SXhs3xljqdtsdH2irFQTA4kmB1WYtoQzusx
         H/X5DWeIhph8gW+5sEl5SoYPcW9A4DgLCHmQCcR0LKXpFHZvyXKd/MA9aH4OXNffHED3
         7/ajGmn9HfdNdL9BGcg7xpersem+Tml2JxJmlx227jTesMErFIz07Z49VaSepQQy9xKr
         cssMpH3sXv7OHea3qGJRU/Og4lLwRWJyTuEhAO9ZPThFYBiZKvQ8MkgddXgB9dfTUmrw
         TAqg==
X-Gm-Message-State: AOAM533w+LT7xadmt05SHiDw0HiwW9w8TwWX4cwyxeeHFC/WjneSf+cn
        zCfldDJuN3rIwZ5p5wlLKyw=
X-Google-Smtp-Source: ABdhPJwyRb8w/rx6X6ysFFBP/QwM5NvVJjNcFLbvn8VRGVBYvWjvHFz59deU9DPiR+2A0vSYHgIDsQ==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr2904628wmh.72.1601734811519;
        Sat, 03 Oct 2020 07:20:11 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:10 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 08/14] ASoC: sun4i-i2s: fix coding-style for callback definition
Date:   Sat,  3 Oct 2020 16:19:44 +0200
Message-Id: <20201003141950.455829-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch script produces warning:
WARNING: function definition argument 'const struct sun4i_i2s *'
should also have an identifier name.

Let's fix this by adding identifier name to get_bclk_parent_rate()
and set_fmt() callback definition.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index fef68146d648..86266879d4bc 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -180,13 +180,13 @@ struct sun4i_i2s_quirks {
 	const struct sun4i_i2s_clk_div	*mclk_dividers;
 	unsigned int			num_mclk_dividers;
 
-	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
+	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *i2s);
 	int	(*get_sr)(unsigned int width);
 	int	(*get_wss)(unsigned int width);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
 				unsigned int channels,	unsigned int slots,
 				unsigned int slot_width);
-	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
+	int	(*set_fmt)(const struct sun4i_i2s *i2s, unsigned int fmt);
 };
 
 struct sun4i_i2s {
-- 
2.25.1


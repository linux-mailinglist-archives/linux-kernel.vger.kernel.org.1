Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D05927207B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgIUKWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgIUKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:21:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C61C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so12127022wrx.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X+rFpG4vvom05OvyshLNJdJ8kwgKGSpX9C8YhBuxe5o=;
        b=cNOdhewYGKl2YXjKJURDIdKsQu8ZURzvDXtycD++ZmmwaT+J5kQ3pbSlKC1ljvk1rb
         7c9mM7lwiacjgzmwvAgZqpm1kttbtMjT/I+1RArtwZZzP+BmSylpv0oayqX6TuxbD1AL
         YtAxB3UvYq7EPNfCtQPdFX+CqsLux1DiX9RG77Qg6/2jtASmro4jYFwhX5ZSnlwr8eJ3
         5rwMXXBdln8bHX4yjru65FoT9fcu0bCqi5LVbEND7/ih/YnZo4HF33N3w8aem5HtqdAd
         XH7qB8d4UKF8a5zjD2c4Zpu3TiAUisMPK5kiY48tVI0NvfXrE+ArvVK9tY0QmZ4spCa/
         M4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X+rFpG4vvom05OvyshLNJdJ8kwgKGSpX9C8YhBuxe5o=;
        b=pf0uXMMiSPXSNdVACXesHuzlGKenz+doezV71IWMO7bvLws5V5kiL9utnYDaxGHLwA
         aMmUJjbwrVliu0Dvf4lprgDrzvSr99l//f6qLp3P56mguU+tV5NMOb15q0jKmZuorc8f
         ihmaUNNFV7N8l/QaEk4eSM7wZTzMXyT14u+zdRv07qpiXK6hj20BG0Ftd3aP7zzoJfqs
         p5v9set5urOViwOOkjjehrrpgYj3A9QpQH6w4Rtt37ovHqJ9V/FSxF9dnVWiLD8eAH5z
         D8gnAqUT9Ehe3ixz1UUvS8T+O0kvIvuiMtgQLryqUHUIRaJhy3qdmmo13iktoCVE64fR
         qY5Q==
X-Gm-Message-State: AOAM530hdAbfTHYMXVSG3528NIpt+0m7NkpMH3sbug+bFeMR4r3d87za
        /wdnxQe9SXA1rwx1N0KIcxXSRw==
X-Google-Smtp-Source: ABdhPJx5/I5MOZQ6v+bndDYnz6frgD0KgYbwoj30CpffrluyW6RiigjRwAq0J2375zGKyZudwb/chw==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr51120033wrt.84.1600683670104;
        Mon, 21 Sep 2020 03:21:10 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.21.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:21:09 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 40/49] staging: media: zoran: device support only 32bit DMA address
Date:   Mon, 21 Sep 2020 10:20:15 +0000
Message-Id: <1600683624-5863-41-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zoran device only supports 32bit DMA address.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 864196e7acae..ab16a70a7451 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1101,6 +1101,12 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int card_num;
 	const char *codec_name, *vfe_name;
 	unsigned int nr;
+	int err;
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (err)
+		return -ENODEV;
+	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 
 	nr = zoran_num++;
 	if (nr >= BUZ_MAX) {
-- 
2.26.2


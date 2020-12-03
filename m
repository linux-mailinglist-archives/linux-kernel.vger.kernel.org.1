Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1B2CCB84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgLCBRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgLCBRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:17:31 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41085C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 17:16:51 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f17so372551pge.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlQ9vZoIsJAnPpI0U3QvE81PrNivsdE6c4oIpPaGaxY=;
        b=cYqt2I7hl2aWLvpaQMHvqHj28usY77Hb6Cq0nv1Ch30mrKGvWf696WQhgNcuPqdCJo
         OkmGZRSt9y6RBouWmuaXxf6qNHV4clEhyicxL31KJgl6QfGLkfV0JuS18HYWFm/OdvYv
         gRNKUEAXjPuJY7n8McM2qtY+fY6wF4R64CBRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlQ9vZoIsJAnPpI0U3QvE81PrNivsdE6c4oIpPaGaxY=;
        b=NrQ6Z8yCfCwfxeq6d780lj8/uy7BKbGs9BdxKrImwF1Zfac2pCJqfwUgRzR4FYI7NR
         Ud35q2iZZTKZJd7SocJTP1kXIbXJT2b4XTmIqKzKPPUYlcjl9i74m5iw8hnQIkIO8eh1
         /OoRYhG9ffEhLjhQX+InIxGmv2EsYRRQEGTSMPzcxilCJff43iy24kUYIlVhDCot8dwV
         oU3XihNqrosNQMkOGq5Zlc/cgoZ8W+eneEZABcigYUkNp2mwTI96nPVABIWuMMfGrpcT
         MvfW/T89JhLNFxtLNou4AZIJzT71oMPUGa/DDq/ccBJsjUIJ79sd7BEMbA/I/O5jLF57
         Ktyw==
X-Gm-Message-State: AOAM531yUcvn/Esr0dLNik+fuyKfnjx1L4FVrFFh3glXCnAvWSqBe9y7
        h5VoYgcWzpKg+zenWlgPTvpZ2w==
X-Google-Smtp-Source: ABdhPJykUA3/9h1CTg6fEsZ56qe4swyPYZSQD5NKYhIDaAHJ4/3RA0BFDe7gadr8NZ8b0KU7CDguEw==
X-Received: by 2002:a65:5cc1:: with SMTP id b1mr903280pgt.42.1606958210830;
        Wed, 02 Dec 2020 17:16:50 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id d19sm123292pjs.0.2020.12.02.17.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 17:16:50 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Simon Glass <sjg@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 0/2] cros_ec_spi: Work better with CS GPIO descriptors
Date:   Wed,  2 Dec 2020 17:16:47 -0800
Message-Id: <20201203011649.1405292-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small patches to work better with the new CS GPIO descriptor logic.
The first one fixes a problem found while trying to enable that feature
and the second patch removes a line that I noticed while looking in the
same area.

Cc: Simon Glass <sjg@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>

Stephen Boyd (2):
  platform/chrome: cros_ec_spi: Don't overwrite spi::mode
  platform/chrome: cros_ec_spi: Drop bits_per_word assignment

 drivers/platform/chrome/cros_ec_spi.c | 2 --
 1 file changed, 2 deletions(-)

base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
-- 
https://chromeos.dev


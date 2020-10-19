Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6AD292DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgJSS40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 14:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgJSS40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:56:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05C2C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:56:25 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x7so539410eje.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLocozs5mbe7AkMYzaqpP1i1qJatxmouRrdruwt75Oo=;
        b=SUgkMpSeKR9pxdYjl+vNR90oMTmi2vfyrxitjrBaRFgZlA9T0Bg7UCvJRgbkUFj8oD
         GA5TrYQ1gsvqtggr57LCs0nrQdU8ktnqdO/NFtb+Z+8TFVxMWdoq7RdoJ/JFUe+zyM5j
         LfnJCslB2mine0mhx7MsgjzqU8aOgy1zhmbr5F4W6SWxuHzJzKYwmQMU1cmOa0hd/7RN
         WWBJolOR4Vgbfzk0BywBwHd6nVC2oVe2jqX9/HOzAtAzodM9R1CPtYsUi5DtxtqcEtfF
         qFtFN12tKm0EItNgC6Uz+Mdcse5g6eSG/wtUrcoKG6MW5LiU+sgTY3B0j2Pv4N2jtaUK
         haUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RLocozs5mbe7AkMYzaqpP1i1qJatxmouRrdruwt75Oo=;
        b=i0Wanh2YBef/455ekSmt5x6rYeJ36LOyxWEMQ/L2roS6J53L0G94vqaZGQVDAH3meh
         NB0KrHNzSg0ffkReQRt+fVD96rfYx3Dx4doXRwdLPJYw7hVDv2FcoLLDsg5kqqwnyQaS
         s7zX8f5TnWs+W4xFglyYyA7YqKxZ+7otsGv3uhGGUaXvxw5Foq8fOs6lkDYUd9j9cB1V
         5unyXBnm9IsYmOcGjQkir5kcr1YWXcLPeKtoFbK+0BOKQGa4L2h3p+Q1deUeio2eDKWv
         xpHs76thHkaoNq3s1ERyjmBiIISSOAjBK/Hliq5EaFI0wjBUACRB2mo+6WUTJdRTbVL1
         /uCg==
X-Gm-Message-State: AOAM533Ob8mjNUWgukZvaEjOOWyA9PBmFys++sQoS9mWLB4+xSyzyprO
        xg2LJuVC74NGZJs2nHXUKVOeEw==
X-Google-Smtp-Source: ABdhPJxnzG1+v1cAInX66kZTH1zNkf1PABNQOw5MZFqEbuBoFHUbZZ1/rnw8zFnCkuOznZsDawCFzA==
X-Received: by 2002:a17:906:4d10:: with SMTP id r16mr1402335eju.68.1603133784402;
        Mon, 19 Oct 2020 11:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:80be:1251:f194:889a])
        by smtp.gmail.com with ESMTPSA id u26sm707236eds.2.2020.10.19.11.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 11:56:23 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Todor Tomov <todor.too@gmail.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [RESEND PATCH v1] MAINTAINERS: camss: Add Robert Foss as co-maintainer
Date:   Mon, 19 Oct 2020 20:56:20 +0200
Message-Id: <20201019185620.493967-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to contribute some of my time to co-maintain the CAMSS
driver. I'm currently working to extend CAMSS to new hardware platforms.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---

I'd like to volunteer as co-maintainer or maintainer. Currently I don't
know how active Todor is, but if he is inactive or indeed would like to
hand over the full maintainership, that would also be ok with me.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5919b758c708..45fea22ed28b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14443,6 +14443,7 @@ W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
 F:	drivers/net/wireless/ath/ath9k/
 
 QUALCOMM CAMERA SUBSYSTEM DRIVER
+M:	Robert Foss <robert.foss@linaro.org>
 M:	Todor Tomov <todor.too@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92E126C9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgIPTks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14983C061356
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k8so1200471pfk.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rl5dMloMz4/NrTqcJ51FK8aDPkUbtuzPHAb3Uft2pLU=;
        b=cU5lUHEPFXE/NLjcdddCxNuONhpIxWDJz6dg8XOIPqSCGejkHIzb/whU2aiDa1eTOM
         P78S7U33cGQyBuD4j/HF7JOmSN3PJe0F6UkiNXaM4XHwH1rS62xSQaVEV/M8xrrb3PNt
         +fq+6JY3wT+7SHgp7fhIQb2DbqNHrSvlGZ+catRh/ZFFGtDhPUrIMU9UxAtKED/m+Fny
         iQ2N+yBiTsMUaLt5iB40fCw9apIa10XTQMoFgVQpE57tS7tB9MMIjuNAKYzbPdybFOa4
         uf+DweWgNiYRtn7ksPvN3yqBhMvqjiqrcpLvpvhyngPafAlc+rF8UTfHNsYU5nJt1BFz
         sp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl5dMloMz4/NrTqcJ51FK8aDPkUbtuzPHAb3Uft2pLU=;
        b=fpaNJ3Wde1359TGtWBYOC7yKqeNxj8RRR3RXd9k1DMRlrP3TdkGVRqoXfVENT3SIHg
         vYs/menb/sWCJ3/Y+HApoc61lwaJiXl7jYhNe7KA7hfYjAKTRvwJqwCqldJo22E7SgNa
         teTz7CgLMqAQDJyy2kTxTsArXI7iJPyYCH2n12vItfNI46T3OuAmeV/fbkbcid7zEA64
         /5v/dRsOf/BzUNGPsai10SfmI77KUZ1xwjJv51NxJBpA8MNSnmAHkwNGak0gkDe/bpTL
         QajUhpn4c+KTLlY2lDtbFAi3egBuVpoG3EWmiRXPEM/259u80j7i8e3QGC21Pgc9yZnc
         aRuA==
X-Gm-Message-State: AOAM533rj1gGdR00ATOuNSFKBAQJ/C8nlRDPXZ6R+TZunuS539SXV14t
        j9zd+VbmMPgbkM08ndXNagc28nkv06D7yw==
X-Google-Smtp-Source: ABdhPJwpEuE++znhk48RHGYA3f6rhRl25oYeQg+VPPiZA6ejE217Jo2U+vXnmlYJWW8H5gcoWePGKQ==
X-Received: by 2002:a63:743:: with SMTP id 64mr6369658pgh.393.1600283872676;
        Wed, 16 Sep 2020 12:17:52 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:52 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] MAINTAINERS: Add CoreSight mailing list
Date:   Wed, 16 Sep 2020 13:17:33 -0600
Message-Id: <20200916191737.4001561-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CoreSight mailing list so that people can participate in patch
reviews and know what features are coming next.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 286fd7263982..54cb47e8a0b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1746,6 +1746,7 @@ ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 R:	Suzuki K Poulose <suzuki.poulose@arm.com>
 R:	Mike Leach <mike.leach@linaro.org>
+L:	coresight@lists.linaro.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
-- 
2.25.1


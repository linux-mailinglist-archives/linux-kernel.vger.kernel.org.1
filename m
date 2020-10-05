Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83B2831C0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJEITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:19:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44057 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEITe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:19:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id a5so1040817ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x9WlGX4960t6tCleUdRFmMIolYpt1rsEaqaNiXS3akc=;
        b=lzRpDXZ7ZTcwKPdBA0mwGyKGWkZvTtUWBy+X1HtmkiOv5JkAt1JhSqK2qrR5cTqp0e
         MnvbsmrTXin9OIrdPy0K9qCdpdDDY0MPa/7P+IMPwH/QmLFGPyXriDBDVClWImAQd6Zl
         vmLNg1oALX5fIhFdQDehkAejyd8kWqLztwfQ7Ipa3Do4O2FF8+Pa6EVsbPCBPZYE1BR2
         k7FE23xan/2uHjaQbgD7PVryOEMUYEIHwwDph1v/qQeE+tmNT7M3esPVKvW3PgD7U0Un
         xr8fCVHpsiHazYUh7m6ePExWSoaUH+8cnGi/ECLPufunWbC23+BKd6xL41upZCxDz+In
         fTvA==
X-Gm-Message-State: AOAM531Uw0/JJ593Hlio+q8940JbAcm/JZcDRfJ2/lF26eje4Oq2vtoJ
        McejIy/1Dib9CUOYJIzfUFE=
X-Google-Smtp-Source: ABdhPJzF1f0W6IBdqaAKx1QGNwgjoU81gEHwHMS7QXapRi5+CnryetiK0NDEeT/vi1y19I1K+t5E2w==
X-Received: by 2002:a05:651c:1181:: with SMTP id w1mr4467435ljo.363.1601885971139;
        Mon, 05 Oct 2020 01:19:31 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id m28sm251594lfq.228.2020.10.05.01.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:19:30 -0700 (PDT)
Date:   Mon, 5 Oct 2020 11:19:24 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [PATCH 2/2] regulator: bd9576: Fix print
Message-ID: <c4f55add237455555df0597c72052022f7a669f6.1601885841.git.matti.vaittinen@fi.rohmeurope.com>
References: <3d92de2085f0c074929861a2f791bf4070920e83.1601885841.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d92de2085f0c074929861a2f791bf4070920e83.1601885841.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print in probe is done using pr_info. Correct print call would be
dev_dbg because:
 - Severity should really be dbg
 - The dev pointer is given as first argument

Fixes: b014e9fae7e7de4329a7092ade4256982c5ce974
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Sorry folks! This should have never slip in...

 drivers/regulator/bd9576-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index 4137fa9a73bb..a8b5832a5a1b 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -275,7 +275,7 @@ static int bd957x_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "Found BD9576MUF\n");
 		break;
 	case ROHM_CHIP_TYPE_BD9573:
-		pr_info(&pdev->dev, "Found BD9573MUF\n");
+		dev_dbg(&pdev->dev, "Found BD9573MUF\n");
 		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported chip type\n");
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 

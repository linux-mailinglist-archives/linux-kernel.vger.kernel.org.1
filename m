Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496A221A1B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGIODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgGIODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F50FC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so1954714wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CM7F/yVSMdD0MwnLwyut2LHrVbWT5ZWz854NoFHIMAw=;
        b=BxHDPHyDMwCkfTRC0Q1ZkF+4Ma/zBrkuVIa4nfvYIsH2XocNv4/T2cCjIDPMZxVeSp
         WzwSmOUfaPaEhKZ+AF5jAS/HRwcF9+4cBfNgiTh99EimNQ/KHh6vAllxXE7iYnbaTVKb
         nHpJuSezWIWU3u56NX2xFCKdU1Q1LQvGq3Wpr+wqvGIsooyBLiJVXGOqG6iUXAyIFZDy
         g/BKZCBw26gjWPqFdq0WFM82Qz4L3xuFDFlxNaC9RkpDQXTTb7iiYnS0LGrB2fA6R+4d
         HfheXePR0dF1+NT7L++XoVTvdzEPlIpEP3AEvzdQ1os6voSfK5HB+FtQlGf4LNfmKAhr
         OVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CM7F/yVSMdD0MwnLwyut2LHrVbWT5ZWz854NoFHIMAw=;
        b=fyReDKpH+PEbYl/nB9axohI0VMwiyZPmFIlMrE+oHlhfVEfAQLzyl769XDSgXSScUA
         4uSEFWPq61Rp8Atgl0dOsXP2lBYaorguq5Lr+v8QLsp05TdajzKU2Er60JU3OvY7IvnF
         y9hoiwhTkWUu3BuUDWDAgjNEkrolDbU/rVTGkjzhsYX03iYCTI0n7MVNArJ4mO1L6d3h
         H2Kpvl7nJIaAcDRmy0iFYOaia4JQvQ6c6SAEe451iN+8ULrtUPL1CdNbdfEHIF8LTx0D
         MtNxufa0r+GZS5HDDNZFOBkGtSx/u+WtCMoasFgqogyX4n5H3nu8UuLcvPBB80zZ7bEt
         esog==
X-Gm-Message-State: AOAM533oovdUrXjR6S8WNX0wU+GZeRMd7mQoVaT0SYIlV3cCO3ONhZf9
        ZXDdZ3k42z3VrrUj8RjdR24=
X-Google-Smtp-Source: ABdhPJzisUnpfGKLyaQeAsd/vql6nryFcY7P93DXPG4QqxdWDcIEuaAMiLxSeRT61HwRyMIIkgBebg==
X-Received: by 2002:a1c:ba08:: with SMTP id k8mr199642wmf.28.1594303418680;
        Thu, 09 Jul 2020 07:03:38 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:38 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 10/14] drm/panfrost: add regulators to devfreq
Date:   Thu,  9 Jul 2020 16:03:18 +0200
Message-Id: <20200709140322.131320-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709140322.131320-1-peron.clem@gmail.com>
References: <20200709140322.131320-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some OPP tables specify voltage for each frequency. Devfreq can
handle these regulators but they should be get only 1 time to avoid
issue and know who is in charge.

If OPP table is probe don't init regulator.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 29 ++++++++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 ++
 drivers/gpu/drm/panfrost/panfrost_device.c  | 11 +++++---
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index d9007f44b772..8ab025d0035f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -93,14 +93,30 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	unsigned long cur_freq;
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
+	struct opp_table *opp_table;
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
+	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
+					      pfdev->comp->num_supplies);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		/* Continue if the optional regulator is missing */
+		if (ret != -ENODEV) {
+			DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
+			goto err_fini;
+		}
+	} else {
+		pfdevfreq->regulators_opp_table = opp_table;
+	}
+
 	ret = dev_pm_opp_of_add_table(dev);
-	if (ret == -ENODEV) /* Optional, continue without devfreq */
-		return 0;
-	else if (ret)
-		return ret;
+	if (ret) {
+		/* Optional, continue without devfreq */
+		if (ret == -ENODEV)
+			ret = 0;
+		goto err_fini;
+	}
 	pfdevfreq->opp_of_table_added = true;
 
 	spin_lock_init(&pfdevfreq->lock);
@@ -153,6 +169,11 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
 		pfdevfreq->opp_of_table_added = false;
 	}
+
+	if (pfdevfreq->regulators_opp_table) {
+		dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
+		pfdevfreq->regulators_opp_table = NULL;
+	}
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 210269944687..db6ea48e21f9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -8,12 +8,14 @@
 #include <linux/ktime.h>
 
 struct devfreq;
+struct opp_table;
 struct thermal_cooling_device;
 
 struct panfrost_device;
 
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
+	struct opp_table *regulators_opp_table;
 	struct thermal_cooling_device *cooling;
 	bool opp_of_table_added;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 0b0fb45aee82..1b5fc9221828 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -223,10 +223,13 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		goto out_clk;
 	}
 
-	err = panfrost_regulator_init(pfdev);
-	if (err) {
-		dev_err(pfdev->dev, "regulator init failed %d\n", err);
-		goto out_devfreq;
+	/* OPP will handle regulators */
+	if (!pfdev->pfdevfreq.opp_of_table_added) {
+		err = panfrost_regulator_init(pfdev);
+		if (err) {
+			dev_err(pfdev->dev, "regulator init failed %d\n", err);
+			goto out_devfreq;
+		}
 	}
 
 	err = panfrost_reset_init(pfdev);
-- 
2.25.1


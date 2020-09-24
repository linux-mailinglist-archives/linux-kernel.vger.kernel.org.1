Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A221F276E85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgIXKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:20:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AA0C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:20:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so1460721pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDW0cijJSG8mG5hnjrtVKr5ql/AKoiRr42pPo1oe7J0=;
        b=png7TEaT9JTulJLXSeEtIicwnhjXOR2MpLBeDM9CINl9FSBpFL8I5a7YVsfwjmx18e
         h7JHkWx3q4xLTHdJiZVDuOcn7Z2GVzhNKJ2m9lwYWgCAd7jQ1RDKtix/nDKOwHPTaQrQ
         1GrAGuqoV3khYx4QTzvcCDb0HUPtmPVSfdnDmuB1jykdh5cZHEk0VsUj2aAYBx2N+VTH
         JZsCkI7RWWs2pT1chDRQeemsgaoUrPV8uRC3jy4RhtQfQXduVDz9+mh9lmCIE+9AemET
         kVWJ7dQ7rF8y3ZQ3BZ4yxjcbZnZYESGGnBUd/+LT3bHXGm/ghHpnz+Yv5FCzFP4kKwaB
         aK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDW0cijJSG8mG5hnjrtVKr5ql/AKoiRr42pPo1oe7J0=;
        b=hAVVvt7vs+XWYKDunDmzlfmPzIU9mLNFeNm50tiiOzu3y4pzklybO3rF/Bjhuoj4DQ
         Q/VPU+js3NWcoE2Zb4as1qzDOUHqUzLTT4gcNGZD5YqTEygo+dYNHeCj/vYD8saN2ndf
         iXSBgxPPVtfxwQLUVfhPuVIs5g+L/gbLQB0HngSFEAuM1Y2lNx7XLgQpWnAMs8j289w4
         wNiGvjtcOzcpvqfe4gEH6NR62/205vTEfnRZs/hgDVLSTJG2+ty3uO3mIG3Qtq5+eFMR
         zMxHHGoLwlzJJ6h0fyxgKJ0O+pl/egQ8O8zAURww39FpS8xINddFBmvbnwG0l01RVnju
         bfsA==
X-Gm-Message-State: AOAM531vT19tWOm48ulItXZij9gYUylHfNDlL0utGjAgq+W81wUDUSip
        aHXX7BTPdEcjAXrzWZep6Yk=
X-Google-Smtp-Source: ABdhPJzVQEnr2gHdgTDv8QoOM0eeMSIF++4bVh2EncAuTRY0YyzDuK0ktquYxouo12BxGQph+36+cA==
X-Received: by 2002:a17:902:fe88:b029:d2:2a16:254 with SMTP id x8-20020a170902fe88b02900d22a160254mr3998235plm.23.1600942850800;
        Thu, 24 Sep 2020 03:20:50 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id l14sm1935673pjy.1.2020.09.24.03.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 03:20:49 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] [PATCH] staging: greybus: fix warnings about endianness detected by sparse
Date:   Thu, 24 Sep 2020 18:20:37 +0800
Message-Id: <20200924102039.43895-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following warnings from sparse,

$ make C=2 drivers/staging/greybus/
drivers/staging/greybus/audio_module.c:222:25: warning: incorrect type in assignment (different base types)
drivers/staging/greybus/audio_module.c:222:25:    expected restricted __le16 [usertype] data_cport
drivers/staging/greybus/audio_module.c:222:25:    got unsigned short [usertype] intf_cport_id
drivers/staging/greybus/audio_topology.c:460:40: warning: restricted __le32 degrades to integer
drivers/staging/greybus/audio_topology.c:691:41: warning: incorrect type in assignment (different base types)
drivers/staging/greybus/audio_topology.c:691:41:    expected unsigned int access
drivers/staging/greybus/audio_topology.c:691:41:    got restricted __le32 [usertype] access
drivers/staging/greybus/audio_topology.c:746:44: warning: incorrect type in assignment (different base types)
drivers/staging/greybus/audio_topology.c:746:44:    expected unsigned int
drivers/staging/greybus/audio_topology.c:746:44:    got restricted __le32
drivers/staging/greybus/audio_topology.c:748:52: warning: incorrect type in assignment (different base types)
drivers/staging/greybus/audio_topology.c:748:52:    expected unsigned int
drivers/staging/greybus/audio_topology.c:748:52:    got restricted __le32
drivers/staging/greybus/audio_topology.c:802:42: warning: restricted __le32 degrades to integer
drivers/staging/greybus/audio_topology.c:805:50: warning: incorrect type in assignment (different base types)
drivers/staging/greybus/audio_topology.c:805:50:    expected restricted __le32
drivers/staging/greybus/audio_topology.c:805:50:    got unsigned int
drivers/staging/greybus/audio_topology.c:814:50: warning: restricted __le32 degrades to integer
drivers/staging/greybus/audio_topology.c:817:58: warning: incorrect type in assignment (different base types)
drivers/staging/greybus/audio_topology.c:817:58:    expected restricted __le32
drivers/staging/greybus/audio_topology.c:817:58:    got unsigned int
drivers/staging/greybus/audio_topology.c:889:25: warning: incorrect type in assignment (different base types)
drivers/staging/greybus/audio_topology.c:889:25:    expected unsigned int access
drivers/staging/greybus/audio_topology.c:889:25:    got restricted __le32 [usertype] access

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/staging/greybus/audio_module.c   |  6 +++---
 drivers/staging/greybus/audio_topology.c | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/greybus/audio_module.c b/drivers/staging/greybus/audio_module.c
index 16f60256adb2..c52c4f361b90 100644
--- a/drivers/staging/greybus/audio_module.c
+++ b/drivers/staging/greybus/audio_module.c
@@ -219,7 +219,7 @@ static int gb_audio_add_data_connection(struct gbaudio_module_info *gbmodule,
 
 	greybus_set_drvdata(bundle, gbmodule);
 	dai->id = 0;
-	dai->data_cport = connection->intf_cport_id;
+	dai->data_cport = cpu_to_le16(connection->intf_cport_id);
 	dai->connection = connection;
 	list_add(&dai->list, &gbmodule->data_list);
 
@@ -329,7 +329,7 @@ static int gb_audio_probe(struct gb_bundle *bundle,
 		if (ret) {
 			dev_err(dev,
 				"%d:Error while enabling %d:data connection\n",
-				ret, dai->data_cport);
+				ret, le16_to_cpu(dai->data_cport));
 			goto disable_data_connection;
 		}
 	}
@@ -451,7 +451,7 @@ static int gb_audio_resume(struct device *dev)
 		if (ret) {
 			dev_err(dev,
 				"%d:Error while enabling %d:data connection\n",
-				ret, dai->data_cport);
+				ret, le16_to_cpu(dai->data_cport));
 			return ret;
 		}
 	}
diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 83b38ae8908c..56bf1a4f95ad 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -466,7 +466,7 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 		goto exit;
 
 	/* update ucontrol */
-	if (gbvalue.value.integer_value[0] != val) {
+	if (gbvalue.value.integer_value[0] != cpu_to_le32(val)) {
 		for (wi = 0; wi < wlist->num_widgets; wi++) {
 			widget = wlist->widgets[wi];
 			snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol,
@@ -689,7 +689,7 @@ static int gbaudio_tplg_create_kcontrol(struct gbaudio_module_info *gb,
 				return -ENOMEM;
 			ctldata->ctl_id = ctl->id;
 			ctldata->data_cport = le16_to_cpu(ctl->data_cport);
-			ctldata->access = ctl->access;
+			ctldata->access = le32_to_cpu(ctl->access);
 			ctldata->vcount = ctl->count_values;
 			ctldata->info = &ctl->info;
 			*kctl = (struct snd_kcontrol_new)
@@ -744,10 +744,10 @@ static int gbcodec_enum_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 		return ret;
 	}
 
-	ucontrol->value.enumerated.item[0] = gbvalue.value.enumerated_item[0];
+	ucontrol->value.enumerated.item[0] = le32_to_cpu(gbvalue.value.enumerated_item[0]);
 	if (e->shift_l != e->shift_r)
 		ucontrol->value.enumerated.item[1] =
-			gbvalue.value.enumerated_item[1];
+			le32_to_cpu(gbvalue.value.enumerated_item[1]);
 
 	return 0;
 }
@@ -801,10 +801,10 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	mask = e->mask << e->shift_l;
 
 	if (gbvalue.value.enumerated_item[0] !=
-	    ucontrol->value.enumerated.item[0]) {
+	    cpu_to_le32(ucontrol->value.enumerated.item[0])) {
 		change = 1;
 		gbvalue.value.enumerated_item[0] =
-			ucontrol->value.enumerated.item[0];
+			cpu_to_le32(ucontrol->value.enumerated.item[0]);
 	}
 
 	if (e->shift_l != e->shift_r) {
@@ -813,10 +813,10 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= e->mask << e->shift_r;
 		if (gbvalue.value.enumerated_item[1] !=
-		    ucontrol->value.enumerated.item[1]) {
+		    cpu_to_le32(ucontrol->value.enumerated.item[1])) {
 			change = 1;
 			gbvalue.value.enumerated_item[1] =
-				ucontrol->value.enumerated.item[1];
+				cpu_to_le32(ucontrol->value.enumerated.item[1]);
 		}
 	}
 
@@ -887,7 +887,7 @@ static int gbaudio_tplg_create_mixer_ctl(struct gbaudio_module_info *gb,
 		return -ENOMEM;
 	ctldata->ctl_id = ctl->id;
 	ctldata->data_cport = le16_to_cpu(ctl->data_cport);
-	ctldata->access = ctl->access;
+	ctldata->access = le32_to_cpu(ctl->access);
 	ctldata->vcount = ctl->count_values;
 	ctldata->info = &ctl->info;
 	*kctl = (struct snd_kcontrol_new)
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A72F7109
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbhAODex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:34:53 -0500
Received: from mail.loongson.cn ([114.242.206.163]:34180 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbhAODex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:34:53 -0500
Received: from zhangzhijie.loongson.cn (unknown [10.20.41.29])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax1bweDQFgA60EAA--.5257S2;
        Fri, 15 Jan 2021 11:33:50 +0800 (CST)
From:   "ZhiJie.Zhang" <zhangzhijie@loongson.cn>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhangzhijie@loongson.cn
Subject: [PATCH v2] drm: Improve the output_poll_changed description
Date:   Fri, 15 Jan 2021 11:33:28 +0800
Message-Id: <20210115033328.1799514-1-zhangzhijie@loongson.cn>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Ax1bweDQFgA60EAA--.5257S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFW5CF43GFW7Kw15tr45GFg_yoW8JryUpr
        sIkryFkr48tF93uF4UGrWIg3W8AanrGF40qFWkKw4SkwnxtwnIvF9Ygr45uFyrWFZxJF45
        Xasa9r98A3Z5CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: x2kd0wx2klyx3h6o00pqjv00gofq/1tbiAQACAF3QvM2fqQAAsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangzhijie <zhangzhijie@loongson.cn>

this callback was used by drm_kms_helper_hotplug_event()

V2: (Thanks for Daniel's suggestions)
- remove the FIXME below.since with the drm_client
- infrastructure and the generic fbdev emulation we've
- resolved this all very neatly now.

Signed-off-by: zhangzhijie <zhangzhijie@loongson.cn>
Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>
---
 include/drm/drm_mode_config.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index ab424ddd7665..50541980f7f2 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -104,13 +104,8 @@ struct drm_mode_config_funcs {
 	 * changes.
 	 *
 	 * Drivers implementing fbdev emulation with the helpers can call
-	 * drm_fb_helper_hotplug_changed from this hook to inform the fbdev
+	 * drm_kms_helper_hotplug_event() from this hook to inform the fbdev
 	 * helper of output changes.
-	 *
-	 * FIXME:
-	 *
-	 * Except that there's no vtable for device-level helper callbacks
-	 * there's no reason this is a core function.
 	 */
 	void (*output_poll_changed)(struct drm_device *dev);
 
-- 
2.29.2


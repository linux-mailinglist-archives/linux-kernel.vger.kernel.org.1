Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA0226F9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIRJ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:57:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:57:31 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M2Nm2-1kKrpW0cQg-003tS6; Fri, 18 Sep 2020 11:56:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     hch@lst.de, Arnd Bergmann <arnd@arndb.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: compat_ioctl: avoid compat_alloc_user_space
Date:   Fri, 18 Sep 2020 11:56:19 +0200
Message-Id: <20200918095642.1446243-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rNdS+a97tkm6jDpBmD5687UbWW7bIFQ+2R1OTRXm1szgDNK2BWK
 diCKoCgNxs45hEpoAJYTXTN8E4gcdjSvEzkBe/1fvGYxfr6O6zab41bHQLAPRsuOR+4VwZg
 lv+kpXi6xX6nPJtAZbojypXIb69rFf1hsoef91zEICfO+C6BJhxDkSEp7cR9qE8vKX6tjEJ
 dZwRmSCy8+2DhWpk7+EKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rdH/X9lyGGI=:BaOigkQBTUv7qsKSTqrKln
 2BWIK6OsuUywgQu2bvoBDE+DBiKcYaPsEeuSyCy92T0icWEIPAUtaZ1WXtAvagT6PdyC1AQ4F
 5p/o9VkCgCSLNQH4airiq4qrinlWfknJlZlh1HGw4ySD9afiwxE6FEovii8Fx3BswdgeJdxfP
 AcRnMDIGBSoql0z6T5KoHOEfrFLkPaPIbOAYQcJSFm+e/aYhcEjD2Ac4jUMB/lMRTrVEgc0GB
 b+cz+uVF3xRP/oiS3nNZBFFTamykuw7k+ECAR26zpGpxuMnmm6zWCKKpabyt6W1EQMTmMXrjY
 EkEQGABH7a2pIjbXlm4TmseZRBYz0b7lFlJK93IPYK0AJd9NbZmt/JsMHoRMJjP/V0XmKT+nE
 blJFuPXTP2kSjijKNyXW6kA8NW9/mlI/QqOGj6+rPjqAc90WPc3S+BpsUBK8RtB5yJUTiMe/Y
 XR7vUYxK7cMnK1U4WCyaGxaZJOoIPGuTGv+svV7kjuY07881FKC7/NFRw90RDnw/v6aW3r5Jy
 3ubuFowy5GwpNIZ6Z9ReBNKbB9da5OkxhVQPtePRN0Zo0timwfr0YI4WpDZYvoUPrWstlbSDq
 UaUX7VUvEk/6pDsI2AQ8yvoandElphStpYpZxKy8gNAs5j3hfNbNkNToBKnWt975GQp+dR+aa
 vh90PpIxji9Qv1pYvjxId+6XAIm3no9dMd8t2wJ25SX0ck6PcIMbsSvNxIgnzTmmS3VtNOUUn
 OgX45wmgId1Bs4QuZR04ODjWJ6nYS3Kp9KI5f2WImTbLZxfsYlZH3d8PGRsm/PuMjYIKshP2W
 S5N4P4lQl/YBldmH2imCzkoofE/VhKtKHkARNAUnoFNlnvFVzekBgNdV8dADa4HmSL4WoeF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using compat_alloc_user_space() tends to add complexity
to the ioctl handling, so I am trying to remove it everywhere.

The two callers in sound/core can rewritten to just call
the same code that operates on a kernel pointer as the
native handler.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/control.c        | 38 ++++++++++++++++++++++++-------------
 sound/core/control_compat.c | 14 ++++++--------
 sound/core/hwdep.c          | 27 ++++++++++++++++----------
 sound/core/hwdep_compat.c   | 23 +++++++---------------
 4 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index aa0c0cf182af..e014598142df 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -717,22 +717,19 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
 }
 
 static int snd_ctl_elem_list(struct snd_card *card,
-			     struct snd_ctl_elem_list __user *_list)
+			     struct snd_ctl_elem_list *list)
 {
-	struct snd_ctl_elem_list list;
 	struct snd_kcontrol *kctl;
 	struct snd_ctl_elem_id id;
 	unsigned int offset, space, jidx;
 	int err = 0;
 
-	if (copy_from_user(&list, _list, sizeof(list)))
-		return -EFAULT;
-	offset = list.offset;
-	space = list.space;
+	offset = list->offset;
+	space = list->space;
 
 	down_read(&card->controls_rwsem);
-	list.count = card->controls_count;
-	list.used = 0;
+	list->count = card->controls_count;
+	list->used = 0;
 	if (space > 0) {
 		list_for_each_entry(kctl, &card->controls, list) {
 			if (offset >= kctl->count) {
@@ -741,12 +738,12 @@ static int snd_ctl_elem_list(struct snd_card *card,
 			}
 			for (jidx = offset; jidx < kctl->count; jidx++) {
 				snd_ctl_build_ioff(&id, kctl, jidx);
-				if (copy_to_user(list.pids + list.used, &id,
+				if (copy_to_user(list->pids + list->used, &id,
 						 sizeof(id))) {
 					err = -EFAULT;
 					goto out;
 				}
-				list.used++;
+				list->used++;
 				if (!--space)
 					goto out;
 			}
@@ -755,11 +752,26 @@ static int snd_ctl_elem_list(struct snd_card *card,
 	}
  out:
 	up_read(&card->controls_rwsem);
-	if (!err && copy_to_user(_list, &list, sizeof(list)))
-		err = -EFAULT;
 	return err;
 }
 
+static int snd_ctl_elem_list_user(struct snd_card *card,
+				  struct snd_ctl_elem_list __user *_list)
+{
+	struct snd_ctl_elem_list list;
+	int err;
+
+	if (copy_from_user(&list, _list, sizeof(list)))
+		return -EFAULT;
+	err = snd_ctl_elem_list(card, &list);
+	if (err)
+		return err;
+	if (copy_to_user(_list, &list, sizeof(list)))
+		return -EFAULT;
+
+	return 0;
+}
+
 /* Check whether the given kctl info is valid */
 static int snd_ctl_check_elem_info(struct snd_card *card,
 				   const struct snd_ctl_elem_info *info)
@@ -1703,7 +1715,7 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_CARD_INFO:
 		return snd_ctl_card_info(card, ctl, cmd, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST:
-		return snd_ctl_elem_list(card, argp);
+		return snd_ctl_elem_list_user(card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
 		return snd_ctl_elem_info_user(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_READ:
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 02df1d7db9a1..1d708aab9c98 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -22,24 +22,22 @@ struct snd_ctl_elem_list32 {
 static int snd_ctl_elem_list_compat(struct snd_card *card,
 				    struct snd_ctl_elem_list32 __user *data32)
 {
-	struct snd_ctl_elem_list __user *data;
+	struct snd_ctl_elem_list data = {};
 	compat_caddr_t ptr;
 	int err;
 
-	data = compat_alloc_user_space(sizeof(*data));
-
 	/* offset, space, used, count */
-	if (copy_in_user(data, data32, 4 * sizeof(u32)))
+	if (copy_from_user(&data, data32, 4 * sizeof(u32)))
 		return -EFAULT;
 	/* pids */
-	if (get_user(ptr, &data32->pids) ||
-	    put_user(compat_ptr(ptr), &data->pids))
+	if (get_user(ptr, &data32->pids))
 		return -EFAULT;
-	err = snd_ctl_elem_list(card, data);
+	data.pids = compat_ptr(ptr);
+	err = snd_ctl_elem_list(card, &data);
 	if (err < 0)
 		return err;
 	/* copy the result */
-	if (copy_in_user(data32, data, 4 * sizeof(u32)))
+	if (copy_to_user(data32, &data, 4 * sizeof(u32)))
 		return -EFAULT;
 	return 0;
 }
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 21edb8ac95eb..0c029892880a 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -203,28 +203,35 @@ static int snd_hwdep_dsp_status(struct snd_hwdep *hw,
 }
 
 static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
-			      struct snd_hwdep_dsp_image __user *_info)
+			      struct snd_hwdep_dsp_image *info)
 {
-	struct snd_hwdep_dsp_image info;
 	int err;
 	
 	if (! hw->ops.dsp_load)
 		return -ENXIO;
-	memset(&info, 0, sizeof(info));
-	if (copy_from_user(&info, _info, sizeof(info)))
-		return -EFAULT;
-	if (info.index >= 32)
+	if (info->index >= 32)
 		return -EINVAL;
 	/* check whether the dsp was already loaded */
-	if (hw->dsp_loaded & (1u << info.index))
+	if (hw->dsp_loaded & (1u << info->index))
 		return -EBUSY;
-	err = hw->ops.dsp_load(hw, &info);
+	err = hw->ops.dsp_load(hw, info);
 	if (err < 0)
 		return err;
-	hw->dsp_loaded |= (1u << info.index);
+	hw->dsp_loaded |= (1u << info->index);
 	return 0;
 }
 
+static int snd_hwdep_dsp_load_user(struct snd_hwdep *hw,
+				   struct snd_hwdep_dsp_image __user *_info)
+{
+	struct snd_hwdep_dsp_image info = {};
+
+	if (copy_from_user(&info, _info, sizeof(info)))
+		return -EFAULT;
+	return snd_hwdep_dsp_load(hw, &info);
+}
+
+
 static long snd_hwdep_ioctl(struct file * file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -238,7 +245,7 @@ static long snd_hwdep_ioctl(struct file * file, unsigned int cmd,
 	case SNDRV_HWDEP_IOCTL_DSP_STATUS:
 		return snd_hwdep_dsp_status(hw, argp);
 	case SNDRV_HWDEP_IOCTL_DSP_LOAD:
-		return snd_hwdep_dsp_load(hw, argp);
+		return snd_hwdep_dsp_load_user(hw, argp);
 	}
 	if (hw->ops.ioctl)
 		return hw->ops.ioctl(hw, file, cmd, arg);
diff --git a/sound/core/hwdep_compat.c b/sound/core/hwdep_compat.c
index bc81db9cb3d4..a0b76706c083 100644
--- a/sound/core/hwdep_compat.c
+++ b/sound/core/hwdep_compat.c
@@ -19,26 +19,17 @@ struct snd_hwdep_dsp_image32 {
 static int snd_hwdep_dsp_load_compat(struct snd_hwdep *hw,
 				     struct snd_hwdep_dsp_image32 __user *src)
 {
-	struct snd_hwdep_dsp_image __user *dst;
+	struct snd_hwdep_dsp_image info = {};
 	compat_caddr_t ptr;
-	u32 val;
 
-	dst = compat_alloc_user_space(sizeof(*dst));
-
-	/* index and name */
-	if (copy_in_user(dst, src, 4 + 64))
-		return -EFAULT;
-	if (get_user(ptr, &src->image) ||
-	    put_user(compat_ptr(ptr), &dst->image))
-		return -EFAULT;
-	if (get_user(val, &src->length) ||
-	    put_user(val, &dst->length))
-		return -EFAULT;
-	if (get_user(val, &src->driver_data) ||
-	    put_user(val, &dst->driver_data))
+	if (copy_from_user(&info, src, 4 + 64) ||
+	    get_user(ptr, &src->image) ||
+	    get_user(info.length, &src->length) ||
+	    get_user(info.driver_data, &src->driver_data))
 		return -EFAULT;
+	info.image = compat_ptr(ptr);
 
-	return snd_hwdep_dsp_load(hw, dst);
+	return snd_hwdep_dsp_load(hw, &info);
 }
 
 enum {
-- 
2.27.0


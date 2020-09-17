Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71D626DFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgIQPb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:31:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgIQPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:30:10 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFsER-1kH4gn01sd-00HQ4A; Thu, 17 Sep 2020 17:28:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-media@vger.kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/8] media: v4l2: remove unneeded compat ioctl handlers
Date:   Thu, 17 Sep 2020 17:28:17 +0200
Message-Id: <20200917152823.1241599-3-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200917152823.1241599-1-arnd@arndb.de>
References: <20200917152823.1241599-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:++SSgZ3DNeodfdLMxxhVdMY6F5zK7tmiDsaTaRq8Tv7DlFh0gI1
 bSE1SOX4Mq/pQJNnY081OagYNaYRDgtdgzvyX6j3+W5TTZVlTNC+wIXK/6nmp38R9MtZ2r+
 zfPuySC/KQv/lnf4LVP2rI3XMD0qnAz71YWxkNnottxLKpYWSrAISp3ynQ2/H1x7z/8t8fV
 JQCdNrjlY22DKDkHBeMbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OqRpyibTxlU=:FKS36pBs2SX+v1pIxsdFc7
 q33YRUwFe64hHk5YKbXFk9e0at/b9nfwafFvurbbwieEPKvgMETuEyhudLUX8jD1M0Rdn29NM
 LlE2dNF+UHjd4vfNY2v26CMySsduDn1cvQ+l15yLNdYM2tQDvlRl2MsZDs6DGiJeyq02xX8av
 5PS3JQGYgKHXBPJ6tHcsN9Lwc455/IJhrHeE4PCPZpJS1pbuHlK+Fu0wBRIo34uLVQIJhZKU1
 SwuMSrTNAsWXNhPdkY4Zgb6OdBbvxV+QK7MOnweOLcBpjbWoepQdW6eiDaP6p7Ekeprknduse
 vO+nkknQeuXtU4QhRKORYGKAid1rRxKjZZZMbQgiN4hwJL5v4TEqvOoRorlOPSsnfqK7LBzMd
 uI+IjEytwPnvvphD8cKu5SmMvBT9X8EqMoUyz0IGSSPJCUyw0/jhD33Pydvvmr/Ljf/mb9VkK
 G7JRyN/7pB1qM8ipDhLbI2eAaIFmNel+2OKlofN8TR+XkFYHU/84314F0kDwAfbXl2gHdwSw7
 iKvH7MkI7vVs9W4TGyXCmdwyAAffIav+xD0/Ub+sjHQ3CBPBU372vrqsNDHnfwySA/fFk/8/m
 cx3/iFj3NXfBQYA6MkjyZt/+vvOHffckjnmHzn39hmLW5OMy8lIGakfHchRsqv9cSO8qoxJBO
 53fwvvefFkDll+pnJ1HRi4qRA+LhtZUglKzorgpdMKOJBWjgd+uyTAUC3oK1GMRFhEn4/7oUI
 5oXDcDHgGJuHsvzW96o36jTk4ERAysDjWgXgbVirwr8DX3/KYykTG30Oxf8vmIFMyoYE49iWq
 LDgbKACbmvByqB/61DbodJTcjWh+nxML7dQIR0jG5Fhz2cSjdswu5Ldnr91BznrjCAdXVQe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These seven commands are all compatible and do not need any
conversion handlers. The existing ones just copy 32-bit
integers around, and those are always compatible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 42 -------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index 8f2cb03be48b..f04e29f3aecc 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -1412,14 +1412,6 @@ static int put_v4l2_edid32(struct v4l2_edid __user *p64,
 #define VIDIOC_PREPARE_BUF32	_IOWR('V', 93, struct v4l2_buffer32)
 #define VIDIOC_PREPARE_BUF32_TIME32 _IOWR('V', 93, struct v4l2_buffer32_time32)
 
-#define VIDIOC_OVERLAY32	_IOW ('V', 14, s32)
-#define VIDIOC_STREAMON32	_IOW ('V', 18, s32)
-#define VIDIOC_STREAMOFF32	_IOW ('V', 19, s32)
-#define VIDIOC_G_INPUT32	_IOR ('V', 38, s32)
-#define VIDIOC_S_INPUT32	_IOWR('V', 39, s32)
-#define VIDIOC_G_OUTPUT32	_IOR ('V', 46, s32)
-#define VIDIOC_S_OUTPUT32	_IOWR('V', 47, s32)
-
 unsigned int v4l2_compat_translate_cmd(unsigned int cmd)
 {
 	switch (cmd) {
@@ -1550,13 +1542,6 @@ static long do_video_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	case VIDIOC_DQEVENT32: ncmd = VIDIOC_DQEVENT; break;
 	case VIDIOC_DQEVENT32_TIME32: ncmd = VIDIOC_DQEVENT_TIME32; break;
 #endif
-	case VIDIOC_OVERLAY32: ncmd = VIDIOC_OVERLAY; break;
-	case VIDIOC_STREAMON32: ncmd = VIDIOC_STREAMON; break;
-	case VIDIOC_STREAMOFF32: ncmd = VIDIOC_STREAMOFF; break;
-	case VIDIOC_G_INPUT32: ncmd = VIDIOC_G_INPUT; break;
-	case VIDIOC_S_INPUT32: ncmd = VIDIOC_S_INPUT; break;
-	case VIDIOC_G_OUTPUT32: ncmd = VIDIOC_G_OUTPUT; break;
-	case VIDIOC_S_OUTPUT32: ncmd = VIDIOC_S_OUTPUT; break;
 	case VIDIOC_CREATE_BUFS32: ncmd = VIDIOC_CREATE_BUFS; break;
 	case VIDIOC_PREPARE_BUF32: ncmd = VIDIOC_PREPARE_BUF; break;
 	case VIDIOC_PREPARE_BUF32_TIME32: ncmd = VIDIOC_PREPARE_BUF_TIME32; break;
@@ -1571,24 +1556,6 @@ static long do_video_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	 * argument into it.
 	 */
 	switch (cmd) {
-	case VIDIOC_OVERLAY32:
-	case VIDIOC_STREAMON32:
-	case VIDIOC_STREAMOFF32:
-	case VIDIOC_S_INPUT32:
-	case VIDIOC_S_OUTPUT32:
-		err = alloc_userspace(sizeof(unsigned int), 0, &new_p64);
-		if (!err && assign_in_user((unsigned int __user *)new_p64,
-					   (compat_uint_t __user *)p32))
-			err = -EFAULT;
-		compatible_arg = 0;
-		break;
-
-	case VIDIOC_G_INPUT32:
-	case VIDIOC_G_OUTPUT32:
-		err = alloc_userspace(sizeof(unsigned int), 0, &new_p64);
-		compatible_arg = 0;
-		break;
-
 	case VIDIOC_G_EDID32:
 	case VIDIOC_S_EDID32:
 		err = alloc_userspace(sizeof(struct v4l2_edid), 0, &new_p64);
@@ -1761,15 +1728,6 @@ static long do_video_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	 * the original 32 bits structure.
 	 */
 	switch (cmd) {
-	case VIDIOC_S_INPUT32:
-	case VIDIOC_S_OUTPUT32:
-	case VIDIOC_G_INPUT32:
-	case VIDIOC_G_OUTPUT32:
-		if (assign_in_user((compat_uint_t __user *)p32,
-				   ((unsigned int __user *)new_p64)))
-			err = -EFAULT;
-		break;
-
 	case VIDIOC_G_FBUF32:
 		err = put_v4l2_framebuffer32(new_p64, p32);
 		break;
-- 
2.27.0


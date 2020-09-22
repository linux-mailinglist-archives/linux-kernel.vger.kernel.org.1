Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A7274A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIVUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgIVUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:34:48 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92438C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:34:48 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so10224246qvk.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R8GFEYnKOk8TfLXo80Jb83h+O7r3IGiEUB0d+BEz6dM=;
        b=cAPH32nULRT1ndOVXA23s7i0HDo2KeRFOCJ4JaJqPZMup5HWoOitcuiWUcNhlsuDXy
         7AKuY/3xBr9qmilRkJR5FX6FbYBDCcwLlde8YdrvPRsaGkCDAU9316RVdKzxQhafLTvg
         +r1gYI/FuuO1X6OFlqaVFp47NYewk14nfgAu30hntiVdlMmhGyaLWVxOYO/1lvgSsQ1l
         2z5MAjYVGE8qULyGCH0M2zcBjKxeWyHRfZKfg3Pwux5uq0em/OsryFyxJExTAI1G52dp
         kXlHcle51eZdLPRuLUBSOInrrrrzHNiUe8ituNAjHfb4abSdD28LywvBdyq5n/bl5/UH
         pWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R8GFEYnKOk8TfLXo80Jb83h+O7r3IGiEUB0d+BEz6dM=;
        b=HHZItmUB3gW+xHjZD39BhKR6P9Wn8eZDTicXIovpFhXJvcpvNQg7zDCdZ0JkUqbYWM
         6CgncWhDUDguQDXXck/jUDhYQta7BvdGnfKmj+m46vuIbY6Itka2827XCqoAEAb4jBP9
         Xp/2J0m6VQ7e/8E4lvy8q+9JQ/EIMYe07fzb8XmwunyJWx+gGEmFd6ltrG0onTdFT1Vg
         XJ8WKPhkGQL790GHsUdlxePkWX1QxeHuv7KGvOm//JaXm4ZtZKHLkFQE+IC4nNu8E1yQ
         ta01xlYiI8JrxDxgM52fkXRV5f1uWfkzvqP8u7m6XFGrW0dF4BKDGLLAvqoCRcHQjeMR
         jIeg==
X-Gm-Message-State: AOAM53310QgPeYrcph0415dgHKPlqUPN1GEecM5QPCOZObAAW3QTSY0S
        Hs7Kg2bh5GmYiWpz962bOys=
X-Google-Smtp-Source: ABdhPJxBRbjg9BEfzJ1YSKVCiubduc02mIA0b5yAqerkWpYQWdVbYvqzZH9wV+EJZCbhJk6gtRAZyQ==
X-Received: by 2002:ad4:5006:: with SMTP id s6mr7787567qvo.51.1600806887754;
        Tue, 22 Sep 2020 13:34:47 -0700 (PDT)
Received: from ?IPv6:2601:5c0:c100:b9d:298d:87e0:b186:e81c? ([2601:5c0:c100:b9d:298d:87e0:b186:e81c])
        by smtp.gmail.com with ESMTPSA id k185sm11904002qkd.94.2020.09.22.13.34.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:34:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] nvme: fix use-after-free during booting
From:   Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <20200922164154.GA1894@lst.de>
Date:   Tue, 22 Sep 2020 16:34:45 -0400
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        "ztong0001@gmail.com" <ztong0001@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
References: <20200916153605.5253-1-ztong0001@gmail.com>
 <20200922135956.GA23437@lst.de>
 <CAA5qM4BPKZaqH0SHS3zCO7oz=f3Ow_zB2fqtJYUrbbFBNbWsNQ@mail.gmail.com>
 <20200922164154.GA1894@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,
I modified the patch a bit and now it works.
Best,
- Tong

---
 block/genhd.c         | 7 +++++--
 include/linux/genhd.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c314..8c432e5f97ea 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -835,7 +835,10 @@ static void __device_add_disk(struct device =
*parent, struct gendisk *disk,
 	 * Take an extra ref on queue which will be put on =
disk_release()
 	 * so that it sticks around as long as @disk is there.
 	 */
-	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+	if (blk_get_queue(disk->queue))
+		disk->flags |=3D GENHD_FL_QUEUE_REF;
+	else
+		WARN_ON_ONCE(1);
=20
 	disk_add_events(disk);
 	blk_integrity_add(disk);
@@ -1567,7 +1570,7 @@ static void disk_release(struct device *dev)
 	kfree(disk->random);
 	disk_replace_part_tbl(disk, NULL);
 	hd_free_part(&disk->part0);
-	if (disk->queue)
+	if (disk->flags & GENHD_FL_QUEUE_REF)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4ab853461dff..9441077ee103 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -135,6 +135,7 @@ struct hd_struct {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+#define GENHD_FL_QUEUE_REF			0x0800
=20
 enum {
 	DISK_EVENT_MEDIA_CHANGE			=3D 1 << 0, /* media =
changed */
--=20
2.25.1


> On Sep 22, 2020, at 12:41 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Tue, Sep 22, 2020 at 12:19:06PM -0400, Tong Zhang wrote:
>> Thank you Christoph for providing the patch.
>> However, the test shows that the issue still persists even with the =
new patch.
>> The call trace is the same as in my first email.
>=20
> Weird.  What baseline did you test?  You need to use the patch on top =
of
> the latest for-next or for-5.10/block tree from Jens for full effect.
>=20
> If that still feels can you send me a longer dmesg that also shows =
what
> happens before the sniplet you sent?


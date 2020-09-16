Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C07F26C68D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgIPRyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbgIPRyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA38AC02C2A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:36:56 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e7so6415674qtj.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTuIKeDT4oZBu9/PmyTJFWVXKqpQ0FNzrmIL6pppv2w=;
        b=Nwh4CIe8iyvAdxENM+gMC5s21hXvVZ07MqkMYP+6Kj2yaWgRuSTRzMvAirfHGbsZTK
         HmvIXCkPww+m+kEGQEHQkW7i02uR9n1QL6lDu3VPGjUBYiDbEFgDOW1GDRWo8m5s7fbJ
         wBGSlVylOqphT2VFgvz7zluzNVD34a7XeAtRBUKLkA/XZ5QsZL8kc74MXigRyF+Ny1E1
         Su+NhuLQY2qx2IXQqt6r3y16d2IfJx+HHs+aOHhqQ4ZMsPNOFhAiPllrOiefgqKb4uyp
         1mqQRJ43phNT799cpQUQ3i2NozpWaiyIsbykC00DwdeYPlgXKKMB/DtAx4kJF5Q35859
         vHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTuIKeDT4oZBu9/PmyTJFWVXKqpQ0FNzrmIL6pppv2w=;
        b=q4Av5dE5XsFP+rRVTRuefNVn6Rpvd3+fWrT6Q/Zeb2uEXlOdMX/9seWNh91m+9Owk9
         L+9q5zeuncQuRFtJ6mLaY/HkFDAESn1VzPbRddMGHfHpOQJB4biG47sL2sao66kWnsCW
         /MXrhmIPrSMjTLDE7MNOTGcYaVvYvXK3Lc+IZJMHiRiiaWeo7mjEZa3b98QwGZoPVNYo
         35jNkEsUDFdkrYiSuH2aAlzu87FuVj70lqFlBkRGUVMNzDscC8XxMn65cTAEb/JcQAAa
         arr5sV0UzJjvKeSYs//TrCGa36XXu9dZY3He9LqmiqEzftrmwOsOM3/5be4w91vYV9p4
         InVg==
X-Gm-Message-State: AOAM531eCgd37hprmqS0ImB0YI1Q+ijOnw/T6CJpgEDxkkGbLMEHya41
        kKePoXp47ogmNyZFzdWw6Xk=
X-Google-Smtp-Source: ABdhPJxmRJoZnXvvEr70yS68oDpU4wfvDGLr4WCGB6/Ql/9c8V0oIJFNGn8BHMarY8skC5JEnK5VpQ==
X-Received: by 2002:aed:36e7:: with SMTP id f94mr23372706qtb.369.1600270615917;
        Wed, 16 Sep 2020 08:36:55 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:d54e:5074:9d44:3698])
        by smtp.googlemail.com with ESMTPSA id x26sm18469219qtr.78.2020.09.16.08.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:36:55 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] nvme: fix NULL pointer dereference
Date:   Wed, 16 Sep 2020 11:36:49 -0400
Message-Id: <20200916153648.5475-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_tag_to_rq can return NULL and this condition must be checked

[  147.861050] BUG: KASAN: null-ptr-deref in nvme_irq+0xfc/0x410
[  147.861326] Write of size 2 at addr 0000000000000122 by task kworker/u4:1/56
[  147.861675]
[  147.861756] CPU: 1 PID: 56 Comm: kworker/u4:1 Not tainted 5.9.0-rc4+ #83
[  147.862657] Workqueue: nvme-wq nvme_scan_work
[  147.862876] Call Trace:
[  147.863002]  <IRQ>
[  147.863112]  dump_stack+0x7d/0xb0
[  147.863280]  kasan_report.cold+0x6a/0x7e
[  147.863478]  ? nvme_irq+0xfc/0x410
[  147.863650]  nvme_irq+0xfc/0x410
[  147.863815]  ? __x64_sys_getrandom+0xb0/0xb0
[  147.864030]  ? nvme_del_cq_end+0x70/0x70
[  147.864229]  __handle_irq_event_percpu+0x69/0x280
[  147.864465]  handle_irq_event_percpu+0x6a/0xe0
[  147.864689]  ? __handle_irq_event_percpu+0x280/0x280
[  147.864939]  ? _raw_spin_lock+0x75/0xd0
[  147.865131]  ? _raw_read_lock_irq+0x30/0x30
[  147.865345]  handle_irq_event+0x57/0x86
[  147.865537]  handle_edge_irq+0xe5/0x2d0
[  147.865732]  asm_call_on_stack+0x12/0x20
[  147.865929]  </IRQ>
[  147.866038]  common_interrupt+0xad/0x110
[  147.866236]  asm_common_interrupt+0x1e/0x40
[  147.866447] RIP: 0010:__asan_load4+0x40/0xa0
[  147.866663] Code: 00 00 ff 48 39 f8 77 56 48 8d 47 03 48 89 c2 83 e2 07 48 83 fa 02 76 2f 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 0f b6 04 08 <84>0
[  147.867577] RSP: 0000:ffff8880666e6d48 EFLAGS: 00000a06
[  147.867837] RAX: 0000000000000000 RBX: ffff8880666e6e28 RCX: dffffc0000000000
[  147.868190] RDX: 0000000000000003 RSI: ffffffffb053e44f RDI: ffff8880666e6e30
[  147.868544] RBP: 0000000000000013 R08: ffffffffafb5ee6f R09: fffffbfff64977ad
[  147.868897] R10: ffffffffb24bbd63 R11: fffffbfff64977ac R12: ffffffffb053e44f
[  147.869250] R13: 0000000000000000 R14: ffff8880666d8040 R15: 0000000000000130

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 899d2f4d7ab6..725d2263a0f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -960,6 +960,8 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
+	if (!req)
+		return;
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
 		nvme_pci_complete_rq(req);
-- 
2.25.1


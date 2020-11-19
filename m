Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8802B2B954E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgKSOnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgKSOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:42:10 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A388C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:42:09 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so6703398wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rOg+qp39SVj5WC86VkdFnTzL9jP06PEcpQhmqKQ3t14=;
        b=VdR4TRQWQACxogAeI8bpxISw4lYuZMDpigTJtM/VpnCefzKALSPbEG99bZ5Wbe+gKp
         gTbBqPkoFOSHKBnAtnkpkRQRBwBUcqVexaUuZzvjGnAeBUC4W8Sgv2HdBZTVCRr0iXOw
         AVEvBuq1VDgLMzYgPJsacfSZW0w7f2MUd4t1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rOg+qp39SVj5WC86VkdFnTzL9jP06PEcpQhmqKQ3t14=;
        b=GBsEwOqen8cT4U2E6nUl69Y88WS1Zil2lQIspTLQKAdqjO6zB8xFsOSFbC9cw5uvuE
         qIZwC4UYD+lHmeZpacnhk38ldGY96VGHXuLSFq0MtlbBuQYWQkE5EOKch29/5raIzL09
         hcQapplUM4G4I9DylT4QEVxrrdaxWWI7tH8PkDclk/6hsHCycaxMJLxRqgtDIWNvWnx2
         SNlu/wwXxNYLFtgHXffSYsiVUE7YfCtajg1e075FA/rTTPicgv04oOh9mI+obSh7kVBN
         RpFeJy/MmLuTJAt7zsk4UnAwSkH7rYrU9ZHyx+CSKoYUkeAOXDyCXqNpBicYAcPUycpl
         spqQ==
X-Gm-Message-State: AOAM533l6pW8A9GM/tsDChN6qqQlaD4TqIRMvt2n+q2fNP7NWW3IO5bN
        8xCd0f79JCF+to9QB0B768XGuw==
X-Google-Smtp-Source: ABdhPJxkxIZb1Dvgqd+l4qpBOUdvHL2JTzWDAAwF5TWOoMRtyTV7FCLmBVro+JG8yHOq0sr6nntY2g==
X-Received: by 2002:a05:6000:372:: with SMTP id f18mr11447766wrf.149.1605796928322;
        Thu, 19 Nov 2020 06:42:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x63sm51292wmb.48.2020.11.19.06.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 06:42:07 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, linux-pci@vger.kernel.org
Subject: [PATCH v6 11/17] PCI: Obey iomem restrictions for procfs mmap
Date:   Thu, 19 Nov 2020 15:41:40 +0100
Message-Id: <20201119144146.1045202-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119144146.1045202-1-daniel.vetter@ffwll.ch>
References: <20201119144146.1045202-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's three ways to access PCI BARs from userspace: /dev/mem, sysfs
files, and the old proc interface. Two check against
iomem_is_exclusive, proc never did. And with CONFIG_IO_STRICT_DEVMEM,
this starts to matter, since we don't want random userspace having
access to PCI BARs while a driver is loaded and using it.

Fix this by adding the same iomem_is_exclusive() check we already have
on the sysfs side in pci_mmap_resource().

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
References: 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
--
v2: Improve commit message (Bjorn)
---
 drivers/pci/proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index d35186b01d98..3a2f90beb4cb 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -274,6 +274,11 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 		else
 			return -EINVAL;
 	}
+
+	if (dev->resource[i].flags & IORESOURCE_MEM &&
+	    iomem_is_exclusive(dev->resource[i].start))
+		return -EINVAL;
+
 	ret = pci_mmap_page_range(dev, i, vma,
 				  fpriv->mmap_state, write_combine);
 	if (ret < 0)
-- 
2.29.2


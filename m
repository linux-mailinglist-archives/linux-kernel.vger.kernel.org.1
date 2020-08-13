Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75718244048
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 23:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHMVEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 17:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHMVEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:21 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F025C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:21 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cs12so3341850qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IaO87JqeLl+O7BlBAJGOZPpEX9UGcCnuKI5svLj4Bs0=;
        b=Dd6NByMnoMi3tP43XCjKs0W3n7u8BCSUEtGRpIIaCs2IgLp+ygeLLj94chmfodjhtt
         EOH55mnbYk2ifoEUgRM+MUfLmmbVss7DZ1GRHcRwgKMysI9HNBdYsJMcOlU9tV3MTfhF
         nk66fgHZH2LURB6agR1Y0tAAI2lnO92ecq153l8ZkE7KtsK6AG0p+L/Ooc4Y6bzNNstw
         ppWq/IY+drpLCtL+4ROVEf6MYHBskleV6qt/xz19czgdWupbyKDRyUrMAL5ymSUvGUIK
         ua96ZYLtZPSo0ReAGKzlDhFZKijMziH69zLENxYL1oHbdNzykL+y7kK5w4qXfmI7zhwH
         NPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaO87JqeLl+O7BlBAJGOZPpEX9UGcCnuKI5svLj4Bs0=;
        b=jsQJq76XM5+vbq5NoBe7AHlRhsRqeLj8A/nO85uVMNYJCJGZSEMbs/iNaEI9O8oGWq
         kX4tz6U+Azx8QhRBTkMJQDJgQUU9+96bzu4zp+Sv9qhSo4sQt81v1sd9vNFT8iwIqQcf
         uR2UgZ1oxNLQiTFhskQgG2XL01eKhqIof4kX/UNJD64UobXKNxMB8u+KtqpEqzO12dIg
         HJrHI5fOjY/LkPoGKz7G3HvEk8NFBWeQsmeTaTQvxBmUToBMAt2jvWqsXOW5FRaNqtEX
         c++CpwGyEhGYxocNFHxTxaDjE0zEaAG0QeHVx9Pln2I1d+WtrMCy7+fIk1r2DIWUdmkW
         z7Bg==
X-Gm-Message-State: AOAM533+L/eNZ56tsZb/bclhRPhytaqYYQZMTyaPTC6TIPFxXSsFDa0z
        LbZe/EBIjLyDWdNpE71WH6IrpQ==
X-Google-Smtp-Source: ABdhPJwUQKeBLYjB4FhXaPS3rNe1ShEUQBY/o2BXQwPq2gZ+BYtq4Fh77+yPDsPgTstlbMMGvYs++Q==
X-Received: by 2002:ad4:560f:: with SMTP id ca15mr6718700qvb.144.1597352660264;
        Thu, 13 Aug 2020 14:04:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c9sm6304727qkm.44.2020.08.13.14.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:04:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: [PATCH 2/6] tree-wide: rename vmemdup_user to kvmemdup_user
Date:   Thu, 13 Aug 2020 17:04:07 -0400
Message-Id: <20200813210411.905010-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813210411.905010-1-josef@toxicpanda.com>
References: <20200813210411.905010-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper uses kvmalloc, not vmalloc, so rename it to kvmemdup_user to
make it clear we're using kvmalloc() and will need to use kvfree().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kvm/cpuid.c                   | 6 +++---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 drivers/tty/vt/consolemap.c            | 2 +-
 include/linux/string.h                 | 2 +-
 mm/util.c                              | 6 +++---
 sound/core/control.c                   | 4 ++--
 virt/kvm/kvm_main.c                    | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3fd6eec202d7..22834ea499ee 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -200,9 +200,9 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
 		goto out;
 	if (cpuid->nent) {
-		cpuid_entries = vmemdup_user(entries,
-					     array_size(sizeof(struct kvm_cpuid_entry),
-							cpuid->nent));
+		cpuid_entries = kvmemdup_user(entries,
+					      array_size(sizeof(struct kvm_cpuid_entry),
+							 cpuid->nent));
 		if (IS_ERR(cpuid_entries)) {
 			r = PTR_ERR(cpuid_entries);
 			goto out;
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 7a2430e34e00..c2f973aa3680 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -147,7 +147,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		bo_handles = NULL;
 	}
 
-	buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
+	buf = kvmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
 		goto out_unused_fd;
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 5947b54d92be..2cffa8b3c74b 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -542,7 +542,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	if (!ct)
 		return 0;
 
-	unilist = vmemdup_user(list, array_size(sizeof(struct unipair), ct));
+	unilist = kvmemdup_user(list, array_size(sizeof(struct unipair), ct));
 	if (IS_ERR(unilist))
 		return PTR_ERR(unilist);
 
diff --git a/include/linux/string.h b/include/linux/string.h
index 21bb6d3d88c4..a6f7218124a0 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -11,7 +11,7 @@
 
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t);
-extern void *vmemdup_user(const void __user *, size_t);
+extern void *kvmemdup_user(const void __user *, size_t);
 extern void *kvmemdup_user_nul(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
diff --git a/mm/util.c b/mm/util.c
index cf454d57d3e2..f434634b6ba3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -183,7 +183,7 @@ void *memdup_user(const void __user *src, size_t len)
 EXPORT_SYMBOL(memdup_user);
 
 /**
- * vmemdup_user - duplicate memory region from user space
+ * kvmemdup_user - duplicate memory region from user space
  *
  * @src: source address in user space
  * @len: number of bytes to copy
@@ -191,7 +191,7 @@ EXPORT_SYMBOL(memdup_user);
  * Return: an ERR_PTR() on failure.  Result may be not
  * physically contiguous.  Use kvfree() to free.
  */
-void *vmemdup_user(const void __user *src, size_t len)
+void *kvmemdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
@@ -206,7 +206,7 @@ void *vmemdup_user(const void __user *src, size_t len)
 
 	return p;
 }
-EXPORT_SYMBOL(vmemdup_user);
+EXPORT_SYMBOL(kvmemdup_user);
 
 /**
  * kvmemdup_user_nul - duplicate memory region from user space and NUL-terminate
diff --git a/sound/core/control.c b/sound/core/control.c
index aa0c0cf182af..b712f4d261de 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1297,7 +1297,7 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 	if (size > 1024 * 128)	/* sane value */
 		return -EINVAL;
 
-	container = vmemdup_user(buf, size);
+	container = kvmemdup_user(buf, size);
 	if (IS_ERR(container))
 		return PTR_ERR(container);
 
@@ -1365,7 +1365,7 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
 	if (ue->info.value.enumerated.names_length > 64 * 1024)
 		return -EINVAL;
 
-	names = vmemdup_user((const void __user *)user_ptrval,
+	names = kvmemdup_user((const void __user *)user_ptrval,
 		ue->info.value.enumerated.names_length);
 	if (IS_ERR(names))
 		return PTR_ERR(names);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 737666db02de..1111780ccefd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3814,8 +3814,8 @@ static long kvm_vm_ioctl(struct file *filp,
 			goto out;
 		if (routing.nr) {
 			urouting = argp;
-			entries = vmemdup_user(urouting->entries,
-					       array_size(sizeof(*entries),
+			entries = kvmemdup_user(urouting->entries,
+						array_size(sizeof(*entries),
 							  routing.nr));
 			if (IS_ERR(entries)) {
 				r = PTR_ERR(entries);
-- 
2.24.1


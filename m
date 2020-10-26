Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362C529878B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770946AbgJZHlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:41:39 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16774 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770320AbgJZHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:41:39 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f967dba0000>; Mon, 26 Oct 2020 00:41:46 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 07:41:38 +0000
Received: from sandstorm.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 07:41:38 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] mm: cleanup: remove unused tsk arg from __access_remote_vm
Date:   Mon, 26 Oct 2020 00:41:37 -0700
Message-ID: <20201026074137.4147787-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603698106; bh=kNTURRfltlV2Fvs3TVU4HcRoa3nFHuc50Qm9MLel+Uc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=M6t8PNi6Td0RPzt/a/iTp1Ajz3t2xn6O4iYzGL4Bolo0OHN4f95P8cfjWk0Ef6a1l
         ZzeH3Cns5AEhaofS4tuJ/81LvDvjRPy/9YvVMVMWXuwE7+aerIiO/mZGwNA4xzgGjr
         jE2HQ+sOm5A1DGgue7p/UqmZ1J7fvbvJoCRQSIc50t62O86Mo2OpueqWGueHBWMTAY
         75o7644HuTXHaXJEWfBDhbFk5BK/Hdkb2cJdHvdDDFDQfq/UOZw7kdXl0BfZQaJsxg
         /2MWYjn5oWUXHxiE4nn6gEt/RJoT+q4MOfp+YWyzow8KlDMNcOF/L5qJvz2mx7RFYg
         B+XElhpPMtoFA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite a comment that said that page fault accounting would be charged
to whatever task_struct* was passed into __access_remote_vm(), the tsk
argument was actually unused.

Delete both the comment, and the argument.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Cc: Oleg Nesterov <oleg@redhat.com>
---

Hi,

Just something that caught my eye when I was reviewing a semi-related
patchset.

thanks,
John Hubbard
NVIDIA

 include/linux/mm.h |  4 ++--
 kernel/ptrace.c    |  2 +-
 mm/memory.c        | 11 +++++------
 mm/nommu.c         |  8 ++++----
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..b3b85a5c5937 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1716,8 +1716,8 @@ extern int access_process_vm(struct task_struct *tsk,=
 unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
-extern int __access_remote_vm(struct task_struct *tsk, struct mm_struct *m=
m,
-		unsigned long addr, void *buf, int len, unsigned int gup_flags);
+extern int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
+			      void *buf, int len, unsigned int gup_flags);
=20
 long get_user_pages_remote(struct mm_struct *mm,
 			    unsigned long start, unsigned long nr_pages,
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..fbbe32443b18 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -57,7 +57,7 @@ int ptrace_access_vm(struct task_struct *tsk, unsigned lo=
ng addr,
 		return 0;
 	}
=20
-	ret =3D __access_remote_vm(tsk, mm, addr, buf, len, gup_flags);
+	ret =3D __access_remote_vm(mm, addr, buf, len, gup_flags);
 	mmput(mm);
=20
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e502..25b28bc251d5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4874,11 +4874,10 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
 #endif
=20
 /*
- * Access another process' address space as given in mm.  If non-NULL, use=
 the
- * given task for page fault accounting.
+ * Access another process' address space as given in mm.
  */
-int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long addr, void *buf, int len, unsigned int gup_flags)
+int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf=
,
+		       int len, unsigned int gup_flags)
 {
 	struct vm_area_struct *vma;
 	void *old_buf =3D buf;
@@ -4955,7 +4954,7 @@ int __access_remote_vm(struct task_struct *tsk, struc=
t mm_struct *mm,
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags)
 {
-	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
+	return __access_remote_vm(mm, addr, buf, len, gup_flags);
 }
=20
 /*
@@ -4973,7 +4972,7 @@ int access_process_vm(struct task_struct *tsk, unsign=
ed long addr,
 	if (!mm)
 		return 0;
=20
-	ret =3D __access_remote_vm(tsk, mm, addr, buf, len, gup_flags);
+	ret =3D __access_remote_vm(mm, addr, buf, len, gup_flags);
=20
 	mmput(mm);
=20
diff --git a/mm/nommu.c b/mm/nommu.c
index 0faf39b32cdb..870fea12823e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1675,8 +1675,8 @@ void filemap_map_pages(struct vm_fault *vmf,
 }
 EXPORT_SYMBOL(filemap_map_pages);
=20
-int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long addr, void *buf, int len, unsigned int gup_flags)
+int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf=
,
+		       int len, unsigned int gup_flags)
 {
 	struct vm_area_struct *vma;
 	int write =3D gup_flags & FOLL_WRITE;
@@ -1722,7 +1722,7 @@ int __access_remote_vm(struct task_struct *tsk, struc=
t mm_struct *mm,
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags)
 {
-	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
+	return __access_remote_vm(mm, addr, buf, len, gup_flags);
 }
=20
 /*
@@ -1741,7 +1741,7 @@ int access_process_vm(struct task_struct *tsk, unsign=
ed long addr, void *buf, in
 	if (!mm)
 		return 0;
=20
-	len =3D __access_remote_vm(tsk, mm, addr, buf, len, gup_flags);
+	len =3D __access_remote_vm(mm, addr, buf, len, gup_flags);
=20
 	mmput(mm);
 	return len;

base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
--=20
2.29.0


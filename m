Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F332D13D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgLGOgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:36:04 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17183 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgLGOgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:36:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1607351632; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=YIBQJTwK0P3P0O06iqP9RoOLLaL7I0s38rXyqtZ3FREMhcy7N7WIB8WC6UFYRg+ntrjBHsXQedtiRsSB7FbxIDH8CjiqFx3Tc5k+NNkXmq/FJNW+sLpORTNMDFO0nQhl8KBsPp/DG0l1gYbTMCzyOc8zkGWLVanj2cBBH+Yn61Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1607351632; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=qAszKcLYs9jvnFBEg3/CMi/T/+x65cdwThphUbpHziw=; 
        b=m7Y8iGDX+2yJwHy7Cvwk9SJ8uKBpQet+FYjkPGdd/7OPPuwCtPPSiv2IHhB2v9lhnL214Yn470oMo3KngUSZLr1nB1dVdTA4UUx2+6NHyKhko7wSfGuk9eoLKjjub3I4LZBVFfWUK6L6B4SzSuyq5LQEZ6qZWQxiBd2v37ej7NU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1607351632;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=qAszKcLYs9jvnFBEg3/CMi/T/+x65cdwThphUbpHziw=;
        b=dj/a+CSIz45qDn8p0Ub+rUaJ31aAS1GSCCT7f+nrgyPUD0yke/zCwNLbGt+fGVue
        YXl9RC1HctKwEcPvkn769WyDSlxZg3VTk3zGEfnDc+IYZALL2EzJGpvY1Zb2I/PQrya
        C0slcU83tOd7uTeHpwL1mOfAjMDIfjEKUG0fpeTE=
Received: from localhost.localdomain (113.116.158.77 [113.116.158.77]) by mx.zoho.com.cn
        with SMTPS id 16073516292831021.863935117984; Mon, 7 Dec 2020 22:33:49 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201207143329.32730-1-cgxu519@mykernel.net>
Subject: [V9fs-developer][PATCH v2] 9p: create writeback fid on shared writable mmap
Date:   Mon,  7 Dec 2020 22:33:29 +0800
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vma is shared and the file was opened for writing,
we should also create writeback fid because vma may be
mprotected writable even if now readonly.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/9p/vfs_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index b177fd3b1eb3..e4256dbcb754 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -517,7 +517,7 @@ v9fs_mmap_file_mmap(struct file *filp, struct vm_area_s=
truct *vma)
 =09mutex_lock(&v9inode->v_mutex);
 =09if (!v9inode->writeback_fid &&
 =09    (vma->vm_flags & VM_SHARED) &&
-=09    (vma->vm_flags & VM_WRITE)) {
+=09    (vma->vm_flags & VM_MAYWRITE)) {
 =09=09/*
 =09=09 * clone a fid and add it to writeback_fid
 =09=09 * we do it during mmap instead of
--=20
2.26.2



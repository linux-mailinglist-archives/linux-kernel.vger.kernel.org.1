Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21892CFF14
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 22:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgLEVH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 16:07:58 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17142 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbgLEVH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 16:07:57 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1607173756; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Fa5o5qvaV3+NAcvHEK9/sD7Gt2+TEJvCTssVhm9qwqM1/SAM0cfg27F7uQxp9rTZvAlZsM0BwRZ4rqCe2bQ8XKUk4M07cCVNkiZuiO19/66yXuyj8qBdXi8j5NHWVwq1N56OVD/RTv+ob5CV4jSi/jFUI9N78+YFsWadJqGyMYY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1607173756; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=tHxG5co5xvuUjGQ5Eh70UR6wHrLHoiLCPbQX5DiQRrY=; 
        b=GudFEi8NTdFPYfbPhjgU4Q63vwdxmupFNfTfoX62CpVWhfqa+p6kaSKC++MGzsSoEi2hMo3DxMIYxAVKtEQict5IKF2S+jv58bo5tE6WLHWs4LDQt2gL9s47Hg1eRaRgSdy3lO4UOqc0XLyGfaOzs+zHNz+Rbxxx3SB0tBJEmpI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1607173756;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=tHxG5co5xvuUjGQ5Eh70UR6wHrLHoiLCPbQX5DiQRrY=;
        b=ZcjEWzaY6FIh68kUQhmOmpeB9GXZcBzOvKzuBjgx7FnyJm56OVzoQ6tG32JMqvDx
        5HoqCnpjq/7g2IKUHIzJnjlRA8GXnUyTa4CxYsQOBQErUjj6m6DcZthn9v8z0KozTTW
        FJAsJu0Kzaz+DxmHH0R9j3ZZOoeM+KlfyBOZsO1o=
Received: from localhost.localdomain (113.87.90.239 [113.87.90.239]) by mx.zoho.com.cn
        with SMTPS id 1607173753136251.15710636560402; Sat, 5 Dec 2020 21:09:13 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201205130904.518104-1-cgxu519@mykernel.net>
Subject: [RFC PATCH] 9p: create writeback fid on shared mmap
Date:   Sat,  5 Dec 2020 21:09:04 +0800
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
Caveat: Only compile tested.

 fs/9p/vfs_file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index b177fd3b1eb3..791839c2dd5c 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -516,8 +516,7 @@ v9fs_mmap_file_mmap(struct file *filp, struct vm_area_s=
truct *vma)
 =09v9inode =3D V9FS_I(inode);
 =09mutex_lock(&v9inode->v_mutex);
 =09if (!v9inode->writeback_fid &&
-=09    (vma->vm_flags & VM_SHARED) &&
-=09    (vma->vm_flags & VM_WRITE)) {
+=09    mapping_writably_mapped(filp->f_mapping)) {
 =09=09/*
 =09=09 * clone a fid and add it to writeback_fid
 =09=09 * we do it during mmap instead of
--=20
2.26.2



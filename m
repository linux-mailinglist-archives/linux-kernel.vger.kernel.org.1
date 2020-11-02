Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48C2A2AB0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgKBM21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:28:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16917 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgKBM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604320101; x=1635856101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VyYqEj02//Q8aOREoIdUadY/41mOapiZeUZLWPcypHI=;
  b=bL2Vrhwt6SRc03IMhQRrMQ4mWem7MlqfxKpNV9+OmwuAywIYE3fnpzl0
   fNvp1B+R2i/1JFqJenQ6d77CSWSYX8kLZSigrxhS0T2gDrYrKUHeIbHnP
   dQscWEkg2anKQA5bkAsSzopSvp3Qaw2hgPxPkQ+jrpYMuIhSYWq0OFsFp
   oxmxHj90DDIf+WRJxz7vMXuW17tJ9M6T3DcB6mWRUhjnRXKVyCjwY06Nl
   GwaAedqIDXVXbB7T8hdNEDvmxORjyRTiWFFgE3aMXPntYg+uDYexrLHYn
   WP6QpQqLGZyqpZggW13SXfOoIA4wW1kSGiBHAgaH9f9i9zA6jvoSbE9qi
   A==;
IronPort-SDR: LEeOjVPZc8tQp7oSycPwjRAQzjFqp67TIpZIT7UoiBbQrZgSQY8ntNY8gRhjQu8k0zAc7cR4cX
 m1Hz9QokKoLihGgp7WW4F/UscVWfh1RTW1FWmP8zkMjvHmByMO3XJhkdup7xaz/5tuhR4vkUxv
 yhoGlw+6cBJZsVK/PYEl+846rbsqwCJhwWnAWV4gh/mtSvEPqTs2v8GD5lRrU8n8tdUAdSTk75
 yLEvuYpsTNCg5OQFf5was6zup+N5ZTEolpmPs3YIs2xxXh9derRd/vtsj5PMSqQqVxe3DpUFeB
 eH8=
X-IronPort-AV: E=Sophos;i="5.77,444,1596470400"; 
   d="scan'208";a="152754059"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2020 20:28:21 +0800
IronPort-SDR: PI6OVr/ejy/TQR2pbwv1zR1R/poZHDHBrLHfKGjQyyDoeITERR0Qki/pPhKTh0EgVM3hBfydZg
 menOJ3FqSgIp1KGDuuEeFRtLajMjVsK4AEAXV1rAJ6/9SKkrd1wI10unDrl8xMr6gvRhG84125
 dC26PMgB0uB6FBDpZm5RK9SeZa5rJu3p0i0R8TnGAr3ABGU2aqU/6pHfa+9BIszbljyU5OR1sG
 wTsYYv0J/QJBPc79rBDvtN/UIp6aOGkGgPNF98FfIc7hgXYfFTmnOyNXll5/CLdM7JIKojgVYr
 zXKlIGktCOADcnuVzagzNt/0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 04:13:20 -0800
IronPort-SDR: dbsrk4PDBindjRLeh6eY7UPaQCYe/OH5eO+SPKWDXHhJkIZ1tqVfFM5zKsXypQ+anChjr2H+8J
 ucykm5KowiOzgOfg6BaDoOiE66ftlfAXKXF7k31ehD3w0KuUyDRV+wnuc5bsomeJ5vRQQVOmxu
 AI1Ym9lOEmI5VCo60vA0g7ihcZUlIZDEe3jS1Ye4jv2t8ztsjLVwa3Z7O0XZA8g3bzcPmTHZcx
 hV+8tagSlMInxJFaWBb7q9rwvH2VzlVUBcvCcTuTSqmgfwx9IR3PlBijBUYoEt6aqL28nMtT1G
 Sco=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Nov 2020 04:28:19 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Lang Dai <lang.dai@intel.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] uio: Fix use-after-free in uio_unregister_device()
Date:   Mon,  2 Nov 2020 21:28:19 +0900
Message-Id: <20201102122819.2346270-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8fd0e2a6df26 ("uio: free uio id after uio file node is freed")
triggered KASAN use-after-free failure at deletion of TCM-user
backstores [1].

In uio_unregister_device(), struct uio_device *idev is passed to
uio_free_minor() to refer idev->minor. However, before uio_free_minor()
call, idev is already freed by uio_device_release() during call to
device_unregister().

To avoid reference to idev->minor after idev free, keep idev->minor
value in a local variable. Also modify uio_free_minor() argument to
receive the value.

[1]
BUG: KASAN: use-after-free in uio_unregister_device+0x166/0x190
Read of size 4 at addr ffff888105196508 by task targetcli/49158

CPU: 3 PID: 49158 Comm: targetcli Not tainted 5.10.0-rc1 #1
Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12/17/2015
Call Trace:
 dump_stack+0xae/0xe5
 ? uio_unregister_device+0x166/0x190
 print_address_description.constprop.0+0x1c/0x210
 ? uio_unregister_device+0x166/0x190
 ? uio_unregister_device+0x166/0x190
 kasan_report.cold+0x37/0x7c
 ? kobject_put+0x80/0x410
 ? uio_unregister_device+0x166/0x190
 uio_unregister_device+0x166/0x190
 tcmu_destroy_device+0x1c4/0x280 [target_core_user]
 ? tcmu_release+0x90/0x90 [target_core_user]
 ? __mutex_unlock_slowpath+0xd6/0x5d0
 target_free_device+0xf3/0x2e0 [target_core_mod]
 config_item_cleanup+0xea/0x210
 configfs_rmdir+0x651/0x860
 ? detach_groups.isra.0+0x380/0x380
 vfs_rmdir.part.0+0xec/0x3a0
 ? __lookup_hash+0x20/0x150
 do_rmdir+0x252/0x320
 ? do_file_open_root+0x420/0x420
 ? strncpy_from_user+0xbc/0x2f0
 ? getname_flags.part.0+0x8e/0x450
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f9e2bfc91fb
Code: 73 01 c3 48 8b 0d 9d ec 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6d ec 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffdd2baafe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007f9e2beb44a0 RCX: 00007f9e2bfc91fb
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f9e1c20be90
RBP: 00007ffdd2bab000 R08: 0000000000000000 R09: 00007f9e2bdf2440
R10: 00007ffdd2baaf37 R11: 0000000000000246 R12: 00000000ffffff9c
R13: 000055f9abb7e390 R14: 000055f9abcf9558 R15: 00007f9e2be7a780

Allocated by task 34735:
 kasan_save_stack+0x1b/0x40
 __kasan_kmalloc.constprop.0+0xc2/0xd0
 __uio_register_device+0xeb/0xd40
 tcmu_configure_device+0x5a0/0xbc0 [target_core_user]
 target_configure_device+0x12f/0x760 [target_core_mod]
 target_dev_enable_store+0x32/0x50 [target_core_mod]
 configfs_write_file+0x2bb/0x450
 vfs_write+0x1ce/0x610
 ksys_write+0xe9/0x1b0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 49158:
 kasan_save_stack+0x1b/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x1b/0x30
 __kasan_slab_free+0x110/0x150
 slab_free_freelist_hook+0x5a/0x170
 kfree+0xc6/0x560
 device_release+0x9b/0x210
 kobject_put+0x13e/0x410
 uio_unregister_device+0xf9/0x190
 tcmu_destroy_device+0x1c4/0x280 [target_core_user]
 target_free_device+0xf3/0x2e0 [target_core_mod]
 config_item_cleanup+0xea/0x210
 configfs_rmdir+0x651/0x860
 vfs_rmdir.part.0+0xec/0x3a0
 do_rmdir+0x252/0x320
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888105196000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1288 bytes inside of
 2048-byte region [ffff888105196000, ffff888105196800)
The buggy address belongs to the page:
page:0000000098e6ca81 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x105190
head:0000000098e6ca81 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x17ffffc0010200(slab|head)
raw: 0017ffffc0010200 dead000000000100 dead000000000122 ffff888100043040
raw: 0000000000000000 0000000000080008 00000001ffffffff ffff88810eb55c01
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff88810eb55c01

Memory state around the buggy address:
 ffff888105196400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888105196480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888105196500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888105196580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888105196600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: 8fd0e2a6df26 ("uio: free uio id after uio file node is freed")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/uio/uio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 6dca744e39e9..be06f1a961c2 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -413,10 +413,10 @@ static int uio_get_minor(struct uio_device *idev)
 	return retval;
 }
 
-static void uio_free_minor(struct uio_device *idev)
+static void uio_free_minor(unsigned long minor)
 {
 	mutex_lock(&minor_lock);
-	idr_remove(&uio_idr, idev->minor);
+	idr_remove(&uio_idr, minor);
 	mutex_unlock(&minor_lock);
 }
 
@@ -990,7 +990,7 @@ int __uio_register_device(struct module *owner,
 err_uio_dev_add_attributes:
 	device_del(&idev->dev);
 err_device_create:
-	uio_free_minor(idev);
+	uio_free_minor(idev->minor);
 	put_device(&idev->dev);
 	return ret;
 }
@@ -1042,11 +1042,13 @@ EXPORT_SYMBOL_GPL(__devm_uio_register_device);
 void uio_unregister_device(struct uio_info *info)
 {
 	struct uio_device *idev;
+	unsigned long minor;
 
 	if (!info || !info->uio_dev)
 		return;
 
 	idev = info->uio_dev;
+	minor = idev->minor;
 
 	mutex_lock(&idev->info_lock);
 	uio_dev_del_attributes(idev);
@@ -1062,7 +1064,7 @@ void uio_unregister_device(struct uio_info *info)
 
 	device_unregister(&idev->dev);
 
-	uio_free_minor(idev);
+	uio_free_minor(minor);
 
 	return;
 }
-- 
2.26.2


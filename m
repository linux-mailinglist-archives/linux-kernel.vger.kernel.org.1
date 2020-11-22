Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B3A2BC78D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 18:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgKVRox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 12:44:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:60185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgKVRox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 12:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606067091;
        bh=OtkRGVMeZMpWYqPOQ45WZkaNM1vFkcGFBfFWwmAMx08=;
        h=X-UI-Sender-Class:From:Cc:Subject:Date;
        b=GcW5EWotj3f798UBjjg9xKNU2C1UR68BNDLEcO0fwKQWqykX4yGbk6YwCBVIn/zT0
         tP7SiBKjS4YmzEPq++UE4WKy5oY20eVcBsXHm/IDSIeJIDexfrfNOKgsZV9lrZgWeY
         aVhSbJZ2MfYlNHmqUHefbuHk4hOF5GCIaIdENAp4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [89.247.255.23] ([89.247.255.23]) by web-mail.gmx.net
 (3c-app-gmx-bap75.server.lan [172.19.172.175]) (via HTTP); Sun, 22 Nov 2020
 18:44:51 +0100
MIME-Version: 1.0
Message-ID: <trinity-510d1e12-98a7-48c2-88d7-a8a1cd608732-1606067091286@3c-app-gmx-bap75>
From:   nslusarek@gmx.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] misc/vmw_vmci: bail out earlier on too big queue allocation
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 22 Nov 2020 18:44:51 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:JkecL+YG/WzIdKeCsv18IWnn0+Q++VKY1iOIPyie1ZAqjyu5EtGu2q9oKZxVO1mN4C7Yx
 9NomC8bO2UTEkofj0Gf6td6N6W8O16QUd7u2kdCmDahYNWLj0qCTXaWou9PFwVSGaCyAfuaqKfiF
 GB1/ZPNuaGqWHtDNECqDmekelkQFI78tUMI34a7dgCEsANHukRkfHX56EhykFHZBTTR5bs+1y8xz
 dhJPXiFKxeYl1I/PUCFYDbccCDT5OSUC68gLhsHLqTnkx5+MJtbEN9wqmx/bO9XkWBJxXHHjkdDf
 kA=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hvNwPLGg3eU=:ncP8MS51HZIzaUdKzR/DUj
 znnn1LudnqBJZKnJ5hpzWBCA2+er7Xksp1hDv4xqOX9NTs2V2B7iCzzYCWTxrbfLl3r/wC+ce
 q9DuXXq4BNHRdcGiHnKsT7AC1rXF1PrZmuvl+dsmpirM4ae6MyIoLeELUbItx07cfN6Tg12o1
 eEEkjjSpr+X7a1aj9rcwkqlOKYWfyx8TPMCIRWDvHe9W2sVfnOM93JL5xd6xoUf5ALBX69d3k
 hxfhCZp105pvDP4TGLQaLP3Yfs2JYst/fQg7OCCPCUPK2fjqw/ii4pmheqNunuHsDHIfH5Wk6
 IpvSF8s4FuUPoGTQeYTEzXO8x5FFd+q4InzpzUvv/rjeXMbkouiIvitV+fPFSRyf2YMtNPDXu
 njXeYoblFgNx/S1ShyBxTkBRef3XadrI4BOWlc9axX6FWEJ4VDsZINEksMeNqJLTj3q2k0coV
 GgbAUeVPWOmt9hPrRGW6H+7YKxt8yr2CpAJam3ni1zi9PV+pNyd69cglK3hHOmHq9t78kPZqo
 mpcYgLED+isYIj0z42d3WSeGM1CFSkZVYW4RjaOmkAGuTe3lHuwYtdalPUEESCCS36CpO4Ux2
 qnT/igYyG05aM=
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Norbert Slusarek <nslusarek@gmx.net>
Date: Sun, 22 Nov 2020 19:16:41 +0100
Subject: [PATCH] misc/vmw_vmci: bail out earlier on too big queue allocati=
on

For the allocation of a queue pair in qp_host_alloc_queue() an arbitrary v=
alue can be
passed for produce_size, which can lead to miscalculation of memory we'd l=
ike to allocate
in one take. A warning is triggered at __alloc_pages_nodemask() in mm/page=
_alloc.c:4737
which aborts the false allocation, but it results in a VMware machine free=
zing
for an infinite time.

Signed-off-by: Norbert Slusarek <nslusarek@gmx.net>

=2D--

To provide an accurate explanation of the problem, I'll describe my observ=
ations and
include a PoC you can run yourself.
The value for produce_size (0x7ffe7001) wasn't chosen randomly, it's the l=
east value
which can trigger the warning. With this value involved, calculations are =
made in
qp_host_alloc_queue() before calling kzalloc() with queue_size + queue_pag=
e_size.
The calculation of queue_size involves taking the size of *queue->kernel_i=
f, which on 5.10-rc4 has the size of 72 bytes and on 5.4.79 it's 168 bytes=
.
While on 5.10-rc4 the size argument for kzalloc() won't surpass
the maximum value of 4096*1024 for an individual allocation
(for produce_size =3D 0x7ffe7001 -> kzalloc(4194216)), it will be greater =
on the stable 5.4.79 kernel
(for produce_size =3D 0x7ffe7001 -> kzalloc(4194312)).
This will ultimately lead to a warning on the stable 5.4 kernel, but not o=
n the upstream kernel,
so ideally my patch would be backported to stable kernels.
Eventhough the warning in __alloc_pages_nodemask() already aborts the over=
sized allocation of memory, VMware will hang for an infinite time, hence I=
 wanted to provide this simple patch. We shouldn't rely on the page alloca=
tor to abort it anyways, it's better to keep it clean and check for
a too large allocation before calling kzalloc().
When I ran the PoC in QEMU and on a host machine, I didn't experience any =
freezes at all, but
the warning gets triggered.

PoC (run on 5.4 stable kernel and VMCI driver loaded for /dev/vmci):

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <endian.h>
#include <stdint.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>

#define VMADDR_CID_LOCAL		1
#define IOCTL_VMCI_VERSION2		1959
#define IOCTL_VMCI_INIT_CONTEXT		1952
#define IOCTL_VMCI_QUEUEPAIR_ALLOC	1960
#define VMCI_VERSION_PREHOSTQP		0x80000
#define VMCI_NO_PRIVILEGE_FLAGS		0

struct vmci_handle {
	unsigned int context;
	unsigned int resource;
};

struct vmci_qp_alloc_info {
	struct vmci_handle handle;
	unsigned int peer;
	unsigned int flags;
	unsigned long produce_size;
	unsigned long consume_size;
	unsigned long ppn_va;
	unsigned long num_ppns;
	int result;
	unsigned int version;
};

struct vmci_init_blk {
	int cid;
	int flags;
};

int main(void)
{
	int fd, flag;

	fd =3D syscall(__NR_openat, -100, "/dev/vmci", O_RDWR, 0);

	flag =3D VMCI_VERSION_PREHOSTQP;
        syscall(__NR_ioctl, fd, IOCTL_VMCI_VERSION2, &flag);

	struct vmci_init_blk cxt =3D {
		.cid =3D VMADDR_CID_LOCAL,
		.flags =3D VMCI_NO_PRIVILEGE_FLAGS
	};
	syscall(__NR_ioctl, fd, IOCTL_VMCI_INIT_CONTEXT, &cxt);

	struct vmci_qp_alloc_info qp =3D {
		.handle.context =3D VMADDR_CID_LOCAL,
		.handle.resource =3D 0,
		.peer =3D 0,
		.flags =3D 0,
		.produce_size =3D 0x7ffe7001,
		.consume_size =3D 0,
		.ppn_va =3D 0,
		.num_ppns =3D 0,
		.result =3D -1,
		.version =3D 0
	};
	syscall(__NR_ioctl, fd, IOCTL_VMCI_QUEUEPAIR_ALLOC, &qp);

	return 0;
}

=2D--
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vm=
ci/vmci_queue_pair.c
index c49065887e8f..997ff32475b2 100644
=2D-- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -526,6 +526,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size=
)
 	struct vmci_queue *queue;
 	size_t queue_page_size;
 	u64 num_pages;
+	unsigned int order;
 	const size_t queue_size =3D sizeof(*queue) + sizeof(*(queue->kernel_if))=
;

 	if (size > SIZE_MAX - PAGE_SIZE)
@@ -537,6 +538,10 @@ static struct vmci_queue *qp_host_alloc_queue(u64 siz=
e)

 	queue_page_size =3D num_pages * sizeof(*queue->kernel_if->u.h.page);

+	order =3D get_order(queue_size + queue_page_size);
+	if (order >=3D MAX_ORDER)
+		return NULL;
+
 	queue =3D kzalloc(queue_size + queue_page_size, GFP_KERNEL);
 	if (queue) {
 		queue->q_header =3D NULL;
=2D-
2.29.2


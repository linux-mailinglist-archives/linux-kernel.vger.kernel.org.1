Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE75C2C172D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgKWVBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:01:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:56145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgKWVBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606165260;
        bh=IS0RDn7I/fqqgn5ezAH0VgxX+Qj4lCLzn3GT9gVwwGs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MTOUm0ttFcKIJGwpZLgGw0eQt5Qw0HrlqFdSoVVWzYD2FRywR1UOoJqdIYhmTySkB
         zxevrp5fj4952+go1hP52ij0AJC58SItkuL3PNnCXYqS6v6A8q5T1GY8/WGji2SVlo
         yqPpiMqbFkQfw741719zPLwvPrq/vqLfEha6sRBU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [94.134.180.30] ([94.134.180.30]) by web-mail.gmx.net
 (3c-app-gmx-bs09.server.lan [172.19.170.60]) (via HTTP); Mon, 23 Nov 2020
 22:01:00 +0100
MIME-Version: 1.0
Message-ID: <trinity-56749cfc-536b-45e2-8e6f-621754c07824-1606165260518@3c-app-gmx-bs09>
From:   Norbert Slusarek <nslusarek@gmx.net>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, jhansen@vmware.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] misc/vmw_vmci: bail out earlier on too big queue
 allocation
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 23 Nov 2020 22:01:00 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:0u99BTHALMGJQKgQxQph/+RQNgGKWsh49lFliUKJgB3JMyxT7odiEYh6qCSeRX4FJoov/
 A0c1cVTtIfl964BRVSwDw0Izu5ygmksmZr6HyQXq5HOqTHn1961zU3U5wl0sGFg7lT68gd4VjveK
 xhQ5oJXMxLQLzJRciUBFQFc44N621vCWbBfplDeh2+UUYb91RyVyu46VcIILJngpO3AwGrM5Bq+E
 cp0Yoh2XT+tfFJkPmadXu67DGKVPy60e1KBGnGCAj49aC87u1B/JvaZLXhwX+DclaLH4cPLTUkkM
 x8=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QBWT62mirHY=:5RbOdBRq09RsMpKCCax/Wm
 4tWL9nQQqTjLq/MzjHXRBwhWLCTeatwCXLeNWF4ACVTn5vUU2RF4r8BD10V5IJdtll1hQ46F1
 HE7r+A1IEtgYLwurBkjHvHVWH0L6lKk4bESBA2S05LLYvr0eydESA4auo2peZ6Z4L1P7cE2Xb
 Qljpkby0UiF0gByEPZnUoIvQpWwQS82lnCrwl2YnM89npEZI8NEDXnQTIeLB4vIdv6hyvCp4t
 vv0Cn9eaN7+51vXimL88sPzmf1DsWtzusV48+22vQQdgOfsCnXUuuogiWIJGgCRviAsAOxKqH
 p+jtvXP1m4150z71FXBsJfeDsoO9ybfoye8161wNSpvH3b5LA75IPOd+RsKMWKhTs1YlkHRbQ
 jHynONVWZK5YX7iipsF82GVg3JFmGxfJjnYxVhhlgP17sheb5Ke2UfyInmF20mIfmee1fKLeN
 ilEGvmLgjWZsJPf/U65ecujduyuvVNlx33SUggbaOTfv2V11nPzrVbCDVldE6yX1uErHTGRmb
 EEAFUp7h9YvYxCjuKhhUfxCFcjbg+4AnHfQqs0SMLgLio6luT4+YKoS5XxGbQO2i8U9M5hSl0
 i9jmkLvb6xBJ8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Norbert Slusarek <nslusarek@gmx.net>
Date: Mon, 23 Nov 2020 21:53:41 +0100
Subject: [PATCH RESEND] misc/vmw_vmci: bail out earlier on too big queue a=
llocation

For the allocation of a queue pair in qp_host_alloc_queue() an arbitrary v=
alue
can be passed for produce_size, which can lead to miscalculation of memory=
 we'd
like to allocate in one take. A warning is triggered at __alloc_pages_node=
mask()
in mm/page_alloc.c:4737 which aborts the false allocation, but it results =
in a
VMware machine freezing for an infinite time.

Signed-off-by: Norbert Slusarek <nslusarek@gmx.net>
=2D--

Resend because of email and formatting issues.

To provide an accurate explanation of the problem, I'll describe my observ=
ations
and include a PoC you can run yourself. The value for produce_size (0x7ffe=
7001)
wasn't chosen randomly, it's the least value which can trigger the warning=
. With
this value, calculations are done in qp_host_alloc_queue() before
calling kzalloc() with queue_size + queue_page_size. The calculation of
queue_size involves taking the size of *queue->kernel_if, which on 5.10-rc=
4 has
the size of 72 bytes and on 5.4.79 it's 168 bytes. While on 5.10-rc4 the s=
ize
argument for kzalloc() won't surpass the maximum value of 4096*1024 for an
individual allocation (for produce_size =3D 0x7ffe7001 -> kzalloc(4194216)=
), it
will be greater on the stable 5.4.79 kernel (for produce_size =3D 0x7ffe70=
01 ->
kzalloc(4194312)). This will ultimately lead to a warning on the stable 5.=
4
kernel, but not on the upstream kernel, so ideally my patch would be backp=
orted
to stable kernels. Eventhough the warning in __alloc_pages_nodemask() alre=
ady
aborts the oversized allocation of memory, VMware will hang for an infinit=
e
time, hence I wanted to provide this simple patch. We shouldn't rely on th=
e page
allocator to abort it anyways, it's better to keep it clean and check for =
a too
large allocation before calling kzalloc(). When I ran the PoC in QEMU and =
on a
host machine, I didn't experience any freezes at all, but the warning gets
triggered.

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

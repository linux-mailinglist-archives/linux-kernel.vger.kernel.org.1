Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588412FE0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbhAUEmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:42:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59004 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbhAUEl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:41:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L4YR4u100352;
        Thu, 21 Jan 2021 04:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=yBNukZT1qBp59XUzso0mgMSL2qpEIBOtEDeURW23gL0=;
 b=aURxsTqmREbzps1uAntJVqSYQN6K89jdl4HE4faMtRKo2581IYgQMi49N+CLyn0Z/21P
 dZHuV28M5YO36IeuJswdCKR1v7NwrHPstgIMxUpeaz8ywh7ckBoWALYCwpCSIgBC10Bk
 w+szW32WLvTxsTqCbWyWrzmPvrglBhevdLGr+jbP2FJJQXaXJzmEC5oXg02eSGQIw3ow
 DWdEQyvCMmXKl7VigsDPD0En23j3nknddGAJfoGglYFL/nI4X76Tp2RGwg4y82M8/W0n
 hQB5EIVQBGfMg8UnC+QxJjVJ6tr6scjKiLLhN8g/onbRYSyv16FZIMT8aygDYf5hvqpk tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3668qmwgaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 04:41:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L4Yk9Q123946;
        Thu, 21 Jan 2021 04:39:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3668qxe831-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 04:39:12 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10L4dBW8018581;
        Thu, 21 Jan 2021 04:39:11 GMT
Received: from localhost.localdomain (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jan 2021 20:39:10 -0800
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     bbhushan2@marvell.com, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        ankur.a.arora@oracle.com, terminus@gmail.com
Subject: Re: vfio-pci: protect remap_pfn_range() from simultaneous calls
Date:   Wed, 20 Jan 2021 20:39:07 -0800
Message-Id: <20210121043907.76037-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <MWHPR18MB1520D43B19368D8D84360248E3A31@MWHPR18MB1520.namprd18.prod.outlook.com>
References: <MWHPR18MB1520D43B19368D8D84360248E3A31@MWHPR18MB1520.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

So I don't have a final patch for you, but can you test the one below
the scissors mark? (The patch is correct, but I'm not happy that it
introduces a new lock.)

Ankur

-- >8 --

Date: Thu, 21 Jan 2021 00:04:36 +0000
Subject: vfio-pci: protect io_remap_pfn_range() from simultaneous calls

A fix for CVE-2020-12888 changed the mmap to be dynamic so it gets
zapped out and faulted back in based on the state of the PCI_COMMAND
register.

The original code flow was:

  vfio_iommu_type1::vfio_device_mmap()
    vfio_pci::vfio_pci_mmap()
      remap_pfn_range(vma->vm_start .. vma->vm_end);

  vfio_iommu_type1::vfio_iommu_type1_ioctl(VFIO_PIN_MAP_DMA)
    get_user_pages_remote()
    iommu_map()

Which became:

  vfio_iommu_type1::vfio_device_mmap()
    vfio_pci::vfio_pci_mmap()
     /* Setup vm->vm_ops */

  vfio_iommu_type1::vfio_iommu_type1_ioctl(VFIO_PIN_MAP_DMA)
    get_user_pages_remote()
      follow_fault_pfn(vma, vaddr); /* For missing pages */
        fixup_user_fault()
          handle_mm_fault()
            vfio_pci::vfio_pci_mmap_fault()
              io_remap_pfn_range(vma->vm_start .. vma->vm_end);
    iommu_map()

With this, simultaneous calls to VFIO_PIN_MAP_DMA for an overlapping
region, would mean potentially multiple calls to io_remap_pfn_range()
-- each of which try to remap the full extent.

This ends up hitting BUG_ON(!pte_none(*pte)) in remap_pte_range()
because we are mapping an already mapped pte.

The fix is to elide calls to io_remap_pfn_range() if the VMA is already
mapped.

Fixes: abafbc551fdd ("vfio-pci: Invalidate mmaps and block MMIO access
on disabled memory")

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/vfio/pci/vfio_pci.c         | 48 ++++++++++++++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_private.h |  2 ++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 706de3ef94bb..db7a2a716f51 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -64,6 +64,11 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+struct vdev_vma_priv {
+	struct vfio_pci_device *vdev;
+	bool vma_mapped;
+};
+
 static inline bool vfio_vga_disabled(void)
 {
 #ifdef CONFIG_VFIO_PCI_VGA
@@ -1527,15 +1532,20 @@ static int vfio_pci_zap_and_vma_lock(struct vfio_pci_device *vdev, bool try)
 		list_for_each_entry_safe(mmap_vma, tmp,
 					 &vdev->vma_list, vma_next) {
 			struct vm_area_struct *vma = mmap_vma->vma;
+			struct vdev_vma_priv *p;
 
 			if (vma->vm_mm != mm)
 				continue;
 
 			list_del(&mmap_vma->vma_next);
 			kfree(mmap_vma);
+			p = vma->vm_private_data;
 
+			mutex_lock(&vdev->map_lock);
 			zap_vma_ptes(vma, vma->vm_start,
 				     vma->vm_end - vma->vm_start);
+			p->vma_mapped = false;
+			mutex_unlock(&vdev->map_lock);
 		}
 		mutex_unlock(&vdev->vma_lock);
 		mmap_read_unlock(mm);
@@ -1591,12 +1601,19 @@ static int __vfio_pci_add_vma(struct vfio_pci_device *vdev,
  */
 static void vfio_pci_mmap_open(struct vm_area_struct *vma)
 {
+	struct vdev_vma_priv *p = vma->vm_private_data;
+	struct vfio_pci_device *vdev = p->vdev;
+
+	mutex_lock(&vdev->map_lock);
+	p->vma_mapped = false;
 	zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
+	mutex_unlock(&vdev->map_lock);
 }
 
 static void vfio_pci_mmap_close(struct vm_area_struct *vma)
 {
-	struct vfio_pci_device *vdev = vma->vm_private_data;
+	struct vdev_vma_priv *p = vma->vm_private_data;
+	struct vfio_pci_device *vdev = p->vdev;
 	struct vfio_pci_mmap_vma *mmap_vma;
 
 	mutex_lock(&vdev->vma_lock);
@@ -1604,6 +1621,7 @@ static void vfio_pci_mmap_close(struct vm_area_struct *vma)
 		if (mmap_vma->vma == vma) {
 			list_del(&mmap_vma->vma_next);
 			kfree(mmap_vma);
+			kfree(p);
 			break;
 		}
 	}
@@ -1613,7 +1631,8 @@ static void vfio_pci_mmap_close(struct vm_area_struct *vma)
 static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct vfio_pci_device *vdev = vma->vm_private_data;
+	struct vdev_vma_priv *p = vma->vm_private_data;
+	struct vfio_pci_device *vdev = p->vdev;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
 
 	mutex_lock(&vdev->vma_lock);
@@ -1633,10 +1652,24 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 
 	mutex_unlock(&vdev->vma_lock);
 
+	/*
+	 * The vdev->map_lock in vfio_pci_zap_and_vma_lock() nests
+	 * inside the vdev->vma_lock but doesn't depend on that for
+	 * protection of the VMA.
+	 * So take vdev->map_lock after releasing vdev->vma_lock.
+	 */
+	mutex_lock(&vdev->map_lock);
+	if (p->vma_mapped)
+		goto unlock_out;
+
 	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		ret = VM_FAULT_SIGBUS;
+	else
+		p->vma_mapped = true;
 
+unlock_out:
+	mutex_unlock(&vdev->map_lock);
 up_out:
 	up_read(&vdev->memory_lock);
 	return ret;
@@ -1654,6 +1687,7 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	struct pci_dev *pdev = vdev->pdev;
 	unsigned int index;
 	u64 phys_len, req_len, pgoff, req_start;
+	struct vdev_vma_priv *priv;
 	int ret;
 
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
@@ -1702,7 +1736,14 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 		}
 	}
 
-	vma->vm_private_data = vdev;
+	priv = kzalloc(sizeof(struct vdev_vma_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->vdev = vdev;
+	priv->vma_mapped = false;
+
+	vma->vm_private_data = priv;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
 
@@ -1967,6 +2008,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_LIST_HEAD(&vdev->dummy_resources_list);
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
 	mutex_init(&vdev->vma_lock);
+	mutex_init(&vdev->map_lock);
 	INIT_LIST_HEAD(&vdev->vma_list);
 	init_rwsem(&vdev->memory_lock);
 
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 5c90e560c5c7..f3010c49b06c 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -142,6 +142,8 @@ struct vfio_pci_device {
 	struct mutex		vma_lock;
 	struct list_head	vma_list;
 	struct rw_semaphore	memory_lock;
+	/* Protects VMA against simultaneous remaps. */
+	struct mutex		map_lock;
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
-- 
2.9.3


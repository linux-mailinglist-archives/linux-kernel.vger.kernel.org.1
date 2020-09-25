Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F12E27928C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgIYUpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:45:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:13951 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgIYUpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:45:39 -0400
IronPort-SDR: TRCJ1dYE7ykJcxzh5YyeQwJfVuIoasQiveXSpQlj/D35p13+yIRwnBOOQMANoUZEsa2EgKLDk4
 KyjgmmKnmF7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="223215134"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="223215134"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:00 -0700
IronPort-SDR: y/5TfPWHk/8Hzw/AbD1aVTu5a2nWwqjoPjcd88tCruatdGVYbHGCzI0P3Yd+oT8ukDm4vRpe5E
 TuzfWGzOQvaA==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="487581711"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:00 -0700
Subject: [PATCH v5 00/17] device-dax: support sub-dividing soft-reserved
 ranges
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Vivek Goyal <vgoyal@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Hulk Robot <hulkci@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jia He <justin.he@arm.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jason Yan <yanaijie@huawei.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Juergen Gross <jgross@suse.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 12:11:39 -0700
Message-ID: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 [1]:
- Rebased on
  device-dax-move-instance-creation-parameters-to-struct-dev_dax_data.patch
  in -mm [2]. I.e. patches that did not need fixups from v4 are not
  included.

- Folded all fixes

- Replaced "device-dax: kill dax_kmem_res" with:

      device-dax/kmem: introduce dax_kmem_range()
      device-dax/kmem: move resource name tracking to drvdata
      device-dax/kmem: replace release_resource() with release_mem_region()

  ...to address David's request to make those cleanups easier to review.
  Note that I dropped changes to how IORESOURCE_BUSY is manipulated since
  David and I are still debating the best way forward there.

- Broke out some of dax-bus reworks in "device-dax: introduce 'seed'
  devices" to a new "device-dax: introduce 'struct dev_dax' typed-driver
  operations"

- Added a conversion of xen_alloc_unallocated_pages() from pgmap.res to
  pgmap.range. I found it odd that there is no corresponding
  memunmap_pages() triggered by xen_free_unallocated_pages()?

- Not included, a conversion of virtio_fs to use pgmap.range for its new
  usage of devm_memremap_pages(). It appears the virtio_fs changes are
  merged after -mm? My mental model of -mm was that it applies on top of
  linux-next? In any event, Vivek, you will need to coordinate a
  conversion to pgmap.range for the virtio_fs dax-support merge. Maybe
  that should go through Andrew as well?

- Lowercase all the subject lines per akpm's preference

- Received a 0day robot build-success notification over 122 configs

- Thanks to Joao for looking after this set while I was out.

[1]: http://lore.kernel.org/r/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com
[2]: https://ozlabs.org/~akpm/mmots/broken-out/device-dax-move-instance-creation-parameters-to-struct-dev_dax_data.patch

---

Andrew, this series replaces

device-dax-make-pgmap-optional-for-instance-creation.patch

...through...

dax-hmem-introduce-dax_hmemregion_idle-parameter.patch

...in your stack.

Let me know if there is a different / preferred way to refresh a bulk of
patches in your queue when only a subset need updates.

---

The device-dax facility allows an address range to be directly mapped
through a chardev, or optionally hotplugged to the core kernel page
allocator as System-RAM. It is the mechanism for converting persistent
memory (pmem) to be used as another volatile memory pool i.e. the
current Memory Tiering hot topic on linux-mm.

In the case of pmem the nvdimm-namespace-label mechanism can sub-divide
it, but that labeling mechanism is not available / applicable to
soft-reserved ("EFI specific purpose") memory [3]. This series provides
a sysfs-mechanism for the daxctl utility to enable provisioning of
volatile-soft-reserved memory ranges.

The motivations for this facility are:

1/ Allow performance differentiated memory ranges to be split between
   kernel-managed and directly-accessed use cases.

2/ Allow physical memory to be provisioned along performance relevant
   address boundaries. For example, divide a memory-side cache [4] along
   cache-color boundaries.

3/ Parcel out soft-reserved memory to VMs using device-dax as a security
   / permissions boundary [5]. Specifically I have seen people (ab)using
   memmap=nn!ss (mark System-RAM as Persistent Memory) just to get the
   device-dax interface on custom address ranges. A follow-on for the VM
   use case is to teach device-dax to dynamically allocate 'struct page' at
   runtime to reduce the duplication of 'struct page' space in both the
   guest and the host kernel for the same physical pages.

[3]: http://lore.kernel.org/r/157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com
[4]: http://lore.kernel.org/r/154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com
[5]: http://lore.kernel.org/r/20200110190313.17144-1-joao.m.martins@oracle.com

---

Dan Williams (14):
      device-dax: make pgmap optional for instance creation
      device-dax/kmem: introduce dax_kmem_range()
      device-dax/kmem: move resource name tracking to drvdata
      device-dax/kmem: replace release_resource() with release_mem_region()
      device-dax: add an allocation interface for device-dax instances
      device-dax: introduce 'struct dev_dax' typed-driver operations
      device-dax: introduce 'seed' devices
      drivers/base: make device_find_child_by_name() compatible with sysfs inputs
      device-dax: add resize support
      mm/memremap_pages: convert to 'struct range'
      mm/memremap_pages: support multiple ranges per invocation
      device-dax: add dis-contiguous resource support
      device-dax: introduce 'mapping' devices
      device-dax: add an 'align' attribute

Joao Martins (3):
      device-dax: make align a per-device property
      dax/hmem: introduce dax_hmem.region_idle parameter
      device-dax: add a range mapping allocation attribute


 arch/powerpc/kvm/book3s_hv_uvmem.c     |   14 
 drivers/base/core.c                    |    2 
 drivers/dax/bus.c                      | 1039 ++++++++++++++++++++++++++++++--
 drivers/dax/bus.h                      |   11 
 drivers/dax/dax-private.h              |   58 ++
 drivers/dax/device.c                   |  112 ++-
 drivers/dax/hmem/hmem.c                |   17 -
 drivers/dax/kmem.c                     |  178 +++--
 drivers/dax/pmem/compat.c              |    2 
 drivers/dax/pmem/core.c                |   14 
 drivers/gpu/drm/nouveau/nouveau_dmem.c |   15 
 drivers/nvdimm/badrange.c              |   26 -
 drivers/nvdimm/claim.c                 |   13 
 drivers/nvdimm/nd.h                    |    3 
 drivers/nvdimm/pfn_devs.c              |   13 
 drivers/nvdimm/pmem.c                  |   27 -
 drivers/nvdimm/region.c                |   21 -
 drivers/pci/p2pdma.c                   |   12 
 drivers/xen/unpopulated-alloc.c        |   45 +
 include/linux/memremap.h               |   11 
 include/linux/range.h                  |    6 
 lib/test_hmm.c                         |   15 
 mm/memremap.c                          |  299 +++++----
 tools/testing/nvdimm/dax-dev.c         |   22 -
 tools/testing/nvdimm/test/iomap.c      |    2 
 25 files changed, 1557 insertions(+), 420 deletions(-)

base-commit: 6764736525f27a411ba2c0c430aaa2df7375f3ac

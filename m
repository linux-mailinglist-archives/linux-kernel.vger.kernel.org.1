Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E672528E995
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgJOBAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:00:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:43909 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgJOBAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:00:34 -0400
IronPort-SDR: Jj5xuFm6ONh3n12DEH1PRP8JvdUvkxXPxo4P5+ynEpI9Uf5U2xw1LNFKRE3BRA7z9NEP+ni5oL
 F923Hxwf+/6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="227879368"
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400"; 
   d="scan'208";a="227879368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 18:00:33 -0700
IronPort-SDR: KS3Q2MPMmR4hzA6BX3wFA5W4ZTgE4BVgWBtN9d6K0JraXbAetqre2n+FMuEAQ3xYV6F7MwO/RB
 ken2QsQHin7A==
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400"; 
   d="scan'208";a="531053664"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 18:00:33 -0700
Subject: [PATCH 0/2] device-dax subdivision v5 to v6 fixups
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, Jia He <justin.he@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        akpm@linux-foundation.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org
Date:   Wed, 14 Oct 2020 17:42:04 -0700
Message-ID: <160272252400.3136502.13635752844548960833.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The v5 series of the device-dax-subdivision series landed upstream which
missed some of the late breaking fixups in v6 [1]. The Xen one is
cosmetic, the kmem one is a functional problem. I will handle the kmem
in a device-dax follow-on pull request post-rc1. The Xen one can go
through the Xen tree at its own pace.

My thanks to Andrew for wrangling the thrash up to v5, and my apologies
to Andrew et al for not highlighting this gap sooner.

[1]: http://lore.kernel.org/r/160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com

---

Dan Williams (2):
      device-dax/kmem: Fix resource release
      xen/unpopulated-alloc: Consolidate pgmap manipulation


 drivers/dax/kmem.c              |   48 ++++++++++++++++++++++++++++-----------
 drivers/xen/unpopulated-alloc.c |   14 ++++++-----
 2 files changed, 41 insertions(+), 21 deletions(-)

base-commit: 4da9af0014b51c8b015ed8c622440ef28912efe6

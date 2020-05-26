Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76BD1D8C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 02:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgESAV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 20:21:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9194 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgESAV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:21:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec325f90001>; Mon, 18 May 2020 17:19:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 17:21:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 May 2020 17:21:27 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 00:21:26 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 May 2020 00:21:26 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.55.90]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec326850001>; Mon, 18 May 2020 17:21:25 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/4] mm/gup, drm/i915: refactor gup_fast, convert to pin_user_pages()
Date:   Mon, 18 May 2020 17:21:20 -0700
Message-ID: <20200519002124.2025955-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589847545; bh=1lNBScctJydku+3qdXzIM8KVklxinSyJ9aQap+4RKHU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=d8/4HFn9ZUARS86BznlNTVIHyfbSi1m+F4pm1l5haXjy+vhXCgsMz4/xCOcVLezCF
         xMWFQ2d/tT5p23YZWaKhH7BcbcYBMiVijTdCBTGiO1/8z5jcLB20qJUVoujCQFg2MG
         iCSLwXt0K3zVZ4uCfFOIONfV1xrwV6SLP9cskkG8zh0ajLTf2IOX0GtRQ5cyaMpXs9
         ajGwwcTVJnUkPJpMwar401mjYDKd46PXQ01hjKGPP8VDS/Az3nqyxYswzRAKFnLFBN
         cnje3+tnXgVji4aCd18GlNlCWLYQyHzjcn/rsWTSxnmDj/bHgssbfrq41SSoyOOg8K
         rWxduGVnAqdUw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This needs to go through Andrew's -mm tree, due to adding a new gup.c
routine. However, I would really love to have some testing from the
drm/i915 folks, because I haven't been able to run-time test that part
of it.

Otherwise, though, the series has passed my basic run time testing:
some LTP tests, some xfs and etx4 non-destructive xfstests, and an
assortment of other smaller ones: vm selftests, io_uring_register, a
few more. But that's only on one particular machine. Also, cross-compile
tests for half a dozen arches all pass.

Details:

In order to convert the drm/i915 driver from get_user_pages() to
pin_user_pages(), a FOLL_PIN equivalent of __get_user_pages_fast() was
required. That led to refactoring __get_user_pages_fast(), with the
following goals:

1) As above: provide a pin_user_pages*() routine for drm/i915 to call,
   in place of __get_user_pages_fast(),

2) Get rid of the gup.c duplicate code for walking page tables with
   interrupts disabled. This duplicate code is a minor maintenance
   problem anyway.

3) Make it easy for an upcoming patch from Souptick, which aims to
   convert __get_user_pages_fast() to use a gup_flags argument, instead
   of a bool writeable arg.  Also, if this series looks good, we can
   ask Souptick to change the name as well, to whatever the consensus
   is. My initial recommendation is: get_user_pages_fast_only(), to
   match the new pin_user_pages_only().

John Hubbard (4):
  mm/gup: move __get_user_pages_fast() down a few lines in gup.c
  mm/gup: refactor and de-duplicate gup_fast() code
  mm/gup: introduce pin_user_pages_fast_only()
  drm/i915: convert get_user_pages() --> pin_user_pages()

 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  22 +--
 include/linux/mm.h                          |   3 +
 mm/gup.c                                    | 150 ++++++++++++--------
 3 files changed, 107 insertions(+), 68 deletions(-)


base-commit: 642b151f45dd54809ea00ecd3976a56c1ec9b53d
--=20
2.26.2


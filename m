Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3C285370
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgJFUvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:51:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:19137 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbgJFUvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:51:11 -0400
IronPort-SDR: ZhAjQPtXEp7AhraDP0n8Wk0e+9ZiIy7tjkVsW4NmaUCZqezHWC5kw5xXn5eyqKbCBp27yZ6up1
 iHlVSxhwZY7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="152454171"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="152454171"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 13:51:08 -0700
IronPort-SDR: 6MRuPVv54ufhdqMKoRfgdP755q19MLAqZ7dy+90lhG8ZFdp0YZpjBX2Y3q62KmXwHWiwM959PQ
 uoWjHZKWSioA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="297299459"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2020 13:51:07 -0700
Subject: [RFC][PATCH 00/12] mm: tweak page cache migration
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, npiggin@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org,
        yang.shi@linux.alibaba.com, linux-mm@kvack.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 06 Oct 2020 13:51:03 -0700
Message-Id: <20201006205103.268F74A9@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, I think this little slice of code is a bit
under-documented.  Perhaps this will help clarify things.

I'm pretty confident the page_count() check in the first
patch is right, which is why I removed it outright.  The
xas_load() check is a bit murkier, so I just left a
warning in for it.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9EB2748FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIVTWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:22:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:65154 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgIVTWC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:22:02 -0400
IronPort-SDR: F5hTQwBDy2fDyO9W6VhOPiOLquECHfQ6B3r/IvN/j59uuv7BU23J71NJj1KQsa/DF6cYLMe9FX
 dPoxp+oyHZTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="161629257"
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="161629257"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 12:22:02 -0700
IronPort-SDR: rz+ca7oucet3OHRxohSiDugDpNelsjl8XXIahXMblWa7CoVQE44F4OiZsUEm80keEpdnAKUYJ3
 5xbA3gw+VK2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="291405671"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2020 12:22:01 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A5850301C71; Tue, 22 Sep 2020 12:22:01 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:22:01 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com, irogers@google.com
Subject: Re: [PATCH v2 0/2] perf: Update CascadelakeX and SkylakeX events list
Message-ID: <20200922192201.GK13818@tassilo.jf.intel.com>
References: <20200922031918.3723-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922031918.3723-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:19:16AM +0800, Jin Yao wrote:
> This patchset updates CascadelakeX events to v1.08 and
> updates SkylakeX events to v1.21.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi

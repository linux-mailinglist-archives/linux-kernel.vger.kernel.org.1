Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78CF1A7B95
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 15:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgDNNAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 09:00:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:61668 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgDNNAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:00:42 -0400
IronPort-SDR: 4Xq0y84i5ZmR/PgeGpEJ8uQGKRHQdpaU5QAW3WGFZI2IYk0eHWhE9SPN6WGLY5WMg43VFJn3nM
 l3MZ49UTIQiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 06:00:41 -0700
IronPort-SDR: PK96sqppHm6BAZTp40dXNxiwYyTHsXkBs6S3+wEg2PS5uKVCQkdl5DIEu5DvD/I6kRDZUhiNs5
 EpLLBuWoiZ3w==
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="427052761"
Received: from mdoerbec-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 06:00:39 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/dp_mst: Fix drm_dp_mst_topology.c selftest compilation warning
In-Reply-To: <ba9202f9-0373-52e7-9d74-4997e33c516d@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200411141740.14584-1-tangbin@cmss.chinamobile.com> <CADnq5_MD6LkOEJC-hKKQSAmFAHY7LMZ2WU_ER-ttNrP20AxoQA@mail.gmail.com> <87imi2miin.fsf@intel.com> <ba9202f9-0373-52e7-9d74-4997e33c516d@cmss.chinamobile.com>
Date:   Tue, 14 Apr 2020 16:00:36 +0300
Message-ID: <877dyimdcb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Tang Bin <tangbin@cmss.chinamobile.com> wrote:
> But someone may query '{}' could not initialize all members, that's
> why I brought '{{{0}}}' up.

{} *does* initialize everything. What are you trying to say?

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center

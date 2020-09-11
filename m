Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAB8266487
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIKQl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:41:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:32704 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgIKQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:40:30 -0400
IronPort-SDR: HEfobIYvM7EQipZ+6QxkpE877s6lu1nkZiLC4ZUayyMQHk4X4xqzCmKBmptRFrswnF84O+E3yO
 fv6NyjCexV4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="159742168"
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="159742168"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 09:40:29 -0700
IronPort-SDR: Yo4I+JHPTOnjKkF7m+329KqmbrdZbZf42SVGZO267ovvixjdSnfm7CZjTE+egKfZ35jWrQjJdc
 oukEO+OsuYNg==
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="450043558"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 09:40:29 -0700
Date:   Fri, 11 Sep 2020 09:40:26 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: use libata instead of the legacy ide driver in
 defconfigs
Message-ID: <20200911164026.GB828@agluck-desk2.amr.corp.intel.com>
References: <20200911094936.1175688-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911094936.1175688-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 11:49:36AM +0200, Christoph Hellwig wrote:
> Switch the ia64 defconfigs to use the modern libata driver instead of
> the soon to be removed legacy ide driver.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied. Thanks

-Tony

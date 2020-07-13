Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A3E21A656
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 19:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGIRwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 13:52:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:47565 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgGIRwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:52:53 -0400
IronPort-SDR: 5U4mr9v5WqFBt9Q7z1uswsyF5jUSIbkYdRqRcYruHlQ9M1JxVDUqmrpEMG4TaJoQbT3zsncYX0
 C7HTbtDgCtKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="128131382"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="128131382"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:52:53 -0700
IronPort-SDR: VsMY2V+hoYriJZJOwUyX0lNdMfiJhAZQIoyh88g+sBZmnw2zAxsfuy9aMVZnihDPPKKQgZvuYd
 OjWZd5kIVXaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="268816948"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2020 10:52:52 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DD7B0301B2A; Thu,  9 Jul 2020 10:52:52 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:52:52 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] perf auxtrace: Add itrace 'q' option for quicker,
 less detailed decoding
Message-ID: <20200709175252.GC1126680@tassilo.jf.intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
 <20200709173628.5613-10-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709173628.5613-10-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +	If supported, the 'q' option may be repeated to increase the effect.

Need better documentation here. What does it mean for PT?


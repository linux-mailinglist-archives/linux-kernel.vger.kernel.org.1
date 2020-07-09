Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEE221A658
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 19:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGIRzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 13:55:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:4379 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgGIRzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:55:07 -0400
IronPort-SDR: c5PpCyyLozX85SPI9Le2JtdYHlzxLLjO4Kqc/x3HUeoH/dgiRa0xFaEqjU5C9ekYRBETUEttNW
 vhQSnaipHnQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="136281326"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="136281326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:55:06 -0700
IronPort-SDR: TSX+R5NfD0uP8yiNp7U2VYqamMQ1OUp+j1OeoxRI0tTHwiWWnVsZR6kzUrM4zf86/E40BadnZa
 vPhXbnkR6YRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="323303320"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2020 10:55:06 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 47142301B2A; Thu,  9 Jul 2020 10:55:06 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:55:06 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] perf intel-pt: Add support for decoding FUP/TIP
 only
Message-ID: <20200709175506.GD1126680@tassilo.jf.intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
 <20200709173628.5613-11-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709173628.5613-11-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 08:36:27PM +0300, Adrian Hunter wrote:
> +The q option does not decode TNT packets, and does not walk object code, but
> +gets the ip from FUP and TIP packets.  The q option can be used with the b and i
> +options but the period is not used.  The q option decodes more quickly, but is
> +useful only if the control flow of interest is represented or indicated by FUP,
> +TIP, TIP.PGE, or TIP.PGD packets.  However the q option could be used to find
> +time ranges that could then be decoded fully using the --time option.

Ah ok the documentation is here. Ignore previous suggestion.

Can you describe the effect in a high level without referring to packet names?

The user may not be familar with them.

So two qs will be PSB only decoding I hope?

-Andi



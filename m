Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9EE24AD6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 05:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHTDpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 23:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHTDpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:45:43 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF00B2078B;
        Thu, 20 Aug 2020 03:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597895143;
        bh=T1vQebJsoBRqHO3+NwQVF50ZvFopAiB6Kd6Ov1R16GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQ3VRVB326vzAgsOF5FG+wpRyVnXx466Dz8HAqWvGnsHXlitWdkRwUClhZBNYJbwY
         G4xCwKnek5kRRMizDBwosfwHYCzJIyECD6GiJrI905muO3LMrbt915WKazYRz1muXq
         WVS5iNPDwXSTFUGkvO6yyQJ8tCwSFzIXYZeQwS/4=
Date:   Thu, 20 Aug 2020 12:45:39 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     David Fugate <david.fugate@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        david.fugate@intel.com
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820034539.GA12222@redsun51.ssa.fujisawa.hgst.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
 <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
 <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 05:43:29PM -0600, David Fugate wrote:
> There were queries? My key takeaways were a maintainer NAK followed by
> instructions to make the Intel drive align with the driver by
> implementing NOIOB. While I disagree with the rejection as it appeared
> to be based entirely on politics, I can accept it as the quirk wasn't
> in the spec.

For the record, the suggestion provided, which you agreed to look into,
most broadly enables your hardware on Linux and was entirely to your
benefit. Not quite as dramatic as a political conspiracy.

You later responded with a technical argument against that suggestion;
however, your reason didn't add up, and that's where you left the
thread.
 
> It's not fair to make this same "your drive should align with the
> driver" demand of Samsung because we *are* talking about a spec'ed
> feature here. Technical critques of their patches and real performance
> degrades observed are fair game and objective; "your company did
> the nastiest possible move violating the normal NVMe procedures to make
> it optional" is not.

Sure, but you're cherry picking comments from the discussion. The
performance impact exists, and it's generally not acceptable from a
maintenance point to duplicate significant code without at least trying
to provide a common solution. 

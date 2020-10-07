Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0267285AC1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgJGIpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:45:14 -0400
Received: from gentwo.org ([3.19.106.255]:50500 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgJGIpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:45:12 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 36BF23F0D9; Wed,  7 Oct 2020 08:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 34D473EC1B;
        Wed,  7 Oct 2020 08:45:10 +0000 (UTC)
Date:   Wed, 7 Oct 2020 08:45:10 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, ben.widawsky@intel.com,
        rientjes@google.com, alex.shi@linux.alibaba.com, dwagner@suse.de,
        tobin@kernel.org, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw, stable@vger.kernel.org
Subject: Re: [RFC][PATCH 01/12] mm/vmscan: restore zone_reclaim_mode ABI
In-Reply-To: <20201006205106.52F4D02E@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.22.394.2010070843540.113351@www.lameter.com>
References: <20201006205103.268F74A9@viggo.jf.intel.com> <20201006205106.52F4D02E@viggo.jf.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020, Dave Hansen wrote:

> But, when the bit was removed (bit 0) the _other_ bit locations also
> got changed.  That's not OK because the bit values are documented to
> mean one specific thing and users surely rely on them meaning that one
> thing and not changing from kernel to kernel.  The end result is that
> if someone had a script that did:

Exactly right. Sorry must have missed to review that patch.

Acked-by: Christoph Lameter <cl@linux.com>


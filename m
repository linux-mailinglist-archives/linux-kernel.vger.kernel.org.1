Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E54285B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgJGIrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:47:15 -0400
Received: from gentwo.org ([3.19.106.255]:50540 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbgJGIrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:47:13 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id C22353F463; Wed,  7 Oct 2020 08:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id C10D83EC1B;
        Wed,  7 Oct 2020 08:47:11 +0000 (UTC)
Date:   Wed, 7 Oct 2020 08:47:11 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, ben.widawsky@intel.com,
        alex.shi@linux.alibaba.com, tobin@kernel.org,
        akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw, dwagner@suse.de
Subject: Re: [RFC][PATCH 03/12] mm/vmscan: replace implicit RECLAIM_ZONE
 checks with explicit checks
In-Reply-To: <20201006205110.1E03E385@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.22.394.2010070845550.113351@www.lameter.com>
References: <20201006205103.268F74A9@viggo.jf.intel.com> <20201006205110.1E03E385@viggo.jf.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020, Dave Hansen wrote:

> These zero checks are not great because it is not obvious what a zero
> mode *means* in the code.  Replace them with a helper which makes it
> more obvious: node_reclaim_enabled().

Well it uselessly checks bits. But whatever. It will prevent future code
removal.

Acked-by: Christoph Lameter <cl@linux.com>

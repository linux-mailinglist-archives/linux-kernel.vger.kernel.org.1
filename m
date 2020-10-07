Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5087E285ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgJGIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:45:53 -0400
Received: from gentwo.org ([3.19.106.255]:50524 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgJGIpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:45:52 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 74BE93F0F8; Wed,  7 Oct 2020 08:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 73CA33EC1B;
        Wed,  7 Oct 2020 08:45:52 +0000 (UTC)
Date:   Wed, 7 Oct 2020 08:45:52 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, ben.widawsky@intel.com,
        rientjes@google.com, alex.shi@linux.alibaba.com, dwagner@suse.de,
        tobin@kernel.org, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
Subject: Re: [RFC][PATCH 02/12] mm/vmscan: move RECLAIM* bits to uapi
 header
In-Reply-To: <20201006205108.ADF7B6F2@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.22.394.2010070845140.113351@www.lameter.com>
References: <20201006205103.268F74A9@viggo.jf.intel.com> <20201006205108.ADF7B6F2@viggo.jf.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020, Dave Hansen wrote:

> It is currently not obvious that the RECLAIM_* bits are part of the
> uapi since they are defined in vmscan.c.  Move them to a uapi header
> to make it obvious.

Acked-by: Christoph Lameter <cl@linux.com>


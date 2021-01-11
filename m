Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFDC2F223A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbhAKVxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:53:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:60306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAKVxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:53:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4C3BAB92;
        Mon, 11 Jan 2021 21:52:26 +0000 (UTC)
Date:   Mon, 11 Jan 2021 13:52:19 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v7 09/18] virt: acrn: Introduce I/O request management
Message-ID: <20210111215219.l44yfpyqh4m2mcbl@offworld>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
 <20210106075055.47226-10-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210106075055.47226-10-shuo.a.liu@intel.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jan 2021, shuo.a.liu@intel.com wrote:
>The processing flow of I/O requests are listed as following:
>
>a) The I/O handler of the hypervisor will fill an I/O request with
>   PENDING state when a trapped I/O access happens in a User VM.
>b) The hypervisor makes an upcall, which is a notification interrupt, to
>   the Service VM.
>c) The upcall handler schedules a tasklet to dispatch I/O requests.
>d) The tasklet looks for the PENDING I/O requests, assigns them to
>   different registered clients based on the address of the I/O accesses,
>   updates their state to PROCESSING, and notifies the corresponding
>   client to handle.

Hmm so tasklets are deprecated (and have been for a while) and it's sad
to see incoming new users in modern Linux. This wouldn't be the first one,
however. We should be _removing_ users, not adding... In addition, this
expands the whole tasklet_disable/enable() hacks.

Could this not be done in process context instead?

Thanks,
Davidlohr

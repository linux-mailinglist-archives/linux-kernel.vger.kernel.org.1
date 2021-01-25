Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABEB302140
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbhAYEjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:39:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:53212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbhAYEjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:39:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC1E7AF1E;
        Mon, 25 Jan 2021 04:38:20 +0000 (UTC)
Date:   Sun, 24 Jan 2021 20:38:11 -0800
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
Subject: Re: [PATCH v8 09/18] virt: acrn: Introduce I/O request management
Message-ID: <20210125043811.4vqtgfuok2dvwvxo@offworld>
References: <20210122110122.45800-1-shuo.a.liu@intel.com>
 <20210122110122.45800-10-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210122110122.45800-10-shuo.a.liu@intel.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021, shuo.a.liu@intel.com wrote:

>From: Shuo Liu <shuo.a.liu@intel.com>
>
>An I/O request of a User VM, which is constructed by the hypervisor, is
>distributed by the ACRN Hypervisor Service Module to an I/O client
>corresponding to the address range of the I/O request.
>
>For each User VM, there is a shared 4-KByte memory region used for I/O
>requests communication between the hypervisor and Service VM. An I/O
>request is a 256-byte structure buffer, which is 'struct
>acrn_io_request', that is filled by an I/O handler of the hypervisor
>when a trapped I/O access happens in a User VM. ACRN userspace in the
>Service VM first allocates a 4-KByte page and passes the GPA (Guest
>Physical Address) of the buffer to the hypervisor. The buffer is used as
>an array of 16 I/O request slots with each I/O request slot being 256
>bytes. This array is indexed by vCPU ID.
>
>An I/O client, which is 'struct acrn_ioreq_client', is responsible for
>handling User VM I/O requests whose accessed GPA falls in a certain
>range. Multiple I/O clients can be associated with each User VM. There
>is a special client associated with each User VM, called the default
>client, that handles all I/O requests that do not fit into the range of
>any other I/O clients. The ACRN userspace acts as the default client for
>each User VM.
>
>The state transitions of a ACRN I/O request are as follows.
>
>   FREE -> PENDING -> PROCESSING -> COMPLETE -> FREE -> ...
>
>FREE: this I/O request slot is empty
>PENDING: a valid I/O request is pending in this slot
>PROCESSING: the I/O request is being processed
>COMPLETE: the I/O request has been processed
>
>An I/O request in COMPLETE or FREE state is owned by the hypervisor. HSM
>and ACRN userspace are in charge of processing the others.
>
>The processing flow of I/O requests are listed as following:
>
>a) The I/O handler of the hypervisor will fill an I/O request with
>   PENDING state when a trapped I/O access happens in a User VM.
>b) The hypervisor makes an upcall, which is a notification interrupt, to
>   the Service VM.
>c) The upcall handler schedules a worker to dispatch I/O requests.
>d) The worker looks for the PENDING I/O requests, assigns them to
>   different registered clients based on the address of the I/O accesses,
>   updates their state to PROCESSING, and notifies the corresponding
>   client to handle.
>e) The notified client handles the assigned I/O requests.
>f) The HSM updates I/O requests states to COMPLETE and notifies the
>   hypervisor of the completion via hypercalls.
>
>Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
>Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>Cc: Zhi Wang <zhi.a.wang@intel.com>
>Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>Cc: Yu Wang <yu1.wang@intel.com>
>Cc: Reinette Chatre <reinette.chatre@intel.com>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Davidlohr Bueso <dave@stgolabs.net>

Thanks for respinning this with a workqueue.

Acked-by: Davidlohr Bueso <dbueso@suse.de>

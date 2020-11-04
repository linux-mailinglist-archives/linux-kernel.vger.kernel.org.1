Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06572A6D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgKDTC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgKDTBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:01:45 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43999206D9;
        Wed,  4 Nov 2020 19:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604516505;
        bh=cTiGqgqGpsKodqEvibMS49L3xkyozODpNheifT9AKdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkJ31z5D7eaYLl6h8W93tCy20DDgfBYHC6f1dozo3hhtKvFx+bKzME29n2+dyIk+7
         M0SglrpSONjRUC6wPDjlY/wqN0Y2zcPBgUKeuD5Ba6i7cXHFEdlmK622WlorDcBUnj
         CPK7xhmqlBhvGvmQR++JNg16kjYyvdKRLWWIQRYg=
Date:   Wed, 4 Nov 2020 20:02:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v5 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20201104190235.GA2855400@kroah.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-7-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019061803.13298-7-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 02:17:52PM +0800, shuo.a.liu@intel.com wrote:
> --- /dev/null
> +++ b/include/uapi/linux/acrn.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace interface for /dev/acrn_hsm - ACRN Hypervisor Service Module
> + *
> + * This file can be used by applications that need to communicate with the HSM
> + * via the ioctl interface.
> + */
> +
> +#ifndef _UAPI_ACRN_H
> +#define _UAPI_ACRN_H
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct acrn_vm_creation - Info to create a User VM
> + * @vmid:		User VM ID returned from the hypervisor
> + * @reserved0:		Reserved
> + * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
> + * @reserved1:		Reserved
> + * @uuid:		UUID of the VM. Pass to hypervisor directly.
> + * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
> + * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
> + *			hypervisor directly.
> + * @cpu_affinity:	CPU affinity of the VM. Pass to hypervisor directly.
> + * @reserved2:		Reserved

Reserved and must be 0?  What are they reserved for?

Same for all of the reserved fields, why?

> + */
> +struct acrn_vm_creation {
> +	__u16	vmid;
> +	__u16	reserved0;
> +	__u16	vcpu_num;
> +	__u16	reserved1;
> +	__u8	uuid[16];

We have a userspace-visable uid structure in include/uapi/uuid.h, why
not use that?

thanks,

greg k-h

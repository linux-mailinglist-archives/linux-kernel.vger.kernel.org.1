Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C062EF4E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbhAHPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbhAHPd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:33:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32448239A1;
        Fri,  8 Jan 2021 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610119968;
        bh=BNj+LwN6ztTnbRDsStE7xSDefTF/gAo+MhLjdTD+jco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wwdaGP4kyqHvt74Pjoe1/piYY1OyUFX8JwLoB4zZO8mRM4EWCzy5/M3IKSIk/ATt2
         PUn49bn3jHfdZsbWYG73dyrQndFeodPHTPPS88IlCZuy84cu1wW5kg+AISJKJ/6l5V
         ReLHRWaqhd+PUNnr0Fk2+Ei9IznNmKRol2CxFjd0=
Date:   Fri, 8 Jan 2021 16:34:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v7 08/18] virt: acrn: Introduce EPT mapping management
Message-ID: <X/h7bhf9RRGjnJ+a@kroah.com>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
 <20210106075055.47226-9-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106075055.47226-9-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 03:50:45PM +0800, shuo.a.liu@intel.com wrote:
> +/**
> + * struct acrn_vm_memmap - A EPT memory mapping info for a User VM.
> + * @type:		Type of the memory mapping (ACRM_MEMMAP_*).
> + *			Pass to hypervisor directly.
> + * @attr:		Attribute of the memory mapping.
> + *			Pass to hypervisor directly.
> + * @user_vm_pa:		Physical address of User VM.
> + *			Pass to hypervisor directly.
> + * @service_vm_pa:	Physical address of Service VM.
> + *			Pass to hypervisor directly.
> + * @vma_base:		VMA address of Service VM. Pass to hypervisor directly.
> + * @len:		Length of the memory mapping.
> + *			Pass to hypervisor directly.
> + */
> +struct acrn_vm_memmap {
> +	__u32	type;
> +	__u32	attr;
> +	__u64	user_vm_pa;
> +	union {
> +		__u64	service_vm_pa;
> +		__u64	vma_base;
> +	};
> +	__u64	len;
> +};

Endianness?


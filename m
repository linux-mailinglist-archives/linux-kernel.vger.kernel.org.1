Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5314B2BAFC2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgKTQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgKTQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:14:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578BCC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:14:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f11ba002f58e87ff3ef848f.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:ba00:2f58:e87f:f3ef:848f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 655451EC04E4;
        Fri, 20 Nov 2020 17:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605888838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KtO9yaqvZcz3NUWGPTgeRgf/kR7pds6O5UFlAwADpkQ=;
        b=R2dKT3/AWv3hTfmPbhgbFl4GN/PVNtgFKLvveM8PAa+A2co4QD2tc05rD+i7SYWmlVWbTL
        /Wis3G5l9fyaCChzuQ+aGwkE3C5MQXmZA4Yt1NORLtmx/QXW+KAya9Du9m7b+XF+KVcf30
        jOSl2oG4hdyoHAIX35TOsB9p81q0/s8=
Date:   Fri, 20 Nov 2020 17:13:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, willemb@google.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com
Subject: Re: [PATCH 1/3] x86/resctrl: Remove superfluous kernfs_get() calls
 to prevent refcount leak
Message-ID: <20201120161351.GC712@zn.tnic>
References: <1604084530-31048-1-git-send-email-xiaochen.shen>
 <1604084638-31197-1-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1604084638-31197-1-git-send-email-xiaochen.shen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 03:03:58AM +0800, Xiaochen Shen wrote:
> Willem reported growing of kernfs_node_cache entries in slabtop when
> repeatedly creating and removing resctrl subdirectories as well as when
> repeatedly mounting and unmounting resctrl filesystem.
> 
> On resource group (control as well as monitoring) creation via a mkdir
> an extra kernfs_node reference is obtained to ensure that the rdtgroup
> structure remains accessible for the rdtgroup_kn_unlock() calls where it
> is removed on deletion. The kernfs_node reference count is dropped by
> kernfs_put() in rdtgroup_kn_unlock().
> 
> With the above explaining the need for one kernfs_get()/kernfs_put()
> pair in resctrl there are more places where a kernfs_node reference is
> obtained without a corresponding release. The excessive amount of
> reference count on kernfs nodes will never be dropped to 0 and the
> kernfs nodes will never be freed in the call paths of rmdir and umount.
> It leads to reference count leak and kernfs_node_cache memory leak.
> 
> Remove the superfluous kernfs_get() calls and expand the existing
> comments surrounding the remaining kernfs_get()/kernfs_put() pair that
> remains in use.
> 
> Superfluous kernfs_get() calls are removed from two areas:
> 
>   (1) In call paths of mount and mkdir, when kernfs nodes for "info",
>   "mon_groups" and "mon_data" directories and sub-directories are
>   created, the reference count of newly created kernfs node is set to 1.
>   But after kernfs_create_dir() returns, superfluous kernfs_get() are
>   called to take an additional reference.
> 
>   (2) kernfs_get() calls in rmdir call paths.
> 
> Cc: stable@vger.kernel.org
> Fixes: 17eafd076291 ("x86/intel_rdt: Split resource group removal in two")
> Fixes: 4af4a88e0c92 ("x86/intel_rdt/cqm: Add mount,umount support")
> Fixes: f3cbeacaa06e ("x86/intel_rdt/cqm: Add rmdir support")
> Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
> Fixes: c7d9aac61311 ("x86/intel_rdt/cqm: Add mkdir support for RDT monitoring")
> Fixes: 5dc1d5c6bac2 ("x86/intel_rdt: Simplify info and base file lists")
> Fixes: 60cf5e101fd4 ("x86/intel_rdt: Add mkdir to resctrl file system")
> Fixes: 4e978d06dedb ("x86/intel_rdt: Add "info" files to resctrl file system")

Are those 8(!) Fixes tags supposed to list *all* commits which add those
wrong kernfs_get() calls?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

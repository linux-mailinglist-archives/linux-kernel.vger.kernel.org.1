Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861A62B463E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgKPOqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbgKPOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:46:34 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FFFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:46:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j5so8499994plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=yAIpN8zzoudkk9iAqlz3Xqnp850qgVBSX7BT49RgjuQ=;
        b=VzbZUJj9cS3VQggxqhAZ+HTaGN2cNSpl5NUMQM+O2AD74aS2uajqI2pyJDdVwZD5Zp
         5p4uMHMm0/BwudVqk4rhBTNhQfGq4a0TqWVKOTn4hJOGVplKq9vtjA6oE3Mrb9F3qIFk
         24BhQKelrtYN/bsPvOco/4j43Vh/znjgnwGwvmAO1A9S897q00dxLHoHdsgurK2QOXFg
         aPz9SYRMIF7BgQo3cNkvq2DwEINvUjCvlYEQDh+pFWeDEwLKueuNRspnBEuXzLbP+N3v
         eBYmFVCVI1VSdBpUD8yupvc99qU6fotW3IwpBZihN9jtzVlLN1pHVWXzq9JyQJpWeq+d
         Gnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=yAIpN8zzoudkk9iAqlz3Xqnp850qgVBSX7BT49RgjuQ=;
        b=p/t7mdrTHXgSBWRvnPdJs5nJnP7JdOgtxAkedcXkqmzKp94DaUmvYAU7oBYs/3tgnS
         p7FGLjOu6AvdIHK5C5C+TpFbR+jy2SHWUS4EGSLhoEWt4oo5nBxBySE2XFjBq9eM2ewl
         I4EAH1J++FdaduSkP+CN2y/NUITZuodvJXKGDJ5Ws6oR1v0qkvODL6Q/E+hlYD0aNIZ5
         lNQG6iAhxC9qIDXWEdI/SalN9GAlD2oqirrswzXFc+F4XsrfUoAANjDZ2otS64ByhU1C
         U4nw/dqjnMqmn0ruNN7Pz2rQm5dbbTxprpmtJsreFakvuXFzB87N82ZeMosafLFfcTFp
         9S1w==
X-Gm-Message-State: AOAM530DWFSlHYMRBOE1FRfpN5cFvjcIONErT6dThpItysIftRslFLS+
        j5xS0fVx1c/tbMK4xN3S20/1cEp4DgWcmUfo8pI=
X-Google-Smtp-Source: ABdhPJzwpADBaSxBgeKugBDrJckn871pRLzSzUnz3cs7ZpMYdF5mdyLJfeQRf/CRk9baQCcixkXXEA==
X-Received: by 2002:a17:902:c286:b029:d6:6cbd:eabf with SMTP id i6-20020a170902c286b02900d66cbdeabfmr12822532pld.41.1605537993159;
        Mon, 16 Nov 2020 06:46:33 -0800 (PST)
Received: from ?IPv6:2a02:8084:a84:8e00:81ce:77ba:c5fc:fb03? ([2a02:8084:a84:8e00:81ce:77ba:c5fc:fb03])
        by smtp.gmail.com with ESMTPSA id j8sm15764972pgb.55.2020.11.16.06.46.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 06:46:32 -0800 (PST)
From:   James Sewart <jamessewart@arista.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: x86 page_fault not succeeding when mapping write-only
Message-Id: <9F7238B5-58AC-485B-861B-C0862D428C00@arista.com>
Date:   Mon, 16 Nov 2020 14:46:25 +0000
Cc:     linux-kernel@vger.kernel.org
To:     linux-mm@kvack.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I=E2=80=99m looking into an issue after remapping some memory on 4.19, =
but looking=20
at the code this may also be an issue in master.

I have a driver that grabs some pages using alloc_pages, these pages are=20=

then remapped to userspace using calls to vm_insert_page inside a syfs=20=

bin_attribute mmap handler. Userspace calls mmap64 on the sysfs file =
with=20
MAP_SHARED and read/write permissions. If the process reads or writes to=20=

the mapping at this point it is fine and works. The issue occurs if the=20=

process calls mprotect with write-only permissions, before =
reading/writing=20
to the mapping, then when writing I see the page fault handler doesn=E2=80=
=99t set=20
up the page tables and the process spins entering the fault handler and=20=

exiting forever.

I tracked the return of page_fault down to a section in function=20
do_page_mkwrite:

	ret =3D vmf->vma->vm_ops->page_mkwrite(vmf);
	/* Restore original flags so that caller is not surprised */
	vmf->flags =3D old_flags;
	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
		return ret;
	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
		lock_page(page);
		if (!page->mapping) {
			unlock_page(page);
			return 0; /* retry */ <- we return here
		}

A 0 return here means wp_page_shared will return before setting up the =
pte.

This is a snippet of the call stack:

	do_page_mkwrite at mm/memory.c:2404
	wp_page_shared at mm/memory.c:2696
	do_wp_page at mm/memory.c:2797
	handle_pte_fault at mm/memory.c:4063
	__handle_mm_fault at mm/memory.c:4171


We hit the (marked unlikely) condition in do_wp_page of the vma being=20
VM_WRITE and VM_SHARED only, which is why I think I only see the issue=20=

when calling mprotect with write-only. Thinking about it now I haven=E2=80=
=99t=20
tried calling mmap with write-only to see what happens.

I think the issue is this vma has vm_ops associated with the kernfs ops,=20=

but as the page was allocated outside of the filesystem stuff, it =
doesn=E2=80=99t=20
have the kernfs address_space_operations associated with it.=20
kernfs_vma_page_mkwrite returns 0 indicating it didn=E2=80=99t lock the =
page, but=20
do_page_mkwrite requires the page to have a mapping in this case.

I=E2=80=99m not sure what the solution is, I can=E2=80=99t figure out =
how to associate the=20
page with kernfs so this condition is satisfied. What is this check for?

Should kernfs_vma_page_mkwrite lock the page? Or maybe it should set=20
page->mapping?

Is there something I can do in my driver to the pages or vma to avoid=20
hitting this issue? I looked through some other kernel code and it seems=20=

to me use of the vmalloc api or dma-iommu may hit the same issue.

Cheers,
James.=

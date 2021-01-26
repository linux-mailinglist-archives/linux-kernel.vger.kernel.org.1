Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEECC304F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhA0DQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbhAZUcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:32:25 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316B0C06174A;
        Tue, 26 Jan 2021 12:31:44 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2005F5F5A;
        Tue, 26 Jan 2021 20:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2005F5F5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611693103; bh=QNbhJWfpGylw9eOPfWr/bvmPVRtZhMmsoAiYwr5ysZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fqgUKFSp0x9hxp+G5VfsABfssNrnF0CSZDquKRdQ2WoE6RzFeg8oBgiAA1N7lNoBI
         jsS2IXaXGrlaMKPUL5xdFeAjBLOjpJUdw5nL0gOB0xx+sA4RRhmxJ3lqOkntWiytvK
         DmOUj43EnvSuO0GL4DjcPeLEXFhQ8svL7BlQ7sOeN/y2eDki7WS5WoU+hFloS9kiyV
         j8ty3zSKlu27eXxh2mhGCY0zwZWZVLKU+gZR5M9g/NebJYg9XdvluN+1hz3rU4gmGi
         yRQA85mnUobCGKdDqRkvPaYw6hvSjnONjp7zmMgs+cNPd0W/45ylmmUFE/iqnT58i0
         vUZo3nYmY0SxA==
Date:   Tue, 26 Jan 2021 13:31:41 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 00/12] docs: path-lookup: Update pathlookup docs
Message-ID: <20210126133141.27eb1c9d@lwn.net>
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 15:24:31 +0800
Fox Chen <foxhlchen@gmail.com> wrote:

> The Path lookup is a very complex subject in VFS. The path-lookup
> document provides a very detailed guidance to help people understand
> how path lookup works in the kernel.This document was originally
> written based on three lwn articles five years ago. As times goes by,
> some of the content was outdated. This patchset is intended to update
> the document to make it more relevant to current codebase.
> 
> 
> Fox Chen (12):
>   docs: path-lookup: update follow_managed() part
>   docs: path-lookup: update path_to_nameidata() parth
>   docs: path-lookup: update path_mountpoint() part
>   docs: path-lookup: update do_last() part
>   docs: path-lookup: remove filename_mountpoint
>   docs: path-lookup: Add macro name to symlink limit description
>   docs: path-lookup: i_op->follow_link replaced with i_op->get_link
>   docs: path-lookup: update i_op->put_link and cookie description
>   docs: path-lookup: no get_link()
>   docs: path-lookup: update WALK_GET, WALK_PUT desc
>   docs: path-lookup: update get_link() ->follow_link description
>   docs: path-lookup: update symlink description
> 
>  Documentation/filesystems/path-lookup.rst | 146 ++++++++++------------
>  1 file changed, 63 insertions(+), 83 deletions(-)

Neil Brown (copied) is the original author of this document; I'd really
like his feedback on these changes.  Neil, the full set is at:

	https://lore.kernel.org/lkml/20210126072443.33066-1-foxhlchen@gmail.com/

Thanks,

jon

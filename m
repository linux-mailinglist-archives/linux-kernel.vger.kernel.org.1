Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC55287289
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgJHK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbgJHK3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:29:37 -0400
Received: from coco.lan (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC9322076B;
        Thu,  8 Oct 2020 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602152976;
        bh=XHI5eZX58sToTeMD5p9ZUxHyJjzwD/WCDYNuZbi56vU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m/7o9uA9S2RFmymlpn8tWUch6q+JhNKekWs3vXjB2A9XJ62bLrjw1p2plaOV6dXk0
         h4fk+CL4Uaq1fwk0jkSjfL5ZLg4sa2c+Vvc+sGeofHPJsmL7OP4gRyc5kKSIsCcyUm
         rv5OUP7/T0je5+WwFN3jyUvdo4iBz5nIP+HivAI8=
Date:   Thu, 8 Oct 2020 12:29:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] script: add a script for checking doc problems with
 external functions
Message-ID: <20201008122931.369b628d@coco.lan>
In-Reply-To: <c256819190b2691f62c515c4aa82033a8d35c8f0.1602077410.git.mchehab+huawei@kernel.org>
References: <aac55ad312d17bb12f905b544a4e485ad507735d.1602070137.git.mchehab+huawei@kernel.org>
        <c256819190b2691f62c515c4aa82033a8d35c8f0.1602077410.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed,  7 Oct 2020 15:31:10 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> While not all EXPORT_SYMBOL*() symbols should be documented,
> it seems useful to have a tool which would help to check what
> symbols aren't documented.
> 
> This is a first step on this direction. The tool has some
> limitations. Yet, it could be useful for maintainers to check
> about missing documents on their subsystems.



./scripts/check_docs_external_symbols drivers/gpu/drm/ took 102.04 seconds



It took more than an hour to run on a Xeon workstation for
the complete Kernel tree.

So, I'm sending a followup patch that makes it a lot better by using
one perl thread per CPU thread.

Before such patch, running this command:

	$ /usr/bin/time --format='%C took %e seconds'  ./scripts/check_docs_external_symbols drivers/gpu/drm/
	
It takes:

	./scripts/check_docs_external_symbols drivers/gpu/drm/ took 1218.96 seconds


After the patch:

	./scripts/check_docs_external_symbols drivers/gpu/drm/ took 102.04 seconds


measured on a machine with a machine with a Xeon(R) W-2133 CPU @ 3.60GHz
(12 CPU threads), with normal HDD.

> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks,
Mauro

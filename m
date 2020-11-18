Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57502B85B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKRUhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:37:06 -0500
Received: from ms.lwn.net ([45.79.88.28]:46502 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRUhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:37:06 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D816B1F5B;
        Wed, 18 Nov 2020 20:37:05 +0000 (UTC)
Date:   Wed, 18 Nov 2020 13:37:04 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH v2] docs: automarkup.py: Allow automatic cross-reference
 inside C namespace
Message-ID: <20201118133704.43977072@lwn.net>
In-Reply-To: <20201117021107.214704-1-nfraprado@protonmail.com>
References: <20201117021107.214704-1-nfraprado@protonmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 02:12:01 +0000
Nícolas F. R. A. Prado <nfraprado@protonmail.com> wrote:

> Sphinx 3.1 introduced namespaces for C cross-references. With this,
> each C domain type/function declaration is put inside the namespace that
> was active at the time of its declaration.
> 
> Add support for automatic cross-referencing inside C namespaces by
> checking whether the corresponding source file had a C namespace Sphinx
> directive, and if so, try cross-referencing inside of it before going to
> the global scope.
> 
> This assumes there's only one namespace (if any) per rst file.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@protonmail.com>
> ---
> 
> To those following from v1:
> 
> I ended up doing the simplest solution possible, which is to just directly read
> the rst source corresponding to the doc page right before doing the automarkup.
> It's not very efficient in the sense that the source is being read
> twice (first by Sphinx, then by this), but it sidesteps the "data sharing
> between processes" issue, so parallel_read_safe can be reenabled, and I didn't
> notice any performance hit from this patch (as opposed to the big hit from v1).
> Works with both Sphinx 2 and 3.

The solution does lack elegance, but it is a solution, which is more than
we had before :)  That said, rather than re-opening and re-reading the
file, why not just connect to the source-read event, which will happily
hand you the document source that it has already read?

Thanks,

jon

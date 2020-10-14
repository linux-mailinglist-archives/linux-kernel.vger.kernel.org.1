Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2841A28E727
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbgJNTTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:19:03 -0400
Received: from ms.lwn.net ([45.79.88.28]:32854 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389668AbgJNTTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:19:02 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F2D2E739;
        Wed, 14 Oct 2020 19:19:01 +0000 (UTC)
Date:   Wed, 14 Oct 2020 13:19:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH v2 5/5] docs: automarkup.py: Allow automatic
 cross-reference inside C namespace
Message-ID: <20201014131900.1137cdc8@lwn.net>
In-Reply-To: <20201014115644.7bda9918@coco.lan>
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
        <20201013231218.2750109-6-nfraprado@protonmail.com>
        <20201014115644.7bda9918@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 11:56:44 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> > To make the first step possible, disable the parallel_read_safe option
> > in Sphinx, since the dictionary that maps the files to the C namespaces
> > can't be concurrently updated. This unfortunately increases the build
> > time of the documentation.  
> 
> Disabling parallel_read_safe will make performance very poor.
> Doesn't the C domain store the current namespace somewhere?
> If so, then, instead of using the source-read phase, something
> else could be used instead.

That seems like the best solution if it exists, yes.  Otherwise a simple
lock could be used around c_namespace to serialize access there, right?

Thanks,

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3029DCEE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbgJ1WU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbgJ1WR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B69C0613CF;
        Wed, 28 Oct 2020 15:17:57 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2F34E49B;
        Wed, 28 Oct 2020 16:21:04 +0000 (UTC)
Date:   Wed, 28 Oct 2020 10:21:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/33] docs: kernel_abi.py: add a script to parse ABI
 documentation
Message-ID: <20201028102103.35884c91@lwn.net>
In-Reply-To: <fbc723a2c49bd928f7845cba08e4996b9eb73142.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
        <fbc723a2c49bd928f7845cba08e4996b9eb73142.1603893146.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this is separate from the patch series itself in a way, but it brings a
question to mind:

On Wed, 28 Oct 2020 15:23:10 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> +# We can't assume that six is installed
> +PY3 = sys.version_info[0] == 3
> +PY2 = sys.version_info[0] == 2
> +if PY3:
> +    # pylint: disable=C0103, W0622
> +    unicode     = str
> +    basestring  = str

I wonder how much longer we really need to support any of:

 - Python < 3.n (where n=5 or 6 maybe)
 - Sphinx < 1.7 or even some 2.x

We're carrying a certain and growing amount of cruft to handle these
cases.  I might start putting together a series to clean this up for 5.11
or so.

jon

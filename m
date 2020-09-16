Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D01926C8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgIPTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgIPRsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BA3C061756;
        Wed, 16 Sep 2020 10:48:16 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C54F92E5;
        Wed, 16 Sep 2020 17:48:12 +0000 (UTC)
Date:   Wed, 16 Sep 2020 11:48:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH 0/3] docs: Add automatic cross-reference for
 documentation pages
Message-ID: <20200916114811.61721553@lwn.net>
In-Reply-To: <20200911133339.327721-1-nfraprado@protonmail.com>
References: <20200911133339.327721-1-nfraprado@protonmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 13:34:27 +0000
Nícolas F. R. A. Prado <nfraprado@protonmail.com> wrote:

> Cross-referencing from a documentation page to another can be done using the
> :doc:`doc-file` directive from Sphinx.
> This however introduces markup that could be avoided to increase readability in
> plain text.
> This patch series adds automatic markup for cross-referencing between
> documentation pages.

Once again, this looks great.  I've applied it, many thanks!

jon

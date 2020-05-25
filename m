Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625B81E12C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 18:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgEYQdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgEYQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:33:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63346C061A0E;
        Mon, 25 May 2020 09:33:53 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 17F8D2DC;
        Mon, 25 May 2020 16:33:53 +0000 (UTC)
Date:   Mon, 25 May 2020 10:33:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: sysctl/kernel: document unaligned controls
Message-ID: <20200525103352.51daf9fc@lwn.net>
In-Reply-To: <20200515212443.5012-1-steve@sk2.org>
References: <20200515212443.5012-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 23:24:44 +0200
Stephen Kitt <steve@sk2.org> wrote:

> This documents ignore-unaligned-usertrap, unaligned-dump-stack, and
> unaligned-trap, based on arch/arc/kernel/unaligned.c,
> arch/ia64/kernel/unaligned.c, and arch/parisc/kernel/unaligned.c.
> 
> While we're at it, integrate unaligned-memory-access.txt into the docs
> tree.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
> Changes since v1:
>   - move unaligned-memory-access.txt to process/
>   - removed UTF-8 apostrophe from the commit message
> 
>  Documentation/admin-guide/sysctl/kernel.rst   | 51 +++++++++++++++++++
>  Documentation/process/index.rst               |  1 +
>  .../unaligned-memory-access.rst}              |  0
>  3 files changed, 52 insertions(+)
>  rename Documentation/{unaligned-memory-access.txt => process/unaligned-memory-access.rst} (100%)

Applied, thanks.

jon

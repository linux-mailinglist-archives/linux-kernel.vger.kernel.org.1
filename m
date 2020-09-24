Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00DD27775A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgIXRCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:02:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:59338 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXRCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:02:05 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 595A52CB;
        Thu, 24 Sep 2020 17:02:04 +0000 (UTC)
Date:   Thu, 24 Sep 2020 11:02:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: rewrite admin-guide/sysctl/abi.rst
Message-ID: <20200924110201.2071ec35@lwn.net>
In-Reply-To: <20200917072123.8847-1-steve@sk2.org>
References: <20200917072123.8847-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 09:21:23 +0200
Stephen Kitt <steve@sk2.org> wrote:

> Following the structure used in sysctl/kernel.rst, this updates
> abi.rst to use ReStructured Text more fully and updates the entries to
> match current kernels:
> 
>   * the list of files is now the table of contents;
>   * links are used to point to other documentation and other sections;
>   * all the existing entries are no longer present, so this removes
>     them;
>   * document vsyscall32.
> 
> Mentions of the kernel version are dropped. Since the document is
> entirely rewritten, I've replaced the copyright statement.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Applied, thanks.

jon

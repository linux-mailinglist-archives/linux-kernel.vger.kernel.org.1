Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599491E12B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgEYQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgEYQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:31:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53136C061A0E;
        Mon, 25 May 2020 09:31:27 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E7EC82DC;
        Mon, 25 May 2020 16:31:26 +0000 (UTC)
Date:   Mon, 25 May 2020 10:31:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        greg@wind.rmcc.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation: admin-guide: update bug-hunting.rst
Message-ID: <20200525103126.60941f34@lwn.net>
In-Reply-To: <c629a9ef-3867-c3d1-f6c9-2c3b0e4ac68a@infradead.org>
References: <c629a9ef-3867-c3d1-f6c9-2c3b0e4ac68a@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 May 2020 20:43:39 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Update Documentation/admin-guide/bug-hunting.rst:
> 
> - add a small section on "Modules linked in" and their possible flags;
> - delete all references to ksymoops since it is no longer applicable;
> - fix spello, grammar, and punctuation;
> - note that get_maintainers.pl only provides recent patchers if it is
>   run inside a git tree;
> - add mention of scripts/decode_stacktrace.sh;
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: greg@wind.rmcc.com
> ---
>  Documentation/admin-guide/bug-hunting.rst |   53 +++++++++++---------
>  1 file changed, 31 insertions(+), 22 deletions(-)

Applied, thanks.

jon

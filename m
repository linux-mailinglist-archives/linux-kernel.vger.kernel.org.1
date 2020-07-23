Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5022B835
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGWUyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGWUyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:54:39 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48CAC0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:54:38 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2E1BC2BA;
        Thu, 23 Jul 2020 20:54:38 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:54:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     torvalds@linux-foundation.org, martink@posteo.de,
        tsbogend@alpha.franken.de, viro@zeniv.linux.org.uk,
        cyphar@cyphar.com, geert+renesas@glider.be,
        luis.f.correia@gmail.com, mchehab+samsung@kernel.org,
        paulburton@kernel.org, ribalda@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] CREDITS: Replace HTTP links with HTTPS ones
Message-ID: <20200723145437.3a756093@lwn.net>
In-Reply-To: <20200714175528.46712-1-grandmaster@al2klimov.de>
References: <20200713114321.783f0ae6@lwn.net>
        <20200714175528.46712-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 19:55:28 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> ationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Undone also three more URLs.
> 
>  ➜  linux git:(https-links/46) ✗ git diff --color-words --word-diff-regex=. -U0
>  diff --git a/CREDITS b/CREDITS
>  index e5267acb98e0..32ee70a7562e 100644

Applied.

jon

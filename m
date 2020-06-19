Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4208E201B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbgFSTXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:23:48 -0400
Received: from ms.lwn.net ([45.79.88.28]:55270 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387818AbgFSTXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:23:47 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F1FFE2CD;
        Fri, 19 Jun 2020 19:23:46 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:23:45 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH] Documentation: fix filesystems/locking.rst malformed
 table warnings
Message-ID: <20200619132345.14c868be@lwn.net>
In-Reply-To: <12c2afd1-2dcf-2ea0-02aa-bc2759729c77@infradead.org>
References: <12c2afd1-2dcf-2ea0-02aa-bc2759729c77@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 20:22:19 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix Sphinx malformed table warnings in filesystems/locking.rst:
> 
> lnx-58-rc1/Documentation/filesystems/locking.rst:443: WARNING: Malformed table.
> Text in column margin in table line 8.
> 
> lnx-58-rc1/Documentation/filesystems/locking.rst:620: WARNING: Malformed table.
> Text in column margin in table line 2.
> 
> Fixes: ec23eb54fbc7 ("docs: fs: convert docs without extension to ReST")
> Fixes: c1e8d7c6a7a6 ("mmap locking API: convert mmap_sem comments")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  Documentation/filesystems/locking.rst |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483C01A294F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 21:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgDHTZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 15:25:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:46376 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbgDHTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:25:07 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E1426307;
        Wed,  8 Apr 2020 19:25:06 +0000 (UTC)
Date:   Wed, 8 Apr 2020 13:25:05 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel build failed ...SPHINX extension error
Message-ID: <20200408132505.52e595bc@lwn.net>
In-Reply-To: <20200408113705.GB1924@ArchLinux>
References: <20200408113705.GB1924@ArchLinux>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 17:07:05 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> Extension error:
> Could not import extension cdomain (exception: cannot import name
> 'c_funcptr_sig_re' from 'sphinx.domains.c'
> (/usr/lib/python3.8/site-packages/sphinx/domains/c.py))
> Apr 08 16:48:46 enabling CJK for LaTeX builder
> Apr 08 16:48:46   CC      kernel/power/poweroff.o
> make[1]: *** [Documentation/Makefile:81: htmldocs] Error 2
> make: *** [Makefile:1549: htmldocs] Error 2
> make: *** Waiting for unfinished jobs....

This is weird, to say the least.  But I think the "python3.8" in the
message above says everything you need to know.  If you're running with
an unreleased version of Python, it's not entirely surprising that you
might run into trouble with a complex package.

jon

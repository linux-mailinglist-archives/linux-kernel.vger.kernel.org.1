Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033041A1605
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDGTct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 15:32:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:40574 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgDGTcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:32:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 210B67DF;
        Tue,  7 Apr 2020 19:32:48 +0000 (UTC)
Date:   Tue, 7 Apr 2020 13:32:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: sysrq: fix RST formatting
Message-ID: <20200407133247.575838bb@lwn.net>
In-Reply-To: <20200403170701.10852-1-hi@alyssa.is>
References: <20200403170701.10852-1-hi@alyssa.is>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Apr 2020 17:07:01 +0000
Alyssa Ross <hi@alyssa.is> wrote:

> "On x86" and "On SPARC" are now definition list terms, like
> "On PowerPC", "On other", and "On all".
> 
> The Credits list is now a bulleted list, like lots of Credits lists in
> other files.  This prevents the list from becoming a single long,
> unpunctuated sentence in the generated documentation.
> 
> I also did a couple of other tiny readability improvements to the
> "How do I use the magic SysRq key?" section while I was there.
> 
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Applied, thanks.

jon

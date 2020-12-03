Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08202CE260
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgLCXJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:09:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:57170 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgLCXJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:09:00 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3CCCA24D3;
        Thu,  3 Dec 2020 23:08:20 +0000 (UTC)
Date:   Thu, 3 Dec 2020 16:08:19 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: fix parsing function-like typedefs
Message-ID: <20201203160819.70cd8673@lwn.net>
In-Reply-To: <218ff56dcb8e73755005d3fb64586eb1841a276b.1606896997.git.mchehab+huawei@kernel.org>
References: <218ff56dcb8e73755005d3fb64586eb1841a276b.1606896997.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Dec 2020 09:17:32 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 6b80975c6308 ("scripts: kernel-doc: fix typedef parsing")
> added support for things like:
> 
> 	typedef unsigned long foo();
> 
> However, it caused a regression on this prototype:
> 
> 	typedef bool v4l2_check_dv_timings_fnc(const struct v4l2_dv_timings *t, void *handle);
> 
> This is only noticed after adding a patch that checks if the
> kernel-doc identifier matches the typedef:
> 
> 	./scripts/kernel-doc -none $(git grep '^.. kernel-doc::' Documentation/ |cut -d ' ' -f 3|sort|uniq) 2>&1|grep expecting
> 	include/media/v4l2-dv-timings.h:38: warning: expecting prototype for typedef v4l2_check_dv_timings_fnc. Prototype was for typedef nc instead
> 
> The problem is that, with the new parsing logic, it is not
> checking for complete words at the type part.
> 
> Fix it by adding a \b at the end of each type word at the
> regex.
> 
> fixes: 6b80975c6308 ("scripts: kernel-doc: fix typedef parsing")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied, thanks.

jon

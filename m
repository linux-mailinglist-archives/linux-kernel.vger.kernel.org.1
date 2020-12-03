Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE752CE207
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgLCWqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbgLCWqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:46:24 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E98C061A4F;
        Thu,  3 Dec 2020 14:45:43 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1E89520AF;
        Thu,  3 Dec 2020 22:45:43 +0000 (UTC)
Date:   Thu, 3 Dec 2020 15:45:42 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     Julia.Lawall@lip6.fr, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, nicolas.palix@imag.fr,
        Gilles.Muller@lip6.fr
Subject: Re: [PATCH v2] Documentation: Coccinelle: Improve command example
 for debugging patches
Message-ID: <20201203154542.6d526394@lwn.net>
In-Reply-To: <20201126075730.w6brpeuviefmsxhl@adolin>
References: <20201126075730.w6brpeuviefmsxhl@adolin>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 13:27:30 +0530
Sumera Priyadarsini <sylphrenadin@gmail.com> wrote:

> Modify Coccinelle documentation to clarify usage of make command to
> run coccicheck on a folder.
> 
> Changes in v2:
> - Give example of folder instead of file
> - Add note
> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  Documentation/dev-tools/coccinelle.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F865241E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgHKQiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgHKQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:38:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4EC06174A;
        Tue, 11 Aug 2020 09:38:16 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C51BD2C0;
        Tue, 11 Aug 2020 16:38:15 +0000 (UTC)
Date:   Tue, 11 Aug 2020 10:38:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     Julia.Lawall@lip6.fr, gregkh@linuxfoundation.org,
        Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] documentation: coccinelle: Improve command example
 for make C={1,2}
Message-ID: <20200811103814.2bbaf4fa@lwn.net>
In-Reply-To: <20200811002350.5553-1-sylphrenadin@gmail.com>
References: <20200811002350.5553-1-sylphrenadin@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 05:53:50 +0530
Sumera Priyadarsini <sylphrenadin@gmail.com> wrote:

> Modify coccinelle documentation to further clarify
> the usage of the makefile C variable by coccicheck.
> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> 
> ---
> Changes in v4:
>         - Modify commit message to clarify C is a variable
> ---
>  Documentation/dev-tools/coccinelle.rst | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Applied, thanks.

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE09241E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgHKQsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgHKQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:48:35 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8758C06174A;
        Tue, 11 Aug 2020 09:48:35 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D6C04FA;
        Tue, 11 Aug 2020 16:48:35 +0000 (UTC)
Date:   Tue, 11 Aug 2020 10:48:34 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] docs: Fix function name trailing double-()s
Message-ID: <20200811104834.5f5ff007@lwn.net>
In-Reply-To: <202008072348.3BA3DD14E@keescook>
References: <202008072348.3BA3DD14E@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 23:49:59 -0700
Kees Cook <keescook@chromium.org> wrote:

> I noticed a double-() after a function name in deprecated.rst today. Fix
> that one and two others in the Documentation/ tree.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/RCU/lockdep.rst                           | 2 +-
>  Documentation/process/deprecated.rst                    | 2 +-
>  Documentation/translations/it_IT/process/deprecated.rst | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

This one doesn't apply, and it crashes b4 outright.  The problem seems to
be some sort of encoding confusion...?

Thanks,

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF325841D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 00:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgHaWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 18:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgHaWbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:31:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4783C061573;
        Mon, 31 Aug 2020 15:31:36 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 134877C0;
        Mon, 31 Aug 2020 22:31:36 +0000 (UTC)
Date:   Mon, 31 Aug 2020 16:31:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] deprecated.rst: Remove now removed uninitialized_var
Message-ID: <20200831163135.411c5edc@lwn.net>
In-Reply-To: <5e10c1645dd8f735215cf54a74db0f8dd3f6cbd5.camel@perches.com>
References: <5e10c1645dd8f735215cf54a74db0f8dd3f6cbd5.camel@perches.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 20:12:01 -0700
Joe Perches <joe@perches.com> wrote:

> It's now gone from the kernel so remove it from the deprecated API text.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  Documentation/process/deprecated.rst | 18 ------------------
>  1 file changed, 18 deletions(-)

Applied, thanks.

jon

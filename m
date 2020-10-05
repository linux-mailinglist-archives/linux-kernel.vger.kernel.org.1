Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B6283B89
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgJEPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgJEPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:45:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B5C0613CE;
        Mon,  5 Oct 2020 08:45:06 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 24E6A2B7;
        Mon,  5 Oct 2020 15:45:04 +0000 (UTC)
Date:   Mon, 5 Oct 2020 09:45:02 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] docs: programming-languages: refresh blurb on clang
 support
Message-ID: <20201005094502.40b187ab@lwn.net>
In-Reply-To: <20200929211936.580805-1-ndesaulniers@google.com>
References: <20200929211936.580805-1-ndesaulniers@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 14:19:35 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> Building the kernel with Clang doesn't rely on third party patches, and
> has not for a few years now.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Documentation/process/programming-language.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.  I also took the liberty of removing the duplicated
"docs" pointed out by Randy.

jon

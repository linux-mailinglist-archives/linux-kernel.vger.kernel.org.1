Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8892953E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505809AbgJUVJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440052AbgJUVJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:09:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A2CC0613CE;
        Wed, 21 Oct 2020 14:09:53 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C1C747C0;
        Wed, 21 Oct 2020 21:09:52 +0000 (UTC)
Date:   Wed, 21 Oct 2020 15:09:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Expand str*cpy() replacement
 notes
Message-ID: <20201021150950.3bd174a5@lwn.net>
In-Reply-To: <20201015231730.2138505-1-keescook@chromium.org>
References: <20201015231730.2138505-1-keescook@chromium.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 16:17:31 -0700
Kees Cook <keescook@chromium.org> wrote:

> The notes on replacing the deprecated str*cpy() functions didn't call
> enough attention to the change in return type. Add these details and
> clean up the language a bit more.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/process/deprecated.rst | 44 ++++++++++++++++------------
>  1 file changed, 26 insertions(+), 18 deletions(-)

Applied, thanks.

jon

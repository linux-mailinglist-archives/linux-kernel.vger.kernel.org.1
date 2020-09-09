Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222852634C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIIRie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:38:34 -0400
Received: from ms.lwn.net ([45.79.88.28]:58560 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgIIRiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:38:24 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2EF6D7C0;
        Wed,  9 Sep 2020 17:38:24 +0000 (UTC)
Date:   Wed, 9 Sep 2020 11:38:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Update zero-length/one-element
 arrays section
Message-ID: <20200909113823.50014d58@lwn.net>
In-Reply-To: <20200901010949.GA21398@embeddedor>
References: <20200901010949.GA21398@embeddedor>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 20:09:49 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Update information in the zero-length and one-element arrays section
> and illustrate how to make use of the new flex_array_size() helper,
> together with struct_size() and a flexible-array member.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  Documentation/process/deprecated.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

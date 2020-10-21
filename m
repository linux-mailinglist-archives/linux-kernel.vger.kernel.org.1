Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74602953FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505953AbgJUVQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505938AbgJUVQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:16:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9635C0613CE;
        Wed, 21 Oct 2020 14:16:36 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B23E12C8;
        Wed, 21 Oct 2020 21:16:35 +0000 (UTC)
Date:   Wed, 21 Oct 2020 15:16:32 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: submitting-patches: describe preserving
 review/test tags
Message-ID: <20201021151632.63b92945@lwn.net>
In-Reply-To: <20201013162725.13572-1-krzk@kernel.org>
References: <20201013162725.13572-1-krzk@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 18:27:25 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> From time to time, the novice kernel contributors do not add Reviewed-by
> or Tested-by tags to the next versions of the patches.  Mostly because
> they are unaware that responsibility of adding these tags in next
> version is on submitter, not maintainer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Reword, following Jonathan suggestions.
> ---
>  Documentation/process/submitting-patches.rst | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

jon

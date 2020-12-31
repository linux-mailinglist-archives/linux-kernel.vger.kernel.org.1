Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269B02E8279
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 23:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgLaWu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 17:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgLaWu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 17:50:27 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F92DC061573;
        Thu, 31 Dec 2020 14:49:47 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E3F0C60B;
        Thu, 31 Dec 2020 22:49:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E3F0C60B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1609454987; bh=jBr+SLjgiIGsvSUN7WO5mLJZBmJ6HtbFQltnqrSoo9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pn0kZ1ee5Hiukaf7Ew5mo67bltIWxtBp0QjbNAhWVkqG0AxkaiByqGj77rWr17miL
         s5vkKh3uM1LgjYeDJxAFpwWX8Qg8suqhcmsuEY4d+j2Ygzju7jcOIogzemJecIz7JT
         GSQiHCOgbNT9iV6utO/Bwvizue0UGlYQWpsVMC7X4LxmY49QIFsgG9XJ4lPR5u9jGS
         gM83wz+4BizXqNdyV2cbjY+8LJaRV9hU3dDcZs9wBTmZcA3kQ3FtM1MNXblzPfwgcj
         Wp+Qza4S9eOP9M6A2IhTqmeeyJvoK/TdTRD6zBxyAMmXhygKOQ9AMxBrh1Vu7TY2X/
         kE2LMjwCdkczA==
Date:   Thu, 31 Dec 2020 15:49:45 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [RFC PATCH] Documentation: doc-guide: fixes to sphinx.rst
Message-ID: <20201231154945.5abca1c4@lwn.net>
In-Reply-To: <20201228231212.22448-1-rdunlap@infradead.org>
References: <20201228231212.22448-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020 15:12:12 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Various fixes to sphinx.rst:
> 
> - eliminate a double-space between 2 words
> - grammar/wording
> - punctuation
> - call rows in a table 'rows' instead of 'columns' (or does Sphinx
>   call everything a column?)
> - It seems that "amdfonts" should be "amsfonts". I can't find any
>   amdfonts.

Applied, thanks.

jon

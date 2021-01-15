Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A62F80F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbhAOQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAOQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:38:38 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34420C0613C1;
        Fri, 15 Jan 2021 08:37:58 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 48FF4614C;
        Fri, 15 Jan 2021 16:37:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 48FF4614C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610728677; bh=8OCXLSQVLLtY+CaM+1GW8kkBfV3J/mP2yF5r3Gw5CX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OnHKa6DR8rn0KB7nsQG/TQ5LY/wZPokH9t5Vq8lOtMDCIbnlUcgEYMVyzWHhpyST1
         chGc5PXoX/dsYx8cSwTLMvXfHXxjNn1NkgOwbca2iPAiE453znWdcf+KEVsRWVy7Eo
         i8a5Ne0JmV5/SNjeBODCPOOzWTN4M5Axnoq0XG9CYfjZoIlYi9lLRHXcnCcW9ouXSd
         6OJ9gk+XT1sU2/rPc7kGnCwywbk0FB7WG+Q9TR01diSGhEhj7UCfD55sPwC0d6nLqJ
         qsjztSu0bAXWu++O+clZrfLRf8mHTcXYTnObBQup0WBVA0NL1rNAS67rtzBDaFngCt
         mavCxzUX7ypcg==
Date:   Fri, 15 Jan 2021 09:37:56 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Fix documentation warnings at linux-next
Message-ID: <20210115093756.5feaf63c@lwn.net>
In-Reply-To: <CAKXUXMziQ2H7_oiVSxbt1=bDFkjLQYOiOgd00YGyDnCTVDhbqA@mail.gmail.com>
References: <CAKXUXMziQ2H7_oiVSxbt1=bDFkjLQYOiOgd00YGyDnCTVDhbqA@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 07:12:38 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> We both, Mauro and I, have been submitting patches to address the
> documentation warnings on linux-next. If it is okay with you, Mauro, I
> would like to take responsibility for the task to send out the patches
> to address all warnings on linux-next in make htmldocs and follow up
> with all the discussions. I can also provide a short weekly summary
> (probably always on Friday) on what is pending where and what I could
> not resolve by myself.
> 
> Is that okay for you?

I'm certainly not going to complain about warning fixes!  If you want to
take up this work, all I can say is - I'm looking forward to the patches.
Thanks for doing this.

jon

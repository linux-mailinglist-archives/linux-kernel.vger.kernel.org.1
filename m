Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23E82953DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505788AbgJUVId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505713AbgJUVId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:08:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54848C0613CE;
        Wed, 21 Oct 2020 14:08:33 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 90F247C0;
        Wed, 21 Oct 2020 21:08:31 +0000 (UTC)
Date:   Wed, 21 Oct 2020 15:08:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hui Su <sh_def@163.com>
Cc:     dsterba@suse.com, mchehab+huawei@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/cpu-load: format the example code.
Message-ID: <20201021150829.125bf59e@lwn.net>
In-Reply-To: <20201018170557.GA7670@rlk>
References: <20201018170557.GA7670@rlk>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 01:05:57 +0800
Hui Su <sh_def@163.com> wrote:

> format the example code.
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  Documentation/admin-guide/cpu-load.rst | 63 ++++++++++++++------------
>  1 file changed, 33 insertions(+), 30 deletions(-)

Hmm...this document wasn't always that way; it looks like maybe the code
got mangled during the RST conversion.

I question the value of this document in general...but as long as we have
it the code might as well look right, so I've applied this, thanks.

jon

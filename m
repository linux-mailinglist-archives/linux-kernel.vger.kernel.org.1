Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFEB2B27BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKMWEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKMWEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:04:23 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D498C0613D1;
        Fri, 13 Nov 2020 14:04:22 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7584D734;
        Fri, 13 Nov 2020 22:04:22 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:04:21 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Justin P . Mattock" <justinmattock@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: Drop trailing whitespace
Message-ID: <20201113150421.2614cd8d@lwn.net>
In-Reply-To: <20201110144033.3278499-1-geert+renesas@glider.be>
References: <20201110144033.3278499-1-geert+renesas@glider.be>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 15:40:33 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Remove all trailing whitespace from the ABI documentation.
> Most of it was introduced during recent updates.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Fixes: 0ea6e61122196509 ("Documentation: update broken web addresses.")
> Fixes: 54a19b4d3fe0fa0a ("docs: ABI: cleanup several ABI documents")
> Fixes: 3197ebdb130473a9 ("ext4: Add sysfs support")
> ---
>  Documentation/ABI/testing/configfs-usb-gadget-ecm     | 2 +-
>  Documentation/ABI/testing/sysfs-devices-memory        | 2 +-
>  Documentation/ABI/testing/sysfs-fs-ext4               | 2 +-
>  Documentation/ABI/testing/sysfs-module                | 2 +-
>  Documentation/ABI/testing/sysfs-platform-renesas_usb3 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.  Not really sure we need Fixes tags for a whitespace fix,
though...

jon

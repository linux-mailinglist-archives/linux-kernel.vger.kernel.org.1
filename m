Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7016C2CE287
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbgLCXS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCXS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:18:28 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9EC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 15:17:48 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 21CB12D3;
        Thu,  3 Dec 2020 23:17:48 +0000 (UTC)
Date:   Thu, 3 Dec 2020 16:17:47 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix multiple typos found in the
 admin-guide subdirectory
Message-ID: <20201203161747.124c3ade@lwn.net>
In-Reply-To: <20201203082029.GA44830@spblnx124.lan>
References: <20201203082029.GA44830@spblnx124.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 11:20:29 +0300
Andrew Klychkov <andrew.a.klychkov@gmail.com> wrote:

> @@ -185,7 +185,7 @@ in a keyring called ".builtin_trusted_keys" that can be seen by::
>  	[root@deneb ~]# cat /proc/keys
>  	...
>  	223c7853 I------     1 perm 1f030000     0     0 keyring   .builtin_trusted_keys: 1
> -	302d2d52 I------     1 perm 1f010000     0     0 asymmetri Fedora kernel signing key: d69a84e6bce3d216b979e9505b3e3ef9a7118079: X509.RSA a7118079 []
> +	302d2d52 I------     1 perm 1f010000     0     0 asymmetric Fedora kernel signing key: d69a84e6bce3d216b979e9505b3e3ef9a7118079: X509.RSA a7118079 []

As Randy pointed out, this change isn't correct.  We can't fix things in
literal kernel output, regardless of how bad they are :)

Thanks,

jon

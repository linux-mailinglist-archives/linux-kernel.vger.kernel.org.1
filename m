Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B662EE7BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbhAGVoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAGVoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:44:01 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2185C0612F4;
        Thu,  7 Jan 2021 13:43:20 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 693E9614F;
        Thu,  7 Jan 2021 21:43:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 693E9614F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610055800; bh=TFc0cUoLuQ0qrusbDJDeWXKvfG94q25qQT3ctU24zlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RDlJ3trMSBMccuC7RQtMUtx4IQ25iR+eGQ7bLyfNoYekP0Y6JB/dMtSpKU/YmUCRb
         WJUpbpAsgWDGzSMywyObQ2b21lrmfLg5bwghWdu3wnH5l5ln/K7JntnK49Vjj/7a39
         WeCgjIBsSUOD23uJt5vNRC4T697QY4XJmvo8d9OMFSIso1op3g782hSqQqlAcZBIUQ
         uXEyvtKAuG74mG7fhLDp/m833RNyyVe2E3+ArXZ/s+7f3Zt9Mn26KL8tY2GHYpmGLj
         6a4yEufDs7bKxBK8M+srlgs7UNKZiOAdbcurz5DMGR1Q8OzLFV1FDhFKGzXOq5UCT4
         uu3b0NWiSi49g==
Date:   Thu, 7 Jan 2021 14:43:19 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Romuald Brunet <romuald@chivil.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: binfmt-misc: Fix .rst formatting
Message-ID: <20210107144319.2f3ffbd7@lwn.net>
In-Reply-To: <20210101211447.1021412-1-j.neuschaefer@gmx.net>
References: <20210101211447.1021412-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jan 2021 22:14:47 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> "name below" is not part of the /proc path and should not be formatted
> in monospace.
> 
> "doesn``t" is rendered in HTML with a double backtick. Revert it back to
> "doesn't".
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/admin-guide/binfmt-misc.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon

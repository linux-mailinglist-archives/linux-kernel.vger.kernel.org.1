Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8215122B779
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgGWUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:20:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052FFC0619DC;
        Thu, 23 Jul 2020 13:20:17 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3455A2CD;
        Thu, 23 Jul 2020 20:20:16 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:20:15 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, mchehab+huawei@kernel.org,
        j.neuschaefer@gmx.net, shobhitkukreti@gmail.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide/index.rst: Add pstore-blk.rst
Message-ID: <20200723142015.5ae4e4c3@lwn.net>
In-Reply-To: <20200718165107.625847-9-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
        <20200718165107.625847-9-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 13:51:03 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> 
> Fix the following warning:
> 
> Documentation/admin-guide/pstore-blk.rst:
> WARNING: document isn't included in any toctree
> 
> By adding 'pstore-blk.rst' to the index
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  Documentation/admin-guide/index.rst | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

jon

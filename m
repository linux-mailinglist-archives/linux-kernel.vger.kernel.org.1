Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7D1D57EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEORaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgEORaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:30:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40EAC061A0C;
        Fri, 15 May 2020 10:30:17 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3A084736;
        Fri, 15 May 2020 17:30:17 +0000 (UTC)
Date:   Fri, 15 May 2020 11:30:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, luochucheng@vivo.com
Subject: Re: [PATCH] doc: zh_CN: add translatation for debugfs.txt
Message-ID: <20200515113016.43c12464@lwn.net>
In-Reply-To: <20200509080535.7625-1-wenhu.wang@vivo.com>
References: <20200408021528.14062-1-luochucheng@vivo.com>
        <20200509080535.7625-1-wenhu.wang@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 May 2020 01:05:35 -0700
Wang Wenhu <wenhu.wang@vivo.com> wrote:

> From: Chucheng Luo <luochucheng@vivo.com>
> 
> Translate Documentation/filesystems/debugfs.txt into Chinese.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> [rebase for upstream conflict and minor change of subject]
> Link: https://lore.kernel.org/linux-doc/20200408021528.14062-1-luochucheng@vivo.com/
> ---
> Note:
>  * Did rebase as asked by Jonathan for the conflict when applied.
>  * Also ajusted the subject description.
>  * For their is no modification of new translated file, I appended
>    the "Reviewed-by" tag from Alex.

Applied, thanks.

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850112F818D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbhAORF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbhAORF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:05:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8DB523998
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610730286;
        bh=xL1qD5UoYvaR5sDbbTcXcMlF4EKf3ytys8k0AGtC3gQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RrGrpF9VWDTLLz4gzV3wdPTf0r639f0y7YibTCLm3xNa4qy+ot3HScEl2gWb9/VqD
         5ThGMdKi2IOi5fJax1I6bKVZZ7bW9Gotcev+SzDjyp18NLChwtKw496uzSWurCe6VG
         0viA48S2xhvM4YdoynTAccoqQbCKJubvaFOUVX5b2deC0KWiDP8pieEU8Eb1dc8XBa
         gp0fXZMye+LsBqWJ1tUHOh2wAzHYt7XROU9OBAt9zcg5XvbLyTt2f6up4htdxCEr0F
         +qUeG6ahaU4TGeGQqLaJmJG2/HniEWxaMDFNluuSkr1J870OTLJVECJJG0+W/ADff2
         71YX1U/44pNiw==
Received: by mail-oi1-f172.google.com with SMTP id q205so10177843oig.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:04:46 -0800 (PST)
X-Gm-Message-State: AOAM531tDwe13djGOvuKK/E90JlW8lmK3SIqjGNmLrJSyPKAVWKJhmRN
        IfFMpj7runzOoD1k5xDhSlsUY+G7+J5lqg8+SY0=
X-Google-Smtp-Source: ABdhPJwYUpojCjyKnFk7rRkBhBCc0DRcNyE3acaPhQVPUZgFeNG0pjekefnQlcnjU8SupuAE6DMolmVHu/eMeFOPQSs=
X-Received: by 2002:aca:e103:: with SMTP id y3mr6018950oig.11.1610730286232;
 Fri, 15 Jan 2021 09:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com> <HK0PR06MB33807C054FCE9E355346E204F2D00@HK0PR06MB3380.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB33807C054FCE9E355346E204F2D00@HK0PR06MB3380.apcprd06.prod.outlook.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 15 Jan 2021 18:04:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2WPvWokkqJB-yhfQH1ofofGNvibqPjUXPme+F2LCHjxw@mail.gmail.com>
Message-ID: <CAK8P3a2WPvWokkqJB-yhfQH1ofofGNvibqPjUXPme+F2LCHjxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     John Wang <wangzhiqiang.bj@bytedance.com>,
        "xuxiaohan@bytedance.com" <xuxiaohan@bytedance.com>,
        "yulei.sh@bytedance.com" <yulei.sh@bytedance.com>,
        Robert Lippert <rlippert@google.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        Patrick Venture <venture@google.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 10:57 AM Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> Hello John, Joel, Jae,
>         For this should be set LCLK to be CRITICAL it will fix LPC related driver. (KCS/BT/SNOOP)
>         I have send the patch before.
>         https://patchwork.ozlabs.org/project/linux-aspeed/patch/20200928070108.14040-2-ryan_chen@aspeedtech.com/
>
> Hello Joel,
>         Will you consider this patch?
>         Beside KCS/BT/SNOOP, UART1/UART2 will be most related issue for host side.

Sorry it did not make it into the merge window. The patch is still in
patchwork. I could just pick it up directly for v5.12, or wait for a
combined pull request with other work. Joel, please let me know
what you prefer.

        Arnd

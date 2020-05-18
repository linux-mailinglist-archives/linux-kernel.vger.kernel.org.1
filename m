Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7951D6E53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 02:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgERAuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 20:50:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41189 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbgERAuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 20:50:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4299D5C010D;
        Sun, 17 May 2020 20:50:08 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Sun, 17 May 2020 20:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=WYkrLdGeuqCWFbXVmvqfnkVYNN+ylfE
        EVvtH8uGYp1o=; b=ERzzZt1CW4/sUq6vbGAtfmPQDH6uI56VKaSVH5m05RlSJvp
        GN1bzqtHMYpAARLmyX6sx6kGyQhXLyZ77/rotq7zt/ekr51CmWk7XeQTNdxsvFnZ
        MCZhrXW5+I+WTW2/cjyjQ4ReVMG552iPUbslUuUeNaxe31as8dNyBgM/lCbq2cJ6
        cU7Ci570bcNbS2q48aOnvagTC/MiA9bUJJ9fVZrbOokrN6dK3ZA95dEQF3KDRfqS
        uNBm+HBI//OfLOj7How0nAErm4TMSBQdR9KHKKO0MKgCDjqbFyUnr2WEWrlDhYgR
        P+n+erwN6hbOlaFWSve4axE2yD6hBzsYu9Ymqvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WYkrLd
        GeuqCWFbXVmvqfnkVYNN+ylfEEVvtH8uGYp1o=; b=t8OjfMRjxHIA6/4OUbeAff
        D4iJ54SzjaM4W45mdcOKnvmfAplQAWcL6apI3W8zsDc83P767gK17pbFaEzGbF2i
        mFTOJk7iLPOAmu23/+3W6/g+wvzjBXusq61S7hdcezD84oINppnLWrBpRodQHbzZ
        RJQZKpoitN8TJDODoOIaqRAfnFEh5gWzWVk0C6z5EGFXLVJy0EMPUu8TiyBd3eob
        yYSB2ldtP694/Y/eiOnhWiuyl2NZr3ob2qTw+itoEh3EBtqwzNYvKS7R5bpKBfoY
        1oHdZwrOg6XJAPNiRnFuIrQXBhPoBlkbv9g9Sg5MOJzNgbF0wW6oeXvhphB1D9vw
        ==
X-ME-Sender: <xms:vtvBXnuw5K5k_AWpUZN0lp1mYUP1EIas0tTJHte8s6EoPgOV_3iItg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtgedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:vtvBXofCR5F_YNC829r0n7EH8ealBuZGcwf023R6YfnRfFI--_wEhw>
    <xmx:vtvBXqx1J7I0lbxlck0HKTfVqGquZ3rQuMNCPOGfgvc2dqCMXJxnwg>
    <xmx:vtvBXmMO-TXHXUP2fYlqyY657rFwQJ7PRjNRBHk9LzUXGmjKr6W9zA>
    <xmx:wNvBXqZ3tiimlwKp6Zn8KNhT4yUHKQ7Bzq4dJs5sEk2pWngqOp05KA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6C7AEE00B3; Sun, 17 May 2020 20:50:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-413-g750b809-fmstable-20200507v1
Mime-Version: 1.0
Message-Id: <8a30fb45-779d-4459-984b-f7792858c92e@www.fastmail.com>
In-Reply-To: <202005171447.00CFE0C@keescook>
References: <20200517153959.293224-1-andrew@aj.id.au>
 <202005171447.00CFE0C@keescook>
Date:   Mon, 18 May 2020 10:19:45 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Russell King" <linux@armlinux.org.uk>, mhiramat@kernel.org,
        labbott@redhat.com, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH]_ARM:_kprobes:_Avoid_fortify=5Fpanic()_when_copying?=
 =?UTF-8?Q?_optprobe_template?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 May 2020, at 07:18, Kees Cook wrote:
> On Mon, May 18, 2020 at 01:09:59AM +0930, Andrew Jeffery wrote:
> > As mentioned, a couple of attempts have been made to address the issue
> > by casting a pointer to optprobe_template_entry before providing it to
> > memcpy(), however gccs such as Ubuntu 20.04's arm-linux-gnueabi-gcc
> > 9.3.0 (Ubuntu 9.3.0-10ubuntu1) see through these efforts.
> 
> Ah, dang. :P
> 
> How about converting them all to unsized arrays, which would also allow
> the code to drop the "&" everywhere, I think. This is untested:

Looks better than my hack. Took it for a spin under qemu and it works for me.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Tested-by: Andrew Jeffery <andrew@aj.id.au>

Thanks Kees!

Andrew

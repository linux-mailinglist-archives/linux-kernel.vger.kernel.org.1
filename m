Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E470E299E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408047AbgJ0AN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:13:26 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:45025 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439449AbgJ0ANX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:13:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id F118AD19;
        Mon, 26 Oct 2020 20:13:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 26 Oct 2020 20:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=Y
        dzpjo4+CjMidbb3ZaFBGf7udcVDCw4IXMh46gqxR0E=; b=FbMHnddjGE9NxsVMV
        D6j+5cjsIREXDwCMjL8VYg22hgNlezpkWkaUoeaWEK6XZxRIJc6vQRqGrfBDVIkv
        IzN8WuAzalljvB9CHvmbLc49S3GYwFMkePK0yA+uHbzSe1TnySOidI034cJ3mccm
        azgi6t4hfju2tA8MoCGCzkQOfuYZq8F+2owQ/0N15vyBwb4asUV2ZChXWnLwIFI9
        /oVLoWYQ+aYkkkgAw0RhHsygFZYdC6aF2aKrWlXeBuCsVvSqTgcP1/MVZaoct98u
        rVUl2skJ5SLMBdMdACcXFWcQFHyrolg6BGGCpdntR/lZNULQCkwLnBJ/FmCfno2K
        5WPaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Ydzpjo4+CjMidbb3ZaFBGf7udcVDCw4IXMh46gqxR
        0E=; b=gnePpegTnRvg/vl+tOST0PmNckjjwMVtcCcz89ewjDLqZc9Xd9hZDNPil
        rtatCMW/wk/erN/wDVabxs9UkuEF5zyheEN8mKiKRidigp9wKqBvt2adbIOAAi5K
        5G/X4oE1iUPGiEpz/2AnTvpvy7NMC00ogUFznc+PqzMHH3aWECpoSQ0TZV4LKgeB
        mHGGB1B+ShOfwjQcHZoWAjr1kHSGq21VHyxHAvSDJdE1zN+shTwmpeakzyKpfoEW
        6W00Ov3ujbhDMt8XkD9v7HFXp4FQOM7Mg7ab6bAbyp+fj3OSvZ550CVVIbT4taW1
        O28x9ppVo19yMRxd3trwHtKFNONBQ==
X-ME-Sender: <xms:IGaXX6XA0QwMN6QIhFqjPY7odFX6DF0XF5WGyfKn1R9Sb-OqsPtydw>
    <xme:IGaXX2lgdd43B-0K9TYQTElm0ptBkA9bIWtbtGGAdBl-dq_zE4BZhKnlnfhrf0JNP
    h_Ta_7B1tytbP3SkmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeekgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeeggeegjeejleehvdfhteevffeuheeiiefftedvteet
    tdeuieefgeehveekteeufeenucffohhmrghinhepshhouhhrtggvfhhorhhgvgdrnhgvth
    enucfkphepudegrdefrdeigedrvddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hp
X-ME-Proxy: <xmx:IGaXX-a6xBJJrFeWEdUKmJam_eBkUfBl6BeCHEKvT4zSaiDxlBrbEw>
    <xmx:IGaXXxWkmcJG8uRAENx7eRJseWQ76mCDIkcI0-DM6-ayzO5CoMVX8A>
    <xmx:IGaXX0l_dZoagJXHs963sSE_Nqld1p_lRBXLdgA2HCodGzgHy5rUbw>
    <xmx:IWaXX1AV1XnJFFES3lT3AbCkEbuu26wOx8NnLN_a4S6XgMeDyHSmAw>
Received: from workstation (ae064207.dynamic.ppp.asahi-net.or.jp [14.3.64.207])
        by mail.messagingengine.com (Postfix) with ESMTPA id BDE41328005A;
        Mon, 26 Oct 2020 20:13:18 -0400 (EDT)
Date:   Tue, 27 Oct 2020 09:13:16 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        oscar.carter@gmail.com
Subject: Re: [PATCH] firewire: fix function type cast warning
Message-ID: <20201027001316.GA27589@workstation>
Mail-Followup-To: Arnd Bergmann <arnd@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        oscar.carter@gmail.com
References: <20201026215138.3893732-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026215138.3893732-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Oct 26, 2020 at 10:51:27PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc -Wextra complains about a suspicious cast:
> 
> rivers/firewire/core-cdev.c:985:8: warning: cast between incompatible function types from ‘void (*)(struct fw_iso_context *, dma_addr_t,  void *)’ {aka ‘void (*)(struct fw_iso_context *, long long unsigned int,  void *)’} to ‘void (*)(struct fw_iso_context *, u32,  size_t,  void *, void *)’ {aka ‘void (*)(struct fw_iso_context *, unsigned int,  long unsigned int,  void *, void *)’} [-Wcast-function-type]
> 
> The behavior is correct in the end, but this is more clearly
> expressed using a transparent union.
> 
> Fixes: 872e330e3880 ("firewire: add isochronous multichannel reception")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firewire/core-cdev.c |  6 +++---
>  drivers/firewire/core-iso.c  |  2 +-
>  include/linux/firewire.h     | 17 ++++++++---------
>  3 files changed, 12 insertions(+), 13 deletions(-)

Oscar Carter has posted a patch to fix it.
https://sourceforge.net/p/linux1394/mailman/message/37024966/

I don't know exactly but maintainers seems to overlook it...


Thanks

Takashi Sakamoto

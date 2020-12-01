Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C58A2CA2F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbgLAMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:42:15 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50245 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731050AbgLAMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:42:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DA16248F;
        Tue,  1 Dec 2020 07:41:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 01 Dec 2020 07:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=R6fmSKML9KtTVBoh+tDAcNNZx9k
        zhrwiKD5SpJTg/LM=; b=E+hrFEK/2joQP5vI6qceFQl9vFdt04UZ7sVBRVrbUav
        gWWq2uJSDajxWFQkqzuFeGL39IwkCs/jTgHPK2Jc5EbpdgVQ96rki5U+Ef8b0Y4G
        MLRFpbcPqWAGodyMeviLHmKqK6JRvR4vCbjx3GoakhsLDIDWGYysabRpZfqv3DPo
        hT0SfYi8Fd4Q6Ovbgez1HB3KoqDiq81LKlGpebTC6O1aJjoe4a142uDhgHY8kRZR
        dF8zJZmjSjUjdKUjBvyj2POher4uC3pVX/usHC9+GNPUEf4M1WxGZZ8AOxHh1x+k
        Uz/I8h6nj53LO2HsgxReSSRdJzFlwy7uxEZm6SMqVdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=R6fmSK
        ML9KtTVBoh+tDAcNNZx9kzhrwiKD5SpJTg/LM=; b=V3AZfWSUzMNTBrcHI06F9v
        QwEsJLv39B9047AsuXXTCFfxrbVxAhepKYxdGY9YMIXc+wQFTHV0iaYlZO6cUOM5
        IE1B0O+oKF2bTMQ6mj3t5iZKhB1L1On+llSGtv4thfp2/gAc6BgkUz3VqabsqW1x
        Ozkon0EqMhyaQEAQ9nYPUl6aueYfTx2Dxy6cHS3uZb8wM8ImJY/5lg6Z8yqkv1dI
        2NLikEv+llOpcPeuVEckOBwAKyHaiCoNMOdAhpB8IxKqZTnEg5l8YxVx18/vCP4L
        +cTUlnP5A15RlqpYZ10jwGy4IK9yAgieL+6a1aamThPfBOjHlJeu8hxCLLC6etIw
        ==
X-ME-Sender: <xms:4jnGXxEfg8ukKO2LUKknxF8HNsoQQfBzhe5TcXchPvvvgxYn1-4VfQ>
    <xme:4jnGX2WcXx4n2FfGkyIr8o7-sryVtj1idAlDMpBR_TDvcf1jqyoc907w40W7sLI81
    GfP4L46ME306EQH-dk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepgeejrddvtddurdeghedrvddtvdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:4jnGXzKttI9aOxYwfSJf7GLOUB9uBGFvv81_0-tHMp2PQ_WXC1Qo5w>
    <xmx:4jnGX3EWhM4y-UgCc2x9_dhoChzMPkStd-7yuwazySbTwgslFTlc8g>
    <xmx:4jnGX3XY1oRVTXdENi1h8YYjhEUqp_QWQB9gx2BwdZ0WZH-x4rKgdA>
    <xmx:4znGX0if1kD89z4om3QGmblNCfaJBU_kSrMzWhYgX8SRmNbRzv7uNQ>
Received: from cisco (unknown [47.201.45.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2D1F1328005D;
        Tue,  1 Dec 2020 07:41:06 -0500 (EST)
Date:   Tue, 1 Dec 2020 07:41:05 -0500
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Alban Crequy <alban@kinvolk.io>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: SECCOMP_IOCTL_NOTIF_ADDFD race condition
Message-ID: <20201201124105.GB103125@cisco>
References: <CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com>
 <20201130232009.GC38675@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130232009.GC38675@cisco>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:20:09PM -0500, Tycho Andersen wrote:
> Idea 1 sounds best to me, but maybe that's because it's the way I
> originally did the fd support that never landed :)
> 
> But here's an Idea 4: we add a way to remotely close an fd (I don't
> see that the current infra can do this, but perhaps I didn't look hard
> enough), and then when you get ENOENT you have to close the fd. Of
> course, this can't be via seccomp, so maybe it's even more racy.

Or better yet: what if the kernel closed everything it had added via
ADDFD if it didn't get a valid response from the supervisor? Then
everyone gets this bug fixed for free.

Tycho

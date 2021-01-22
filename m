Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF62FFDA2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbhAVHvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:51:06 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38583 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbhAVHvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:51:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 61E2E5C0227;
        Fri, 22 Jan 2021 02:49:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 22 Jan 2021 02:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=W
        cZl6uTTqBwLCl3/0Cj2KExpfYfUUjhDJqKjoRytFsc=; b=C8WN7ZH9ojPbAAYjQ
        HQdYXIsucS2354AKI2AOzSOsVvykamfojD7xyt6pS6kp07Ka7w5F9S2LJY53xqj7
        lsaxO/e/ylS+ZuakcDB/JB4KPfWEDzv+MXxmzzcreaC9NKoROQ/OWXCoew/vu7Kz
        gLnZg3eZ8JzXHZ1Hc0yITyLbW0cIMcfaJDGhS1fQQPk0KQ9eYqhs/oVqFAhSx9qW
        +oFqDPJDw2FijTdPk7pJyWVLp6LZ4hiP9wodiYSNO6SrhZwug68nfln6IA60anBs
        zyGKx+eUrzWnbAssk/2pnc4KJ/a63e8jJ6lIZGrCDPAE+oR913q7tek2QLU1Cos+
        uiR1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=WcZl6uTTqBwLCl3/0Cj2KExpfYfUUjhDJqKjoRytF
        sc=; b=LS2kxw/EkPPo3zp6LISc9X9eyB6dv/ADsuBUDYou7pEtVSBOvv2h4uZXm
        J/kjgw1wm359LXzYjlmiKYxIw+juyhL3UnCNj6yZtZXtNekBgNtUqPZjb+K8jCit
        aqVJKi/OR3LOCWpddyXnIUjJLUTrLUYRQ3Pvf1NWNp8JxisDdkuu0a+Vgg4ZJDTj
        niuhViyV70qCc+BJ9t5N7u0ISNNyLs+vzrdmoBdTVPthJX41N6zZlgRxFN1GuLJq
        WivjL6Q2He36cXCtXvXv8ygzcayidIkpiGzEj7IPDTLUqxuTlXNCncAcOgPHodec
        qae4VLoTT3CVI+pfqcFdAbfx5jQmg==
X-ME-Sender: <xms:ooMKYIW7eloDm2rRTVU1Zar0ZQSOjPrqIjSu71dlYD5ATcL4ouA3zA>
    <xme:ooMKYMlxTUdWrW6zBd8aRxgK-5z-yRvET3iYXdMmjpKGxY4Z8lCskKOwlSledyEuF
    hUZYz6ZAsqoOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepvedtie
    elueetgeeggfeufefhvefgtdetgfetgfdtvdegjeehieduvddtkeffheffnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:ooMKYMZg4BrAtAKQPIKkMhiS5SRNX3XVv1Qbmd-bL6FBO30m1J1Q9g>
    <xmx:ooMKYHWE5jfOFirqxBVv7f0COAyajoD19cpZciMVMqpwy07TLTxh3w>
    <xmx:ooMKYClIR7bBrfRhtpkrQgPEzOSNBoOkF4-5zjtRSxU_Ug2RsJBfbg>
    <xmx:o4MKYEUAC5doHg7xlaYtUfa6QS7Z8WGU-NoGGLky02V3pmBeMqyHVA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 90A251080063;
        Fri, 22 Jan 2021 02:49:54 -0500 (EST)
Date:   Fri, 22 Jan 2021 08:49:53 +0100
From:   Greg KH <greg@kroah.com>
To:     =?iso-8859-1?Q?Gy=F6rgy?= Andrasek <jurily@gmail.com>
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org
Subject: Re: [PATCH] objtool: Don't fail the kernel build on fatal errors
Message-ID: <YAqDoSH66pSB6Xzs@kroah.com>
References: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
 <545be952-908a-f125-ebb0-d96ed1e25cd5@linux.vnet.ibm.com>
 <581806c7-091e-b1f0-41f2-b770e8fd7f5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <581806c7-091e-b1f0-41f2-b770e8fd7f5b@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 08:32:35AM +0100, György Andrasek wrote:
> I'm rejecting both these morons as invalid. Please review everything they've
> been doing lately.

As Stephen said, please take this elsewhere, it does not belong on the
Linux kernel mailing lists.

greg k-h

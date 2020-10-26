Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9E298CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774760AbgJZMK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:10:57 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33589 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1774752AbgJZMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:10:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D874D9C4;
        Mon, 26 Oct 2020 08:10:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 26 Oct 2020 08:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Ut4Y+O3Rv1uyW+JIxybbrMjrNHx
        rXw0OHws027OXW5w=; b=Byfm54OZH5mCT2M2DT7HpyPua3i9VQ2nANNOWptbqqL
        mg5+y0VC28EutCCNhYAQsswM7tr1VbfztuAqHlQxq/8pspWJb7hOJqJTontQU7oc
        9195weDBYdfD1i597usOpGlJqQ+ug5IxINQInRRs5PuWdZ2z2W4XGX1onfkzUqIX
        TrxRB8vqYCI1jWMiGvkqwtZIH0cF8MrNrux5HrxHMEOwPDp29HhRgXZaoTkjBV1y
        j4BMLx6ZwXkXM1RJ0S7KrTMltPd3zuVMnyHekYRWLGuEFnBwGbP80gP8S1d2GhUQ
        jFi/jJk0NXBAbqLUQauOBVMNrPxm4qFKfIhMVlegM1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ut4Y+O
        3Rv1uyW+JIxybbrMjrNHxrXw0OHws027OXW5w=; b=kQ/4KEAxoEdmk9oPBo7V4E
        1Ck/zaeIOVkpponIEeB8wdDx0ADAvYu2Ln+JyDYhtqxVXyE0NzkQ1hO9H0+OTILs
        M6TfOcLR3PxzTTd8vZ3Hcy4JL1JzmvrJYg3+hTSB17KExFJ3MTFGiIpyUA32QJT3
        MDJsc7nAZy7JzNW+ph/gLnY/gn4g5TdxZLWcDtS99nL7v0lEvN0BvuXtfaLtb0zK
        tYKxqlZp0CtelMWg+WcmtzYE7yFMrLsKiVzUS85GQ7DpR5jEMLZjm1ZSOrVWylww
        HJmFwQ/Q8XI9wTxD4Cx6wMf7yDdTuLzEV35hU1p9hQQZr7tnY7JH3OVueBSjOZIA
        ==
X-ME-Sender: <xms:z7yWX0nD_dTeeRmogeKGaQXMqOo1zOFhJnmCGVmRyG-9-uYVUWGXhA>
    <xme:z7yWXz3YwUqgpSbpdQWaD_sCo_-4KhJuK5J0wQTsV_S1v_R6zuh4dDD9FDhciTPBp
    vHU_dkOwrMIjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeejucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvd
    enucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggft
    rfgrthhtvghrnhepueelledtheekleethfeludduvdfhffeuvdffudevgeehkeegieffve
    ehgeeftefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedr
    jeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:z7yWXyo4bDLxrnAjLvWkgaWTJq9d_cnRVyvaAxMfqICv3eQMFeFF6g>
    <xmx:z7yWXwkSJSrgN-T-h3eo31l5plu4525hmy792EQgX3zXYpNJmu9Azw>
    <xmx:z7yWXy2IjOpEW3d-qKycUf0tcPM32OC8-dKP71my6HLDJM8mcguhuw>
    <xmx:z7yWX39wNBMyH6wSA9DpZrHizskU2lFMSHDhBhtflrRgXl8BI8hN6g>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id B44833064686;
        Mon, 26 Oct 2020 08:10:54 -0400 (EDT)
Date:   Mon, 26 Oct 2020 13:11:23 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre-louis.bossart@linux.intel.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "ASoC: topology: disable size checks for bytes_ext
 controls if needed" has been added to the 4.9-stable tree
Message-ID: <20201026121123.GA2474358@kroah.com>
References: <20201026055347.0F79E20882@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026055347.0F79E20882@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:53:46AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     ASoC: topology: disable size checks for bytes_ext controls if needed
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      asoc-topology-disable-size-checks-for-bytes_ext-cont.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

This breaks the build, so I'm dropping it from everywhere it had
problems.

Also, why 5.4.y and not 4.19.y, but 4.14.y and 4.9.y?

thanks,

greg k-h

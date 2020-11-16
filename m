Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166012B51BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgKPT64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:58:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgKPT64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:58:56 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605556734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iT1pB+Lu/nt51+dstirMjndmyj/5r7MSVzH6je9F1oE=;
        b=J8UO8/MEyinNbsaWfEtkw0S8WJo8z5XgMf3ZQpk40Y1mIyinIwhIU+KJJYRMIlpTUUQToc
        eh+oY6qIU6GFFe3ZfDIyap06R7wSYjh6Qa63mOgNDV1VINoXdrujdEsCbfvn2Q32IoIE6T
        0byAwmt/Fxb0U2GiID5ON5kzkhvrTTdV6ZKqdy2TUMsqlujXymjBSfOChIuKnmjX9WxumK
        HfA5Q9ETW2b2A6Ub9mOqu+MH48niDZPSigY8nOCHFY5WiW0UypLHkJpRHr+wY3CYKxKkyG
        mAtTRIFgIN7PE6N66kENj47Lb372+HgUkXlvhoK7b51DGos6oXEl2YNK14zsPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605556734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iT1pB+Lu/nt51+dstirMjndmyj/5r7MSVzH6je9F1oE=;
        b=QYp+xOkSDE7KGTcpde8HIc8UtyROgSb2xsE379TxjmE+tP9wbj8u1xQF3S2peDWN0M4Wlq
        CHKHTYg16s/sD9AQ==
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.10-rc4 compile error
In-Reply-To: <b5b1a7c7-02ae-746b-2a6b-819f0a6b2595@skogtun.org>
References: <b5b1a7c7-02ae-746b-2a6b-819f0a6b2595@skogtun.org>
Date:   Mon, 16 Nov 2020 20:58:54 +0100
Message-ID: <87v9e5xedd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at 15:32, Harald Arnesen wrote:
> I get the following compile error, which reverting commit
> ff828729be446b86957f7c294068758231cd2183 fixes (and the resulting kernel
> boots fine).
>   CC      drivers/iommu/intel/dmar.o
> drivers/iommu/intel/dmar.c: In function 'vf_inherit_msi_domain':
> drivers/iommu/intel/dmar.c:338:59: error: 'struct pci_dev' has no member
> named 'physfn'; did you mean 'is_physfn'?
>   338 |  dev_set_msi_domain(&pdev->dev,
> dev_get_msi_domain(&pdev->physfn->dev));

I queued a fix already:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=8986f223bd777a73119f5d593c15b4d630ff49bb

Sorry for the wreckage.

Thanks,

        tglx

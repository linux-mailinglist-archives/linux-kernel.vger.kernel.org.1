Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8D2F9E08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbhARLUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389983AbhARLOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:14:30 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D70C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:13:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u14so9226189wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fLMG4vsTzbqzDa7NYZTtEssmDNdJhpiTjSVtjAKlEtA=;
        b=bYq5xCIxzjmV299kxFOaCiB/AS3jxa624Jqc6YIZmywPF0VJLTMwG3jbAp3Rl307/k
         hbfiB4H9mXbxETPI4v+GT1gwFHDX70mGRsQar2IpJ2FKIAKHJvFWzRMFchybki6gBfPB
         6p7Z5e/42vPSZqedt7jpJtu9+gZwqSj8cfxt/JH2KRt19eCGYArh3kvHtA9a7qRIRLL8
         b+nazIab6dctS0iZyKhVbpkE8mb0EMfLHaKpgyBxCulmhIYnf5VVvq5LCDBvM/gkb6AL
         2M3nAOmJjcBr9iah49+H/XndkzN8NpGh9ij+ij8wEH6swOnsfecHixfdPAc94g17XTIC
         z6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fLMG4vsTzbqzDa7NYZTtEssmDNdJhpiTjSVtjAKlEtA=;
        b=RV3MV2p5EA8wZ+rNI2X5qmerSKKlUUB3w5gUyhCH20ijic44oLXJn127wNP/LIRYw5
         LYOpgA/EfbwXLyM/P/k6t6k02P7gduMcg5+VP5Md/7O6dJQhAxcx4ER06kkOseZnTxGJ
         grXXF5XVSKLjPJG86bMzODet6VwrAYMS0IHxrs9fGbrgTmZ2IFlEsV5wvkxga11WZDmJ
         yr5JywjXjLTv14UzshAhirvkdy++OEmWJJ0d/xSV+sIQWGczLpU6T7vA30Ojbf0x6Jzb
         XOx8Lpzx0xNQ1Uw/Qi+oEAcMXgOmYu6YiNUr6KkCiD9pCuxeRdaRek9V8OnHuSZWv7s5
         rZIQ==
X-Gm-Message-State: AOAM531MFh2xf5/Y87xQRV7/52bA76mQfG2JgyZo02GIokakrasurP/o
        R7mRYC0grxZZSOXY6JtibTvZSQ==
X-Google-Smtp-Source: ABdhPJzf9c0SbOFn9Oq6MnmHnjRdRnsDCTN+qFk/yY+z+IA/dnEfzlcf743XMJ3WHiVu6gPS86334Q==
X-Received: by 2002:a1c:e055:: with SMTP id x82mr19724434wmg.185.1610968423194;
        Mon, 18 Jan 2021 03:13:43 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id b7sm28398175wrv.47.2021.01.18.03.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:13:42 -0800 (PST)
Date:   Mon, 18 Jan 2021 11:13:41 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 01/21] arm64: Fix labels in el2_setup macros
Message-ID: <20210118111341.porgvi56bzqlt36v@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-2-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:13AM +0000, Marc Zyngier wrote:
> If someone happens to write the following code:
> 
> 	b	1f
> 	init_el2_state	vhe
> 1:
> 	[...]
> 
> they will be in for a long debugging session, as the label "1f"
> will be resolved *inside* the init_el2_state macro instead of
> after it. Not really what one expects.
> 
> Instead, rewite the EL2 setup macros to use unambiguous labels,
> thanks to the usual macro counter trick.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/el2_setup.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Acked-by: David Brazdil <dbrazdil@google.com>


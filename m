Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888912D5CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389840AbgLJOEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389835AbgLJOEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:04:06 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80FAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:03:25 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so7433006ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wQkZfoQiHk1xwccW1qOvkd2W3WhIuH9Tuwz2EAXi1QE=;
        b=TohY7715fqEyw/5GjAEVPNV37qaIsrFhUphQ5D0Qi62jTDE/9Mr3f3oICVrRu0NQVR
         ZlRrHK3BK05HYMiI2ImzDJ3XcD+ycCwriNVRzRZUpKfD9o1WNriiQGfExofjaxgrag9U
         MXsilONV07UtdI/ToYtXVqwJkt3QEKspK5uMhxjB+bK3w7YFeEwgkcX48fcIJM5VaAy/
         PKDZBok9Ia9S3ii1chbrBz/mp/qNMQMPs/u6osmeEuRp/e9vzvQkW0pS7xHE+Uf0j3Wl
         u1NMjEifApdg6JTcSugs2/0c3WZgLr2OETvf071QVDwYShhkmXn9+EmDTPGBhH33xqM3
         M+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wQkZfoQiHk1xwccW1qOvkd2W3WhIuH9Tuwz2EAXi1QE=;
        b=qQjzIMNQPZ90H7Ss+XPwuEgrvXE/lAFxJNTSnKAFRN7MhkgZSsCSRqxTAP//HZW/HN
         tJy2IqJ4r+xUC80HU+6xBMmgllNjahVa84vPbj8QDJxow5Cmr/YbwzTAcrzfNBZshLBz
         tcLfM7UkBf7NEirK0n3W0v73IkjUqyjwHYEkCgVZkdc6/11p46n7syZMprtWO0dqecTM
         2h9+VppAdm9LNHY2K+qG/GhI8vHq9KeqY3k9E6kTrp6mXdzewa0o9/rdwSzJwQ4PEuV1
         irRpAy79CslMJe52q6/Zsy2WhrxrBVb4uDU14NfuhPfh9+z1IbKj7v/+Dfiq0D7t777I
         gtGQ==
X-Gm-Message-State: AOAM533/I8OU//7uEt8eb/nPK33IlvzmELBnLDXAb2asAKy4xVdh0Bif
        kJravhp0mbjeMlNohcqZfPiqeQ==
X-Google-Smtp-Source: ABdhPJwYDfFoEIJMhCuEIucESC7KnKGajEnGFwmu71YD+I9rvBJsJTreJiRmXUx82xbweE+nQCNkyw==
X-Received: by 2002:a17:906:7fcd:: with SMTP id r13mr6682088ejs.242.1607609004361;
        Thu, 10 Dec 2020 06:03:24 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f11sm5148560edy.59.2020.12.10.06.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 06:03:23 -0800 (PST)
Subject: Re: linux-next: manual merge of the tip tree with the microblaze tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201210155808.717a7257@canb.auug.org.au>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <1848f245-2a64-0aec-58db-b575de29debc@monstr.eu>
Date:   Thu, 10 Dec 2020 15:03:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210155808.717a7257@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 10. 12. 20 5:58, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tip tree got conflicts in:
> 
>   arch/microblaze/Kconfig
>   arch/microblaze/mm/Makefile
> 
> between commit:
> 
>   05cdf457477d ("microblaze: Remove noMMU code")
> 
> from the microblaze tree and commit:
> 
>   7ac1b26b0a72 ("microblaze/mm/highmem: Switch to generic kmap atomic")
> 
> from the tip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Thanks for letting me know. I will mentioned it to Linus.
Your resolution is correct.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


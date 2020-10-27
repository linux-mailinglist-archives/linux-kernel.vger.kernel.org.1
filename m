Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131E829BB9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1808775AbgJ0QWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:22:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41729 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1804890AbgJ0P7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:59:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id l24so1966060edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CvPFb4kyBEugekUbJn2sOaqGP8u3RgKrWq2nBe9yDAE=;
        b=MXfLiAZCOyDLmDCHAn3NmON7byOVbkAO2XDk5691T3mF2z1TGHIqQVSG9CPuBAchC4
         hC6mvrhrm5JTs2ybM2JQwI0niqdSJ7bh/2C7fjmLZE1ik3rQI5uXqN1Eefun2hrLMyso
         rtQ+xzzIQmhy9+2ZT2b1UbSC9m56eMpMKr9XuClwL0L7e26jJrvZ7Sp5XP7glfNnmXV7
         aAFEfDGMTlhST29rc12CBpweVPHshXJTJ91jNs85OuNupGbwZJAeeBZvrh7FL6kOvf3v
         0EATqhGZJXc6hA3sxxPslgayjnsfq19bL0yHaf5HWxNzaxqH6kh1B7K5cigk0KE9rrpc
         Nw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CvPFb4kyBEugekUbJn2sOaqGP8u3RgKrWq2nBe9yDAE=;
        b=BNATJBWdPZMgn5ekpqpm8MaD/YDTMH2cww1kX/kZRWroCgqInA1uiGZjxGfsZ3SyS4
         zBdx8t8w2uI0kAbQI/Kl/iJBem/43VCDPnpf830FZVDCvd4K0umMQWAMhODRRnhHOtyO
         C0fJm0CoyAY0qbQGZuG79ITbZHGKKOayhtbZkjFbRxYFMahaphB/BJSIdJEshK9yySHg
         cWgGnCRJ3/5lmTHPbNkp2zQpCRbW9xQND1ZNXa4+CEBR1+S09RQ349AHRsHOP1GTVDNw
         6Un8nA55EYk1KKOflRmtffX7oIPmUPta4tQy5UCRF8Ce6RLsArLc+pcUFRoybd4koUpV
         wI8A==
X-Gm-Message-State: AOAM531QMGCZke9CbzqZaOT8UI+3+aDEYzVMCuXYD/jjl6Ij74VO/PM9
        HXF5+Vslx/aTHskjTGVvi2UiRQ==
X-Google-Smtp-Source: ABdhPJxuQbeMnOycxsv8oOumQFxdFJSIacf4CbhNGbLASp6ukbC7K8gLn0zvA/v/40DlrMasJ397NQ==
X-Received: by 2002:a05:6402:395:: with SMTP id o21mr2904999edv.2.1603814387438;
        Tue, 27 Oct 2020 08:59:47 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:567:3dba:e4e9:3d61])
        by smtp.gmail.com with ESMTPSA id q19sm1295053ejx.118.2020.10.27.08.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 08:59:46 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
References: <20201027135450.497324313@linuxfoundation.org>
 <20201027135517.727716271@linuxfoundation.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH 5.9 580/757] selftests: mptcp: depends on built-in IPv6
Message-ID: <3cdf310c-dcef-ad91-6f30-3cd48c6c47de@tessares.net>
Date:   Tue, 27 Oct 2020 16:59:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201027135517.727716271@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 27/10/2020 14:53, Greg Kroah-Hartman wrote:
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> [ Upstream commit 287d35405989cfe0090e3059f7788dc531879a8d ]
> 
> Recently, CONFIG_MPTCP_IPV6 no longer selects CONFIG_IPV6. As a
> consequence, if CONFIG_MPTCP_IPV6=y is added to the kconfig, it will no
> longer ensure CONFIG_IPV6=y. If it is not enabled, CONFIG_MPTCP_IPV6
> will stay disabled and selftests will fail.

I think Sasha wanted to drop this patch [1]. But as I said earlier [2], 
this patch is not wrong, it is just not needed in v5.9 because the 
"Fixes" commit 010b430d5df5 ("mptcp: MPTCP_IPV6 should depend on IPV6 
instead of selecting it") is not in v5.9.

I guess it is certainly easier to keep it because it is not wrong and 
doesn't hurt.

[1] https://lore.kernel.org/stable/20201026142329.GJ4060117@sasha-vm/
[2] 
https://lore.kernel.org/stable/1de2bf78-4b47-21b0-9d56-3c8063cdf4bb@tessares.net/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

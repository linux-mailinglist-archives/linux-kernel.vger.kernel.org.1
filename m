Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0525F041
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 21:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIFTk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 15:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgIFTkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:40:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1BC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 12:40:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so2189780pjr.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j3rc1A1n4o4I/iEnllWJzN48dgtrCcYNim+LPVJv+lY=;
        b=o+J3/469K1VMiSzO5aI8gMHlCFqZ6rCwjmXF0asQ25E8HpFKLUSTPF4tfyizzD0kQF
         X3cVRB/Bw1nQttZKrbkqVnFEAklj6h21gnS6cg7SjYR29Ohf6Z80vVej/Wcgo1v059Iz
         HOVjSE1zwJUBPQ/LkhEV2q+aIn2d2QKpETPlec+wyQfar5Uk5aerfcMto7oF8yufsehL
         mM9RkqWwCZYMkcxQ84xJSYk0xugqtxirz6DNbYgMNvgjtLclqCIYChbODVcpL8TGzlCL
         XX9Mk2bfseiZbe7BxIi71oOrx5DRCAwQLdGX8dS++KsaSRZcbdfxz1kNT+HVgKDYeQ1c
         h0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j3rc1A1n4o4I/iEnllWJzN48dgtrCcYNim+LPVJv+lY=;
        b=L32mghYpJdO8Hes5xNzvlrJSgPCKKBFXdfZZZcsB0Bu5hQ8aaPIKqVQnCenaGM5U9w
         D+xqb9vvYY0r2xsKEpzpw+E7v3fdPDw5nU27xxn7G9rADQQxFcQI5Ev+hxBmI8rVZnby
         c/0WQ6etVwEDfNJUKKZNR9QYGC9IOEHQdJa3Mlxon6ArHOxfSimj+1wgDKcJ53y69rRZ
         8LUZVC3/p/7ttH8oX60aUizjNSiw9Qil/OPTJBxxC42xVOZAV46v35O3iLpqst0T9kJb
         6w3VDNngTuu3A5sy6XaJJgl4Hb1BzlmVgsmZisCMBlzcIAo3b4i9qsSpkJSEySPfUf01
         8QKQ==
X-Gm-Message-State: AOAM532pJYgxISFrkJ6ImqA795qR0OMjeEsOZVwG3jFrpFZ/ClnWpoFW
        CYkrAVdhIj77BAWWdwR8heRR52qGYhA=
X-Google-Smtp-Source: ABdhPJxwsgQBZevKyH8GwJhV+CtTquUQsyN5D65Q56ZHHHFFBNXw4yswdyaBOGbOEUSqT18E8UsYew==
X-Received: by 2002:a17:90b:289:: with SMTP id az9mr17917914pjb.31.1599421250907;
        Sun, 06 Sep 2020 12:40:50 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m20sm12806794pfa.115.2020.09.06.12.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 12:40:49 -0700 (PDT)
Subject: Re: [PATCH] ARM: brcmstb: Add debug UART entry for 72615
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200904204248.3307516-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cbcb8d30-5e43-f3dc-6a89-ce1c7a07d575@gmail.com>
Date:   Sun, 6 Sep 2020 12:40:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200904204248.3307516-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2020 1:42 PM, Florian Fainelli wrote:
> 72165 has the same memory map as 7278 and the same physical address for
> the UART, alias the definition accordingly.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next
-- 
Florian

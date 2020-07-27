Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB80D22F6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgG0Rmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbgG0Rmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:42:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91DEC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:42:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so2615839pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lsbka09HUg/6AnqlzwCmUEpN5zjWnvzDu4J8ThOF1eI=;
        b=r0nWfJeixf6Lj+km7L3Pz6DT4+fYo1qxHNgUPJGoxKo++zwulrc9YaIPT3UXHuIFUL
         pyAFnxAqlRTX2/FXo5stzuidX1UmOct461dBiSxciWndxFchoDGsjWuSL3RacmTZ4A1C
         6IslrowS3wNyVTSWlpn83eYTjMZvfSvVpyldJWR8cHvzAP5CFInMEvpxNP1fE0p5FWpK
         nJ9mU7a7pBJcjLWs68/tAzSTfjNM0MtxYc0csTehZE+6SHYk3k/2uUgOaDWgGSk4unAA
         Bm9OpajN3Jl44obCfwbnB0mAR4jnTreXXynFQwJMnlTsof78GjRoscNpCiKEZu0PyLGF
         griw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lsbka09HUg/6AnqlzwCmUEpN5zjWnvzDu4J8ThOF1eI=;
        b=GPXiNP3YTPqfJ/V13GZt/ETFjfwpNK4f5jOYw9mgasdLxEWg/i3mQpmRklRCoY6PZQ
         BRfLSFTv96qnLRPrrJ30BC19DPQ8A/FTVMP0B55Kk0nXnJoQos1jeHcXfNhHe0UcBkrR
         lA3bBh0NKioCygH+YIv5a7Kfj3Q+dyy7uFYWyRMGvoIFGCl0PNco9w8cuIosJxtWr7rF
         Tlm2eKG4aqYT6X+4y6hhOfj8nhpPkqR5MoxxBXF7vPjR8QKGdcYm5cRJF9R/mQB/Zg1E
         Tidmxj8phq9tmEBBwOT/RE3CkcHfH5H3DCPirHHlGZI3endvYknu2qnLoPbajLAfn2Cy
         IT2A==
X-Gm-Message-State: AOAM5324a/DwI/WIkvB5uU49FnZfI9nllZNjuRofIehLD1DgFlxx4i+y
        e8j/n3HD/9mpBj2ZS3xhxFQMfw==
X-Google-Smtp-Source: ABdhPJxtBjozrrmTF4k4W+BHFQLbRoB8W6XPzUk4V7UxSjHortXTE1AqQ3bjd1AMkeifgNSJklFueg==
X-Received: by 2002:a63:9dcd:: with SMTP id i196mr20321294pgd.378.1595871773315;
        Mon, 27 Jul 2020 10:42:53 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b22sm218988pju.26.2020.07.27.10.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 10:42:52 -0700 (PDT)
Subject: Re: [PATCH v2] ata: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
 <20200727174012.GA696265@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
Date:   Mon, 27 Jul 2020 11:42:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727174012.GA696265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
> The patch is compile-tested only.

Please test and verify actual functionality, if you're serious about
potentially getting this into the kernel.

-- 
Jens Axboe


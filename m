Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB95281F6D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJBXzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBXza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:55:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F7C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:55:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u3so1866988pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rqxvmSasQjlgVbaPeIKaSrToGxLtYT0M0RkvDPPApmc=;
        b=LOTTLgi5WeWLE3h3cPaIzvWhlk0qSvrVGP6jVVq8gW3kmepi+rLBD4t1C16kWjsntn
         KS/qYioUIuhZtFgK5dleAi2COwm1VZHspZjN7GE3o+BO1iWMSfhgmxOWYO4VzRfu3VaR
         CjlbmQPs6eWxh8xUib5SUxuQinNjvppw7pys+R7FgudePCkAkpuG7qocPLX4QGGKarBU
         t57hXCNZ/JRSWja3UIE2J1e8Igkz/HVl/ioCHkXP2bYd/ZLeFoPl8LOxemoMzZsC/z7k
         c38NAowwbPZqMRGR+IdimNJj4TahRZ45zhYfMduWbta+CLgZXVazzxppYRo1u3O40i87
         SkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rqxvmSasQjlgVbaPeIKaSrToGxLtYT0M0RkvDPPApmc=;
        b=FP1d7KOUxUkffhoKrcbEFHGd5HDrpRxBn524NRVffFS0nO3R//hvoUxrZBqhrd5tT/
         adWkPNyH0ey3in/YTXFy3q4Y8Eu2+y72PxVO246qg8/c9U6ixbwICMslEc3bPgRQ7iP5
         8PSW8ZY4XfJgB9Ixq1cB51/iykdETAXdaJPIa333byoFtrpATTtQZ/xXYE0jwQIdrtxZ
         6+DZq1/EPYQA3SvaQI7i04eb/LaGzViUhdv3Weh7opRL365QccF0EUiiRdz+WiR0tjC6
         94a/bpyazsljUBvnrwdxRMBnfld6MGLhn5+g3TxB+Ak7HJmf7mAgw0BQfCIEl1K8+6pf
         Nc5w==
X-Gm-Message-State: AOAM533Havm9XD1InQxxXx3Yg5B/Te5MbqGyEHo5PgmszahZQRjKlEsN
        CDFxhTgAw4LGl3zj9uRZx/N7ZQ==
X-Google-Smtp-Source: ABdhPJxAubvtUF5U07ypj+nujnmOFtmQNvBFDt1wJZbt8c9NbwJDa6TctAJgZcWyGsHNqzQTYQLC6A==
X-Received: by 2002:a17:90a:94c1:: with SMTP id j1mr3273371pjw.120.1601682928624;
        Fri, 02 Oct 2020 16:55:28 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w195sm3240685pff.74.2020.10.02.16.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:55:28 -0700 (PDT)
Subject: Re: [PATCH][next] rsxx: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20201002235928.GA13477@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff2b483a-004f-2653-db65-8d1e3c48fe1c@kernel.dk>
Date:   Fri, 2 Oct 2020 17:55:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002235928.GA13477@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 5:59 PM, Gustavo A. R. Silva wrote:
> Replace /* Fall through. */ comment with the new pseudo-keyword macro
> fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Applied, thanks.

-- 
Jens Axboe


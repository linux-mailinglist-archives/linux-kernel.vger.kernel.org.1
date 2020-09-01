Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20874259200
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgIAPAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 11:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgIAPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:00:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C04C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:00:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n3so746979pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0YwaUAtyLuBHyoh2ibrlVoJxiTsYvjNgC8iqPh2Ghqs=;
        b=TtnmLFikCF7Sp7MAYur04NeYak24VaV8QHQ3CMiEnrCxpBvhZ4BNf4iDKjciZKE8vQ
         C/QK61cJmKH6R7RZVsZDtK9pnZAzReMNFhfIRroEyYTdhNS3HXrj0fWQmGxOnj/+93Tw
         //Ak6nYKTiUprwK5XBmTt66QqL55viIZWLLVbcHlOR2Hj4D9EIeTXYV6zoZWRagAl0Qm
         qNsHlaRWAVmL/j8BfU7sCXX4vhXGd6HAcyEYE0H81QTNSlC6iKJfD8e4DsKf6SXs2wEu
         FRHJ5ANVIgnOiIDmcXlJIH6j9AWH95OKmwEZqClQOLosSn2H4tWYRJa1dYGnxRJzlB4V
         jP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0YwaUAtyLuBHyoh2ibrlVoJxiTsYvjNgC8iqPh2Ghqs=;
        b=Bzth2H77rYWgDSxnWLJ4+5dUHK5bYGmDAPMy0s7/5pNHK1CDeR39xHO+DFMmW208ir
         jaL2svTiUDjTs8oZuwKrzEpS4jnIDgFQlHUbKzwcjUX8wT31wqaw/0qCBytou1pUTOzL
         WhbmNHNRjlWNriN8lXPJqWdomequhiVofHsLB8L4aQo0LdFnIAe/b7NCyVCnD1yuC6pg
         obn2vJ43Aj7B2wMzCLEKutEMIVd2aot1Zxggpd0zBiQFCLgr+otS+u9w92uqxEpSC7JJ
         rq24EsXp37KENZFudi4z2eJuCj0DpkkLsF7dMeAFaZpw2gsrmI5+KS8OWAz4Aqhd03OL
         OUxQ==
X-Gm-Message-State: AOAM532hDklvjjQJbHvAIL69CIlpatiATWp/euUW8moaDMeQ60OD8YnG
        DOOuIiuIciqXXXXCxtKlEEVkoeR2R2++8sf+
X-Google-Smtp-Source: ABdhPJzutePB5AqLEzn5ErjFqlD9TIRB3sgQe6qrVbyY6oynoSEwt5F0KSOUf4tBmUTeXUH4Ix5gwg==
X-Received: by 2002:a17:902:a508:: with SMTP id s8mr1722898plq.152.1598972416896;
        Tue, 01 Sep 2020 08:00:16 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e66sm2133888pfa.130.2020.09.01.08.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 08:00:16 -0700 (PDT)
Subject: Re: [PATCH] [v3] blk-mq: use BLK_MQ_NO_TAG for no tag
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200827063417.35851-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <be1f0442-b9ed-e82d-bfc6-6cc66866f026@kernel.dk>
Date:   Tue, 1 Sep 2020 09:00:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827063417.35851-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 12:34 AM, Xianting Tian wrote:
> Replace various magic -1 constants for tags with BLK_MQ_NO_TAG.

Applied, thanks.

-- 
Jens Axboe


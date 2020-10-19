Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95699292F34
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgJSULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgJSULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:11:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9BCC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:11:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s22so262342pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=R+VZxLw3M5VVMS/Oy1ye3FEsyXYNvktUSMjfNrh7K8s=;
        b=eQYbLSkG9xq6qO/TTxN4Oktwj9Tl2zd9eBNsRi1Spxg8LXN7/k4yZK3tXiOmMUPZKa
         f2rnKFtkPwloBbk+UqEQTU2XAR5NLLXyuAV85J6y/ebcF/bY1xGpXAr9lqQlXOKQGZ8C
         YngsD/nKFa+65nVuU/H+P6lCWT93T/Yy1g9whDWf/NlplBFSAUriWT+qnIZ9yHjt6/If
         MEpmSGmk+qto28lTPXZA6VG6ONkY4o1AMLAuOHMfv68D4BJMFXWR9y98Lj0hmkes2y2+
         /tkIdi/6WtKhn6NMuY9/tADf6PsE/Qgry5WiG9YYy4PG5O7j4b/pGltvjTuMKoX4Y25m
         tIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R+VZxLw3M5VVMS/Oy1ye3FEsyXYNvktUSMjfNrh7K8s=;
        b=UByxaRWEADc6k/9r5WwGMhdJsUYg/5+Lj+/pUlycyL0keQ5wdfi7SwF753f0XrGM2C
         YsS15TgUikALBdj01pfxQPoyA63zi/rvZbJOXuAduOX7PcGWexZxtN4B8BNA9AVXvlCG
         s+6mxThfK7RMQo1Sn31Hldvx9bXEWLeq60dUI0/iTEfJlTEXh2mATa7MICsPMvtY+gPa
         HhiqRdIQA7odsDkwFQAlyG99p9uS1ZoF0WLW5Tr5MLRmGrlUAqv1ScUa5HC7T6CXMiOJ
         INUqgrSF0uo0Kv3oTVXqx9WudG3H+d38yl8mul/F2a6cK87TpMdC6vPjGC3iQQzxL46W
         Uoug==
X-Gm-Message-State: AOAM532S8DGtYv1rOIehDClKGN9DLI35f4P+8tERrNWH94iGmqSPvnoz
        mEjXuhhCmvvS0ozeWoo59j0R9g==
X-Google-Smtp-Source: ABdhPJzhZ1+c/FI1IIIsPu3ZdVZt9Xtq0jyr7PwLKkWN/gCtz9q7A/q0TjxkJ50gR3xOjghDYI28BQ==
X-Received: by 2002:a63:541a:: with SMTP id i26mr1199135pgb.117.1603138306070;
        Mon, 19 Oct 2020 13:11:46 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l3sm306197pju.28.2020.10.19.13.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 13:11:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: Add some exports for bcachefs
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20201019190241.2910492-1-kent.overstreet@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <37a5f032-4979-706b-ea34-926e1756ccb1@kernel.dk>
Date:   Mon, 19 Oct 2020 14:11:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019190241.2910492-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 1:02 PM, Kent Overstreet wrote:
> bcachefs has its own direct IO code.

I talked to Kent about this offline, but just for completeness sake,
my recommendation is to keep these as prep patches for the bcachefs
series so we avoid having modular exports of code that don't have
any in-kernel modular users.

-- 
Jens Axboe


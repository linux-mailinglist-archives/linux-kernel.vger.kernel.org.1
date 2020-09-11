Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0312F266952
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgIKUDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgIKUDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:03:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F8C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:03:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id m15so1376036pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=frP8Q+XX3vatIolvDa1CfpmKMR9bYV+BQ0pT6Q4S34s=;
        b=bi5YLKmLyb3PdnbKs+BioUD4eTOKUvTFmSH93jPwe8WGn/jZKERBN77kVgZD27Y1D1
         OXmlzXSSgUy+Gu5dAS1LgPWA+r4B/SCN/9UDEhfrsoxyqrCF1WcsvQ+OOMJvNihbG6zq
         BywqpY7yUGXofRN0q8UJ5B1ZLvTp5rFGos4IBwJyjK/U5RXSamPyYts3Wx1rqrzupWLT
         n+0dPIeb9ebBU0QcXCSNQYdzM1Kj58yLcfq0xMuwUm5tsBIPtUiW5VhVT9Ri62fpQiIN
         QpSHxjyLw20ppjDLbYSI4PYz8l5rymJm1S3cdhHyycrD1Wddw0pTDbiVH4bJbBjRHHvK
         Y48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=frP8Q+XX3vatIolvDa1CfpmKMR9bYV+BQ0pT6Q4S34s=;
        b=VB9nH0YBE14Ha8l4fsTva0/3lnn2Cy9ntDfxMSgx2Fq9HNCF/KCRDytXz6gJ9GU60C
         m4mR70YU0aReb0hqog0vqQ6jdNtIi7hxf9f527EWEVchE1RRGufi4rUyck/t9xdZzgOj
         vZm1gJIvMl1giQXZOPu1TVuhmUMad2gk45DAXNwfksoQZfqAXKdyVIX288Q0gvvEQKor
         AsdAOhcKntoBzJ8BYp+4mC+5nWUwp1i/cYTOlReJjaIkev50Xr/9LjV2HiU4wP6YS3Ox
         IfG+osNjucUABjPEGTqdhKo655GVFWKyBTxI3gFk5u/dSqV9Ql8A8kXsSsiSGtXuM/5y
         sqMg==
X-Gm-Message-State: AOAM532MUYxkzgEJpDiuIZdwzbNNyE22VCzPEteq3GU06cU/elq4arga
        VciS++vrQBJMRclFZNfjy9lUPw==
X-Google-Smtp-Source: ABdhPJzP5JEZgAXjbay1DV3k010EzssCEgYlUoidnF/pMQkAiKmIaiX0cBIMnT3lDCJwc9PC5HAi7A==
X-Received: by 2002:a17:902:465:b029:d0:89f1:9e2a with SMTP id 92-20020a1709020465b02900d089f19e2amr3853867ple.6.1599854615696;
        Fri, 11 Sep 2020 13:03:35 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h12sm3083153pfo.68.2020.09.11.13.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 13:03:35 -0700 (PDT)
Subject: Re: INFO: rcu detected stall in ext4_file_write_iter
To:     syzbot <syzbot+7d19c5fe6a3f1161abb7@syzkaller.appspotmail.com>,
        acme@kernel.org, adilger.kernel@dilger.ca, dvyukov@google.com,
        fweisbec@gmail.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mingo@kernel.org, mingo@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu
References: <00000000000029b48f05af0ec14f@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32e8b6b0-fa68-42ac-f216-4bc2534bbfd6@kernel.dk>
Date:   Fri, 11 Sep 2020 14:03:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000029b48f05af0ec14f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: block: allow for_each_bvec to support zero len bvec


-- 
Jens Axboe


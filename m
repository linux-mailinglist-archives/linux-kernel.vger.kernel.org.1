Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC51B2B97
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDUPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726136AbgDUPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:50:19 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41170C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:50:19 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e8so6691890ilm.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qcGkRm5B6/y2G7+o+8knsoRwPwaIjT33dqtXOR9suII=;
        b=LTqSdoD2p6ZggutU2qU4llC5M7CPI3Gj8DJ+/v0Dv8ZlWjeqj2DEwXzu3d2OB/bMxO
         RTavrl7IaqUSrcSAUg9Y4WhYZnU1+9PHlD0mHnFl0aS5Ch5HXpveSjz7QMpnl+XOUAIm
         x6+EIMk3ytPbhnznixgTsUJA3MzIJpybBmMJZEsJ6Pz0uGwHETdU6ogbalOsUh903L1p
         i/9OXm2e5dGtV2G7M7eEBGvHXX86rtEWrS79jbIyZ7KAyX79GkONfg64QF3zUpEjPj34
         tsVnyx6SpBNEEGF73pB/HjrMPX6m/rUW3pwOITIOTZt1X3iiqYlaIDlrn/hD23XnKU9O
         Y7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qcGkRm5B6/y2G7+o+8knsoRwPwaIjT33dqtXOR9suII=;
        b=tRB/wJcY4jTBleQFXmZ7cfu0uiy2nH6yblMmyAJmE2euzv9XilFF1TlNuNiEV9C1yY
         wTPXLfHGSFZyXrThPai6GR1HylGlWMqk3Or+n6wtYWQnolAXysz+F8MR9D329W8doQho
         0tmdVNb1/8BUmRNQ6vMKqnl1ErnLJkOxcdeXVs1jvmSXhgPnYeWpZOylDecziLsBqcS3
         jDSno21LjJhFiU9fVPjNEYxit2bEjjMiqXqFozWin4MbPu9dR5DinYUci0QrxKn0CYtH
         1DnxgN89v+enRvnQc2nSUylGd6FE8YE3FyRY7AYX7V34TZLUKRyraK+DIKBbdZANuyMu
         EN/g==
X-Gm-Message-State: AGi0PuabUNWjJ7LHA9fklPPh53MMAR5HjfYMwwWbs9JnOvlXzyIGDjMo
        JCLmZoxo9UNsGqq3kkQV4UGmCp3hmAYXTA==
X-Google-Smtp-Source: APiQypKPLk26mkWusup1d/4oA1eOuQ+oFhDUweYJPtbtExABcgxJzTrIonyBnP3rXaRS2xOmveqNaA==
X-Received: by 2002:a92:5dca:: with SMTP id e71mr20627198ilg.34.1587484218448;
        Tue, 21 Apr 2020 08:50:18 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c87sm1041220ilg.2.2020.04.21.08.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 08:50:17 -0700 (PDT)
Subject: Re: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
To:     Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20200421130755.18370-1-longman@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4ba2d62-993e-9da3-9adb-4049bda6ba63@kernel.dk>
Date:   Tue, 21 Apr 2020 09:50:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421130755.18370-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 7:07 AM, Waiman Long wrote:
> Systemtap 4.2 is unable to correctly interpret the "u32 (*missed_ppm)[2]"
> argument of the iocost_ioc_vrate_adj trace entry defined in
> include/trace/events/iocost.h leading to the following error:
> 
>   /tmp/stapAcz0G0/stap_c89c58b83cea1724e26395efa9ed4939_6321_aux_6.c:78:8:
>   error: expected ‘;’, ‘,’ or ‘)’ before ‘*’ token
>    , u32[]* __tracepoint_arg_missed_ppm
> 
> That argument type is indeed rather complex and hard to read. Looking
> at block/blk-iocost.c. It is just a 2-entry u32 array. By simplifying
> the argument to a simple "u32 *missed_ppm" and adjusting the trace
> entry accordingly, the compilation error was gone.

Applied, thanks.

-- 
Jens Axboe


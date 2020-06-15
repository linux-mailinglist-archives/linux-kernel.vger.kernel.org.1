Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E5D1F9A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgFOOeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbgFOOeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:34:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:34:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so6925651pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f85rrqFngvdCKTEpKuKTy8kjhWt8QTpT8bVjpAa5hW4=;
        b=Jdg4jr8xAi9kF9Nn9iL2akThoq7TpNj2BMVqv8qxyKnCFp+mTcunS31rJStb2QIu33
         Io1VP1WFh6LLls1VuLiPD6if1ncdbvFa53VTke3n6bVjsVq/zdICZof3OVODj4JT+CU0
         hdNpGqg2WGNGn8o2N+kQyJ8WAgflKI5XWZRbttKhWgjScG0H4Ib44MKH/7IKhWw2c12Y
         Psg2hv3ePZ+7UtzjDoV0FZ18wrPCCNHuWwnYyXezSMkL6YlUQfq5vfBmU7sJOi4FeTIM
         sUZFPBjKDyflbIm7zpYKr0uFvPpU/blE/9++1PTR8TsNqx9lIKTNQlyMoFiFJpANAYJG
         JK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f85rrqFngvdCKTEpKuKTy8kjhWt8QTpT8bVjpAa5hW4=;
        b=s2TMlC1bjtOiuqSDQ18VDNnKrMbYklaFDBJMZjwRb6DZs8z46szBu4BvxiGP3eo1cG
         7O2L0OTZIW30LHS9pLc79XiAGjT9bkWM1f4DLqe930nRRMwV92WtBt2oe2hcw2xBeVra
         rMWp21o7f64+/lfWiNVq8ETBWUUSfbZbXw7IvGjTfT6OhbwxbXdt9zDzm/6Z057yH1xY
         tw6IX69jphWv8RtVWQxHg+DVw/kybuxJBayayWWSeoThncyYSO4m+YlwWnPSPSVitToE
         5Zy3oOOyHiwLDmgcV6MEavNu2+jTsWmvWonHcDd6FN4fUFSk93WlVTO6RYv6Awv8sLbk
         fu4g==
X-Gm-Message-State: AOAM533HZZr1zXqFfWxu0rqosW5wFksogJ/bP+qaWrqiOld/DFTLbp5j
        rqBda3mqZVNojvvqOfE3yodP+g==
X-Google-Smtp-Source: ABdhPJxRMk04y079i5dtaVxtnAaPaF7BWQW5y8NTrcrcmaBMfYf7/xZfyamaXqSx8qLKOoDWP41T0w==
X-Received: by 2002:a17:90a:2461:: with SMTP id h88mr12976159pje.180.1592231662231;
        Mon, 15 Jun 2020 07:34:22 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z8sm12977684pjr.41.2020.06.15.07.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:34:21 -0700 (PDT)
Subject: Re: [PATCH 6/6] smp: Cleanup smp_call_function*()
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org, tsbogend@alpha.franken.de,
        rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        dchickles@marvell.com, davem@davemloft.net, kuba@kernel.org,
        daniel.thompson@linaro.org, gerald.schaefer@de.ibm.com
References: <20200615125654.678940605@infradead.org>
 <20200615131143.434079683@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f615f81-eeec-fc34-ffe0-c8621af63bb2@kernel.dk>
Date:   Mon, 15 Jun 2020 08:34:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615131143.434079683@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 6:57 AM, Peter Zijlstra wrote:
> Get rid of the __call_single_node union and cleanup the API a little
> to avoid external code relying on the structure layout as much.

core and block bits look good to me.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC42907CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409435AbgJPOx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394947AbgJPOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:53:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964BC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:53:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q21so1579562pgi.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7wrAFrQUbhjohmG+yzeVkhlwYfh81dSt3oQQlEyyNKQ=;
        b=rvUHYiv61e9UOpqMZ+1aLFH3V8k1Sy2d+UAevkQKgGSi8I5uAdCcSSkknLrG3NchXK
         7jeWq31V/oLD1kCucsslIcUcfTG/EvAfn2qCF4pZ8eXeUrlOsf9mcSf++TVN1SJvyEbS
         kaJWz/WkpsWZEl7yd3MOXklPQQFwoWMSP6KgVq7is1KZAzW4hs8H/5fuG0yApyLnJs06
         893TadG7sR7BazPsL2Q7qNQlYQz5F6Ov03xqJ7ZiGESruEvc95o7UEic9rtDlM4O27+t
         tqDLlqM8BKLDVzX0gOy6RPCp9a7Q9cLjFdLsyxJ9wyQgnJJKnI0Co9zbTp15Msi+eghq
         Rdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7wrAFrQUbhjohmG+yzeVkhlwYfh81dSt3oQQlEyyNKQ=;
        b=lyNy5Aixr+fX18JlQTYXwRDQLuxDpzlL9Y6cD0KCCvrlAOe8GHx/JvhSraGgNQNw1b
         TxS+XyYhqBmZNV9KazWb9V7Onwbupd4fUmaWnMuOmQRm2K3bQd9FGaWFH1sjdGWkZzwD
         Iz1lm7cBRsYspTnsCszKzJr2c5JujQrCcCptIeFSc+SIP9CLD+9JAVCJf2eI9gtXchv/
         NgU1XX9rasPv27EzrHk5APwHvoerjbEH0yB/sJg5A6bfkiNJVMzuIEU2k4qIMElRPo0E
         3hHP8UeDfjFBKbZDQ0J75uGqpZ+mx30L+m/iN1594LcPxuQ2HVwmJS+fFtBDu/XyIV1h
         YpCA==
X-Gm-Message-State: AOAM532a5mlZ8KMjI8wyFfqSkH1aRFOi83dOgPYJBFvRUZijuFI4peyc
        YKQ0kS6wcMGzF/ggt61e3C4ttQ==
X-Google-Smtp-Source: ABdhPJwQZhhvkLFb1LbTZK7fHEb1X6uNP4Dy3qqVx1CPMR97ZjGa84MNNPd0X/7+SLmhIO9usrv4cw==
X-Received: by 2002:a63:e705:: with SMTP id b5mr3374044pgi.230.1602860035351;
        Fri, 16 Oct 2020 07:53:55 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 132sm3094943pfu.52.2020.10.16.07.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 07:53:54 -0700 (PDT)
Subject: Re: [PATCH 5/5] task_work: use TIF_NOTIFY_SIGNAL if available
To:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, Roman Gershman <romger@amazon.com>
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-6-axboe@kernel.dk> <20201015154953.GM24156@redhat.com>
 <e17cd91e-97b2-1eae-964b-fc90f8f9ef31@kernel.dk>
 <87a6wmv93v.fsf@nanos.tec.linutronix.de>
 <871rhyv7a8.fsf@nanos.tec.linutronix.de>
 <fbaab94b-dd85-9756-7a99-06bf684b80a4@kernel.dk>
 <87a6wmtfvb.fsf@nanos.tec.linutronix.de> <20201016145138.GB21989@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1a89eacd-830e-7310-0e56-9b4b389cdc5d@kernel.dk>
Date:   Fri, 16 Oct 2020 08:53:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016145138.GB21989@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 8:51 AM, Oleg Nesterov wrote:
> On 10/16, Thomas Gleixner wrote:
>>
>> With moving the handling into get_signal() you don't need more changes
>> to arch/* than adding the TIF bit, right?
> 
> we still need to do something like
> 
> 	-	if (thread_flags & _TIF_SIGPENDING)
> 	+	if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> 			do_signal(...);
> 
> and add _TIF_NOTIFY_SIGNAL to the WORK-PENDING mask in arch/* code.

Yes, but it becomes really minimal at that point, and just that. There's
no touching any of the arch do_signal() code.

Just finished the update of the branch to this model, and it does simplify
things quite a bit! Most arch patches are now exactly just what you write
above, no more.

-- 
Jens Axboe


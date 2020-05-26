Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1489319EE62
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 00:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgDEWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 18:24:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41360 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgDEWYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 18:24:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id d24so5134708pll.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cBUqwyFaaMgPDC136EdKrYKFduVaDYD9gWafLqWLat8=;
        b=EZ03bsicf8ec3VRWrGwceWMI5Y3DdUFIdjPtdlthXFEau6iJP7+PcfeoJcifHAnua1
         5TDdcQ2urw4xCp5PJhpfKgI5xyZKdeVrIG1ZPuIB3lMLVVwclfmJV8V1BGwcGnewaegc
         N4PFhfsXRZm4z9ePInwtY64N70bf6Xo415+4uVjPm4yn27luGbZ/AHdGdWegeP+Rhn5K
         l5lKApoqn2u7u3jCSXblHPzSHjevjVFxnF6phuXHWmdplcJ3HHLUgzxhV1Xh1a8dYeOK
         GbAHbKrDjgUye4WyHUA0qgx38v2pKMwWWOLHvcTQnhfTR43GxMtcTu0bMBD5H6z1iG/H
         6/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cBUqwyFaaMgPDC136EdKrYKFduVaDYD9gWafLqWLat8=;
        b=rejmz41T4RQ87KceXOr6YP5wE/TUL80psstGp847HV5fPdcbMNpzOdOx7xXwi6zIUf
         DQ2z5G29oKRZeLtph5mFl30JNKELVm3j6PLtQZlntPG/UoaTSmtedkunHQHnU+jvY/fk
         C3AsS1qZ8of7ANbEDyuN9L3VbroTkiLK1dbAIVeKj9jlkAVLHs2w3Am7FX55jplMG6Wk
         tZY8nEjFDJoRVPNqbPGcYw4cyrRtU/hAmXkrjz5bIm05v7piAPZuZXOMwrRTx5vBXSEa
         /2z3Fa1djKJnSeFXfHEcRxR4VT7PdxG9ub0XRrLWlFz+2kg5hkvVGKPZemhZBkTegSj0
         yebw==
X-Gm-Message-State: AGi0PuYgFZFrbv4bC0/LdTVMQB1lzJG4+AiZ5KYFaZALNRHRFUKknfGh
        FdvyKjWTzYoDHAF2t04w6EFYZW4/znpxWA==
X-Google-Smtp-Source: APiQypKLY6GAjok/YBhZdRycoLQmtEL+JiOwwcjY9MB0FZoQN/+QoPoBkvhsU+qv7sh2NO70lCpKUA==
X-Received: by 2002:a17:90a:343:: with SMTP id 3mr19057622pjf.115.1586125451566;
        Sun, 05 Apr 2020 15:24:11 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:5d19:ea24:5c10:884d? ([2605:e000:100e:8c61:5d19:ea24:5c10:884d])
        by smtp.gmail.com with ESMTPSA id g11sm10126763pjs.17.2020.04.05.15.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 15:24:10 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix ctx refcounting in io_submit_sqes()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8b53ce4539784423b493fdbfae9bd4c720b24d2a.1586120916.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c6da3fdd-541c-ba20-ec7a-6acd2ce9c3cd@kernel.dk>
Date:   Sun, 5 Apr 2020 15:24:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8b53ce4539784423b493fdbfae9bd4c720b24d2a.1586120916.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/20 3:08 PM, Pavel Begunkov wrote:
> If io_get_req() fails, it drops a ref. Then, awhile keeping @submitted
> unmodified, io_submit_sqes() breaks the loop and puts @nr - @submitted
> refs. For each submitted req a ref is dropped in io_put_req() and
> friends. So, for @nr taken refs there will be
> (@nr - @submitted + @submitted + 1) dropped.
> 
> Remove ctx refcounting from io_get_req(), that at the same time makes
> it clearer.

Applied, but also marked for 5.6 stable.

-- 
Jens Axboe

